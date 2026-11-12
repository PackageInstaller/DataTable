using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50161BianSuCiKe;

public class Skill_Dash_Daily_1 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Start_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	private static readonly ComboInputBuffer.ActionKey[] Dash_Combo = new ComboInputBuffer.ActionKey[3];

	private static readonly FP searchDistanc = 10;

	private static readonly List<FP> searchAngles = new List<FP> { 120, 150, 180, 210, 240 };

	private FP dashDistance = 15;

	private FP dashSpeed = 50;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Start_Combo, flushInputedKeys: true);
		yield return WaitCustomEvent("ExitBattle");
		SetUnparalleledEnable();
		SetHideModelEnable();
		GetAttackTarget(isUpToDate: true);
		TSVector2 pointsByActorAndScreenTopDirWithRotationAnglesAndDistance = ILRuntimeAPI.GetPointsByActorAndScreenTopDirWithRotationAnglesAndDistance(_actor, searchAngles, searchDistanc, searchDistanc);
		Teleport(pointsByActorAndScreenTopDirWithRotationAnglesAndDistance);
		BeginLookAt_NotWait(GetAttackTarget(), 1, 999);
		yield return WaitTime(1);
		StopWaitLookAt();
		PlayEffect("fx_common_base_Dash_YuJing_20_start", 1f, 0, GetPosition(), 0, 1f, actorScale: true);
		BeginAttack(1, Dash_Combo, flushInputedKeys: true);
		yield return WaitCustomEvent("HideModelDisable");
		SetHideModelDisable();
		PlayEffect("DashCharge", 1f, 0, GetPosition(), 0, 1f, actorScale: true);
		yield return WaitCustomEvent("JoinBattle");
		SetUnparalleledDisable();
		yield return WaitCustomEvent("BackDash");
		BeginDash(2, GetForward() * -1, 2.5, 1.5, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitCustomEvent("FlashFX");
		PlayEffect("FlashFX", 1f, 3.8, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0.88, -0.72)), 0, 1f, actorScale: true);
		yield return WaitCustomEvent("Dash");
		SetCloseBlockEnable();
		BeginDashActorForward(1, dashSpeed, dashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetCloseBlockDisable();
		AimAtMonsterTarget(160);
		yield return WaitTime(2);
		CancelAim();
	}
}
