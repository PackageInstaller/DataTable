using System.Collections.Generic;
using UnityEngine.Pool;

namespace Ase;

public class BuffConditionEventDamageTimer : BuffConditionBase
{
	private EntityTeamType teamType1;

	private EntityTeamType teamType2;

	private float timer;

	private int count;

	private float tempTime;

	private bool isHit;

	private bool conditionVal;

	private List<float> attackTimerList;

	protected override BattleObserverEventEnum EventType
	{
		get
		{
			return base.EventType;
		}
		set
		{
			base.EventType = value;
		}
	}

	public override BuffConditionType BuffConditionType => BuffConditionType.EventDamageTimer;

	protected override int paramsMinCount => 5;

	protected override void OnInit(List<string> paramList)
	{
		EventType = Utility.Convert.StringToEnum<BattleObserverEventEnum>(paramList[0]);
		teamType1 = Utility.Convert.StringToEnum<EntityTeamType>(paramList[1]);
		teamType2 = Utility.Convert.StringToEnum<EntityTeamType>(paramList[2]);
		timer = Utility.Convert.StringToFloat(paramList[3]);
		count = Utility.Convert.StringToInt(paramList[4]);
		tempTime = timer;
		conditionVal = false;
		attackTimerList = CollectionPool<List<float>, float>.Get();
		runtimeData = new BuffRuntimeDataBase();
	}

	protected override string OnGetDataString()
	{
		return $"{EventType},{teamType1},{teamType2},{timer},{count}";
	}

	protected override void OnMessage(IObserverParams param)
	{
		if (!(param is ObserverDamageProgressParams observerDamageProgressParams) || conditionVal)
		{
			return;
		}
		if (param.ObserverEventType == BattleObserverEventEnum.Attack || param.ObserverEventType == BattleObserverEventEnum.AttackBefore)
		{
			if (!ConditionUtility.CompareTargetInTeamType(observerDamageProgressParams.Trigger, entityFrom, entityTarget, teamType1))
			{
				return;
			}
		}
		else if ((param.ObserverEventType == BattleObserverEventEnum.Damage || param.ObserverEventType == BattleObserverEventEnum.DamageBefore) && !ConditionUtility.CompareTargetInTeamType(observerDamageProgressParams.Trigger, entityFrom, entityTarget, teamType2))
		{
			return;
		}
		isHit = true;
		attackTimerList.Add(tempTime);
		if (!conditionVal)
		{
			conditionVal = CheckCondition();
		}
		if (conditionVal)
		{
			runtimeData.toEntity = observerDamageProgressParams.Trigger;
			OnResetTimer();
		}
	}

	private bool CheckCondition()
	{
		int num = attackTimerList.Count;
		if (num < count)
		{
			return false;
		}
		return attackTimerList[num - 1] - attackTimerList[num - count] <= timer;
	}

	public override void Update(float deltaTime)
	{
		if (isHit)
		{
			tempTime += deltaTime;
			if (attackTimerList.Count > 0 && tempTime - attackTimerList[attackTimerList.Count - 1] > timer)
			{
				OnResetTimer();
			}
		}
	}

	public override bool OnCheck(Buff buff = null)
	{
		return conditionVal;
	}

	protected override void OnCheckSyncBattleSafeAction()
	{
		base.OnCheckSyncBattleSafeAction();
		if (teamType1 != EntityTeamType.Actor)
		{
			_ = teamType1;
			_ = 12;
		}
		if (teamType2 != EntityTeamType.Actor)
		{
			_ = teamType2;
			_ = 12;
		}
	}

	protected override void OnReset()
	{
		conditionVal = false;
	}

	private void OnResetTimer()
	{
		isHit = false;
		attackTimerList.Clear();
		tempTime = 0f;
	}

	protected override void OnDispose()
	{
		conditionVal = false;
		CollectionPool<List<float>, float>.Release(attackTimerList);
	}
}
