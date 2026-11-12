using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._10007KuangFengQingXiao;

public class Action_Activity : MonsterActionBase
{
	private static readonly int Skill1 = 1000701;

	private static readonly int Skill2 = 1000702;

	private static readonly int Skill3 = 1000703;

	private static readonly int Skill4 = 1000704;

	private static readonly int Skill14 = 1000714;

	private static readonly int Skill5 = 1000705;

	private static readonly int Skill6 = 1000706;

	private static readonly int Skill8 = 1000708;

	private static readonly int testSkillId = 0;

	private static readonly int intervaltime = 0;

	private bool ultraskillCast = true;

	private bool IsPhase2;

	private static readonly FP HpPercentStage2 = 0.65;

	private FP summontime = 120f;

	private FP summoninterval = 20f;

	private List<int> summonlist = new List<int> { 1, 2, 3 };

	private int summonnum = 4;

	private CoroutineNode _summonCoroutine;

	private int TmpSkillID;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> sequenceBranches = new List<BaseBranchInfo>
		{
			new BaseBranchInfo(1001, 20, 360, 5, null, SkillGroup01),
			new BaseBranchInfo(1002, 20, 360, 5, null, SkillGroup02),
			new BaseBranchInfo(1003, 20, 360, 5, null, SkillGroup03),
			new BaseBranchInfo(1004, 20, 360, 5, null, SkillGroup04),
			new BaseBranchInfo(1005, 20, 360, 5, null, SkillGroup05),
			new BaseBranchInfo(1006, 20, 360, 5, null, SkillGroup06),
			new BaseBranchInfo(1008, 20, 360, 5, null, SkillGroup08)
		};
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int> { 1001, 1002, 1003, 1005, 1008, 1006, 1001, 1005, 1002, 1008 },
			[2] = new List<int> { 1004, 1003, 1002, 1005, 1001, 1006, 1008 }
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		_summonCoroutine = StartCoroutine(summonskill());
		SetLogicTagStringValue(_actor, "Bosstag", "Boss");
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		if (_summonCoroutine != null)
		{
			StopCoroutine(_summonCoroutine);
			_summonCoroutine = null;
		}
	}

	private IEnumerator summonskill()
	{
		yield return WaitTime(5);
		while (summontime >= 0)
		{
			LogicEntity currentPlayer = GetCurrentPlayer();
			Action_Activity action_Activity = this;
			TSVector2 entityPosition = GetEntityPosition(_actor);
			FP radius = 9;
			FP innerRadius = 6;
			FP angle = 360;
			FP rotation = 0;
			DeterministicShape shapeData = action_Activity.GetShapeData(DeterministicShape.ShapeType.Fan, entityPosition, default, default, radius, innerRadius, angle, rotation);
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, currentPlayer, isReachable: true);
			SummonTeammate(summonnum, shapeRandomPoint, GetForward());
			yield return WaitTime(summoninterval);
			summontime -= summoninterval;
		}
		yield return WaitTime(1);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfHpChanged, active: true, PhaseChange);
	}

	private void PhaseChange(IEvent evt)
	{
		if (_actor.actorHealthInfo.hpPercentage <= HpPercentStage2 && !IsPhase2)
		{
			SetLogicTagFpValue(_actor, "BossStage", 2);
			SwitchSequence(2);
			IsPhase2 = true;
		}
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		TmpSkillID = ID;
		CastSkill(ID);
	}

	private IEnumerator SkillGroup01()
	{
		GotoCastSkill(Skill1);
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}

	private IEnumerator SkillGroup02()
	{
		GotoCastSkill(Skill2);
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}

	private IEnumerator SkillGroup03()
	{
		GotoCastSkill(Skill3);
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}

	private IEnumerator SkillGroup04()
	{
		if (ultraskillCast)
		{
			GotoCastSkill(Skill4);
			ultraskillCast = false;
		}
		else
		{
			GotoCastSkill(Skill14);
			ultraskillCast = true;
		}
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}

	private IEnumerator SkillGroup05()
	{
		GotoCastSkill(Skill5);
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}

	private IEnumerator SkillGroup06()
	{
		GotoCastSkill(Skill6);
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}

	private IEnumerator SkillGroup08()
	{
		GotoCastSkill(Skill8);
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}
}
