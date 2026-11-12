using System.Collections;

namespace AIScript.Monster._50581DuoBiTaiDeng;

public class Skill_WanderAction : SkillSimpleBase
{
	private static readonly string WanderAction = "WanderAction";

	private static readonly ComboInputBuffer.ActionKey[] Attack_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.R };

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		UpdateData();
	}

	protected void UpdateData()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack_1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(4);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected void OnFinish()
	{
		_skill?.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}
}
