using System.Collections;

namespace AIScript.Monster._FengCao_1st._16510FengCao;

public class Skill_Change_Hard : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	private LogicEntity AttackTarget;

	private readonly string WakeUp_Event = "WakeUp";

	private readonly string AreaEffectAlia = "Weapon_16510FengCao_Blow_WakeUp";

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
		SetLockToughnessEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey1);
		BeginLookAt_NotWait(AttackTarget, 5, 120);
		yield return WaitCustomEvent(WakeUp_Event);
		PlayAreaEffect(AreaEffectAlia, GetPosition());
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetLockToughnessDisable();
	}

	protected override void OnSkillDisable()
	{
		SetLockToughnessDisable();
	}
}
