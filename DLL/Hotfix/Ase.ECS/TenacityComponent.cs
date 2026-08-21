using UnityEngine;

namespace Ase.ECS;

public class TenacityComponent : BaseComponent
{
	private bool _isBoss;

	private bool recoverTenacity;

	private PropertyData tenacityData;

	private float tenacityBreakTime;

	private float tenacityRecoverTimer;

	public float GetTenacityValue()
	{
		return mBaseEntity.GetProperty("Tenacity");
	}

	public void ResetMonsterTenacity()
	{
		mBaseEntity.ResetProperty("Tenacity", toMax: true);
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		_isBoss = GetData<bool>("IsBoss");
		tenacityData = mBaseEntity.GetPropertyData("Tenacity");
		tenacityBreakTime = mBaseEntity.GetProperty("TenacityBreakTime");
	}

	public void SetTenacityValue(float value)
	{
		mBaseEntity.SetProperty("Tenacity", value);
	}

	public void DealTenacityHit(float finalCutTenacity, BaseEntity attackerEntity, ref bool bossKnockDown, ref int realTenacityValue)
	{
		if (recoverTenacity || (!_isBoss && mBaseEntity.GetProperty("Tenacity") == 0f) || mBaseEntity.GetPropertyMax("Tenacity") == 0f)
		{
			return;
		}
		float tenacityValue = GetTenacityValue();
		float num = tenacityValue;
		int num2 = Mathf.CeilToInt(tenacityValue - finalCutTenacity);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"处理受击削韧的逻辑 currentTenacity {tenacityValue}  finalCutTenacity  {finalCutTenacity}  finallyValue = {num2}", mBaseEntity);
		}
		SetTenacityValue(num2);
		tenacityValue = GetTenacityValue();
		if (tenacityValue == 0f)
		{
			CutEntityState(attackerEntity);
			if (_isBoss)
			{
				bossKnockDown = true;
			}
			else
			{
				mBaseEntity.GetComponent<HpComponent>()?.SetDownState(downState: true, GetDownStateDamageAddition());
			}
			recoverTenacity = true;
			tenacityRecoverTimer = 0f;
		}
		realTenacityValue = (num - tenacityValue).CeilToInt();
	}

	private string GetDownStateDamageAddition()
	{
		float downStateDamageAddition = mBaseEntity.GetComponent<StateComponent>().GetDownStateDamageAddition();
		downStateDamageAddition = 1f + downStateDamageAddition + mBaseEntity.GetProperty("KnockDownDamageAddition");
		return (int)(downStateDamageAddition * 100f) + "%";
	}

	public void SetMonsterKnockDown()
	{
		if (!recoverTenacity && (_isBoss || mBaseEntity.GetProperty("Tenacity") != 0f) && mBaseEntity.GetPropertyMax("Tenacity") != 0f)
		{
			if (_isBoss)
			{
				SetBossDownState(isDown: true, null, GetDownStateDamageAddition());
			}
			else
			{
				mBaseEntity.GetComponent<HpComponent>()?.SetDownState(downState: true, GetDownStateDamageAddition());
			}
			recoverTenacity = true;
			tenacityRecoverTimer = 0f;
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		RecoverTenacity(deltaTime);
	}

	private void SetBossDownState(bool isDown, BaseEntity attacker, string damageRatio)
	{
		BattleSystem system = mBaseEntity.GetSystem<BattleSystem>();
		MonsterPhaseComponent component = mBaseEntity.GetComponent<MonsterPhaseComponent>();
		system?.SetBossDown(isDown, damageRatio);
		component?.SetBossDown(isDown);
		if (isDown)
		{
			ObserverMonsterFuzzyParams observerMonsterFuzzyParams = new ObserverMonsterFuzzyParams();
			observerMonsterFuzzyParams.Init(attacker);
			mBaseEntity.GetSystem<BattleObserverSystem>().Notify(BattleObserverEventEnum.MonsterFuzzy, observerMonsterFuzzyParams);
		}
	}

	private void RecoverTenacity(float deltaTime)
	{
		if (!recoverTenacity || tenacityData == null)
		{
			return;
		}
		if (tenacityRecoverTimer >= tenacityBreakTime)
		{
			recoverTenacity = false;
			tenacityRecoverTimer = tenacityBreakTime;
			if (_isBoss)
			{
				SetBossDownState(isDown: false, null, string.Empty);
			}
			else
			{
				mBaseEntity.GetComponent<HpComponent>()?.SetDownState(downState: false, string.Empty);
			}
		}
		SetTenacityValue(tenacityRecoverTimer / tenacityBreakTime * tenacityData.MaxValue);
		tenacityRecoverTimer += deltaTime;
	}

	private void CutEntityState(BaseEntity baseEntity)
	{
		MonsterKnockDownLevelEnum monsterKnockDownLevelEnum = mBaseEntity.GetComponent<StateComponent>().GetCurrentState().StateConfig.MonsterKnockDownLevelEnum;
		int stateInfliction = baseEntity.Parent?.Id ?? 0;
		if (_isBoss)
		{
			switch (monsterKnockDownLevelEnum)
			{
			case MonsterKnockDownLevelEnum.None:
				mBaseEntity.GetComponent<StateComponent>().AddState(mBaseEntity.GetComponent<KnockDownStateWeightComponent>().GetKnockDownStateId(MonsterKnockDownLevelEnum.One), stateInfliction);
				mBaseEntity.GetComponent<EntityWarningComponent>()?.StopWarningIndicator(isForce: false);
				break;
			case MonsterKnockDownLevelEnum.One:
				mBaseEntity.GetComponent<StateComponent>().AddState(mBaseEntity.GetComponent<KnockDownStateWeightComponent>().GetKnockDownStateId(MonsterKnockDownLevelEnum.Two), stateInfliction);
				break;
			case MonsterKnockDownLevelEnum.Two:
				mBaseEntity.GetComponent<StateComponent>().AddState(mBaseEntity.GetComponent<KnockDownStateWeightComponent>().GetKnockDownStateId(MonsterKnockDownLevelEnum.Two), stateInfliction);
				break;
			}
		}
		else
		{
			if (monsterKnockDownLevelEnum == MonsterKnockDownLevelEnum.None)
			{
				mBaseEntity.GetComponent<EntityWarningComponent>()?.StopWarningIndicator(isForce: false);
			}
			mBaseEntity.GetComponent<StateComponent>().AddState(mBaseEntity.GetComponent<KnockDownStateWeightComponent>().MinionKnockDownState, stateInfliction);
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		recoverTenacity = false;
		tenacityData = null;
	}
}
