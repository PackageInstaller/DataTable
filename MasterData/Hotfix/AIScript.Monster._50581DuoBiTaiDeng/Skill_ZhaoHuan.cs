using System.Collections;
using AdventureBehaviour;

namespace AIScript.Monster._50581DuoBiTaiDeng;

public class Skill_ZhaoHuan : SkillSimpleBase
{
	private readonly int summonedChessId = 50582;

	private static readonly ComboInputBuffer.ActionKey[] Attack_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected ComboInputBuffer.ActionKey[] _actionKey;

	private static readonly string BulletAlias = "Weapon_50581_HuanRao_Deng_ZiZouQi_5";

	private static readonly string BulletAlias_P1 = "Weapon_50581_HuanRao_Deng_ZiZouQi_10";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		AddBuffToTarget(_actor, 505810099);
		SetLockToughnessEnable();
		GetAttackTarget();
		BeginAttack(1, Attack_1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1);
		yield return WaitTime(1);
		ILRuntimeAPI.ShootRotateWepon(BulletAlias, _actor, null, _actor.tsTransform.Forward);
		ILRuntimeAPI.ShootRotateWepon(BulletAlias_P1, _actor, null, _actor.tsTransform.Forward);
		SetLockToughnessDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
