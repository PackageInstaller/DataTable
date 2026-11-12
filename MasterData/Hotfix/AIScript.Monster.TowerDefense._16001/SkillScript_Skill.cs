using System;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.TowerDefense._16001;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string key_skill = "Skill";

	private string evt_summon = "160_Summon";

	private FP searchRange = 7.5;

	public const int summonedId = 8016001;

	private FP summonOffset = 1;

	private SummonCfg summonCfg = new SummonCfg
	{
		summonFollowType = SummonFollowType.NotFollow,
		summonAttrType = SummonAttrType.Self,
		summonRelation = SummonRelation.Coexisted,
		leftTime = -1,
		useSummonHit = false
	};

	private readonly List<LogicEntity> entities = new List<LogicEntity>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	private void DoMainLogic()
	{
		CommonUtils.SearchNearTargetsByCircleInTD(_actor, _actor.tsTransform.Position, searchRange, entities, isConfront: true);
		LogicEntity attackTarget = ((entities.Count > 0) ? entities.get_Item(0) : null);
		_actor.attackTarget = attackTarget;
		string actionTag = key_skill;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: true, attackTarget, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals(evt_summon))
		{
			TSVector2 result = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : (_actor.tsTransform.Position + _actor.tsTransform.Forward * summonOffset));
			if (!_actor.QueryPositionReachable(result))
			{
				_actor.QueryClosestPositionWalkable(result, out result);
			}
			CommonUtils.SummonMonster(_actor, 0, 8016001, result, _actor.tsTransform.Forward, summonCfg);
		}
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}
}
