#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._10019BanShenHua;

public class Skill_NormalAttack : SkillSimpleBase
{
	public static List<long> ringFxIndex = new List<long>();

	private static readonly int AttackIndex = 1;

	private static readonly string AttackCombo = "NormalAttack";

	private static readonly string Custom = "Attack";

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
		BeginAttack(AttackIndex, AttackCombo, flushInputedKeys: true, forceInterruptAttack: true);
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

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == Custom && comboIndex == AttackIndex)
		{
			ringFxIndex.Add(PlayEffect("fx_m10019_base_Skill1_atk", 0.8f));
			ringFxIndex.Add(PlayAreaEffect("DiffusionAttack", GetPosition(), GetRotation()));
		}
	}
}
