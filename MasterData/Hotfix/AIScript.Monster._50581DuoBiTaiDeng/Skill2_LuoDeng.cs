using System.Collections;

namespace AIScript.Monster._50581DuoBiTaiDeng;

public class Skill2_LuoDeng : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	protected ComboInputBuffer.ActionKey[] _actionKey;

	private static readonly int BuffID = 505810001;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		GetAttackTarget();
		BeginAttack(1, Attack_1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.6);
		foreach (LogicEntity item in GetTargetsByFaction(isFriend: true))
		{
			AddBuffToTarget(item, BuffID);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
