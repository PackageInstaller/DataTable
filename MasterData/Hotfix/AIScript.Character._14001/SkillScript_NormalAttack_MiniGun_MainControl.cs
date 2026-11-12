using System;
using AIScript.Utils;

namespace AIScript.Character._14001;

public class SkillScript_NormalAttack_MiniGun_MainControl : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	public void OnStart()
	{
		string comboTag = GetComboTag();
		if (string.IsNullOrEmpty(comboTag))
		{
			_skill.Clear();
			return;
		}
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(comboTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private string GetComboTag()
	{
		string result = "140_Attack_Cannon";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514006, out var _))
		{
			result = "140_Attack_Fly";
		}
		return result;
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget == null)
		{
			comboAttack.InterruptAttack();
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
	}
}
