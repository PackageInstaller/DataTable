#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50081DaShiLaiMu;

public class ActionBase : MonsterActionBase
{
	protected static List<BaseBranchInfo> sequenceBranchesList;

	private static readonly int splitThrowBranchID = 1001;

	private static readonly int splitThrowSkillID = 5008111;

	protected static readonly int diffusionBubbleBranchID = 1002;

	private static readonly int diffusionBubbleSkillID = 5008141;

	protected static readonly int doubleComboBranchID = 1003;

	private static readonly int doubleComboSkillID = 5008121;

	protected static readonly int assaultBranchID = 1004;

	private static readonly int assaultSkillID = 5008131;

	protected static readonly int burstBranchID = 1005;

	private static readonly int burstSkillID = 5008151;

	private static readonly int initializeBranchID = 2001;

	private static readonly int initializeSkillID = 5008101;

	private static readonly int deathBranchID = 2002;

	private static readonly int deathSkillID = 5008102;

	private static readonly int alertMovementBranchID = 2003;

	private static readonly int alertMovementSkillID = 5008103;

	private static readonly int randomCombo1To2BranchID = 2004;

	protected static int randomCombo1To2Result = 0;

	protected static readonly int to1 = 2011;

	protected static readonly int to2 = 2012;

	protected static readonly int to3 = 2013;

	protected static readonly int to4 = 2014;

	protected static readonly int to5 = 2015;

	protected static readonly int to6 = 2016;

	private static readonly List<int> toSequenceList = new List<int> { to1, to2, to3, to4 };

	protected static readonly int wait0 = 2020;

	protected static readonly int wait05 = 20205;

	protected static readonly int wait1 = 2021;

	protected static readonly int wait2 = 2022;

	protected static readonly int wait3 = 2023;

	protected static readonly int wait4 = 2024;

	protected readonly List<int> initialSkill = new List<int> { initializeSkillID };

	protected readonly List<int> Combo_1 = new List<int> { splitThrowBranchID, diffusionBubbleBranchID, randomCombo1To2BranchID, alertMovementBranchID };

	protected readonly List<int> Combo_2 = new List<int> { splitThrowBranchID, doubleComboBranchID, diffusionBubbleBranchID, alertMovementBranchID };

	protected readonly List<int> Combo_2_1 = new List<int> { doubleComboBranchID, doubleComboBranchID, diffusionBubbleBranchID, alertMovementBranchID };

	protected readonly List<int> Combo_3 = new List<int> { diffusionBubbleBranchID, alertMovementBranchID, assaultBranchID };

