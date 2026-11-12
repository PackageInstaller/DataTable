using System.Collections;
using TrueSync;

namespace AIScript.Monster._50571FengShanJi;

public class Skill_Crush_Zizouqi : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Crush_Combo_Normal = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.P };

	private static readonly ComboInputBuffer.ActionKey[] Crush_Combo_Update = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Q };

	private static readonly FP CrushSpeedP1 = 40;

	private static readonly FP CrushSpeedP2 = 40;

	private static readonly FP CrushDistance = 16;

	private ComboInputBuffer.ActionKey[] Crush_Combo;

	private FP CrushSpeed;

	private FP Phase;

	private string CrushWarningLineFX;

	private float CrushWarningLineFXScale;

	protected override void OnSkillEnable()
	{
		Phase = GetLogicTagFpValue(_actor, "Phase");
		if (Phase == 1)
		{
			Crush_Combo = Crush_Combo_Normal;
			CrushSpeed = CrushSpeedP1;
			CrushWarningLineFX = "CrushWarningLine1";
			CrushWarningLineFXScale = 1f;
		}
		else
		{
			Crush_Combo = Crush_Combo_Update;
			CrushSpeed = CrushSpeedP2;
			CrushWarningLineFX = "CrushWarningLine2";
			CrushWarningLineFXScale = 0.75f;
		}
	}

	protected override void OnSkillDisable()
	{
		if (Phase == 2)
		{
			AddBuffToTarget(_actor, 505719913);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return BeginLookAt(GetAttackTarget(isUpToDate: true), 0, 200);
		BeginAttack(1, Crush_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		if (Phase == 2)
		{
			AddBuffToTarget(_actor, 505719912);
		}
		WaitLookAt_NoWait(GetAttackTarget(), 999, 150);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		StopWaitLookAt();
		Skill_Crush_Zizouqi skill_Crush_Zizouqi = this;
		string crushWarningLineFX = CrushWarningLineFX;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		float crushWarningLineFXScale = CrushWarningLineFXScale;
		skill_Crush_Zizouqi.PlayEarlyWarningEffect(crushWarningLineFX, 0.5f, default, position, rotation, crushWarningLineFXScale);
		yield return WaitTime(0.5);
		BeginDashActorForward(1, CrushSpeed, CrushDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		BeginAttack(1, Crush_Combo);
		BeginDashActorForward(2, 6, 3, 999, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		WaitLookAt_NoWait(GetAttackTarget(), 999, 360);
		yield return WaitCustomEvent("StopBrakeTurn");
		StopWaitLookAt();
		Skill_Crush_Zizouqi skill_Crush_Zizouqi2 = this;
		string crushWarningLineFX2 = CrushWarningLineFX;
		position = GetPosition();
		rotation = GetRotation();
		crushWarningLineFXScale = CrushWarningLineFXScale;
		skill_Crush_Zizouqi2.PlayEarlyWarningEffect(crushWarningLineFX2, 0.5f, default, position, rotation, crushWarningLineFXScale);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		BeginDashActorForward(1, CrushSpeed, CrushDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		CancelAttack();
		if (Phase == 2)
		{
			AddBuffToTarget(_actor, 505719913);
		}
		BeginDashActorForward(2, 6, 3, 999, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		WaitLookAt_NoWait(GetAttackTarget(), 999, 360);
		yield return WaitCustomEvent("StopBrakeTurn");
		StopWaitLookAt();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
