using System.Collections;
using TrueSync;

namespace AIScript.BrickBreaker._11501;

public class Skill : SkillSimpleBase
{
	private readonly string combo_key = "Skill_Attack";

	private readonly string combo_key2 = "Skill_End";

	private readonly FP skill_PaddleSpeed = 4;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		Singleton<BrickBreakerManager>.Instance.Paddle?.ChangeSpeed(skill_PaddleSpeed);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Singleton<BrickBreakerManager>.Instance.Paddle?.ResetSpeed();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, combo_key, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(2.1);
		BeginAttack(2, combo_key2, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.3);
		Singleton<BrickBreakerManager>.Instance.Paddle?.ResetSpeed();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	public void OnUpdate()
	{
	}

	protected override void OnCustomEvent(int comboIndex, string evt)
	{
	}
}
