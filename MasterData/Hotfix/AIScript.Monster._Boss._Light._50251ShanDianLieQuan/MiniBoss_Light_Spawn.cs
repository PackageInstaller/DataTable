using System.Collections;

namespace AIScript.Monster._Boss._Light._50251ShanDianLieQuan;

public class MiniBoss_Light_Spawn : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

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
		PlayEffect("Born_Lighting", 1.5f, 1, GetPosition(), 0, 1f, actorScale: true);
		yield return WaitTime(0.7);
		PlayEffect("Born_LightDown_Start", 1f, 1, GetPosition(), 0, 1f, actorScale: true);
		yield return WaitTime(0.7);
		BeginAttack(2, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		AddBuffToTarget(_actor, 502510001);
		RemoveBuffFromTarget(_actor, 990020140);
		SetHideModelDisable();
		SetBattleOutDisable();
		ShowCenterHpBar();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
