using System.Collections;
using TrueSync;

namespace AIScript.Monster._10005JiaMianYeZhu;

public class Skill_CommonSummon : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Angry_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	private static readonly int SummonAmount = 2;

	private static readonly FP SummonMinDis = 3;

	private static readonly FP SummonMaxDis = 6;

	private int SummonCount;

	private TSVector2 SummonPosition;

	private DeterministicShape SummonShape;

	protected override void OnSkillEnable()
	{
		SummonCount = 0;
		TSVector2 position = GetPosition();
		FP summonMaxDis = SummonMaxDis;
		FP summonMinDis = SummonMinDis;
		SummonShape = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, summonMaxDis, summonMinDis);
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Angry_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1);
		while (SummonCount < SummonAmount)
		{
			SummonPosition = GetShapeRandomPoint(SummonShape, _actor, isReachable: true);
			SummonTeammate(1, SummonPosition, GetForward());
			SummonCount++;
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
