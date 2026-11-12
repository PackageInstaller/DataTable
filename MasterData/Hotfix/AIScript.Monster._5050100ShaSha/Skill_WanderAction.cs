using System.Collections;

namespace AIScript.Monster._5050100ShaSha;

public class Skill_WanderAction : SkillSimpleBase
{
	private static readonly string WanderAction = "WanderAction";

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
		BeginAttack(1, WanderAction, flushInputedKeys: true, forceInterruptAttack: true);
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
