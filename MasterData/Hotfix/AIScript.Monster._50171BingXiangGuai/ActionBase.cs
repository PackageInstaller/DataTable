#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai;

public class ActionBase : MonsterActionBase
{
	protected static List<BaseBranchInfo> sequenceBranchesList;

	protected static readonly int to1 = 1011;

	protected static readonly int to2 = 1012;

	protected static readonly int to3 = 1013;

	protected static readonly int to4 = 1014;

	protected static readonly int to5 = 1015;

	protected static readonly int to6 = 1016;

	protected static readonly int to7 = 1017;

	protected static readonly int alertMovementBranchID = 1021;

	protected static readonly int alertMovementSkillID = 5060102;

	protected static readonly int wait1 = 1031;

	protected static readonly int wait2 = 1032;

	protected static readonly int wait3 = 1033;

	protected static readonly int wait4 = 1034;

	protected static readonly int checkConditionBranch = 1041;

	private static readonly int flapBranchID = 2001;

	private static readonly int flapSkillID = 5017151;

	private static readonly int dashBranchID = 2002;

	private static readonly int dashSkillID = 5017152;

	private static readonly int iceBranchID = 2003;

	private static readonly int iceSkillID = 5017153;

	protected readonly List<int> flapSkill = new List<int> { flapBranchID };

	protected readonly List<int> dashSkill = new List<int> { dashBranchID };

	protected readonly List<int> iceSkill = new List<int> { iceBranchID };

	private IEnumerator To1()
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

	private IEnumerator To7()
	{
		SwitchSequence(7);
		yield break;
	}

	protected IEnumerator AlertMovementEnumerator()
	{
		CastSkill(alertMovementSkillID);
		yield return WaitSkillFinish();
	}

	protected IEnumerator Wait1()
	{
		yield return WaitTime(1);
	}

	protected IEnumerator Wait2()
	{
		yield return WaitTime(2);
	}

	protected IEnumerator Wait3()
	{
		yield return WaitTime(3);
	}

	protected IEnumerator Wait4()
	{
		yield return WaitTime(4);
	}

	private IEnumerator FlapEnumerator()
	{
		CastSkill(flapSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator DashEnumerator()
	{
		CastSkill(dashSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator IceEnumerator()
	{
		CastSkill(iceSkillID);
		yield return WaitSkillFinish();
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
		int id7 = to7;
		operateIEnumerator = To7;
		list.Add(new BaseBranchInfo(id7, default, default, default, null, operateIEnumerator));
		int id8 = wait1;
		operateIEnumerator = Wait1;
		list.Add(new BaseBranchInfo(id8, default, default, default, null, operateIEnumerator));
		int id9 = wait2;
		operateIEnumerator = Wait2;
		list.Add(new BaseBranchInfo(id9, default, default, default, null, operateIEnumerator));
		int id10 = wait3;
		operateIEnumerator = Wait3;
		list.Add(new BaseBranchInfo(id10, default, default, default, null, operateIEnumerator));
		int id11 = wait4;
		operateIEnumerator = Wait4;
		list.Add(new BaseBranchInfo(id11, default, default, default, null, operateIEnumerator));
		int id12 = flapBranchID;
		operateIEnumerator = FlapEnumerator;
		list.Add(new BaseBranchInfo(id12, default, default, default, null, operateIEnumerator));
		int id13 = dashBranchID;
		operateIEnumerator = DashEnumerator;
		list.Add(new BaseBranchInfo(id13, default, default, default, null, operateIEnumerator));
		int id14 = iceBranchID;
		operateIEnumerator = IceEnumerator;
		list.Add(new BaseBranchInfo(id14, default, default, default, null, operateIEnumerator));
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
		case 7:
			list.Add(to7);
			break;
		default:
			list.Add(to1);
			NovaLogger.Debug("冰箱怪.AI脚本.ToTargetKey函数传参有误,默认1");
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
