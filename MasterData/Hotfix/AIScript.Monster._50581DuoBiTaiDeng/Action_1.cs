using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50581DuoBiTaiDeng;

public class Action_1 : MonsterActionBase
{
	private static readonly int Attack_JinZhan = 5058121;

	private static readonly int Skill1_ZhaoHuan = 5058122;

	private static readonly int Skill2_LuoDeng = 5058103;

	private static readonly int Skill3_LeiDian = 5058104;

	private static readonly int Skill3_LeiDian_P1 = 5058114;

	private static readonly int Skill4_ZhuaZi = 5058105;

	private static readonly int Skill5_XuanZhuan = 5058106;

	private static readonly int Attack_Laser = 5058107;

	private static readonly int Wander = 5058199;

	private static readonly FP HpPercentStage2 = 0.5;

	private static readonly FP FarSkillOutRadius = 12;

	private static readonly FP FarSkillinnerRadius = 7.5;

	private static readonly FP NearSkillOutRadius = 5;

	private static readonly FP fanAngle = 90;

	private static readonly int testSkillId = 0;

	private static readonly int intervaltime = 1;

	private int SmallNearSkillCount;

	private int TmpSkillID;

	private bool IsPhase2;

	private bool IsPhase3;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = SmallSkillCast;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = MediumSkillCast;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = SummonSkillCast;
		list.Add(new BaseBranchInfo(1003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = StressSkillCast;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = UltraSkillCast;
		list.Add(new BaseBranchInfo(1005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = ShootSkillCast;
		list.Add(new BaseBranchInfo(1006, default, default, default, null, operateIEnumerator));
		operateIEnumerator = WanderCast;
		list.Add(new BaseBranchInfo(9999, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int> { 1003, 1001, 1006, 1002, 1001, 1004, 1006, 1001, 1002 },
			[2] = new List<int> { 1005, 1003, 1002, 1006, 1001, 1004, 1006, 1001, 1002, 1006 }
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfHpChanged, active: true, PhaseChange);
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, OnToughnessState);
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

	private bool SmallSkillWithLongDistance()
	{
		TSVector2 position = GetPosition();
		FP farSkillOutRadius = FarSkillOutRadius;
		FP farSkillinnerRadius = FarSkillinnerRadius;
		FP angle = fanAngle;
		FP rotation = GetRotation();
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, farSkillOutRadius, farSkillinnerRadius, angle, rotation);
		return IsAttackTargetInArea(shapeData);
	}

	private IEnumerator SmallSkillCast()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= NearSkillOutRadius)
		{
			GotoCastSkill(Attack_JinZhan);
			SmallNearSkillCount++;
		}
		else
		{
			GotoCastSkill(Attack_Laser);
		}
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}

	private IEnumerator MediumSkillCast()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= FarSkillinnerRadius)
		{
			GotoCastSkill(Skill5_XuanZhuan);
		}
		else
		{
			GotoCastSkill(Skill4_ZhuaZi);
		}
		SmallNearSkillCount = 0;
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}

	private IEnumerator SummonSkillCast()
	{
		GotoCastSkill(Skill1_ZhaoHuan);
		yield return WaitSkillFinish();
	}

	private IEnumerator StressSkillCast()
	{
		GotoCastSkill(Skill2_LuoDeng);
		yield return WaitSkillFinish();
	}

	private IEnumerator UltraSkillCast()
	{
		if (TmpSkillID != Skill3_LeiDian)
		{
			GotoCastSkill(Skill3_LeiDian);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator ShootSkillCast()
	{
		GotoCastSkill(Skill4_ZhuaZi);
		yield return WaitSkillFinish();
	}

	private IEnumerator WanderCast()
	{
		GotoCastSkill(Wander);
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}

	private void PhaseChange(IEvent evt)
	{
		if (_actor.actorHealthInfo.hpPercentage <= HpPercentStage2 && !IsPhase2)
		{
			SetLogicTagFpValue(_actor, "TaiDeng_Stage", 2);
			SwitchSequence(2);
			IsPhase2 = true;
		}
	}

	private void OnToughnessState(IEvent evt)
	{
	}
}
