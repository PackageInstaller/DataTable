using System.Collections;

namespace AIScript.Monster._50531DaGuanZi;

public class Skill4_GetOut : SkillSimpleBase
{
	protected readonly int startKeyIndex1 = 1;

	protected readonly ComboInputBuffer.ActionKey[] startKey1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		SetBlockPriorityToStatic();
		SetLockToughnessEnable();
		AddBuffToTarget(_actor, 990020140);
	}

	protected override void OnSkillDisable()
	{
		ResetBlockPriority();
		RemoveBuffFromTarget(_actor, 990020140);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, startKey1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(2.5);
		ReplaceAnimationGroup(1);
		SetLogicTagToggleValue(_actor, "DaGuanZiToXiaoGuanZi", value: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
