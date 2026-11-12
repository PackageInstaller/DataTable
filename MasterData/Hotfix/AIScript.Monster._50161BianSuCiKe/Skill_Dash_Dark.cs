using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50161BianSuCiKe;

public class Skill_Dash_Dark : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Start_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	private static readonly ComboInputBuffer.ActionKey[] Dash_Combo = new ComboInputBuffer.ActionKey[3];

	private static readonly FP searchDistanc = 5;

	private static readonly List<FP> searchAngles = new List<FP> { 120, 150, 180, 210, 240 };

	private FP dashDistance = 10;

	private FP dashSpeed = 70;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Start_Combo, flushInputedKeys: true);
		yield return WaitCustomEvent("ExitBattle");
		SetUnparalleledEnable();
		SetHideModelEnable();
		GetAttackTarget(isUpToDate: true);
		TSVector2 pointsByActorAndScreenTopDirWithRotationAnglesAndDistance = ILRuntimeAPI.GetPointsByActorAndScreenTopDirWithRotationAnglesAndDistance(_actor, searchAngles, searchDistanc, searchDistanc);
		Teleport(pointsByActorAndScreenTopDirWithRotationAnglesAndDistance);
		BeginLookAt_NotWait(GetAttackTarget(), 0.1, 999);
		BeginAttack(1, Dash_Combo, flushInputedKeys: true);
		BeginLookAt_NotWait(GetAttackTarget(), 999, 999);
		yield return WaitCustomEvent("HideModelDisable");
		SetHideModelDisable();
		PlayEffect("DashCharge", 1f, 0, GetPosition(), 0, 1f, actorScale: true);
		yield return WaitCustomEvent("JoinBattle");
		SetUnparalleledDisable();
		yield return WaitCustomEvent("BackDash");
		BeginDash(2, GetForward() * -1, 2.5, 1.5, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitCustomEvent("FlashFX");
		PlayEffect("FlashFX", 1f, 3.8, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0.88, -0.72)), 0, 1f, actorScale: true);
		StopWaitLookAt();
		yield return WaitCustomEvent("Dash");
		BeginDashActorForward(1, dashSpeed, dashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
