using System.Collections;
using TrueSync;

namespace AIScript.Monster._2nd._70031Huochui;

public class Skill_FeiLeiShen_02 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.H,
		ComboInputBuffer.ActionKey._2
	};

	private static readonly string StopAttack_Event = "StopAttack";

	private static readonly string TeleportStart_Event = "TeleportStart";

	private static readonly string AreaEffectWarning_Event = "AreaEffectWarning";

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
		StopLookAt();
		SetCloseBlockEnable();
		yield return WaitCustomEvent(CameraDown_Event);
		SwitchCameraSetting(active: false, "Camera_FeiLeiShen");
		BeginLookAt_NotWait(AttackTarget, 2, 360);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		SetCloseBlockDisable();
		SwitchCameraSetting(active: false, "Camera_FeiLeiShen");
	}
}
