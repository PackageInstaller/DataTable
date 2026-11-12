using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50161BianSuCiKe;

public class Skill_TopDown : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_2_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_2_2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Q };

	private static readonly string customEvent_JoinBattle = "JoinBattle";

	private static readonly string customEvent_ExitBattle = "ExitBattle";

	private static readonly string StartFxAlias = "FlashIn";

	private static readonly string WarningFxAlias = "TopDownWarning";

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
		GetAttackTarget(isUpToDate: true);
		TSVector2 blinkPoint = ILRuntimeAPI.GetPointsByActorAndScreenTopDirWithRotationAnglesAndDistance(_actor, new List<FP> { 0 }, 0.3, 0.3);
		GetAttackTarget();
		Teleport(blinkPoint);
		BeginLookAt_NotWait(GetAttackTarget(), 0.1, 999);
		PlayFx(StartFxAlias, 1f, 3, _actor.tsTransform.Position, 180);
		yield return WaitTime(0.2);
		PlayEffect(WarningFxAlias, 1f, 0, TransLocalPosToWorldPos(blinkPoint, GetForward(), new TSVector2(0, 1.6)), 0);
		yield return WaitFrame(1);
		InterruptHideModel();
		SetCloseBlockEnable();
		PlayEffect("FlashFX", 1f, 4.4, GetPosition(), 0, 1f, actorScale: true);
		BeginAttack(1, actionKeys_1, flushInputedKeys: true);
		yield return WaitCustomEvent(customEvent_JoinBattle);
		InterruptUnparalleled();
		SetCloseBlockDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
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
		ShowBlood(isShow: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
