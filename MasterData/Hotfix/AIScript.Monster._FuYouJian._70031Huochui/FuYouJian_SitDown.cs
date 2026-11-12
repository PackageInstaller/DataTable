using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._FuYouJian._70031Huochui;

public class FuYouJian_SitDown : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey._1
	};

	private LogicEntity AttackTarget;

	private static readonly string AreaEffectAlias = "FuYouJian_DaoDi_Buff";

	private readonly ComboInputBuffer.ActionKey[] _actionKey2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.Z,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly string KillActors_Event = "KillActors";

	private List<LogicEntity> KillTarget = new List<LogicEntity>();

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
		PlayAreaEffect(AreaEffectAlias, GetPosition());
		while (GetBuffNum(_actor, 160510130) <= 0 && GetBuffNum(_actor, 155109320) <= 0)
		{
			yield return null;
		}
		if (GetBuffNum(_actor, 160510130) > 0)
		{
			CancelAttack();
			AddBuffToTarget(_actor, 990060010);
			SetBattleOutDisable();
			SetSearchedImmunityDisable();
			SetImmuneControlDisable();
			SetCloseBlockDisable();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else if (GetBuffNum(_actor, 155109320) > 0)
		{
			CancelAttack();
			BeginAttack(2, _actionKey2, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			CancelAttack();
			yield return WaitCustomEvent(KillActors_Event);
			SetHideModelEnable();
			KillTarget.Add(_actor);
			KillActors(KillTarget);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	protected override void OnSkillDisable()
	{
		SetBattleOutDisable();
		SetSearchedImmunityDisable();
		SetImmuneControlDisable();
		SetCloseBlockDisable();
	}
}
