using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30271ShengDanQieChe;

public class ActionLv2 : MonsterActionBase
{
	private static readonly int Skill01_DriftAttackLv1 = 3027101;

	private static readonly int Skill01_DriftAttackLv2 = 3027102;

	private static readonly int Skill02_ThrowGiftLv1 = 3027103;

	private static readonly int Skill02_ThrowGiftLv2 = 3027104;

	private static readonly int Skill03_Dash = 3027105;

	private static readonly int Skill03_DashThrowLv2 = 3027107;

	private static readonly int Skill04_CallGiftMachine = 3027108;

	private static readonly int Skill05_CallMinions = 3027109;

	private static readonly int Skill06_CrazyRotation = 3027110;

	private static readonly int Skill13_RunningAway = 3027113;

	private static readonly FP DriftDistance = 4;

	private static readonly FP RunAwayDistance = 4;

	private static readonly FP HP_P2 = 0.8;

	private static readonly int testSkillId = 0;

	private FP StartTime;

	private FP DistanceToTarget;

	private bool IsP2;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		FP releaseAngle = 15;
		OperateDelegate operateIEnumerator = Cast1;
		list.Add(new BaseBranchInfo(1001, default, releaseAngle, default, null, operateIEnumerator));
		operateIEnumerator = Cast2;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		releaseAngle = 15;
		operateIEnumerator = Cast3;
		list.Add(new BaseBranchInfo(1003, default, releaseAngle, default, null, operateIEnumerator));
		operateIEnumerator = Cast4;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast5;
		list.Add(new BaseBranchInfo(1005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast6;
		list.Add(new BaseBranchInfo(1006, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast7;
		list.Add(new BaseBranchInfo(1007, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast8;
		list.Add(new BaseBranchInfo(1008, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast9;
		list.Add(new BaseBranchInfo(1009, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast10;
		list.Add(new BaseBranchInfo(1010, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast11;
		list.Add(new BaseBranchInfo(1011, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int> { 1001, 1002, 1004 },
			[2] = new List<int> { 1006, 1010, 1005, 1008, 1011, 1009 }
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
		StartTime = _actor.LogicTime;
	}

	protected override void OnActionEnable()
	{
		IsP2 = false;
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfHpChanged, active: true, PhaseChange);
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, RemoveBuff);
	}

	private void PhaseChange(IEvent evt)
	{
		if (_actor.actorHealthInfo.hpPercentage <= HP_P2 && !IsP2)
		{
			SwitchSequence(2);
			IsP2 = true;
		}
	}

	private void RemoveBuff(IEvent evt)
	{
		RemoveBuffFromTarget(_actor, 302710002);
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		CastSkill(ID);
	}

	private IEnumerator Cast1()
	{
		GotoCastSkill(Skill02_ThrowGiftLv1);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast2()
	{
		DistanceToTarget = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
		if (DistanceToTarget <= DriftDistance)
		{
			GotoCastSkill(Skill01_DriftAttackLv1);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Cast3()
	{
		GotoCastSkill(Skill13_RunningAway);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast4()
	{
		if (GetBuffNum(_actor, 302710002) >= 1)
		{
			GotoCastSkill(Skill06_CrazyRotation);
			yield return WaitSkillFinish();
		}
		else
		{
			GotoCastSkill(Skill03_Dash);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Cast5()
	{
		GotoCastSkill(Skill04_CallGiftMachine);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast6()
	{
		GotoCastSkill(Skill02_ThrowGiftLv2);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast7()
	{
		DistanceToTarget = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
		if (DistanceToTarget <= RunAwayDistance)
		{
			GotoCastSkill(Skill13_RunningAway);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Cast8()
	{
		GotoCastSkill(Skill03_DashThrowLv2);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast9()
	{
		GotoCastSkill(Skill05_CallMinions);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast10()
	{
		DistanceToTarget = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
		if (DistanceToTarget <= DriftDistance)
		{
			GotoCastSkill(Skill01_DriftAttackLv2);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Cast11()
	{
		if (GetBuffNum(_actor, 302710002) >= 1)
		{
			GotoCastSkill(Skill06_CrazyRotation);
			yield return WaitSkillFinish();
		}
	}
}
