using System;
using AIScript.Utils;

namespace AIScript.Character._15801;

public class SkillScript_NormalAttack_Transfrom : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	public virtual void OnStart()
	{
		string text = (((PlayerAdventureActor)_actor).isAssist ? "Attack_Ultra_Support" : "Attack_Ultra");
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515841, out var _) && _actor.buffComponent.CheckBuffByBuffID(15841011))
		{
			text = (((PlayerAdventureActor)_actor).isAssist ? "Attack_Ultra_Support" : "Attack_Ultra");
		}
		string actionTag = text;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
	}
}
