#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50601JinDuanLiRong;

public class JinDuanLiRongActionBasetion : MonsterActionBase
{
	protected bool changePhase;

	private string alertTypeName = "AlertType";

	protected static List<BaseBranchInfo> sequenceBranchesList;

	private static readonly int faCycloneBranchID = 1001;

	private static readonly int faCycloneSkillID = 5060130;

	private static readonly int deathBranchID = 1002;

	private static readonly int deathSkillID = 5060127;

	protected static readonly int spawnBranchID = 1003;

	private static readonly int spawnSkillID = 5060128;

	protected static readonly int wanderActionHandBranchID = 1004;

	private static readonly int wanderActionHandSkillID = 5060133;

	protected static readonly int wanderActionFootBranchID = 1005;

	private static readonly int wanderActionFootSkillID = 5060134;

	protected static readonly int to1 = 1011;

	protected static readonly int to2 = 1012;

	protected static readonly int to3 = 1013;

	protected static readonly int to4 = 1014;

	protected static readonly int to5 = 1015;

	protected static readonly int to6 = 1016;

	protected static readonly int to7 = 1017;

	protected static readonly int wait1 = 1031;

	protected static readonly int wait2 = 1032;

	protected static readonly int wait3 = 1033;

	protected static readonly int wait4 = 1034;

	protected static readonly int checkConditionBranch = 1041;

	private static readonly int normalATKBranchID = 2001;

	private static readonly int normalATKSkillID = 5060101;

	private static readonly int kickBranchID = 2002;

	private static readonly int kickSkillID = 5060104;

	private static readonly int firstAttackBranchID = 2003;

	private static readonly int firstAttackSkillID = 5060116;

	private static readonly int chargeBranchID = 3001;

	private static readonly int chargeSkillID = 5060103;

	private static readonly int normalAttack_SCBranchID = 3002;

	private static readonly int normalAttack_SCSkillID = 5060119;

	private static readonly int normalATK_SC_NCBranchID = 3003;

	private static readonly int normalATK_SC_NCSkillID = 5060101;

	private static readonly int normalATK_JCBranchID = 4001;

	private static readonly int normalATK_JCSkillID = 5060121;

	private static readonly int cycloneATK_JCBranchID = 4002;

	private static readonly int cycloneATK_JCSkillID = 5060122;

	protected static readonly int breakATKBranchID = 5001;

	private static readonly int breakATKSkillID = 5060111;

	private static readonly int normalATK_FABranchID = 5002;

	private static readonly int normalATK_FASkillID = 5060124;

	private static readonly int charge_FABranchID = 5003;

	private static readonly int charge_FASkillID = 5060125;

	private static readonly int normalATK_Score_FABranchID = 5004;

	private static readonly int normalATK_Score_FASkillID = 5060132;

	protected static readonly int faUltimateBranchID = 6001;

	private static readonly int faUltimateSkillID = 5060112;

	protected static readonly int switchArms2SCBranchID = 6002;

	private static readonly int switchArms2SCSkillID = 5060117;

	protected static readonly int switchArms2JCBranchID = 6003;

	private static readonly int switchArms2JCSkillID = 5060123;

	protected readonly List<int> wanderActionHandSkill = new List<int> { wanderActionHandBranchID };

	protected readonly List<int> wanderActionFootSkill = new List<int> { wanderActionFootBranchID };

	protected readonly List<int> changePhaseSkill = new List<int> { checkConditionBranch };

	protected readonly List<int> initialSkill = new List<int> { firstAttackBranchID, normalATKBranchID, normalATKBranchID, kickBranchID };

	protected readonly List<int> jC_H1 = new List<int> { normalATK_JCBranchID, normalATK_JCBranchID };

	protected readonly List<int> jC_H2 = new List<int> { normalATK_JCBranchID, cycloneATK_JCBranchID };

	protected readonly List<int> jC_H3 = new List<int> { normalATK_JCBranchID, normalATK_JCBranchID, normalATK_JCBranchID };

	protected readonly List<int> jC_H4 = new List<int> { normalATK_JCBranchID };

	protected readonly List<int> jC_H5 = new List<int> { cycloneATK_JCBranchID };

	protected readonly List<int> sC_H1 = new List<int> { chargeBranchID, chargeBranchID, normalAttack_SCBranchID, normalAttack_SCBranchID };

	protected readonly List<int> sC_H2 = new List<int> { chargeBranchID, chargeBranchID, normalATK_SC_NCBranchID, normalATK_SC_NCBranchID };

	protected readonly List<int> sC_H3 = new List<int> { chargeBranchID, normalATK_SC_NCBranchID, normalATK_SC_NCBranchID, chargeBranchID };

