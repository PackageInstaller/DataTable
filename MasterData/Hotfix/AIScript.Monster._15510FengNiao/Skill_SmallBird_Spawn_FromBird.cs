using System.Collections;

namespace AIScript.Monster._15510FengNiao;

public class Skill_SmallBird_Spawn_FromBird : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Spawn_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._2 };

	protected override void OnSkillEnable()
	{
		SetLogicTagToggleValue(_actor, "SummonComplete", value: false);
		SetLogicTagToggleValue(_actor, "SpawnComplete", value: false);
	}

	protected override IEnumerator DoMainLogic()
	{
		SetHideModelEnable();
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		SetBattleOutEnable(autoDisableWhenSkillDisable: false);
		while (!GetLogicTagToggleValue(_actor, "SummonComplete"))
		{
			yield return null;
		}
		yield return null;
		SetHideModelDisable();
		BeginAttack(1, Spawn_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetLogicTagToggleValue(_actor, "SpawnComplete", value: true);
	}
}
