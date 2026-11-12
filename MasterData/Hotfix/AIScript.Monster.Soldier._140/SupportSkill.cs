using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._140;

public class SupportSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Support";

	private readonly FP loopDuration = 0.6;

	private readonly string eventName_GenerateAreaEffect = "Fire";

	private readonly string areaEffectKey = "AreaEffect_1";

	private readonly string areaEffectKey_Potential = "AreaEffect_2";

	private readonly int extraTriggerTargetCount_Potential = 2;

	private int _potentialLv;

	private bool _beginLoop;

	private FP _loopDuration;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
	}

	public void OnStart()
	{
		string actionTag = comboTag;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnAnticipationEnd()
	{
		_loopDuration = loopDuration;
		_beginLoop = true;
	}

	public void OnUpdate()
	{
		if (_beginLoop)
		{
			if (_loopDuration > 0)
			{
				_loopDuration -= _actor.LogicDeltaTime;
				return;
			}
			_beginLoop = false;
			comboAttack.CancelAttack();
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (!string.Equals(eventName, eventName_GenerateAreaEffect))
		{
			return;
		}
		TSVector2 position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position);
		string fxAlias = areaEffectKey;
		if (_potentialLv >= 2)
		{
			fxAlias = areaEffectKey_Potential;
		}
		ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position);
		if (!(_actor.attackTarget != null) || _potentialLv < 3 || !(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return;
		}
		List<SoldierActor> battleActors = soldierLevelController.GetBattleActors(_actor.attackTarget as AdventureActor);
		battleActors.Remove(_actor.attackTarget as SoldierActor);
		if (battleActors != null && battleActors.Count > 0)
		{
			int num = extraTriggerTargetCount_Potential;
			int num2 = 0;
			while (num2 < battleActors.Count && num > 0)
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, battleActors.get_Item(num2).tsTransform.Position);
				num2++;
				num--;
			}
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_beginLoop = false;
		_loopDuration = 0;
	}
}
