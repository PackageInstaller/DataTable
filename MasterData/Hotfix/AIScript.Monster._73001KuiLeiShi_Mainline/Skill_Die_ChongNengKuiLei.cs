using System.Collections;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_Die_ChongNengKuiLei : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	private static readonly string airBorneDeathEffectAlias = "fx_common_base_die_airborne";

	private static readonly FP effectDuration = 2f;

	protected override IEnumerator DoMainLogic()
	{
		SetCloseBlockEnable();
		SendDeclareDeadEvent();
		_actor.PlayDeathAnim();
		BeginAttack(1, actionKeys);
		yield return WaitCustomEvent("Hide");
		SetHideModelEnable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
