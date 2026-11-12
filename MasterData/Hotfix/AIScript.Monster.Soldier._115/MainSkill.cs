using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._115;

public class MainSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Skill";

	private readonly string eventName_GenerateAreaEffect = "Fire";

	private readonly string areaEffectKey = "AreaEffect_1";

	private readonly string areaEffectKey_Potential = "AreaEffect_2";

	private int _potentialLv;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
	}

	public void OnStart()
	{
		string actionTag = comboTag;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventName_GenerateAreaEffect))
		{
			TSVector2 position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position);
			string fxAlias = areaEffectKey;
			if (_potentialLv >= 2)
			{
				fxAlias = areaEffectKey_Potential;
			}
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position);
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
	}
}
