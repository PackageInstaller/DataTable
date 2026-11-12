using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._10501BanShenShu;

public class Skill_Flower : SkillSimpleBase
{
	private static readonly int VineIndex = 0;

	private static readonly string VineAttack = "Vine";

	private static readonly int MonsterID = 4;

	private static readonly List<TSVector2> HandPOS = new List<TSVector2>
	{
		new TSVector2(-2, 3),
		new TSVector2(4, 2)
	};

	private static readonly List<string> FxFlowerLine = new List<string> { "fx_m10501_loop_Skill7_ground_appear_1", "fx_m10501_loop_Skill7_ground_appear_2" };

	private static readonly List<FP> LineAngle = new List<FP> { -130, 135 };

	private static readonly List<TSVector2> SummonPOS = new List<TSVector2>
	{
		new TSVector2(-10, 3),
		new TSVector2(10.5, 3)
	};

	private static List<long> FxLine = new List<long>();

	private static CoroutineNode TimeLimit;

	private static int AttackTimes;

	private static TSVector2 FxPOS;

	private static TSVector2 SelfPOS;

	private static TSVector2 SelfForward;

	protected override void OnSkillEnable()
	{
		AttackTimes = 0;
	}

	protected override void OnSkillDisable()
	{
		AttackTimes = 0;
		StopCor(TimeLimit);
		FxLine.Clear();
		for (int i = 0; i < FxLine.Count; i++)
		{
			StopEffect(FxLine.get_Item(i));
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		TimeLimit = StartCor(SkillDuration());
		BeginAttack(VineIndex, VineAttack, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return StartCor(SummonFlower());
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopCor(TimeLimit);
	}

	protected override void OnComboLoop(int comboIndex)
	{
		if (comboIndex != 0)
		{
			return;
		}
		AttackTimes++;
		if (AttackTimes == 1)
		{
			CancelAttack();
			for (int i = 0; i < FxLine.Count; i++)
			{
				StopEffect(FxLine.get_Item(i));
			}
		}
	}

	protected IEnumerator SkillDuration()
	{
		yield return WaitTime(10);
		CancelAttack();
		for (int i = 0; i < FxLine.Count; i++)
		{
			StopEffect(FxLine.get_Item(i));
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
		InterruptSkill();
	}

	protected IEnumerator SummonFlower()
	{
		SelfPOS = GetPosition();
		SelfForward = GetForward();
		for (int i = 0; i < 2; i++)
		{
			FxPOS = TransLocalPosToWorldPos(SelfPOS, SelfForward, HandPOS.get_Item(i));
			FxLine.Add(PlayEffect(FxFlowerLine.get_Item(i), 1f, default, FxPOS, LineAngle.get_Item(i)));
		}
		yield return WaitTime(0.9);
		for (int j = 0; j < 2; j++)
		{
			SummonTeammate(MonsterID, SummonPOS.get_Item(j), SelfForward);
		}
		yield return WaitTime(0.5);
	}
}
