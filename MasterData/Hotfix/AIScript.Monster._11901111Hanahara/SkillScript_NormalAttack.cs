using System;

namespace AIScript.Monster._11901111Hanahara;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	protected readonly ComboInputBuffer.ActionKey[] key = new ComboInputBuffer.ActionKey[4]
	{
		(ComboInputBuffer.ActionKey)1750359160,
		(ComboInputBuffer.ActionKey)1348824421,
		(ComboInputBuffer.ActionKey)1550545509,
		(ComboInputBuffer.ActionKey)1835362388
	};

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
		ComboInputBuffer.ActionKey[] keys = key;
		System.Action onComboFinish = OnFinishOrInterrupt;
		System.Action onInterrupt = OnFinishOrInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	protected void OnFinishOrInterrupt()
	{
		_skill.Clear();
	}
}
