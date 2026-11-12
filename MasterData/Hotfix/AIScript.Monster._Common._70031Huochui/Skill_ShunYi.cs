using System.Collections;
using TrueSync;

namespace AIScript.Monster._Common._70031Huochui;

public class Skill_ShunYi : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.U,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly string StopAttack_Event = "StopAttack";

	private static readonly string TeleportStart_Event = "TeleportStart";

	private static readonly string ShowModel_Event = "ShowModel";

	private LogicEntity AttackTarget;

	private readonly TSVector2 centerPosition1 = new TSVector2(0, 0);

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
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitCustomEvent(TeleportStart_Event);
		SetHideModelEnable();
		SetUnparalleledEnable();
		yield return WaitCustomEvent(StopAttack_Event);
		Teleport(centerPosition1);
		CancelAttack();
		yield return WaitCustomEvent(ShowModel_Event);
		SetUnparalleledDisable();
		SetHideModelDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		SetHideModelDisable();
		SetInvincibleDisable();
	}
}
