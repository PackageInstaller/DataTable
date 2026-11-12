using System.Collections;
using TrueSync;

namespace AIScript.Monster._10501BanShenShu;

public class Skill_Weeds_MainlineShow : SkillSimpleBase
{
	private readonly int actionIndex;

	private readonly string attackAction = "GeneralAttack";

	private readonly string fx_L_Ground = "fx_m10501_loop_Skill8_ground_l";

	private readonly string fx_R_Ground = "fx_m10501_loop_Skill8_ground_r";

	private TSVector2 leftHitPOS = new TSVector2(10, 6.25);

	private TSVector2 rightHitPOS = new TSVector2(-10, 6.25);

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(actionIndex, attackAction, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		StartCor(Attack());
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator Attack()
	{
		TSVector2 selfPOS = GetPosition();
		TSVector2 forward = GetForward();
		TransLocalPosToWorldPos(selfPOS, forward, leftHitPOS);
		TransLocalPosToWorldPos(selfPOS, forward, rightHitPOS);
		PlayWwiseSound("mon_10010_general_attack_start");
		yield return WaitTime(0.8);
		PlayEffect(fx_L_Ground, 1f, default, selfPOS, 90);
		PlayEffect(fx_R_Ground, 1f, default, selfPOS, -90);
		yield return WaitTime(0.2);
		PlayWwiseSound("mon_10010_general_attack_end");
	}
}
