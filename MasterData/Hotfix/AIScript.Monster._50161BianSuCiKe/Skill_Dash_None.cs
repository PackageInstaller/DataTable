using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50161BianSuCiKe;

public class Skill_Dash_None : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Start_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	private static readonly ComboInputBuffer.ActionKey[] Dash_Combo = new ComboInputBuffer.ActionKey[3];

	private static readonly FP searchDistanc = 1.5;

	private static readonly List<FP> searchAngles = new List<FP> { 120, 150, 180, 210, 240 };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Start_Combo, flushInputedKeys: true);
		yield return WaitCustomEvent("ExitBattle");
		SetUnparalleledEnable();
		SetHideModelEnable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		GetAttackTarget(isUpToDate: true);
		TSVector2 pointsByActorAndScreenTopDirWithRotationAnglesAndDistance = ILRuntimeAPI.GetPointsByActorAndScreenTopDirWithRotationAnglesAndDistance(_actor, searchAngles, searchDistanc, searchDistanc);
		Teleport(pointsByActorAndScreenTopDirWithRotationAnglesAndDistance);
		BeginAttack(1, Dash_Combo, flushInputedKeys: true);
		BeginLookAt_NotWait(GetAttackTarget(), 0.1, 999);
		yield return WaitCustomEvent("HideModelDisable");
		SetHideModelDisable();
		PlayEffect("DashCharge", 1f, 0, GetPosition(), 0, 1f, actorScale: true);
		yield return WaitCustomEvent("JoinBattle");
		SetUnparalleledDisable();
		yield return WaitCustomEvent("FlashFX");
		PlayEffect("FlashFX", 1f, 3.8, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0.88, -0.72)), 0, 1f, actorScale: true);
		StopWaitLookAt();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
