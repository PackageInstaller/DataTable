using System.Collections;

namespace AIScript.Monster._Boss._Wind._50251ShanDianLieQuan;

public class MiniBoss_Wind_Spawn : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Born = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	private readonly ComboInputBuffer.ActionKey[] Move = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

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
		PlayEffect("fx_m50251_base_Wind_Atk03_Appear", 1f, 1, GetPosition(), 0, 1f, actorScale: true);
		yield return WaitTime(0.15);
		BeginAttack(2, Born, flushInputedKeys: true, forceInterruptAttack: true);
		RemoveBuffFromTarget(_actor, 990020140);
		SetHideModelDisable();
		SetBattleOutDisable();
		ShowCenterHpBar();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
