using System.Collections;
using TrueSync;

namespace AIScript.Monster._FengCao_1st._16510FengCao;

public class Skill_Spawn : SkillSimpleBase
{
	protected static readonly ComboInputBuffer.ActionKey[] Spawn_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	private LogicEntity AttackTarget;

	private float GroundFxSize;

	private float FxSize;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override void OnSkillDisable()
	{
		ShowCenterHpBar();
	}

	protected override IEnumerator DoMainLogic()
	{
		SetBattleOutEnable();
		SetHideModelEnable();
		Skill_Spawn skill_Spawn = this;
		TSVector2 position = GetPosition();
		float groundFxSize = GroundFxSize;
		skill_Spawn.PlayEffect("fx_common_base_monster_in_ground", 1f, default, position, default, groundFxSize);
		yield return WaitTime(0.15);
		Skill_Spawn skill_Spawn2 = this;
		position = GetPosition();
		groundFxSize = FxSize;
		skill_Spawn2.PlayEffect("fx_common_base_monster_in", 1f, default, position, default, groundFxSize);
		BeginAttack(1, Spawn_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		SetHideModelDisable();
		SetBattleOutDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
