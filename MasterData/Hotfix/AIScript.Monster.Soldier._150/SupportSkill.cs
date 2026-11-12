using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._150;

public class SupportSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Support";

	private readonly string eventName_GenerateAreaEffect = "Fire";

	private readonly string areaEffectKey = "AreaEffect_A";

	private readonly string areaEffectKey_Potential2 = "AreaEffect_B";

	private readonly string areaEffectKey_Potential3 = "AreaEffect_C";

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
			string fxAlias = areaEffectKey;
			if (_potentialLv >= 3)
			{
				fxAlias = areaEffectKey_Potential3;
			}
			else if (_potentialLv >= 2)
			{
				fxAlias = areaEffectKey_Potential2;
			}
			TSVector2 position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position);
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
