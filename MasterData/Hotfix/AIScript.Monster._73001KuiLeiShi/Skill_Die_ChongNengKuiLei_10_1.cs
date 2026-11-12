using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_Die_ChongNengKuiLei_10_1 : SkillSimpleBase
{
	private string tag1 = "Mark1";

	private string tag2 = "Mark2";

	private string tag3 = "Mark3";

	private static readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	private static readonly string airBorneDeathEffectAlias = "fx_common_base_die_airborne";

	private static readonly FP effectDuration = 2f;

	protected override IEnumerator DoMainLogic()
	{
		string monsterTagValue = GetMonsterTagValue(_actor, 1);
		if (monsterTagValue == tag1)
		{
			List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(2);
			ClearActors(targetByTeammateIndex);
		}
		else if (monsterTagValue == tag2)
		{
			List<LogicEntity> targetByTeammateIndex2 = GetTargetByTeammateIndex(4);
			ClearActors(targetByTeammateIndex2);
		}
		else if (monsterTagValue == tag3)
		{
			List<LogicEntity> targetByTeammateIndex3 = GetTargetByTeammateIndex(5);
			ClearActors(targetByTeammateIndex3);
		}
		SetCloseBlockEnable();
		SendDeclareDeadEvent();
		_actor.PlayDeathAnim();
		BeginAttack(1, actionKeys);
		yield return WaitCustomEvent("Hide");
		SetHideModelEnable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
