using System.Collections;
using TrueSync;

namespace AIScript.Monster._11021XunHuiQuan;

public class Skill_Spawn : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] B = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected readonly FP disWithPlayer = 4;

	protected TSVector2 TargetPosition;

	protected long FXid01;

	protected override void OnSkillEnable()
	{
		SetSuperArmorEnable(autoDisableWhenSkillDisable: false);
		SetBattleOutEnable();
	}

	protected override void OnSkillDisable()
	{
		StopEffect(FXid01);
	}

	protected override IEnumerator DoMainLogic()
	{
		Skill_Spawn skill_Spawn = this;
		Skill_Spawn skill_Spawn2 = this;
		TSVector2 position = _actor.tsTransform.Position;
		skill_Spawn.FXid01 = skill_Spawn2.PlayEffect("warning", 1f, default, position);
		BeginAttack(1, B);
		SetBattleOutDisable();
		yield return WaitTime(0.5);
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (currentPlayer != null)
		{
			TargetPosition = GetEntityPosition(currentPlayer);
		}
		while (Distance(TargetPosition, GetPosition()) >= 4)
		{
			yield return WaitFrame(3);
			currentPlayer = GetCurrentPlayer();
			if (currentPlayer != null)
			{
				TargetPosition = GetEntityPosition(currentPlayer);
			}
		}
		CancelAttack();
		StopEffect(FXid01);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
