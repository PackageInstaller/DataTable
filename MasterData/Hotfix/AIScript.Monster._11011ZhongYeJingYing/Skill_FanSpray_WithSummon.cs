using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._11011ZhongYeJingYing;

public class Skill_FanSpray_WithSummon : Skill_FanSpray
{
	protected const string beginFirstRotateEvt = "Turn";

	protected const string switchRotateEvt = "TurnOver";

	protected const string endSecnodRotateEvt = "TurnOver2";

	protected const string summonEvt = "Step";

	protected FP firstRotateSpeed = 240;

	protected FP secondRotateSpeed = 50;

	protected const int monsterId = 5050501;

	protected readonly List<TSVector2> position_PlanA = new List<TSVector2>
	{
		new TSVector2(0, 7.2),
		new TSVector2(0, -7.2)
	};

	protected readonly List<FP> direction_PlanA = new List<FP> { -270, -90 };

	protected readonly List<TSVector2> position_PlanB = new List<TSVector2>
	{
		new TSVector2(7.2, 0),
		new TSVector2(-7.2, 0)
	};

	protected readonly List<FP> direction_PlanB = new List<FP> { 180, 0 };

	protected readonly List<TSVector2> position_PlanC = new List<TSVector2>
	{
		new TSVector2(7.6, 7.2),
		new TSVector2(7.6, -7.2)
	};

	protected readonly List<FP> direction_PlanC = new List<FP> { -225, -135 };

	protected override void InitData()
	{
		_actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };
	}

	protected override void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "Turn"))
		{
			LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			if (activedPlayerActor != null)
			{
				_lookAtTarget?.BeginLookAt(_actor, activedPlayerActor, 0, firstRotateSpeed, null);
			}
		}
		else if (string.Equals(eventName, "TurnOver"))
		{
			_lookAtTarget?.StopLookAt();
			LogicEntity activedPlayerActor2 = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			if (activedPlayerActor2 != null)
			{
				_lookAtTarget?.BeginLookAt(_actor, activedPlayerActor2, 0, secondRotateSpeed, null);
			}
		}
		else if (string.Equals(eventName, "TurnOver2"))
		{
			_lookAtTarget?.StopLookAt();
		}
		else if (string.Equals(eventName, "Step"))
		{
			SummonMonster();
		}
	}

	protected void SummonMonster()
	{
		int num = (int)(long)_actor.logicVariable.GetLogicTagValue("SummonPlanIndex");
		List<TSVector2> list;
		List<FP> list2;
		switch (num)
		{
		case 0:
			list = position_PlanA;
			list2 = direction_PlanA;
			num++;
			break;
		case 1:
			list = position_PlanB;
			list2 = direction_PlanB;
			num++;
			break;
		case 2:
			list = position_PlanC;
			list2 = direction_PlanC;
			num = 0;
			break;
		default:
			list = position_PlanA;
			list2 = direction_PlanA;
			num = 0;
			break;
		}
		for (int i = 0; i < list.Count; i++)
		{
			list2.get_Item(i);
			TSVector2 dir = TSVector2.Rotate(TSVector2.up, list2.get_Item(i));
			ILRuntimeAPI.SummonMonster(_actor, 0, 5050501, list.get_Item(i), dir);
		}
		_actor.logicVariable.SetLogicTagValue("SummonPlanIndex", num);
	}
}
