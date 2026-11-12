using System.Collections;
using TrueSync;

namespace AIScript.Monster._50571FengShanJi;

public class Skill_Crush_BossRush : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Crush_Combo_Normal = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private readonly ComboInputBuffer.ActionKey[] Crush_Combo_Update = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private readonly ComboInputBuffer.ActionKey[] Crush_Combo_Update_Twice = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Q };

	private readonly FP CrushSpeed = 40;

	private readonly FP CrushDistance = 16;

	private ComboInputBuffer.ActionKey[] Crush_Combo;

	private FP Phase;

	private string CrushWarningLineFX;

	private float CrushWarningLineFXScale;

	private bool IsUpdate;

	protected override void OnSkillEnable()
	{
		Phase = GetLogicTagFpValue(_actor, "BattleStage");
		if (Phase == 1)
		{
			IsUpdate = false;
		}
		else
		{
			IsUpdate = true;
		}
		if (!IsUpdate)
		{
			Crush_Combo = Crush_Combo_Normal;
			CrushWarningLineFX = "CrushWarningLine1";
			CrushWarningLineFXScale = 1f;
			return;
		}
		if (Phase == 3)
		{
			Crush_Combo = Crush_Combo_Update_Twice;
		}
		else
		{
			Crush_Combo = Crush_Combo_Update;
		}
		CrushWarningLineFX = "CrushWarningLine2";
		CrushWarningLineFXScale = 0.75f;
	}

	protected override void OnSkillDisable()
	{
		if (IsUpdate)
		{
			AddBuffToTarget(_actor, 505719913);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return BeginLookAt(GetAttackTarget(isUpToDate: true), 0, 200);
		BeginAttack(1, Crush_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		if (IsUpdate)
		{
			AddBuffToTarget(_actor, 505719912);
		}
		WaitLookAt_NoWait(GetAttackTarget(), 999, 75);
		yield return WaitCustomEvent("StopTurn");
		StopWaitLookAt();
		Skill_Crush_BossRush skill_Crush_BossRush = this;
		string crushWarningLineFX = CrushWarningLineFX;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		float crushWarningLineFXScale = CrushWarningLineFXScale;
		skill_Crush_BossRush.PlayEarlyWarningEffect(crushWarningLineFX, 1f, default, position, rotation, crushWarningLineFXScale);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(0.5);
		BeginDashActorForward(1, CrushSpeed, CrushDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		if (Phase == 3)
		{
			BeginAttack(1, Crush_Combo);
			BeginDashActorForward(2, 6, 3, 999, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			WaitLookAt_NoWait(GetAttackTarget(), 999, 360);
			yield return WaitCustomEvent("StopBrakeTurn");
			StopWaitLookAt();
			Skill_Crush_BossRush skill_Crush_BossRush2 = this;
			string crushWarningLineFX2 = CrushWarningLineFX;
			position = GetPosition();
			rotation = GetRotation();
			crushWarningLineFXScale = CrushWarningLineFXScale;
			skill_Crush_BossRush2.PlayEarlyWarningEffect(crushWarningLineFX2, 0.5f, default, position, rotation, crushWarningLineFXScale);
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			BeginDashActorForward(1, CrushSpeed, CrushDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitDashFinish();
		}
		CancelAttack();
		if (IsUpdate)
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
