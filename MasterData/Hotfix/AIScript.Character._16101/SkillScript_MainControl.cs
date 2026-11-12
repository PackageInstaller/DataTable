using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16101;

public class SkillScript_MainControl : SkillAdvancedBase
{
	private const string key_Skill = "161_Skill_Main";

	private const string evt_Summon = "SummonEvt";

	private const int exploreResCount = 5;

	private static readonly FP exploreRadius = 5;

	private static readonly FP exploreMinDist = 0.5;

	private const int perkId_2 = 516102;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnUpdate()
	{
		LockDirection();
	}

	public void OnStart()
	{
		ExploreResourcePoints();
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack("161_Skill_Main", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("SummonEvt"))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.eventHashCode = Config.summonEvt;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private void ExploreResourcePoints()
	{
		DeterministicShape shape = new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Circle,
			radius = exploreRadius,
			position = _actor.tsTransform.Position
		};
		List<TSVector2> list = new List<TSVector2>(5);
		int num = 0;
		int num2 = 40;
		string fxAlias = (GetPerk(516102) ? "Drop_16101_Res_P02" : "Drop_16101_Res");
		while (list.Count < 5 && num < num2)
		{
			num++;
			TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, shape);
			bool flag = true;
			for (int i = 0; i < list.Count; i++)
			{
				if (TSVector2.Distance(list.get_Item(i), randomPointInShape) < exploreMinDist)
				{
					flag = false;
					break;
				}
			}
			if (flag)
			{
				list.Add(randomPointInShape);
				FP terrainHeight = CommonHelper.GetTerrainHeight(randomPointInShape, 0);
				ILRuntimeAPI.PlayDrop(_actor, fxAlias, randomPointInShape, terrainHeight);
			}
		}
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		_skill?.Clear();
	}
}
