using System.Collections.Generic;
using Ase.ECS;
using UnityEngine.Pool;

namespace Ase;

public class BuffConditionMonsterOD : BuffConditionBase
{
	private List<BaseEntity> damageEntityList = new List<BaseEntity>();

	protected EntityTeamType teamType;

	protected MonsterPhaseEnum odState;

	protected bool conditionVal;

	public override BuffConditionType BuffConditionType => BuffConditionType.MonsterOD;

	protected override int paramsMinCount => 3;

	protected override void OnInit(List<string> paramList)
	{
		teamType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[0]);
		odState = Utility.Convert.StringToEnum<MonsterPhaseEnum>(paramList[1]);
		conditionVal = Utility.Convert.StringToBool(paramList[2]);
		EventType = BattleObserverEventEnum.AttackBefore;
	}

	protected override string OnGetDataString()
	{
		return $"{teamType},{odState},{conditionVal}";
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
		List<BaseEntity> targetByTeamTypeList = BuffExtension.GetTargetByTeamTypeList(entityFrom, entityTarget, teamType, damageEntityList, isCreateNewList: false);
		if (targetByTeamTypeList == null)
		{
			return false;
		}
		bool flag = false;
		foreach (BaseEntity item in targetByTeamTypeList)
		{
			if (ValidState(item, odState))
			{
				flag = true;
				break;
			}
		}
		CollectionPool<List<BaseEntity>, BaseEntity>.Release(targetByTeamTypeList);
		return flag == conditionVal;
	}

	private bool ValidState(BaseEntity entity, MonsterPhaseEnum odState)
	{
		if (entity is MonsterEntity monsterEntity)
		{
			MonsterPhaseComponent component = monsterEntity.GetComponent<MonsterPhaseComponent>();
			if (component != null && component.GetMonsterPhase() == odState)
			{
				return true;
			}
		}
		return false;
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
