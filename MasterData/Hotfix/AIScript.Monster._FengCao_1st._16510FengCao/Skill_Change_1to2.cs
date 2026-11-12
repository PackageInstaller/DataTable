using System.Collections;

namespace AIScript.Monster._FengCao_1st._16510FengCao;

public class Skill_Change_1to2 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	private LogicEntity AttackTarget;

	private static readonly string WakeUp_Event = "WakeUp";

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
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		SetLockToughnessDisable();
		PlayAreaEffect(AreaEffectAlia, GetPosition());
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (comboIndex == 1 && eventName == WakeUp_Event)
		{
			PlayAreaEffect(AreaEffectAlia, GetPosition());
		}
	}
}
