using System;

namespace AIScript.Character._15801;

public class SkillScript_CoordinateAttack_Soldier_MainControl : SkillScript_Summoned
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_actor.attackTarget != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0f);
		}
	}

	public void OnStart()
	{
		string text = "15801_Soldier_Skill";
		if (HavePersonalPerk(515801, out var _))
		{
			text = "15801_Soldier_Skill_Strengthen";
		}
		string actionTag = text;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	public void OnFinish()
	{
		_skill.Clear();
	}

	public void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
