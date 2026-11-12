using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50511TaLou;

public class Action : MonsterActionBase
{
	protected int Skill_HitFloor;

	protected int Skill_FloatHitFloor;

	protected int Skill_GroundFire;

	protected int Skill_FireMine;

	protected int Skill_FireStorm;

	protected int Skill_FloatMove;

	private readonly FP FarSkillOutRadius = 12;

	private readonly FP FarSkillinnerRadius = 8.5;

	private readonly FP NearSkillOutRadius = 3.5;

	private readonly FP fanAngle = 90;

	private readonly int testSkillId;

	private int SmallNearSkillCount;

	private int TmpSkillID;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>
		{
			new BaseBranchInfo(1001, NearSkillOutRadius, fanAngle, 999, SmallSkillWithLongDistance, SmallSkillCast)
		};
		OperateDelegate operateIEnumerator = MediumSkillCast;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = BigSkillCast;
		list.Add(new BaseBranchInfo(1003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = UltraSkillCast;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int> { 1001, 1001, 1002, 1001, 1001, 1003 },
			[2] = new List<int> { 1004, 1001, 1001, 1002, 1001, 1001, 1003 }
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected void InitConfig(int _skill_HitFloor, int _skill_FloatHitFloor, int _skill_GroundFire, int _skill_FireMine, int _skill_FireStorm, int _skill_FloatMove)
	{
		Skill_HitFloor = _skill_HitFloor;
		Skill_FloatHitFloor = _skill_FloatHitFloor;
		Skill_GroundFire = _skill_GroundFire;
		Skill_FireMine = _skill_FireMine;
		Skill_FireStorm = _skill_FireStorm;
		Skill_FloatMove = _skill_FloatMove;
	}

	protected override void SetListenEvents()
	{
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
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: false) <= NearSkillOutRadius)
		{
			GotoCastSkill(Skill_HitFloor);
			SmallNearSkillCount++;
		}
		else
		{
			GotoCastSkill(Skill_GroundFire);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator MediumSkillCast()
	{
		if (SmallNearSkillCount >= 2)
		{
			GotoCastSkill(Skill_FloatMove);
		}
		else
		{
			GotoCastSkill(Skill_FloatHitFloor);
		}
		SmallNearSkillCount = 0;
		yield return WaitSkillFinish();
	}

	private IEnumerator BigSkillCast()
	{
		GotoCastSkill(Skill_FireMine);
		SmallNearSkillCount = 0;
		yield return WaitSkillFinish();
	}

	private IEnumerator UltraSkillCast()
	{
		if (TmpSkillID != Skill_FireStorm)
		{
			GotoCastSkill(Skill_FireStorm);
			yield return WaitSkillFinish();
		}
	}

	protected override void OnHandleCustomSwitchState()
	{
		base.OnHandleCustomSwitchState();
		FP logicTagValue = _actor.logicVariable.GetLogicTagValue("FireTaLou_ChangeState");
		if (logicTagValue == 2)
		{
			SwitchSequence(2);
		}
		else if (logicTagValue == 3 && (int)(long)_actor.logicVariable.GetLogicTagValue("FireTaLou_Stage3SkillId") != TmpSkillID)
		{
			SetCurrentSequenceIndex(0);
		}
	}
}
