using System.Collections;
using TrueSync;

namespace AIScript.Monster._30281ShengDanTaLou;

public class Skill_05 : SkillSimpleBase
{
	private string Attack = "Skill04and05";

	private string Rest = "Skill04_Rest";

	private long WarningFX;

	private long DotArea;

	private TSVector2 SpawnPos = new TSVector2(0, -15);

	private TSVector2 CenterPos = new TSVector2(0, 10);

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
		BeginLookAtByDir_NotWait(SpawnPos, 0.5, 360);
		yield return WaitTime(0.5);
		Dash();
		BeginLookAtByDir_NotWait(CenterPos, 5, 30);
		yield return WaitDashFinish();
		StopWaitLookAt();
		SetCloseBlockDisable();
		StopAreaEffect(DotArea);
		WarningFX = PlayEarlyWarningEffect("Effect_Skill04_Warning", 1f, default, GetPosition());
		BeginLookAtByDir_NotWait(CenterPos, 0.5, 360);
		yield return WaitTime(0.65);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void Dash()
	{
		BeginDash(1, SpawnPos - GetPosition(), 8, Distance(GetPosition(), SpawnPos), 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.5);
	}
}
