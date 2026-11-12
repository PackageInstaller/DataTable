using System.Collections;
using TrueSync;

namespace AIScript.Monster._50541ChuShi;

public class Skill2_Slash3Times : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Slash3Times = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.B,
		ComboInputBuffer.ActionKey.B
	};

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
		BeginAttack(1, Slash3Times, flushInputedKeys: true);
		yield return WaitCustomEvent("SlashLightFX");
		PlayEffect("SlashLightFire");
		yield return WaitCustomEvent("Slash1FX");
		Skill2_Slash3Times skill2_Slash3Times = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill2_Slash3Times.PlayEffect("Slash1Fire", 1f, default, position, rotation);
		yield return WaitCustomEvent("Slash2FX");
		PlayEffect("Slash2Fire");
		yield return WaitCustomEvent("StartTurn2");
		BeginLookAt_NotWait(GetAttackTarget(isUpToDate: true), 999, RotateSpeed * 2.5);
		yield return WaitCustomEvent("StopTurn2");
		StopWaitLookAt();
		yield return WaitCustomEvent("StartTurn3");
		BeginLookAt_NotWait(GetAttackTarget(isUpToDate: true), 999, RotateSpeed);
		yield return WaitCustomEvent("StopTurn3");
		StopWaitLookAt();
		yield return WaitCustomEvent("Slash3FX");
		Skill2_Slash3Times skill2_Slash3Times2 = this;
		position = GetPosition();
		rotation = GetRotation();
		skill2_Slash3Times2.PlayEffect("Slash3", 1f, default, position, rotation);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
