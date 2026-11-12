using System.Collections;
using TrueSync;

namespace AIScript.Monster._30901ChiHou;

public class SummonSkill03_DashAndSmash : SkillSimpleBase
{
	private readonly string ShieldDash = "ShieldDash";

	private readonly string ShieldSmash = "ShieldSmash";

	private readonly FP DashSpeed = 15;

	private readonly FP DashDistance = 22;

	private readonly FP JumpTime = 0.63;

	private TSVector2 DashForward;

	private LogicEntity Targetenemy;

	private FP JumpPosition_x;

	private FP JumpPosition_y;

	private TSVector2 JumpPosition;

	private FP JumpSpeed;

	private FP JumpDistance;

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
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return BeginLookAtByDir(-DashForward, 0.1, 3600);
		GetEnemy();
		JumpPosition_x = GetEntityPosition(Targetenemy).x;
		JumpPosition_y = GetPosition().y;
		JumpPosition = GetTSVector2(JumpPosition_x, JumpPosition_y);
		JumpDistance = TSMath.Abs(JumpPosition_x - GetPosition().x);
		if (JumpDistance == 0)
		{
			JumpDistance = 1;
		}
		JumpSpeed = JumpDistance / JumpTime;
		BeginAttack(2, ShieldSmash, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEarlyWarningEffect("fx_warning_circular_2_5", 2.2f, 0, JumpPosition, default, 1.2f);
		yield return WaitCustomEvent("JumpStart");
		Jump();
		yield return WaitCustomEvent("ShieldOff");
		ModelNodeShow("shield", isShow: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(GetRandomValue(0, 1));
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	private void Dash()
	{
		BeginDashActorForward(1, DashSpeed, DashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private void Jump()
	{
		BeginDashActorForward(1, JumpSpeed, JumpDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}
}
