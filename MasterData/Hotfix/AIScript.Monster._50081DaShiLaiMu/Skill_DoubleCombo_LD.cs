using System.Collections;
using TrueSync;

namespace AIScript.Monster._50081DaShiLaiMu;

public class Skill_DoubleCombo_LD : SkillSimpleBase
{
	private int branch;

	private const int diffTag1 = 500810000;

	private const int diffTag2 = 500810001;

	private const int diffTag3 = 500810002;

	private int shootCount;

	private int bulletCount;

	private FP angle;

	private string bullet = "DiffusionBubble";

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
		}
		else
		{
			BeginAttack(RightIndex, _RightCombo);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
