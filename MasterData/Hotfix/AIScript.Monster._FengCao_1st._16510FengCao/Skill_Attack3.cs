using System.Collections;
using TrueSync;

namespace AIScript.Monster._FengCao_1st._16510FengCao;

public class Skill_Attack3 : SkillSimpleBase
{
	private readonly int startKeyIndex1 = 1;

	private readonly string attack3LKey = "Attack3_L";

	private readonly int startKeyIndex2 = 2;

	private readonly string attack3RKey = "Attack3_R";

	private FP AngleOfIncline;

	private LogicEntity AttackTarget;

	protected override IEnumerator DoMainLogic()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = GetCurrentPlayer();
		}
		AngleOfIncline = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		if (AngleOfIncline >= 0)
		{
			BeginAttack(startKeyIndex1, attack3LKey, flushInputedKeys: true);
		}
		else
		{
			BeginAttack(startKeyIndex2, attack3RKey, flushInputedKeys: true);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
