using System.Collections;
using TrueSync;

namespace AIScript.Monster._50541ChuShi;

public class Skill1_SlashTwice : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] SlashTwice = new ComboInputBuffer.ActionKey[2];

	private FP RotateSpeed;

	protected override void OnSkillEnable()
	{
		RotateSpeed = GetRotSpdInSkill();
	}

	protected override void OnSkillDisable()
	{
		StopWaitLookAt();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, SlashTwice, flushInputedKeys: true);
		yield return WaitCustomEvent("SlashLightFX");
		PlayEffect("SlashLight");
		yield return WaitCustomEvent("Slash1FX");
		Skill1_SlashTwice skill1_SlashTwice = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill1_SlashTwice.PlayEffect("Slash1", 1f, default, position, rotation);
		yield return WaitCustomEvent("Slash2FX");
		PlayEffect("Slash2");
		yield return WaitCustomEvent("StartTurn2");
		BeginLookAt_NotWait(GetAttackTarget(isUpToDate: true), 999, RotateSpeed * 2.5);
		yield return WaitCustomEvent("StopTurn2");
		StopWaitLookAt();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
