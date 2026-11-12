using System.Collections;

namespace AIScript.Monster._Boss._Dark._50251ShanDianLieQuan;

public class MiniBoss_Dark_Spawn : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Born = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	private readonly ComboInputBuffer.ActionKey[] Move = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	private readonly string JumpOut = "Spawn_JumpOut";

	protected override void OnSkillEnable()
	{
		SetHideModelEnable();
		SetBattleOutEnable();
		AddBuffToTarget(_actor, 990020140);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Move, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.5, 3600);
		PlayEffect("fx_m50251_base_Dark_Atk03_Energy", 1f, 1, GetPosition(), 0, 1f, actorScale: true);
		yield return WaitTime(0.5);
		BeginAttack(2, JumpOut, flushInputedKeys: true, forceInterruptAttack: true);
		RemoveBuffFromTarget(_actor, 990020140);
		SetHideModelDisable();
		SetBattleOutDisable();
		ShowCenterHpBar();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(3, Born, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
