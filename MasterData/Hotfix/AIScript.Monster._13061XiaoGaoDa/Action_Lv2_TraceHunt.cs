using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._13061XiaoGaoDa;

public class Action_Lv2_TraceHunt : MonsterActionBase
{
	private static readonly int Attack_JinZhan = 1306101;

	private static readonly int Attack_Empty = 1306102;

	private static readonly int Skill1_Burst = 1306104;

	private static readonly int Skill3_Charge = 1306105;

	private static readonly int Skill3_Charge_Normal = 1306115;

	private static readonly int Skill4_Shoot = 1306106;

	private static readonly int Skill4_Shoot_mod3 = 1306110;

	private static readonly int Skill5_MissileShoot = 1306109;

	private static readonly FP HpPercentStage2 = 0.7;

	private static readonly int Stage2RequireLevel = 15;

	private static readonly FP FarSkillOutRadius = 12;

	private static readonly FP FarSkillinnerRadius = 7.5;

	private static readonly FP NearSkillOutRadius = 5;

	private static readonly FP fanAngle = 90;

	private static readonly int testSkillId = 0;

	private static readonly int intervaltime = 0;

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
		operateIEnumerator = DashSkillCast;
		list.Add(new BaseBranchInfo(1003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = StressSkillCast;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = UltraSkillCast;
		list.Add(new BaseBranchInfo(1005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = FarSkillCast;
		list.Add(new BaseBranchInfo(1006, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int>
			{
				1003, 1006, 1001, 1006, 1004, 1002, 1001, 1003, 1002, 1004,
				1006, 1001, 1002, 1004
			},
			[2] = new List<int>
			{
				1005, 1006, 1004, 1002, 1003, 1004, 1002, 1001, 1004, 1003,
				1003, 1003, 1004
			}
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.BattleLevelChange, active: true, LevelUp);
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
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= 6)
		{
			GotoCastSkill(Attack_Empty);
			SmallNearSkillCount++;
		}
		else
		{
			GotoCastSkill(Attack_JinZhan);
		}
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}

	private IEnumerator MediumSkillCast()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= 8)
		{
			GotoCastSkill(Attack_JinZhan);
		}
		else
		{
			GotoCastSkill(Skill4_Shoot);
		}
		SmallNearSkillCount = 0;
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}

	private IEnumerator DashSkillCast()
	{
		GotoCastSkill(Skill3_Charge);
		yield return WaitSkillFinish();
	}

	private IEnumerator StressSkillCast()
	{
		GotoCastSkill(Skill1_Burst);
		yield return WaitSkillFinish();
	}

	private IEnumerator UltraSkillCast()
	{
		if (TmpSkillID != Skill5_MissileShoot)
		{
			GotoCastSkill(Skill5_MissileShoot);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator FarSkillCast()
	{
		if (GetRandomValue(1, 3, isInt: true) == 1)
		{
			GotoCastSkill(Skill4_Shoot_mod3);
		}
		else
		{
			GotoCastSkill(Skill4_Shoot_mod3);
		}
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}

	private void LevelUp(IEvent evt)
	{
		if ((evt as AdventureMonsterBattleLevelChangedEvent).newLevel >= Stage2RequireLevel && !IsPhase2)
		{
			SetLogicTagFpValue(_actor, "TaiDeng_Stage", 2);
			SwitchSequence(2);
			IsPhase2 = true;
		}
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
}
