using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50571FengShanJi;

public class Action_Lv1 : MonsterActionBase
{
	private static readonly int Skill_BalloonSummon = 5057101;

	private static readonly int Skill_Crush = 5057102;

	private static readonly int Skill_SpinShoot = 5057103;

	private static readonly int Skill_WindBlade = 5057104;

	private static readonly int Skill_WindBlast = 5057105;

	private static readonly int Skill_ShootTwice = 5057106;

	private static readonly int Skill_StormBlade = 5057107;

	private static readonly FP NearSkillRadiusIni = 4;

	private static readonly FP FarSkillRadiusIni = 7;

	private static readonly FP EdgeDistance = 8;

	private static readonly FP HpPercentStage2 = 0.7;

	private static readonly int testSkillId = 0;

	private FP FarSkillRadius;

	private FP NearSkillRadius;

	private int DistanceLevel;

	private int[] WeightInSkill;

	private bool IsPhase2;

	private bool IsFirstSkill;

	private int ChosenSkillIndex;

	private int ShootSkillCastIndex;

	private int SharpeSkillCastIndex;

	private int TmpShootSkillID;

	private int TmpSharpeSkillID;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = SummonSkillCastP1;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = ShootSkillCast;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = SharpSkillCastP1;
		list.Add(new BaseBranchInfo(1003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = UltraSkillCastP2;
		list.Add(new BaseBranchInfo(2001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = ShootSkillCast;
		list.Add(new BaseBranchInfo(2002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = SharpSkillCastP2;
		list.Add(new BaseBranchInfo(2003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = SummonSkillCastP2;
		list.Add(new BaseBranchInfo(2004, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int> { 1001, 1002, 1003, 1002, 1003 },
			[2] = new List<int> { 2001, 2004, 2002, 2003, 2004, 2002, 2003 }
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void OnActionEnable()
	{
		SetLogicTagFpValue(_actor, "Phase", 1);
		SetLogicTagFpValue(_actor, "Difficulty", 1);
		SetLogicTagToggleValue(_actor, "IsFirstInPhase2", value: true);
		FarSkillRadius = FarSkillRadiusIni;
		NearSkillRadius = NearSkillRadiusIni;
		IsPhase2 = false;
		IsFirstSkill = true;
		ShootSkillCastIndex = 1;
		SharpeSkillCastIndex = 1;
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfHpChanged, active: true, PhaseChange);
	}

	private void PhaseChange(IEvent evt)
	{
		if (_actor.actorHealthInfo.hpPercentage <= HpPercentStage2 && !IsPhase2)
		{
			SetLogicTagFpValue(_actor, "Phase", 2);
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
		CastSkill(ID);
	}

	private int CheckDistanceWithTarget()
	{
		FP distanceWithTarget = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
		if (distanceWithTarget <= NearSkillRadius)
		{
			return 1;
		}
		if (distanceWithTarget >= FarSkillRadius)
		{
			return 3;
		}
		return 2;
	}

	private IEnumerator SummonSkillCastP1()
	{
		TmpShootSkillID = 0;
		TmpSharpeSkillID = 0;
		ShootSkillCastIndex = 1;
		SharpeSkillCastIndex = 1;
		if (GetTargetByTeammateIndex(1).Count < 4)
		{
			GotoCastSkill(Skill_BalloonSummon);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator ShootSkillCast()
	{
		DistanceLevel = CheckDistanceWithTarget();
		if (ShootSkillCastIndex == 1)
		{
			if (DistanceLevel == 3)
			{
				if (GetRandomValue(0, 100, isInt: true) >= 70)
				{
					TmpShootSkillID = Skill_ShootTwice;
				}
				else
				{
					TmpShootSkillID = Skill_SpinShoot;
				}
			}
			else if (GetRandomValue(0, 100, isInt: true) >= 30)
			{
				TmpShootSkillID = Skill_ShootTwice;
			}
			else
			{
				TmpShootSkillID = Skill_SpinShoot;
			}
			if (Distance(GetPosition(), GetPlaceHolderPosition("CenterPoint")) >= EdgeDistance)
			{
				TmpShootSkillID = Skill_SpinShoot;
			}
			ShootSkillCastIndex = 2;
		}
		else
		{
			if (DistanceLevel == 3)
			{
				TmpShootSkillID = Skill_SpinShoot;
			}
			else if (TmpShootSkillID == Skill_ShootTwice)
			{
				TmpShootSkillID = Skill_SpinShoot;
			}
			else
			{
				TmpShootSkillID = Skill_ShootTwice;
			}
			ShootSkillCastIndex = 1;
		}
		if (IsFirstSkill)
		{
			TmpShootSkillID = Skill_ShootTwice;
			IsFirstSkill = false;
			ShootSkillCastIndex = 2;
		}
		GotoCastSkill(TmpShootSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator SharpSkillCastP1()
	{
		DistanceLevel = CheckDistanceWithTarget();
		if (SharpeSkillCastIndex == 1)
		{
			if (DistanceLevel == 3)
			{
				TmpSharpeSkillID = Skill_Crush;
			}
			else if (GetRandomValue(0, 100, isInt: true) >= 50)
			{
				TmpSharpeSkillID = Skill_WindBlast;
			}
			else
			{
				TmpSharpeSkillID = Skill_Crush;
			}
			SharpeSkillCastIndex = 2;
			if (Distance(GetPosition(), GetPlaceHolderPosition("CenterPoint")) >= EdgeDistance)
			{
				TmpSharpeSkillID = Skill_Crush;
			}
		}
		else if (SharpeSkillCastIndex == 2)
		{
			if (DistanceLevel == 3)
			{
				TmpSharpeSkillID = Skill_Crush;
			}
			else if (TmpSharpeSkillID == Skill_WindBlast)
			{
				TmpSharpeSkillID = Skill_Crush;
			}
			else
			{
				TmpSharpeSkillID = Skill_WindBlast;
			}
			SharpeSkillCastIndex = 1;
		}
		GotoCastSkill(TmpSharpeSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator UltraSkillCastP2()
	{
		TmpShootSkillID = 0;
		TmpSharpeSkillID = 0;
		ShootSkillCastIndex = 1;
		SharpeSkillCastIndex = 1;
		GotoCastSkill(Skill_StormBlade);
		yield return WaitSkillFinish();
	}

	private IEnumerator SharpSkillCastP2()
	{
		DistanceLevel = CheckDistanceWithTarget();
		if (DistanceLevel == 1)
		{
			WeightInSkill = new int[3] { 1, 1, 0 };
		}
		else if (DistanceLevel == 3)
		{
			WeightInSkill = new int[3] { 0, 1, 2 };
		}
		else
		{
			WeightInSkill = new int[3] { 16777216, 771751936, 1936933212 };
		}
		if (SharpeSkillCastIndex == 2)
		{
			if (TmpSharpeSkillID == Skill_WindBlast)
			{
				WeightInSkill[0] = 0;
			}
			if (TmpSharpeSkillID == Skill_Crush)
			{
				WeightInSkill[1] = 0;
			}
			if (TmpSharpeSkillID == Skill_WindBlade)
			{
				WeightInSkill[2] = 0;
			}
		}
		SharpeSkillCastIndex = 2;
		ChosenSkillIndex = randomWeight(WeightInSkill);
		switch (ChosenSkillIndex)
		{
		case 0:
			TmpSharpeSkillID = Skill_WindBlast;
			break;
		case 1:
			TmpSharpeSkillID = Skill_Crush;
			break;
		case 2:
			TmpSharpeSkillID = Skill_WindBlade;
			break;
		}
		GotoCastSkill(TmpSharpeSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator SummonSkillCastP2()
	{
		if (GetTargetByTeammateIndex(1).Count < 4)
		{
			GotoCastSkill(Skill_BalloonSummon);
			yield return WaitSkillFinish();
		}
	}
}
