using UnityEngine;

namespace Ase.ECS;

public class ReBornComponent : BaseComponent
{
	private bool _cantRevived;

	private bool _isRebornState;

	private float _reBornTime;

	private float _time;

	private bool _isIgnoreRebornNumber;

	public bool CantRevived => _cantRevived;

	public bool IsRebornState => _isRebornState;

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		_time = (_reBornTime = 5f);
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		if (_isRebornState)
		{
			_time = Mathf.Clamp(_time -= deltaTime, 0f, _reBornTime);
			if (mBaseEntity is HeroEntity heroEntity)
			{
				heroEntity.BattleHeroData.SetRevivedTime(_time, _reBornTime);
			}
			if (_time <= 0f)
			{
				EntityExitRebornState();
			}
		}
	}

	public bool EntityEnterRebornState()
	{
		return false;
	}

	private void EntityExitRebornState()
	{
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId("死亡倒计时结束进入重生", mBaseEntity);
		}
		_isRebornState = false;
		_time = _reBornTime;
		mBaseEntity.RebornResetAllProperty();
		mBaseEntity.ChangeEntitySurvivalState();
		mBaseEntity.GetComponent<StateComponent>().EnterRebornState();
		mBaseEntity.GetSystem<CommandSystem>().ClearCacheCommand();
		if (mBaseEntity is HeroEntity heroEntity)
		{
			heroEntity.BattleHeroData.EntityExitDead();
		}
	}

	public void EntityForceReborn()
	{
		if (mBaseEntity.GetComponent<StateComponent>().IsDeadState())
		{
			mBaseEntity.ChangeEntitySurvivalState();
			mBaseEntity.GetComponent<StateComponent>().EnterNormalState();
			if (mBaseEntity is HeroEntity heroEntity)
			{
				heroEntity.BattleHeroData.EntityExitDead();
				mBaseEntity.GetSystem<CommandSystem>().ClearCacheCommand();
			}
		}
		if (mBaseEntity.GetComponent<StateComponent>().IsNearDeathState())
		{
			mBaseEntity.GetComponent<StateComponent>().EnterNormalState();
		}
		mBaseEntity.GetComponent<NearDeathRescueComponent>().OnEntityReborn();
		mBaseEntity.GetComponent<KinematicMoveComponent>().OnEntityReborn();
		mBaseEntity.GetSystem<BuffSystem>().FinishEntityBuffByTag(mBaseEntity.Id, "Battle");
		mBaseEntity.RebornResetProperty();
		mBaseEntity.GetComponent<EntityDynamicAbnormalMaterialComponent>()?.OnEntityReborn();
	}

	public override void OnEntityReborn()
	{
		_isRebornState = true;
	}
}