	private IEnumerator SplitThrowEnumerator()
	{
		CastSkill(splitThrowSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator DiffusionBubbleEnumerator()
	{
		CastSkill(diffusionBubbleSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator DoubleComboEnumerator()
	{
		CastSkill(doubleComboSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator AssaultEnumerator()
	{
		CastSkill(assaultSkillID);
		yield return WaitSkillFinish();
	}

	protected virtual IEnumerator BurstIEnumerator()
	{
		yield return StartCor(BurstIEnumeratorCor());
	}

	protected IEnumerator BurstIEnumeratorCor()
	{
		CastSkill(burstSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator InitializeEnumerator()
	{
		CastSkill(initializeSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator DeathEnumerator()
	{
		CastSkill(deathSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator AlertMovementEnumerator()
	{
		CastSkill(alertMovementSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator RandomCombo1To2Enumerator()
	{
		randomCombo1To2Result = ((GetRandomValue(0, 1) >= 0.5) ? 3 : 4);
		yield break;
	}

	protected IEnumerator To1()
	{
		SwitchSequence(1);
		yield break;
	}

	private IEnumerator To2()
	{
		SwitchSequence(2);
		yield break;
	}

	private IEnumerator To3()
	{
		SwitchSequence(3);
		yield break;
	}

	private IEnumerator To4()
	{
		SwitchSequence(4);
		yield break;
	}

	private IEnumerator To5()
	{
		SwitchSequence(5);
		yield break;
	}

	private IEnumerator To6()
	{
		SwitchSequence(6);
		yield break;
	}

	private IEnumerator Wait0()
	{
		yield break;
	}

	private IEnumerator Wait05()
	{
		yield return WaitTime(0.5);
	}

	private IEnumerator Wait1()
	{
		yield return WaitTime(1);
	}

	private IEnumerator Wait2()
	{
		yield return WaitTime(2);
	}

	private IEnumerator Wait3()
	{
		yield return WaitTime(3);
	}

	private IEnumerator Wait4()
	{
		yield return WaitTime(4);
	}

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		int id = to1;
		OperateDelegate operateIEnumerator = To1;
		list.Add(new BaseBranchInfo(id, default, default, default, null, operateIEnumerator));
		int id2 = to2;
		operateIEnumerator = To2;
		list.Add(new BaseBranchInfo(id2, default, default, default, null, operateIEnumerator));
		int id3 = to3;
		operateIEnumerator = To3;
		list.Add(new BaseBranchInfo(id3, default, default, default, null, operateIEnumerator));
		int id4 = to4;
		operateIEnumerator = To4;
		list.Add(new BaseBranchInfo(id4, default, default, default, null, operateIEnumerator));
		int id5 = to5;
		operateIEnumerator = To5;
		list.Add(new BaseBranchInfo(id5, default, default, default, null, operateIEnumerator));
		int id6 = to6;
		operateIEnumerator = To6;
		list.Add(new BaseBranchInfo(id6, default, default, default, null, operateIEnumerator));
		int id7 = wait0;
		operateIEnumerator = Wait0;
		list.Add(new BaseBranchInfo(id7, default, default, default, null, operateIEnumerator));
		int id8 = wait05;
		operateIEnumerator = Wait05;
		list.Add(new BaseBranchInfo(id8, default, default, default, null, operateIEnumerator));
		int id9 = wait1;
		operateIEnumerator = Wait1;
		list.Add(new BaseBranchInfo(id9, default, default, default, null, operateIEnumerator));
		int id10 = wait2;
		operateIEnumerator = Wait2;
		list.Add(new BaseBranchInfo(id10, default, default, default, null, operateIEnumerator));
		int id11 = wait3;
		operateIEnumerator = Wait3;
		list.Add(new BaseBranchInfo(id11, default, default, default, null, operateIEnumerator));
		int id12 = wait4;
		operateIEnumerator = Wait4;
		list.Add(new BaseBranchInfo(id12, default, default, default, null, operateIEnumerator));
		int id13 = randomCombo1To2BranchID;
		operateIEnumerator = RandomCombo1To2Enumerator;
		list.Add(new BaseBranchInfo(id13, default, default, default, null, operateIEnumerator));
		int id14 = splitThrowBranchID;
		operateIEnumerator = SplitThrowEnumerator;
		list.Add(new BaseBranchInfo(id14, default, default, default, null, operateIEnumerator));
		list.Add(new BaseBranchInfo(doubleComboBranchID, 5, 360, 2, MeleeStopTrace, DoubleComboEnumerator));
		int id15 = assaultBranchID;
		operateIEnumerator = AssaultEnumerator;
		list.Add(new BaseBranchInfo(id15, default, default, default, null, operateIEnumerator));
		int id16 = diffusionBubbleBranchID;
		operateIEnumerator = DiffusionBubbleEnumerator;
		list.Add(new BaseBranchInfo(id16, default, default, default, null, operateIEnumerator));
		int id17 = burstBranchID;
		operateIEnumerator = BurstIEnumerator;
		list.Add(new BaseBranchInfo(id17, default, default, default, null, operateIEnumerator));
		int id18 = initializeBranchID;
		operateIEnumerator = InitializeEnumerator;
		list.Add(new BaseBranchInfo(id18, default, default, default, null, operateIEnumerator));
		int id19 = deathBranchID;
		operateIEnumerator = DeathEnumerator;
		list.Add(new BaseBranchInfo(id19, default, default, default, null, operateIEnumerator));
		int id20 = alertMovementBranchID;
		operateIEnumerator = AlertMovementEnumerator;
		list.Add(new BaseBranchInfo(id20, default, default, default, null, operateIEnumerator));
		sequenceBranchesList = list;
	}

	private bool MeleeStopTrace()
	{
		TSVector2 position = GetPosition();
		FP radius = 5;
		FP innerRadius = 0;
		FP angle = 80;
		FP rotation = GetRotation();
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
		return IsAttackTargetInArea(shapeData);
	}

	protected List<int> ToTargetKey(List<int> skillList, int targetKey)
	{
		List<int> list = new List<int>();
		list.AddRange(skillList);
		foreach (int toSequence in toSequenceList)
		{
			if (list.Contains(toSequence))
			{
				list.Remove(toSequence);
			}
		}
		switch (targetKey)
		{
		case 1:
			list.Add(to1);
			break;
		case 2:
			list.Add(to2);
			break;
		case 3:
			list.Add(to3);
			break;
		case 4:
			list.Add(to4);
			break;
		case 5:
			list.Add(to5);
			break;
		case 6:
			list.Add(to6);
			break;
		default:
			list.Add(to1);
			NovaLogger.Debug("大史莱姆.AI脚本.ToTargetKey函数传参有误,默认1");
			break;
		}
		return list;
	}

	protected List<int> SkillListAddSkill(List<int> skillList, params int[] targetSkillBranch)
	{
		List<int> list = new List<int>();
		list.AddRange(skillList);
		foreach (int item in targetSkillBranch)
		{
			list.Add(item);
		}
		return list;
	}

	protected List<int> AssemblyList(List<int> skillGroup, params List<int>[] targetSkillBranch)
	{
		List<int> list = new List<int>();
		list.AddRange(skillGroup);
		foreach (List<int> collection in targetSkillBranch)
		{
			list.AddRange(collection);
		}
		return list;
	}
}
