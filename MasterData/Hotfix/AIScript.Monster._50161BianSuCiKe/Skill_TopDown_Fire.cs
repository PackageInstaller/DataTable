using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50161BianSuCiKe;

public class Skill_TopDown_Fire : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] Start_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	private static readonly ComboInputBuffer.ActionKey[] Null_Combo = new ComboInputBuffer.ActionKey[0];

	protected override void OnSkillEnable()
	{
		SetBlockPriorityToStatic();
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Start_Combo, flushInputedKeys: true);
		yield return WaitCustomEvent("ExitBattle");
		SetUnparalleledEnable();
		SetHideModelEnable();
		yield return WaitTime(0.5);
		GetAttackTarget(isUpToDate: true);
		TSVector2 blinkPoint = ILRuntimeAPI.GetPointsByActorAndScreenTopDirWithRotationAnglesAndDistance(_actor, new List<FP> { 0 }, 0.3, 0.3);
		Teleport(blinkPoint);
		BeginLookAt_NotWait(GetAttackTarget(), 0.1, 999);
		PlayEffect("FlashIn", 1f, position: GetPosition(), fxPositionY: 3);
		yield return WaitFrame(1);
		SetHideModelDisable();
		SetUnparalleledDisable();
		SetSearchedImmunityEnable();
		SetCloseBlockEnable();
		BeginAttack(2, Attack_Combo, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		PlayEffect("TopDownWarning", 1f, 0, TransLocalPosToWorldPos(blinkPoint, GetForward(), new TSVector2(0, 1.6)), 0);
		yield return WaitTime(0.6);
		PlayEffect("ReadyToAttack", 1f, default, default, default, 1.5f);
		PlayEffect("FlashFX", 1f, 5.5, GetPosition(), 0, 1f, actorScale: true);
		yield return WaitTime(0.3);
		CancelAttack();
		yield return WaitCustomEvent("JoinBattle");
		SetSearchedImmunityDisable();
		SetCloseBlockDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
