using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Common._70031Huochui;

public class Skill_XiuFu : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.U,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] _actionKey2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.V,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly string StopAttack_Event = "StopAttack";

	private static readonly string TeleportStart_Event = "TeleportStart";

	private static readonly string AddHp_Event = "AddHp";

	private LogicEntity AttackTarget;

	private LogicEntity MonsterTarget;

	private TSVector2 MonsterTargetPos;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(1);
		MonsterTarget = ((targetByTeammateIndex.Count > 0) ? targetByTeammateIndex.get_Item(0) : _actor);
		MonsterTargetPos = GetEntityPosition(MonsterTarget);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey1);
		BeginLookAt_NotWait(MonsterTarget, 8, 360);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitCustomEvent(TeleportStart_Event);
		SetHideModelEnable();
		SetUnparalleledEnable();
		yield return WaitCustomEvent(StopAttack_Event);
		Teleport(MonsterTargetPos);
		CancelAttack();
		SetUnparalleledDisable();
		SetHideModelDisable();
		StopLookAt();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(2, _actionKey2);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitFrame(100);
		CancelAttack();
		yield return WaitCustomEvent(AddHp_Event);
		AddBuffToTarget(MonsterTarget, 160510130);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		SetHideModelDisable();
		AddBuffToTarget(MonsterTarget, 160510130);
	}
}
