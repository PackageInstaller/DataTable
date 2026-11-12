using System.Collections;
using TrueSync;

namespace AIScript.Monster._30901ChiHou;

public class SummonSkill01_ShieldDash : SkillSimpleBase
{
	private readonly string ShieldDash = "ShieldDash";

	private readonly FP DashSpeed = 15;

	private readonly FP DashDistance = 22;

	private TSVector2 DashForward;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (GetPosition().x < 0)
		{
			DashForward = TSVector2.right;
		}
		else
		{
			DashForward = TSVector2.left;
		}
		SetUnparalleledEnable();
		SetCloseBlockEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return BeginLookAtByDir(DashForward, 0.1, 3600);
		BeginAttack(1, ShieldDash, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEarlyWarningEffect("fx_warning_dash_2_5x20", 1f, 0, GetPosition(), GetTSVectToAngle(GetForward(), 0));
		yield return WaitCustomEvent("ShieldOn");
		ModelNodeShow("shield", isShow: true);
		yield return WaitCustomEvent("Dash");
		Dash();
		yield return WaitDashFinish();
		CancelAttack();
		yield return WaitCustomEvent("ShieldOff");
		ModelNodeShow("shield", isShow: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(GetRandomValue(0, 1));
	}

	private void Dash()
	{
		BeginDashActorForward(1, DashSpeed, DashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}
}
