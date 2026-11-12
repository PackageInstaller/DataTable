using System.Collections;
using TrueSync;

namespace AIScript.Monster._2nd._70031Huochui;

public class Skill_FeiLeiShen_01 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.H,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly string StopAttack_Event = "StopAttack";

	private static readonly string TeleportStart_Event = "TeleportStart";

	private static readonly string AreaEffectWarning_Event = "AreaEffectWarning";

	private static readonly string StartLookAt_Event = "StartLookAt";

	private static readonly string LookAtPlayer_Event = "LookAtPlayer";

	private static readonly string CameraUp_Event = "CameraUp";

	private static readonly string CameraDown_Event = "CameraDown";

	private static readonly string AreaEffectAlias1 = "2nd_Skill_07_FeiLeiShen_AreaEffect_Attack";

	private LogicEntity AttackTarget;

	private TSVector2 targetPosition;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey1);
		BeginLookAt_NotWait(AttackTarget, 8, 360);
		yield return WaitCustomEvent(CameraUp_Event);
		SwitchCameraSetting(active: true, "Camera_FeiLeiShen");
		yield return WaitCustomEvent(AreaEffectWarning_Event);
		long AreaEffectId = PlayAreaEffect(AreaEffectAlias1, GetEntityPosition(AttackTarget));
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitCustomEvent(TeleportStart_Event);
		targetPosition = GetAreaEffectPosition(AreaEffectId);
		Teleport(targetPosition);
		yield return WaitCustomEvent(StopAttack_Event);
		CancelAttack();
		StopWaitLookAt();
		SetCloseBlockEnable();
		BeginLookAt_NotWait(AttackTarget, 0.1, 1800);
		yield return WaitTime(0.1);
		StopWaitLookAt();
		yield return WaitTime(0.6);
		BeginLookAt_NotWait(AttackTarget, 0.1, 300);
		yield return WaitCustomEvent(StartLookAt_Event);
		StopWaitLookAt();
		yield return WaitCustomEvent(CameraDown_Event);
		SwitchCameraSetting(active: false, "Camera_FeiLeiShen");
		yield return WaitCustomEvent(LookAtPlayer_Event);
		BeginLookAt_NotWait(AttackTarget, 0.5, 360);
		yield return WaitTime(0.5);
		StopWaitLookAt();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		SetCloseBlockDisable();
		SwitchCameraSetting(active: false, "Camera_FeiLeiShen");
	}
}
