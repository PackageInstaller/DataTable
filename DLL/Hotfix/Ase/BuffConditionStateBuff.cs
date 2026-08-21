using System.Collections.Generic;
using Ase.ECS;
using UnityEngine.Pool;

namespace Ase;

public class BuffConditionStateBuff : BuffConditionBase
{
	private List<BaseEntity> damageEntityList = new List<BaseEntity>();

	protected int stateId;

	protected int curStateId;

	protected EntityTeamType teamType;

	protected bool conditionVal;

	public override BuffConditionType BuffConditionType => BuffConditionType.StateBuff;

	protected override int paramsMinCount => 3;

	protected override void OnInit(List<string> paramList)
	{
		stateId = Utility.Convert.StringToInt(paramList[0]);
		teamType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[1]);
		conditionVal = Utility.Convert.StringToBool(paramList[2]);
		EventType = BattleObserverEventEnum.AttackBefore;
	}

	protected override string OnGetDataString()
	{
		return $"{stateId},{teamType},{conditionVal}";
	}

	protected override void OnMessage(IObserverParams param)
	{
		ObserverDamageProgressParams observerDamageProgressParams = (ObserverDamageProgressParams)param;
		if (teamType != EntityTeamType.DamageTarget || observerDamageProgressParams.Attacker == null || observerDamageProgressParams.Attacker.Id != entityTarget.Id)
		{
			return;
		}
		for (int i = 0; i < damageEntityList.Count; i++)
		{
			if (damageEntityList[i].Id == observerDamageProgressParams.Defender.Id)
			{
				return;
			}
		}
		damageEntityList.Add(observerDamageProgressParams.Defender);
	}

	public override bool OnCheck(Buff buff = null)
	{
		return CompareStateValue();
	}

	private bool CompareStateValue()
	{
		List<BaseEntity> targetByTeamTypeList = BuffExtension.GetTargetByTeamTypeList(entityFrom, entityTarget, teamType, damageEntityList, isCreateNewList: false);
		if (targetByTeamTypeList == null)
		{
			return false;
		}
		bool flag = false;
		foreach (BaseEntity item in targetByTeamTypeList)
		{
			if (ValidState(item, stateId))
			{
				flag = true;
				break;
			}
		}
		CollectionPool<List<BaseEntity>, BaseEntity>.Release(targetByTeamTypeList);
		return flag == conditionVal;
	}

	protected virtual bool ValidState(BaseEntity baseEntity, int stateId)
	{
		return baseEntity.GetComponent<StateComponent>()?.ContainsImmuneBuff(stateId) ?? false;
	}

	protected override void OnCheckSyncBattleSafeAction()
	{
		base.OnCheckSyncBattleSafeAction();
		if (teamType != EntityTeamType.Actor)
		{
			_ = teamType;
			_ = 12;
		}
	}

	protected override void OnReset()
	{
		damageEntityList?.Clear();
	}

	protected override void OnDispose()
	{
		damageEntityList?.Clear();
	}
}
