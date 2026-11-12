#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._10019BanShenHua;

public class Skill_Born : SkillSimpleBase
{
	private static readonly int BornIndex = 1;

	private static readonly string BornAction = "Born";

	private static CoroutineNode TimeLimit;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		StopCoroutine(TimeLimit);
	}

	protected override IEnumerator DoMainLogic()
	{
		TimeLimit = StartCoroutine(SkillDuration());
		BeginAttack(BornIndex, BornAction, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopCoroutine(TimeLimit);
	}

	protected IEnumerator SkillDuration()
	{
		yield return WaitTime(10);
		CancelAttack();
		NovaLogger.Debug("异常结束");
		yield return WaitCombo(ComboAttackType.isComboFinish);
		InterruptSkill();
	}
}
