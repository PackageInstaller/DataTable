using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13001;

public class SkillScript_MainControl_Skill : SkillAdvancedBase
{
	private DeterministicShape _randomPositionShape;

	private SummonCfg _summonCfg;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		DefaultLookAt();
		_randomPositionShape.shapeType = DeterministicShape.ShapeType.Circle;
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustonEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("B1_Skill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustonEvent(string eventName)
	{
		if (string.Equals(eventName, "B1_Summon"))
		{
			Summon();
		}
	}

	private void Summon()
	{
		TSVector2 position = _actor.tsTransform.Position;
		TSVector2 dir = _actor.tsTransform.Forward;
		bool searchSuccess2;
		if (_actor.attackTarget != null)
		{
			position = GetSummonPosition(_actor.attackTarget, out var searchSuccess);
			if (!searchSuccess)
			{
				position = GetSummonPosition(_actor, out searchSuccess2);
			}
			dir = _actor.attackTarget.tsTransform.Position - position;
			dir.Normalize();
		}
		else
		{
			position = GetSummonPosition(_actor, out searchSuccess2);
		}
		if (_summonCfg == null)
		{
			_summonCfg = new SummonCfg
			{
				summonAttrType = SummonAttrType.InheritByInitialSnapshot,
				summonRelation = SummonRelation.Coexisted,
				attrPercent = 100,
				leftTime = Config_MainControl.durationTime_Summone_Skill
			};
		}
		ILRuntimeAPI.SummonMonster(_actor, 0, 13001111, position, dir, _summonCfg);
	}

	private TSVector2 GetSummonPosition(LogicEntity target, out bool searchSuccess)
	{
		FP radius = target.GetRadius();
		_randomPositionShape.innerRadius = radius;
		_randomPositionShape.radius = radius + Config_MainControl.randomRadius_SummonPosition_Skill;
		_randomPositionShape.position = target.tsTransform.Position;
		TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, _randomPositionShape);
		searchSuccess = randomPointInShape != _randomPositionShape.position;
		return randomPointInShape;
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513001, out var perkLevel))
		{
			_actor.logicVariable.ToggleLogicTag("TriggerPerk_P1", value: true);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513011, out perkLevel))
		{
			_actor.logicVariable.ToggleLogicTag("TriggerPerk_P11", value: true);
			_actor.buffComponent.AddBuff(13011011, _actor);
		}
	}
}
