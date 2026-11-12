using System.Collections;

namespace AIScript.Monster._30281ShengDanTaLou;

public class Skill_04 : SkillSimpleBase
{
	private string Attack = "Skill04and05";

	private string Rest = "Skill04_Rest";

	private long WarningFX;

	private long DotArea;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopEffect(WarningFX);
		StopAreaEffect(DotArea);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("StartDash");
		SetCloseBlockEnable();
		DotArea = PlayAreaEffect("Area_30281_Skill04_Dot", GetPosition());
		BeginTrace(GetCurrentPlayer(), 1, -1, 3);
		yield return WaitTraceFinish();
		SetCloseBlockDisable();
		StopAreaEffect(DotArea);
		WarningFX = PlayEarlyWarningEffect("Effect_Skill04_Warning", 1f, default, GetPosition());
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.6, 360);
		yield return WaitTime(0.65);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
