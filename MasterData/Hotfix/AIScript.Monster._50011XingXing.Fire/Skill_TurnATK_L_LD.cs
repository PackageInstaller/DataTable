using System.Collections;

namespace AIScript.Monster._50011XingXing.Fire;

public class Skill_TurnATK_L_LD : SkillSimpleBase
{
	private static readonly string WarningFx = "fx_common_base_charge_fire_actor";

	private static readonly int ATKLIndex = 0;

	private static readonly string ATKLKey = "TurnAttack_L";

	private LogicEntity Target;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		if (CheckTargetIsValid(GetAttackTarget(isUpToDate: true)))
		{
			Target = GetAttackTarget(isUpToDate: true);
		}
		else
		{
			Target = GetCurrentPlayer();
		}
		BeginAttack(ATKLIndex, ATKLKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
