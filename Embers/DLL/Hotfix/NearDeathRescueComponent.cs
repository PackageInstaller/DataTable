using System.Collections.Generic;
using Ase;
using Ase.ECS;
using GameFramework;

public class NearDeathRescueComponent : BaseComponent
{
	private bool _isStartRescue;

	private float _rescueRadius;

	private HeroEntity _rescueHeroEntity;

	private HeroEntity waitRescuseEntity1;

	private HeroEntity waitRescuseEntity2;

	private float _nearDeathRecoverHp;

	private bool _enterNearDeathState;

	private float _nearDeathSpeed;

	private bool _isCanEnterNearDeadState = true;

	private BaseEntity rescueEntity1;

	private BaseEntity rescueEntity2;

	private float rebornHitedPauseIncreaseTime;

	private HeroEntity mHeroEntity;

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		_rescueRadius = mBaseEntity.GetWorld().BattleConfig.RescueRadius;
		_nearDeathRecoverHp = mBaseEntity.GetWorld().BattleConfig.NearDeathRecoverHp;
		_enterNearDeathState = false;
		mHeroEntity = mBaseEntity as HeroEntity;
	}

	public bool GetIsInNearDeathState()
	{
		return _enterNearDeathState;
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		CheckNearDeathSchedule(deltaTime);
		if (mBaseEntity.IsSurvival)
		{
			RescueCheckDistance();
		}
		RescueTimeOut(deltaTime);
	}

	public void EnterNearDeathState()
	{
		_enterNearDeathState = true;
		_nearDeathSpeed = 1f;
		mBaseEntity.GetSystem<BuffSystem>().FinishEntityBuffByTag(mBaseEntity.Id, "Battle");
	}

	public void OnNearDeathAttacked(float damage)
	{
		if (!(damage <= 0f))
		{
			rebornHitedPauseIncreaseTime = mBaseEntity.GetWorld().BattleConfig.RebornHitedPauseIncreaseTime;
		}
	}

	private void CheckNearDeathSchedule(float deltaTime)
	{
		if (_enterNearDeathState)
		{
			mBaseEntity.SetProperty("RebornEneryRemaind", mBaseEntity.GetProperty("RebornEneryRemaind") - _nearDeathSpeed * deltaTime);
			UpdateRescueIconShow();
			if (mBaseEntity.GetProperty("RebornEneryRemaind") <= 0f)
			{
				WoundedDie();
				_enterNearDeathState = false;
			}
		}
	}

	public void DamageBreakRescue()
	{
		GiveUpRescue();
	}

	public void PullThrough()
	{
		_enterNearDeathState = false;
		mBaseEntity.GetComponent<StateComponent>().EnterNormalState();
		mBaseEntity.GetComponent<AIParadoxComponent>().SetVariableValues("IsRescued", paramValue: false);
		mBaseEntity.RebornResetAllProperty();
		if (mBaseEntity is HeroEntity { IsAi: not false })
		{
			mBaseEntity.ResetProperty("Hp", toMax: true);
		}
		else
		{
			float propertyMax = mBaseEntity.GetPropertyMax("Hp");
			mBaseEntity.SetProperty("Hp", propertyMax * _nearDeathRecoverHp);
		}
		mBaseEntity.GetSystem<CommandSystem>().ClearCacheCommand();
		rescueEntity1 = null;
		rescueEntity2 = null;
		mBaseEntity.EntityViewModel.BeingRescued = false;
		mBaseEntity.SetProperty("RebornProgress", mBaseEntity.GetWorld().BattleConfig.RebornNeedProgress);
		UpdateRescueIconShow();
	}

	private void UpdateRescueIconShow()
	{
		if (mBaseEntity.GetProperty("RebornProgress") < mBaseEntity.GetProperty("RebornNeedProgress") && mBaseEntity.GetProperty("RebornEneryRemaind") > 0f)
		{
			mHeroEntity.BattleHeroData.ShowRecuseIcon = true;
		}
		else
		{
			mHeroEntity.BattleHeroData.ShowRecuseIcon = false;
		}
	}

	public void SuccessFulRescue()
	{
		mBaseEntity.GetSystem<TouchSystem>().ShowAllInterRecuseBtn();
		mBaseEntity.GetSystem<TouchSystem>().SetRescueCooling(0f);
		_rescueHeroEntity = null;
		_isStartRescue = false;
		if (mHeroEntity != null)
		{
			mHeroEntity.BattleHeroData.WaitRecuseHeroId1 = 0;
			mHeroEntity.BattleHeroData.WaitRecuseHeroId2 = 0;
			RefreshRecuseBtn();
		}
		mBaseEntity.GetSystem<TouchSystem>().ShowAllInterRecuseBtn();
	}

	public bool StartRescue(HeroSkillTypeEnum heroSkillTypeEnum, out int rescueEntityId)
	{
		if (_isStartRescue)
		{
			rescueEntityId = _rescueHeroEntity.Id;
			return true;
		}
		if (_rescueHeroEntity == null)
		{
			switch (heroSkillTypeEnum)
			{
			case HeroSkillTypeEnum.Rescue1:
				if (waitRescuseEntity1 == null)
				{
					rescueEntityId = 0;
					return false;
				}
				rescueEntityId = waitRescuseEntity1.Id;
				_rescueHeroEntity = waitRescuseEntity1;
				break;
			case HeroSkillTypeEnum.Rescue2:
				if (waitRescuseEntity2 == null)
				{
					rescueEntityId = 0;
					return false;
				}
				rescueEntityId = waitRescuseEntity2.Id;
				_rescueHeroEntity = waitRescuseEntity2;
				break;
			default:
				_rescueHeroEntity = null;
				rescueEntityId = 0;
				return false;
			}
		}
		if (_rescueHeroEntity == null)
		{
			_rescueHeroEntity = null;
			rescueEntityId = 0;
			return false;
		}
		if (!_rescueHeroEntity.GetComponent<NearDeathRescueComponent>().JudeEntityCanRescue(mBaseEntity))
		{
			_rescueHeroEntity = null;
			rescueEntityId = 0;
			return false;
		}
		_isStartRescue = true;
		mBaseEntity.GetSystem<EntitySystem>().RegisterRescue(_rescueHeroEntity, (HeroEntity)mBaseEntity);
		rescueEntityId = _rescueHeroEntity.Id;
		mBaseEntity.GetSystem<TouchSystem>().HideAllRescuce();
		ObserverRescueParams observerRescueParams = ReferencePool.Acquire<ObserverRescueParams>();
		observerRescueParams.Init(BattleObserverEventEnum.RescueStart, _rescueHeroEntity, mBaseEntity);
		mBaseEntity.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.RescueStart, observerRescueParams);
		ReferencePool.Release(observerRescueParams);
		return true;
	}

	public bool AIRecuse(int woundEntityId, out int rescueEntityId)
	{
		if (mBaseEntity.IsActorEntity)
		{
			rescueEntityId = 0;
			return false;
		}
		if (_isStartRescue)
		{
			rescueEntityId = _rescueHeroEntity.Id;
			return true;
		}
		_rescueHeroEntity = mBaseEntity.GetSystem<EntitySystem>().GetEntity(woundEntityId) as HeroEntity;
		if (_rescueHeroEntity == null)
		{
			rescueEntityId = 0;
			return false;
		}
		if (!_rescueHeroEntity.GetComponent<NearDeathRescueComponent>().JudeEntityCanRescue(mBaseEntity))
		{
			_rescueHeroEntity = null;
			rescueEntityId = 0;
			return false;
		}
		_isStartRescue = true;
		mBaseEntity.GetSystem<EntitySystem>().RegisterRescue(_rescueHeroEntity, (HeroEntity)mBaseEntity);
		rescueEntityId = _rescueHeroEntity.Id;
		ObserverRescueParams observerRescueParams = ReferencePool.Acquire<ObserverRescueParams>();
		observerRescueParams.Init(BattleObserverEventEnum.RescueStart, _rescueHeroEntity, mBaseEntity);
		mBaseEntity.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.RescueStart, observerRescueParams);
		ReferencePool.Release(observerRescueParams);
		return true;
	}

	public bool GetIsInRescuse()
	{
		return _isStartRescue;
	}

	public void CancaleRescuse()
	{
		if (_isStartRescue)
		{
			GiveUpRescue();
			mBaseEntity.GetSystem<TouchSystem>().SetRescueCooling(1f);
			mBaseEntity.GetSystem<TouchSystem>().ShowAllInterRecuseBtn();
		}
	}

	public bool JudeEntityCanRescue(BaseEntity entity)
	{
		if (rescueEntity1 != null && rescueEntity2 != null)
		{
			return false;
		}
		if (rescueEntity1 == entity || rescueEntity2 == entity)
		{
			return false;
		}
		return true;
	}

	public void WoundedStartCure(BaseEntity entity)
	{
		if (rescueEntity1 == null)
		{
			rescueEntity1 = entity;
		}
		else if (rescueEntity2 == null)
		{
			rescueEntity2 = entity;
		}
		mBaseEntity.EntityViewModel.BeingRescued = true;
		mBaseEntity.GetComponent<AIParadoxComponent>().SetVariableValues("IsRescued", paramValue: true);
	}

	public void OnWoundedGiveUp(BaseEntity entity)
	{
		if (rescueEntity1 == entity)
		{
			rescueEntity1 = null;
		}
		if (rescueEntity2 == entity)
		{
			rescueEntity2 = null;
		}
		if (rescueEntity1 == null && rescueEntity2 == null)
		{
			mBaseEntity.EntityViewModel.BeingRescued = false;
			mBaseEntity.GetComponent<AIParadoxComponent>().SetVariableValues("IsRescued", paramValue: false);
		}
	}

	public void GiveUpRescue()
	{
		if (_isStartRescue)
		{
			mBaseEntity.GetSystem<EntitySystem>().GiveUpRescue(_rescueHeroEntity, (HeroEntity)mBaseEntity);
		}
		ObserverRescueParams observerRescueParams = ReferencePool.Acquire<ObserverRescueParams>();
		observerRescueParams.Init(BattleObserverEventEnum.RescueBreak, _rescueHeroEntity, mBaseEntity);
		mBaseEntity.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.RescueBreak, observerRescueParams);
		ReferencePool.Release(observerRescueParams);
		_rescueHeroEntity = null;
		_isStartRescue = false;
		if (mHeroEntity != null)
		{
			mHeroEntity.BattleHeroData.WaitRecuseHeroId1 = 0;
			mHeroEntity.BattleHeroData.WaitRecuseHeroId2 = 0;
			RefreshRecuseBtn();
		}
		mBaseEntity.GetSystem<TouchSystem>().ShowAllInterRecuseBtn();
	}

	private void WoundedDie()
	{
		mBaseEntity.GetSystem<EntitySystem>().WoundedDie((HeroEntity)mBaseEntity);
		mBaseEntity.GetTypeOfComponent<DestroyComponent>().DoEntityDead();
		_rescueHeroEntity = null;
	}

	public void ExecuteCommand(MsgPlayerInput playerInput)
	{
		if (playerInput.optionCode != HeroSkillTypeEnum.None && (playerInput.optionCode != HeroSkillTypeEnum.Rescue1 || playerInput.optionCode != HeroSkillTypeEnum.Rescue2))
		{
			GiveUpRescue();
		}
	}

	private void RescueTimeOut(float deltaTime)
	{
		if (!_enterNearDeathState)
		{
			return;
		}
		if (rebornHitedPauseIncreaseTime <= 0f)
		{
			if (GetOtherCanRescue())
			{
				mBaseEntity.ChangeProperty("RebornProgress", (0f - deltaTime) * mBaseEntity.GetProperty("RebornSelfIncrease"));
			}
			else
			{
				mBaseEntity.ChangeProperty("RebornProgress", (0f - deltaTime) * mBaseEntity.GetProperty("RebornOnlySelfIncrease"));
			}
		}
		else
		{
			rebornHitedPauseIncreaseTime -= deltaTime;
		}
		if (rescueEntity2 != null)
		{
			mBaseEntity.ChangeProperty("RebornProgress", (0f - deltaTime) * rescueEntity2.GetProperty("RescueIncrease"));
		}
		if (rescueEntity1 != null)
		{
			mBaseEntity.ChangeProperty("RebornProgress", (0f - deltaTime) * rescueEntity1.GetProperty("RescueIncrease"));
		}
		if (mBaseEntity.GetProperty("RebornProgress") <= 0f)
		{
			_isStartRescue = false;
			mBaseEntity.GetSystem<EntitySystem>().SuccessFulRescue(mBaseEntity as HeroEntity);
			ObserverRescueParams observerRescueParams = ReferencePool.Acquire<ObserverRescueParams>();
			observerRescueParams.Init(BattleObserverEventEnum.RescueSuccess, mBaseEntity, mBaseEntity);
			mBaseEntity.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.RescueSuccess, observerRescueParams);
			ReferencePool.Release(observerRescueParams);
		}
		UpdateRescueIconShow();
	}

	private void RescueCheckDistance()
	{
		if (!mBaseEntity.GetSystem<EntitySystem>().IsNeedRescue)
		{
			if (waitRescuseEntity1 != null && mHeroEntity != null)
			{
				waitRescuseEntity1 = null;
				mHeroEntity.BattleHeroData.WaitRecuseHeroId1 = 0;
				RefreshRecuseBtn();
			}
			if (waitRescuseEntity2 != null && mHeroEntity != null)
			{
				waitRescuseEntity2 = null;
				mHeroEntity.BattleHeroData.WaitRecuseHeroId2 = 0;
				RefreshRecuseBtn();
			}
		}
		else
		{
			if (!mBaseEntity.GetComponent<StateComponent>().IsNormalState())
			{
				return;
			}
			if (_rescueHeroEntity == null)
			{
				if (waitRescuseEntity1 != null)
				{
					waitRescuseEntity1 = null;
				}
				if (waitRescuseEntity2 != null)
				{
					waitRescuseEntity2 = null;
				}
				GetCanRecuseEntity();
				SetBattleHeroDataRecuse();
			}
			else if ((_rescueHeroEntity.transform.position - mBaseEntity.transform.position).sqrMagnitude > _rescueRadius * _rescueRadius)
			{
				GiveUpRescue();
			}
		}
	}

	private void SetBattleHeroDataRecuse()
	{
		if (mHeroEntity != null)
		{
			if (waitRescuseEntity1 == null && mHeroEntity.BattleHeroData.WaitRecuseHeroId1 != 0)
			{
				mHeroEntity.BattleHeroData.WaitRecuseHeroId1 = 0;
				RefreshRecuseBtn();
			}
			if (waitRescuseEntity2 == null && mHeroEntity.BattleHeroData.WaitRecuseHeroId2 != 0)
			{
				mHeroEntity.BattleHeroData.WaitRecuseHeroId2 = 0;
				RefreshRecuseBtn();
			}
		}
	}

	private void RefreshRecuseBtn()
	{
		if (mHeroEntity.IsActorEntity)
		{
			mHeroEntity.GetSystem<TouchSystem>().RefreshRecuseBtn();
		}
	}

	private void GetCanRecuseEntity()
	{
		for (int i = 0; i < mBaseEntity.GetSystem<EntitySystem>().WoundedList.Count; i++)
		{
			if (!((mBaseEntity.GetSystem<EntitySystem>().WoundedList[i].transform.position - mBaseEntity.transform.position).sqrMagnitude <= _rescueRadius * _rescueRadius))
			{
				continue;
			}
			if (waitRescuseEntity1 == null)
			{
				waitRescuseEntity1 = mBaseEntity.GetSystem<EntitySystem>().WoundedList[i];
				if (mHeroEntity != null && mHeroEntity.BattleHeroData.WaitRecuseHeroId1 != waitRescuseEntity1.Config.Id)
				{
					mHeroEntity.BattleHeroData.WaitRecuseHeroId1 = waitRescuseEntity1.Config.Id;
					RefreshRecuseBtn();
				}
			}
			else if (waitRescuseEntity2 == null)
			{
				waitRescuseEntity2 = mBaseEntity.GetSystem<EntitySystem>().WoundedList[i];
				if (mHeroEntity != null && mHeroEntity.BattleHeroData.WaitRecuseHeroId2 != waitRescuseEntity2.Config.Id)
				{
					mHeroEntity.BattleHeroData.WaitRecuseHeroId2 = waitRescuseEntity2.Config.Id;
					RefreshRecuseBtn();
				}
			}
		}
	}

	private bool GetOtherCanRescue()
	{
		List<HeroEntity> teamHero = mBaseEntity.GetSystem<EntitySystem>().GetTeamHero();
		if (teamHero.Count == 1)
		{
			return false;
		}
		foreach (HeroEntity item in teamHero)
		{
			if (item.IsSurvival && item.Id != mBaseEntity.Id)
			{
				return true;
			}
		}
		return false;
	}

	public void SetIsCanEnterNearDeadState(bool isCan)
	{
		_isCanEnterNearDeadState = isCan;
	}

	public void CheckHeroCanReborn(BaseEntity killer, bool isKilled)
	{
		DestroyComponent typeOfComponent = mBaseEntity.GetTypeOfComponent<DestroyComponent>();
		if (typeOfComponent != null)
		{
			typeOfComponent.SetKillerEntity(killer);
			if (!_isCanEnterNearDeadState)
			{
				typeOfComponent.DoEntityDead(isKilled);
				return;
			}
			if (mBaseEntity.GetPropertyCur("RebornEneryRemaind") <= 0f)
			{
				typeOfComponent.DoEntityDead(isKilled);
				return;
			}
			mBaseEntity.GetComponent<StateComponent>().EnterNearDeadState();
			mBaseEntity.GetSystem<BattleSystem>().UpdateTeamKillNumber();
		}
	}

	public override void OnEntityReborn()
	{
		base.OnEntityReborn();
		_enterNearDeathState = false;
		rescueEntity1 = null;
		rescueEntity2 = null;
		mBaseEntity.EntityViewModel.BeingRescued = false;
		rebornHitedPauseIncreaseTime = 0f;
	}

	public override void OnEntityDead()
	{
		base.OnEntityDead();
		GiveUpRescue();
	}

	public override void OnDispose()
	{
		_rescueHeroEntity = null;
		_isStartRescue = false;
		_rescueRadius = 0f;
		_nearDeathRecoverHp = 0f;
		_enterNearDeathState = false;
		base.OnDispose();
	}
}
