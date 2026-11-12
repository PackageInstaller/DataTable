#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50081DaShiLaiMu;

public class Skill_DoubleCombo_SP_LD : SkillSimpleBase
{
	private static readonly string _LeftCombo = "DoubleCombo_Left";

	private static readonly int LeftIndex = 1;

	private static readonly string _RightCombo = "DoubleCombo_Right";

	private static readonly int RightIndex = 2;

	private static readonly string _DiffusionCombo = "DiffusionBubble";

	private static readonly int DiffusionComboIndex = 3;

	private static readonly FP THOfDist = 5;

	private static FP AngleOfIncline;

	private static FP RelativeDist;

	private static LogicEntity Target;

	protected override IEnumerator DoMainLogic()
	{
		Target = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(Target))
		{
			Target = _actor;
		}
		AngleOfIncline = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		if (AngleOfIncline >= 0)
		{
			BeginAttack(LeftIndex, _LeftCombo);
			NovaLogger.Debug("释放左刀");
			yield return WaitTime(1.5);
		}
		else
		{
			BeginAttack(RightIndex, _RightCombo);
			yield return WaitTime(1.5);
		}
		yield return WaitTime(1.2);
		RelativeDist = Distance(GetPosition(), GetEntityPositionObsoleted(GetAttackTarget()));
		if (RelativeDist >= THOfDist)
		{
			BeginAttack(DiffusionComboIndex, _DiffusionCombo, flushInputedKeys: false, forceInterruptAttack: true);
			NovaLogger.Debug("释放扩散攻击");
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
