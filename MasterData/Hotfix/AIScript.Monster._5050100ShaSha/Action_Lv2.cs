#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class Action_Lv2 : MonsterActionBase
{
	private static readonly int Dash = 5050151;

	private static readonly int Sweep = 5050152;

	private static readonly int ChargeFlick = 5050153;

	private static readonly int JumpFlick = 5050184;

	private static readonly int Crush = 5050154;

	private static readonly int CrargeBreath = 5050155;

	private static readonly int WaterSpit = 5050156;

	private static readonly int WaterSpit3 = 5050166;

	private static readonly int ShadowBall = 5050157;

	private static readonly int ShadowGathering = 5050158;

	private static readonly int TravelAround = 5050159;

	private static readonly int Whelmed = 5050160;

	private static readonly int Jump = 5050114;

	private static readonly int Wander = 5050199;

	private static readonly FP HpPercentStage2 = 0.7;

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
		OperateDelegate operateIEnumerator = SkillGroup01;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = SkillGroup02;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = DashSkillCast;
		list.Add(new BaseBranchInfo(1003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = StressSkillCast;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = UltraSkillCast;
		list.Add(new BaseBranchInfo(1005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = FarSkillCast;
		list.Add(new BaseBranchInfo(1006, default, default, default, null, operateIEnumerator));
		operateIEnumerator = ShadowSkillCast;
		list.Add(new BaseBranchInfo(1007, default, default, default, null, operateIEnumerator));
		operateIEnumerator = JumpFlickCast;
		list.Add(new BaseBranchInfo(1008, default, default, default, null, operateIEnumerator));
		operateIEnumerator = WanderCast;
		list.Add(new BaseBranchInfo(9999, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int>
			{
				1004, 1003, 9999, 1002, 1001, 1003, 1002, 9999, 1008, 1001,
				1002, 1001, 9999, 1002
			},
			[2] = new List<int>
			{
				1005, 1007, 1006, 1006, 9999, 1001, 1002, 1003, 1001, 1006,
				9999, 1008, 1003, 1006, 1002, 9999, 1001
			}
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

	private IEnumerator SkillGroup01()
	{
		FP fP = CalcAngleBetweenSelfAndAttackTarget();
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= 6.5f)
		{
			if (fP <= 60)
			{
				GotoCastSkill(Sweep);
			}
			else if (fP >= 120)
			{
				GotoCastSkill(ChargeFlick);
			}
			else if (fP <= 120 && fP >= 60)
			{
				GotoCastSkill(Crush);
			}
		}
		else
		{
			GotoCastSkill(CrargeBreath);
		}
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}

	private IEnumerator SkillGroup02()
	{
		FP distanceWithTarget = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
		if (distanceWithTarget <= 8 && distanceWithTarget > 6)
		{
			GotoCastSkill(Dash);
		}
		else if (distanceWithTarget > 8)
		{
			if (_actor.buffComponent.CheckBuffByBuffID(505010110))
			{
				GotoCastSkill(WaterSpit3);
			}
			else
			{
				GotoCastSkill(WaterSpit);
			}
		}
		else
		{
			GotoCastSkill(ChargeFlick);
		}
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}

	private IEnumerator DashSkillCast()
	{
		GotoCastSkill(Dash);
		yield return WaitSkillFinish();
	}

	private IEnumerator StressSkillCast()
	{
		GotoCastSkill(CrargeBreath);
		yield return WaitSkillFinish();
	}

	private IEnumerator UltraSkillCast()
	{
		if (!_actor.buffComponent.CheckBuffByBuffID(505010110))
		{
			GotoCastSkill(TravelAround);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator FarSkillCast()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) > 8)
		{
			if (GetRandomValue(1, 3, isInt: true) == 1)
			{
				GotoCastSkill(WaterSpit3);
			}
			else
			{
				GotoCastSkill(ShadowBall);
			}
		}
		else
		{
			GotoCastSkill(ShadowBall);
		}
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}

	private IEnumerator ShadowSkillCast()
	{
		if (TmpSkillID != ShadowGathering)
		{
			GotoCastSkill(ShadowGathering);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator JumpFlickCast()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= 6)
		{
			GotoCastSkill(ChargeFlick);
		}
		else
		{
			GotoCastSkill(JumpFlick);
		}
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
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
			_actor.actorSkillManage.DestoryAllSkill();
			_actor.InterruptAttack(force: true);
			base.OnHandleCustomSwitchState();
			SetLogicTagFpValue(_actor, "TaiDeng_Stage", 2);
			SwitchSequence(2);
			IsPhase2 = true;
		}
	}

	private void OnToughnessState(IEvent evt)
	{
		MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent = evt as MonsterToughnessStateChangeEvent;
		if (_actor != null && _actor.Id == monsterToughnessStateChangeEvent.actor.Id && monsterToughnessStateChangeEvent.isToughnessBroken)
		{
			_actor.InterruptForceControl();
			NovaLogger.Debug("鲨鱼 破除韧性  眩晕");
			_actor.actorSkillManage.DestoryAllSkill();
			_actor.InterruptAttack(force: true);
			GotoCastSkill(Whelmed);
		}
	}
}
