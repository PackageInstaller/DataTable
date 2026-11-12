using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._117;

public class MainSkill : SkillAdvancedBase
{
	private readonly string comboTag = "MainSkill";

	private readonly string eventName_PlayArea = "117_B2_Area";

	private readonly string areaEffectKey = "Area_MainSkill_ElectricCircle_Soldier";

	private readonly string areaEffectKey_Potential3 = "Area_MainSkill_ElectricCircle_Soldier_Large";

	private readonly FP areaDropDistance = 3;

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
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventName_PlayArea))
		{
			TSVector2 position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : (_actor.tsTransform.Position + _actor.tsTransform.Forward.normalized * areaDropDistance));
			string fxAlias = ((_potentialLv >= 3) ? areaEffectKey_Potential3 : areaEffectKey);
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position);
		}
	}

	public void OnUpdate()
	{
		LockDirection();
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
