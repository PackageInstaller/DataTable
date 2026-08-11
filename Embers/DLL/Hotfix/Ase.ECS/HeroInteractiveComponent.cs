using GameFramework;

namespace Ase.ECS;

public class HeroInteractiveComponent : BaseComponent
{
	private InteractiveStateChecker interactiveStateChecker;

	private HeroSkillTypeEnum interactionSkillType;

	private StateComponent stateComponent;

	private bool isInteractiving;

	private float interactiveTime;

	private InputSystem _inputSystem;

	private TouchSystem _touchSystem;

	private BattleHeroData _battleHeroData;

	public override void OnInit(object data)
	{
		base.OnInit(data);
		stateComponent = mBaseEntity.GetComponent<StateComponent>();
		_inputSystem = mBaseEntity.GetSystem<InputSystem>();
		_touchSystem = mBaseEntity.GetSystem<TouchSystem>();
	}

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		_battleHeroData = mBaseEntity.EntityViewModel as BattleHeroData;
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		if (mBaseEntity.CacheTickUpdate)
		{
			if (interactiveStateChecker != null && interactiveStateChecker.isRelease)
			{
				CloseInteractiveIcon(isFinishInter: false);
			}
			OnInteractiving(deltaTime);
		}
	}

	public void ShowInterctiveIcon(InteractiveStateChecker interactiveStateChecker)
	{
		AddInteractiveStateChecker(interactiveStateChecker);
		isInteractiving = false;
	}

	private void CloseInteractiveIcon(bool isFinishInter)
	{
		interactiveTime = 0f;
		isInteractiving = false;
		if (stateComponent != null)
		{
			if (interactiveStateChecker.GetInteractiveState() != 0)
			{
				stateComponent.RemoveState(interactiveStateChecker.GetInteractiveState());
			}
			else
			{
				_inputSystem.SetPaused(paused: false);
			}
		}
		interactiveStateChecker.InteractiveCloseCallback(mBaseEntity.Id);
		_touchSystem.SetInteractionCooling(0f, interactionSkillType);
		if (isFinishInter)
		{
			interactionSkillType = HeroSkillTypeEnum.None;
		}
		RemoveInteractiveStateChecker(interactiveStateChecker, isFinishInter);
		interactiveStateChecker = null;
	}

	public void RemoveInteractiveStateChecker(InteractiveStateChecker checker, bool isFinishInter)
	{
		if (_battleHeroData != null)
		{
			_battleHeroData.RemoveInteractiveStateChecker(checker, isFinishInter);
		}
	}

	private void AddInteractiveStateChecker(InteractiveStateChecker checker)
	{
		if (_battleHeroData != null)
		{
			_battleHeroData.AddInteractiveStateChecker(checker);
		}
	}

	public void RemoveInteractive(InteractiveStateChecker interactiveStateChecker)
	{
		if (ContanisInteractiveChecker(interactiveStateChecker))
		{
			this.interactiveStateChecker = interactiveStateChecker;
			CloseInteractiveIcon(isFinishInter: false);
		}
	}

	private void FinishInteractive()
	{
		interactiveStateChecker.InteractiveFinishCallback(base.Entity.Id);
		int interactiveEntityId = interactiveStateChecker.GetInteractiveEntityId();
		BaseEntity entity = mBaseEntity.GetSystem<EntitySystem>().GetEntity(interactiveEntityId);
		ObserverInteractiveParams observerInteractiveParams = ReferencePool.Acquire<ObserverInteractiveParams>();
		observerInteractiveParams.Init(BattleObserverEventEnum.InteractiveSuccess, mBaseEntity, entity);
		mBaseEntity.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.InteractiveSuccess, observerInteractiveParams);
		ReferencePool.Release(observerInteractiveParams);
		CloseInteractiveIcon(isFinishInter: true);
	}

	private bool CheckHeroEntityState()
	{
		if (interactiveStateChecker.GetInteractiveState() == 0)
		{
			return true;
		}
		if (stateComponent != null && stateComponent.CanInteractive())
		{
			return stateComponent.GetCurrentState().Id.Equals(interactiveStateChecker.GetInteractiveState());
		}
		return false;
	}

	public bool CheckCanInteractiving()
	{
		if (_battleHeroData == null)
		{
			return false;
		}
		if (_battleHeroData.CheckCanInteractiving())
		{
			return base.Entity.GetComponent<StateComponent>().IsNormalState();
		}
		return false;
	}

	public bool ContanisInteractiveChecker(InteractiveStateChecker interactiveStateChecker)
	{
		if (_battleHeroData == null)
		{
			return false;
		}
		return _battleHeroData.ContanisInteractiveChecker(interactiveStateChecker);
	}

	public bool CheckInteractivingOther(InteractiveStateChecker interactiveStateChecker)
	{
		if (this.interactiveStateChecker != null)
		{
			return !this.interactiveStateChecker.IsSame(interactiveStateChecker);
		}
		return false;
	}

	public void StartInteractive(HeroSkillTypeEnum skillTypeEnum)
	{
		if (_battleHeroData == null)
		{
			return;
		}
		int num = 0;
		switch (skillTypeEnum)
		{
		case HeroSkillTypeEnum.Interaction1:
			num = 0;
			break;
		case HeroSkillTypeEnum.Interaction2:
			num = 1;
			break;
		case HeroSkillTypeEnum.Interaction3:
			num = 2;
			break;
		case HeroSkillTypeEnum.Interaction4:
			num = 3;
			break;
		}
		if (_battleHeroData.GetinteractiveStateCheckerCount() <= num)
		{
			return;
		}
		interactiveStateChecker = _battleHeroData.GetinteractiveStateCheckerByIndex(num);
		interactionSkillType = skillTypeEnum;
		if (interactiveStateChecker == null)
		{
			return;
		}
		interactiveTime = interactiveStateChecker.GetInteractiveTime();
		interactiveStateChecker.InteractiveStartCallback(base.Entity.Id);
		isInteractiving = true;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"获取交互时间 ：{interactiveTime}", mBaseEntity);
		}
		if (interactiveTime <= 0f)
		{
			FinishInteractive();
		}
		else if (stateComponent != null)
		{
			int interactiveState = interactiveStateChecker.GetInteractiveState();
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"获取交互物状态：{interactiveState}", mBaseEntity);
			}
			if (interactiveState != 0)
			{
				stateComponent.AddState(interactiveStateChecker.GetInteractiveState(), mBaseEntity.Id);
			}
			else
			{
				_inputSystem.SetPaused(paused: false);
			}
			int interactiveEntityId = interactiveStateChecker.GetInteractiveEntityId();
			BaseEntity entity = mBaseEntity.GetSystem<EntitySystem>().GetEntity(interactiveEntityId);
			ObserverInteractiveParams observerInteractiveParams = ReferencePool.Acquire<ObserverInteractiveParams>();
			observerInteractiveParams.Init(BattleObserverEventEnum.InteractiveStart, mBaseEntity, entity);
			mBaseEntity.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.InteractiveStart, observerInteractiveParams);
			ReferencePool.Release(observerInteractiveParams);
		}
	}

	private void OnInteractiving(float deltaTime)
	{
		if (!isInteractiving)
		{
			return;
		}
		if (!CheckHeroEntityState())
		{
			BaseEntity entity = mBaseEntity.GetSystem<EntitySystem>().GetEntity(interactiveStateChecker.GetInteractiveEntityId());
			ObserverInteractiveParams observerInteractiveParams = ReferencePool.Acquire<ObserverInteractiveParams>();
			observerInteractiveParams.Init(BattleObserverEventEnum.InteractiveBreak, mBaseEntity, entity);
			mBaseEntity.GetSystem<BattleObserverSystem>().Notify(BattleObserverEventEnum.InteractiveBreak, observerInteractiveParams);
			ReferencePool.Release(observerInteractiveParams);
			CloseInteractiveIcon(isFinishInter: false);
		}
		else if (interactiveTime > 0f)
		{
			interactiveTime -= deltaTime;
			if (base.Entity.IsActorEntity)
			{
				_touchSystem.SetInteractionCooling(1f - interactiveTime / interactiveStateChecker.GetInteractiveTime(), interactionSkillType);
			}
			if (interactiveTime <= 0f)
			{
				FinishInteractive();
			}
		}
	}

	public override void OnDispose()
	{
		stateComponent = null;
		interactiveStateChecker = null;
		_inputSystem = null;
		_touchSystem = null;
		base.OnDispose();
	}

	public int GetInteractiveEntityId()
	{
		return interactiveStateChecker?.GetInteractiveEntityId() ?? 0;
	}
}
