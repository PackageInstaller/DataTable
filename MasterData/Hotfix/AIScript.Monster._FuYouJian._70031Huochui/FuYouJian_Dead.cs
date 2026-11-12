using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._FuYouJian._70031Huochui;

public class FuYouJian_Dead : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.Z,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly string KillActors_Event = "KillActors";

	private List<LogicEntity> KillTarget = new List<LogicEntity>();

	private LogicEntity AttackTarget;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget();
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
		KillTarget.Clear();
		SetBattleOutEnable();
		SetSearchedImmunityEnable();
		SetImmuneControlEnable();
		SetCloseBlockEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey1, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		CancelAttack();
		yield return WaitCustomEvent(KillActors_Event);
		SetHideModelEnable();
		KillTarget.Add(_actor);
		KillActors(KillTarget);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
