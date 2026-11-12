using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50161BianSuCiKe;

public class Skill_Spin_Water : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Start_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	private static readonly ComboInputBuffer.ActionKey[] Dash_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly FP searchDistanc = 8;

	private static readonly List<FP> searchAngles = new List<FP>
	{
		50, 30, 10, -10, -30, -50, 70, -70, 90, -90,
		0
	};

	private long HideFX;

	protected override void OnSkillDisable()
	{
		StopEffect(HideFX);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Start_Combo, flushInputedKeys: true);
		yield return WaitCustomEvent("ExitBattle");
		SetUnparalleledEnable();
		SetHideModelEnable();
		yield return WaitTime(1);
		GetAttackTarget(isUpToDate: true);
		TSVector2 pointsByActorAndScreenTopDirWithRotationAnglesAndDistance = ILRuntimeAPI.GetPointsByActorAndScreenTopDirWithRotationAnglesAndDistance(_actor, searchAngles, searchDistanc, searchDistanc);
		Teleport(pointsByActorAndScreenTopDirWithRotationAnglesAndDistance);
		BeginAttack(1, Dash_Combo, flushInputedKeys: true);
		BeginLookAt_NotWait(GetAttackTarget(), 0.1, 999);
		yield return WaitCustomEvent("HideModelDisable");
		SetHideModelDisable();
		StopWaitLookAt();
		yield return WaitCustomEvent("JoinBattle");
		SetUnparalleledDisable();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		BeginLookAt_NotWait(GetAttackTarget(), 999, 50);
		yield return WaitTime(0.5);
		StopWaitLookAt();
		BeginAttack(1, Dash_Combo);
		long SpinAttackFX = PlayEffect("SpinAttackFX");
		yield return WaitTime(0.3);
		HideFX = PlayEffect("HideFX");
		yield return WaitTime(0.5);
		BeginLookAtMonsterTarget(999, 120);
		BeginDashActorForward(1, 4, 12, 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		StopEffect(SpinAttackFX);
		StopWaitLookAt();
		CancelAttack();
		StopEffect(HideFX);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
