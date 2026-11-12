using System.Collections;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Wind;

public class Attack_ShortLong_Wind : SkillScript_Base
{
	private static readonly string StopLookAT_Event = "StopLookAt";

	private static readonly string AreaEffectAlias = "Wind_Attack_Bullet";

	private readonly string lightSpawnFxAlias = "fx_m50011_loop_ground_wind_born";

	private LogicEntity AttackTarget;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		int num = TSRandom.Range(0, 100);
		int num2 = 50;
		if (num < num2)
		{
			BeginAttack(SkillScript_Base.ATKSIndex, SkillScript_Base.ATKSKey, flushInputedKeys: true, forceInterruptAttack: true);
			ElementalSkill();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			BeginAttack(SkillScript_Base.ATKLIndex, SkillScript_Base.ATKLKey, flushInputedKeys: true, forceInterruptAttack: true);
			ElementalSkill();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	private void ElementalSkill()
	{
		int aiType = GetAiType();
		if (aiType != 0 && aiType == 1)
		{
			StartCor(LongJuanFeng());
		}
	}
}
