using System.Collections;

namespace AIScript.Monster.TowerDefense.Skill;

public class Skill_JinZhanFengCao_GrowGrass : TowerMonsterSkillBase
{
	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "Skill", flushInputedKeys: true, forceInterruptAttack: true);
		AddBuffToTarget(_actor, 809001220);
		yield return WaitCustomEvent("LoopStart");
		Dispatch_GetNextGridInfo((MonsterRecGridInfo gridInfo) =>
		{
			Dispatch_CreateGrass(gridInfo.ccIndex);
		});
		yield return WaitTime(3);
		CancelAttack();
		RemoveBuffFromTarget(_actor, 809001220);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		RemoveBuffFromTarget(_actor, 809001220);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		Dispatch_GetNextGridInfo((MonsterRecGridInfo gridInfo) =>
		{
			Dispatch_ClearGrass(gridInfo.ccIndex);
		});
		_skill?.Clear();
	}
}
