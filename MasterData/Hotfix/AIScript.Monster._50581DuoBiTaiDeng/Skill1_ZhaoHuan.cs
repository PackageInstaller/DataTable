using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50581DuoBiTaiDeng;

public class Skill1_ZhaoHuan : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected ComboInputBuffer.ActionKey[] _actionKey;

	private static readonly string BulletAlias = "Weapon_50581_HuanRao_Deng";

	private static readonly string BulletAlias_P1 = "Weapon_50581_HuanRao_Deng_P1";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		SetLockToughnessEnable();
		GetAttackTarget();
		BeginAttack(1, Attack_1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1);
		List<int> indexes = new List<int> { 1, 2, 3 };
		KillActors(GetTargetByTeammateIndexes(indexes));
		yield return WaitTime(1);
		if (_actor.buffComponent.CheckBuffByBuffID(505810099))
		{
			SummonTeammate(1, new TSVector2(0, 5), new TSVector2(-1, 0));
			SummonTeammate(2, new TSVector2(-4.33, -2.5), new TSVector2(1, -1.732));
			SummonTeammate(3, new TSVector2(4.33, -2.5), new TSVector2(1, 1.732));
			ILRuntimeAPI.ShootRotateWepon(BulletAlias, _actor, null, _actor.tsTransform.Forward);
		}
		else
		{
			SummonTeammate(1, new TSVector2(-5, 0), new TSVector2(0, -1));
			SummonTeammate(2, new TSVector2(5, 0), new TSVector2(0, 1));
			ILRuntimeAPI.ShootRotateWepon(BulletAlias_P1, _actor, null, _actor.tsTransform.Forward);
		}
		SetLockToughnessDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
