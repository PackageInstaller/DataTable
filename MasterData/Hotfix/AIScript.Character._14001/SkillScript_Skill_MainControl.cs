using System;
using AIScript.Utils;

namespace AIScript.Character._14001;

public class SkillScript_Skill_MainControl : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.logicVariable.ToggleLogicTag("IsTransformToTank", value: false);
		_actor.logicVariable.ToggleLogicTag("IsTransformToMiniGun", value: false);
	}

	public void OnStart()
	{
		Action onActivationEnd = OnActivationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("140_Main_Skill_Transform", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, onActivationEnd);
	}

	private void OnActivationEnd()
	{
		if (_actor.logicVariable.GetLogicTagToggle("HoldingKeyB"))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514006, out var _))
			{
				Action onComboFinish = OnFinish;
				Action onInterrupt = OnInterrupt;
				BeginAttack("140_Main_Skill_Type_Fly", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
				_actor.ReplaceAnimationGroup(2);
			}
			else
			{
				Action onInterrupt = OnFinish;
				Action onComboFinish = OnInterrupt;
				BeginAttack("140_Main_Skill_Type_Cannon", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onInterrupt, onComboFinish);
				_actor.ReplaceAnimationGroup(1);
			}
			_actor.logicVariable.ToggleLogicTag("IsTransformToMiniGun", value: true);
		}
		else
		{
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack("140_Main_Skill_Type_Tank", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
			_actor.ReplaceAnimationGroup();
			_actor.logicVariable.ToggleLogicTag("IsTransformToTank", value: true);
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
	}
}