	protected readonly List<int> sC_H4 = new List<int> { chargeBranchID, chargeBranchID };

	protected readonly List<int> fA_N1 = new List<int> { normalATK_FABranchID, normalATK_FABranchID, charge_FABranchID };

	protected readonly List<int> fA_N2 = new List<int> { normalATK_FABranchID, normalATK_FABranchID, faCycloneBranchID };

	private IEnumerator FaCycloneEnumerator()
	{
		CastSkill(faCycloneSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator DeathEnumerator()
	{
		CastSkill(deathSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator SpawnEnumerator()
	{
		CastSkill(spawnSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator WanderActionHandEnumerator()
	{
		CastSkill(wanderActionHandSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator WanderActionFootEnumerator()
	{
		CastSkill(wanderActionFootSkillID);
		yield return WaitSkillFinish();
	}

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

	protected IEnumerator CheckCondition()
	{
		if (changePhase)
		{
			SwitchSequence(4);
			changePhase = false;
		}
		yield break;
	}

	private IEnumerator normalAttackEnumerator()
	{
		CastSkill(normalATKSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator kickEnumerator()
	{
		CastSkill(kickSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator firstAttackEnumerator()
	{
		CastSkill(firstAttackSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator ChargeEnumerator()
	{
		CastSkill(chargeSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator NormalAttack_SCEnumerator()
	{
		CastSkill(normalAttack_SCSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator NormalATK_SC_NCEnumerator()
	{
		CastSkill(normalATK_SC_NCSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator normalATK_JCEnumerator()
	{
		CastSkill(normalATK_JCSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator cycloneATK_JCEnumerator()
	{
		CastSkill(cycloneATK_JCSkillID);
		yield return WaitSkillFinish();
	}

	protected IEnumerator breakATKEnumerator()
	{
		CastSkill(breakATKSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator normalATK_FAEnumerator()
	{
		CastSkill(normalATK_FASkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator charge_FAEnumerator()
	{
		CastSkill(charge_FASkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator normalATK_Score_FAEnumerator()
	{
		CastSkill(normalATK_Score_FASkillID);
		yield return WaitSkillFinish();
	}

	protected virtual IEnumerator faUltimateEnumerator()
	{
		yield return StartCor(faUltimateEnumeratorCor());
	}

	protected IEnumerator faUltimateEnumeratorCor()
	{
		CastSkill(faUltimateSkillID);
		yield return WaitSkillFinish();
	}

	protected virtual IEnumerator switchArms2SCEnumerator()
	{
		yield return StartCor(switchArms2SCEnumeratorCor());
	}

	protected IEnumerator switchArms2SCEnumeratorCor()
	{
		CastSkill(switchArms2SCSkillID);
		yield return WaitSkillFinish();
	}

	protected virtual IEnumerator switchArms2JCEnumerator()
	{
		yield return StartCor(switchArms2JCEnumeratorCor());
	}

	protected IEnumerator switchArms2JCEnumeratorCor()
	{
		CastSkill(switchArms2JCSkillID);
		yield return WaitSkillFinish();
	}

	protected override void SetConfig()
	{
		changePhase = false;
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		int id = checkConditionBranch;
		OperateDelegate operateIEnumerator = CheckCondition;
		list.Add(new BaseBranchInfo(id, default, default, default, null, operateIEnumerator));
		int id2 = wanderActionHandBranchID;
		operateIEnumerator = WanderActionHandEnumerator;
		list.Add(new BaseBranchInfo(id2, default, default, default, null, operateIEnumerator));
		int id3 = wanderActionFootBranchID;
		operateIEnumerator = WanderActionFootEnumerator;
		list.Add(new BaseBranchInfo(id3, default, default, default, null, operateIEnumerator));
		int id4 = to1;
		operateIEnumerator = To1;
		list.Add(new BaseBranchInfo(id4, default, default, default, null, operateIEnumerator));
		int id5 = to2;
		operateIEnumerator = To2;
		list.Add(new BaseBranchInfo(id5, default, default, default, null, operateIEnumerator));
		int id6 = to3;
		operateIEnumerator = To3;
		list.Add(new BaseBranchInfo(id6, default, default, default, null, operateIEnumerator));
		int id7 = to4;
		operateIEnumerator = To4;
		list.Add(new BaseBranchInfo(id7, default, default, default, null, operateIEnumerator));
		int id8 = to5;
		operateIEnumerator = To5;
		list.Add(new BaseBranchInfo(id8, default, default, default, null, operateIEnumerator));
		int id9 = to6;
		operateIEnumerator = To6;
		list.Add(new BaseBranchInfo(id9, default, default, default, null, operateIEnumerator));
		int id10 = to7;
		operateIEnumerator = To7;
		list.Add(new BaseBranchInfo(id10, default, default, default, null, operateIEnumerator));
		int id11 = wait1;
		operateIEnumerator = Wait1;
		list.Add(new BaseBranchInfo(id11, default, default, default, null, operateIEnumerator));
		int id12 = wait2;
		operateIEnumerator = Wait2;
		list.Add(new BaseBranchInfo(id12, default, default, default, null, operateIEnumerator));
		int id13 = wait3;
		operateIEnumerator = Wait3;
		list.Add(new BaseBranchInfo(id13, default, default, default, null, operateIEnumerator));
		int id14 = wait4;
		operateIEnumerator = Wait4;
		list.Add(new BaseBranchInfo(id14, default, default, default, null, operateIEnumerator));
		list.Add(new BaseBranchInfo(normalATKBranchID, 5, 90, 2, MeleeStopTrace, normalAttackEnumerator));
		int id15 = chargeBranchID;
		operateIEnumerator = ChargeEnumerator;
		list.Add(new BaseBranchInfo(id15, default, default, default, null, operateIEnumerator));
		list.Add(new BaseBranchInfo(kickBranchID, 8, 120, 2, MeleeStopTrace, kickEnumerator));
		int id16 = breakATKBranchID;
		operateIEnumerator = breakATKEnumerator;
		list.Add(new BaseBranchInfo(id16, default, default, default, null, operateIEnumerator));
		int id17 = faUltimateBranchID;
		operateIEnumerator = faUltimateEnumerator;
		list.Add(new BaseBranchInfo(id17, default, default, default, null, operateIEnumerator));
		int id18 = firstAttackBranchID;
		operateIEnumerator = firstAttackEnumerator;
		list.Add(new BaseBranchInfo(id18, default, default, default, null, operateIEnumerator));
		int id19 = switchArms2SCBranchID;
		operateIEnumerator = switchArms2SCEnumerator;
		list.Add(new BaseBranchInfo(id19, default, default, default, null, operateIEnumerator));
		list.Add(new BaseBranchInfo(normalAttack_SCBranchID, 5, 90, 2, MeleeStopTrace, NormalAttack_SCEnumerator));
		int id20 = normalATK_JCBranchID;
		operateIEnumerator = normalATK_JCEnumerator;
		list.Add(new BaseBranchInfo(id20, default, default, default, null, operateIEnumerator));
		int id21 = cycloneATK_JCBranchID;
		operateIEnumerator = cycloneATK_JCEnumerator;
		list.Add(new BaseBranchInfo(id21, default, default, default, null, operateIEnumerator));
		int id22 = switchArms2JCBranchID;
		operateIEnumerator = switchArms2JCEnumerator;
		list.Add(new BaseBranchInfo(id22, default, default, default, null, operateIEnumerator));
		int id23 = normalATK_FABranchID;
		operateIEnumerator = normalATK_FAEnumerator;
		list.Add(new BaseBranchInfo(id23, default, default, default, null, operateIEnumerator));
		int id24 = normalATK_Score_FABranchID;
		operateIEnumerator = normalATK_Score_FAEnumerator;
		list.Add(new BaseBranchInfo(id24, default, default, default, null, operateIEnumerator));
		int id25 = charge_FABranchID;
		operateIEnumerator = charge_FAEnumerator;
		list.Add(new BaseBranchInfo(id25, default, default, default, null, operateIEnumerator));
		int id26 = deathBranchID;
		operateIEnumerator = DeathEnumerator;
		list.Add(new BaseBranchInfo(id26, default, default, default, null, operateIEnumerator));
		int id27 = spawnBranchID;
		operateIEnumerator = SpawnEnumerator;
		list.Add(new BaseBranchInfo(id27, default, default, default, null, operateIEnumerator));
		int id28 = faCycloneBranchID;
		operateIEnumerator = FaCycloneEnumerator;
		list.Add(new BaseBranchInfo(id28, default, default, default, null, operateIEnumerator));
		list.Add(new BaseBranchInfo(normalATK_SC_NCBranchID, 5, 90, 2, MeleeStopTrace, NormalATK_SC_NCEnumerator));
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
			NovaLogger.Debug("禁断丽容.AI脚本.ToTargetKey函数传参有误,默认1");
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

	protected void SetAlertType(int Index)
	{
		SetLogicTagFpValue(_actor, alertTypeName, Index);
	}
}
