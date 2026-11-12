using System.Collections;
using TrueSync;

namespace AIScript.Monster._FanRong_None._10012FanRongZhiShiTi;

public class FanRong_None_Spawn : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] A1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.Y,
		ComboInputBuffer.ActionKey._0
	};

	protected readonly ComboInputBuffer.ActionKey[] A2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.Y,
		ComboInputBuffer.ActionKey._1
	};

	protected readonly FP disWithPlayer = 15;

	protected TSVector2 TargetPosition;

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable();
		AddBuffToTarget(_actor, 990020140);
		SetSuperArmorEnable();
		SetLockToughnessEnable();
		SetUnparalleledEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, A1, flushInputedKeys: true);
		LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
		if (attackTarget != null)
		{
			TargetPosition = GetEntityPositionObsoleted(attackTarget);
		}
		while (Distance(TargetPosition, GetPosition()) >= disWithPlayer)
		{
			yield return WaitFrame(3);
			attackTarget = GetAttackTarget(isUpToDate: true);
			if (attackTarget != null)
			{
				TargetPosition = GetEntityPositionObsoleted(attackTarget);
			}
		}
		SetBattleOutDisable();
		ShowCenterHpBar();
		BeginAttack(1, A2, flushInputedKeys: true);
		yield return WaitFrame(30);
		SetSuperArmorDisable();
		SetLockToughnessDisable();
		SetUnparalleledDisable();
		RemoveBuffFromTarget(_actor, 990020140);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
