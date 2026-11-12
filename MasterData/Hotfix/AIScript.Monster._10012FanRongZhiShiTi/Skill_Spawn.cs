using System.Collections;
using TrueSync;

namespace AIScript.Monster._10012FanRongZhiShiTi;

public class Skill_Spawn : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] Attack1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.Y,
		ComboInputBuffer.ActionKey._0
	};

	protected readonly ComboInputBuffer.ActionKey[] Attack2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.Y,
		ComboInputBuffer.ActionKey._1
	};

	protected readonly FP disWithPlayer = 14;

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
		BeginAttack(1, Attack1, flushInputedKeys: true, forceInterruptAttack: true);
		LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
		if (attackTarget != null)
		{
			TargetPosition = GetEntityPosition(attackTarget);
		}
		while (Distance(TargetPosition, GetPosition()) >= disWithPlayer)
		{
			yield return WaitFrame(3);
			attackTarget = GetAttackTarget(isUpToDate: true);
			if (attackTarget != null)
			{
				TargetPosition = GetEntityPosition(attackTarget);
			}
		}
		SetBattleOutDisable();
		ShowCenterHpBar();
		BeginAttack(1, Attack2, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(30);
		SetSuperArmorDisable();
		SetLockToughnessDisable();
		SetUnparalleledDisable();
		RemoveBuffFromTarget(_actor, 990020140);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
