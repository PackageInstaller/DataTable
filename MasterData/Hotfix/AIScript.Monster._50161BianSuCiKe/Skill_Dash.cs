using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50161BianSuCiKe;

public class Skill_Dash : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys_1_1 = new ComboInputBuffer.ActionKey[3];

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_1_2 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey.A
	};

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_2_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_2_2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Q };

	private static readonly string customEvent_JoinBattle = "JoinBattle";

	private static readonly string customEvent_Dash = "Dash";

	private static readonly string customEvent_ExitBattle = "ExitBattle";

	private static readonly string customEvent_FlashFX = "FlashFX";

	private static readonly string customEvent_HideModelDisable = "HideModelDisable";

	private static readonly string customEvent_BackDash = "BackDash";

	private static readonly FP searchDistanc = 5.5;

	private static readonly FP searchDistancNear = 4.5;

	private static readonly List<FP> searchAngles = new List<FP> { 120, 150, 180, 210, 240 };

	private FP dashDistance = 10;

	private FP dashSpeed = 70;

	private ComboInputBuffer.ActionKey[] actionKeys_1;

	private ComboInputBuffer.ActionKey[] actionKeys_2;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		if (GetLogicTagFpValue(_actor, "Phase") == 1)
		{
			actionKeys_1 = actionKeys_1_1;
		}
		else
		{
			actionKeys_1 = actionKeys_1_2;
		}
		GetAttackTarget(isUpToDate: true);
		TSVector2 pointsByActorAndScreenTopDirWithRotationAnglesAndDistance = ILRuntimeAPI.GetPointsByActorAndScreenTopDirWithRotationAnglesAndDistance(_actor, searchAngles, searchDistanc, searchDistancNear);
		Teleport(pointsByActorAndScreenTopDirWithRotationAnglesAndDistance);
		BeginLookAt_NotWait(GetAttackTarget(), 0.1, 999);
		BeginAttack(1, actionKeys_1, flushInputedKeys: true);
		BeginLookAt_NotWait(GetAttackTarget(), 999, 999);
		yield return WaitCustomEvent(customEvent_HideModelDisable);
		InterruptHideModel();
		PlayEffect("DashCharge", 1f, 0, GetPosition(), 0, 1f, actorScale: true);
		yield return WaitCustomEvent(customEvent_JoinBattle);
		InterruptUnparalleled();
		yield return WaitCustomEvent(customEvent_BackDash);
		BeginDash(2, GetForward() * -1, 2.5, 1.5, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitCustomEvent(customEvent_FlashFX);
		PlayEffect("FlashFX", 1f, 3.8, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0.88, -0.72)), 0, 1f, actorScale: true);
		StopWaitLookAt();
		yield return WaitCustomEvent(customEvent_Dash);
		BeginDashActorForward(1, dashSpeed, dashDistance, 0, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		long DashSpeedlineFX = PlayEffect("DashSpeedLine");
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopEffect(DashSpeedlineFX);
		BeginAttack(2, "Idle", flushInputedKeys: true);
		yield return BeginLookAtMonsterTarget(1, 100);
		CancelAttack();
		InterruptAttack();
		if (GetLogicTagFpValue(_actor, "Phase") == 1)
		{
			actionKeys_2 = actionKeys_2_1;
		}
		else
		{
			actionKeys_2 = actionKeys_2_2;
		}
		BeginAttack(2, actionKeys_2, flushInputedKeys: true);
		yield return WaitCustomEvent(customEvent_ExitBattle);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
		ShowBlood(isShow: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
