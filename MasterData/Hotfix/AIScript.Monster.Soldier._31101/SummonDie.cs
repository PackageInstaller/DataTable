using System.Collections;

namespace AIScript.Monster.Soldier._31101;

public class SummonDie : SkillSimpleBase
{
	private const string comboTag = "Die";

	private const string areaEffectAlias = "Area_Attack_End_Soldier";

	private const string areaEffectAlias_Ex = "Area_Attack_End_EX_Soldier";

	private const int checkBuffId = 250106301;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "Die", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetHideModelEnable();
		if (_actor.buffComponent.CheckBuffByBuffID(250106301))
		{
			PlayAreaEffect("Area_Attack_End_Soldier", GetPosition());
		}
		else
		{
			PlayAreaEffect("Area_Attack_End_EX_Soldier", GetPosition());
		}
		_actor.DestroySelf();
	}
}
