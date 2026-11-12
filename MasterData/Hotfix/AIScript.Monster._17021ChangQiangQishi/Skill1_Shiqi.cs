using System.Collections;

namespace AIScript.Monster._17021ChangQiangQishi;

public class Skill1_Shiqi : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly string Startfx = "fx_m17011_loop_atk1_2_start";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.5f);
		foreach (LogicEntity item in GetTargetByBuffID(170210020))
		{
			AddBuffToTarget(item, 170210010);
		}
		AddBuffToTarget(_actor, 170210030);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
