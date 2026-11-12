using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50571FengShanJi;

public class Action_BossRush : MonsterActionBase
{
	private readonly int Skill_Test;

	private readonly int Skill_BalloonSummon = 5057114;

	private readonly int Skill_Crush = 5057115;

	private readonly int Skill_WindBlast = 5057116;

	private readonly int Skill_WindBlade = 5057117;

	private readonly int Skill_SpinShoot = 5057118;

	private readonly int Skill_ShootTwice = 5057119;

	private readonly int Skill_StormBlade = 5057107;

	private readonly int Stage2RequireLevel = 15;

	private readonly int Stage3RequireLevel = 25;

	private readonly FP FarSkillOutRadius = 5;

	private readonly List<int> SafeSkillList = new List<int> { 5057118, 5057119 };

	private readonly List<int> P1BreakSkillList = new List<int> { 5057115, 5057117 };

	private readonly List<int> P23BreakSkillList = new List<int> { 5057116, 5057115, 5057117 };

	private bool HasTransformedTo2;

	private bool HasTransformedTo3;

	private int TmpSkill_Safe;

	private int TmpSkill_Break;

	private int CurrentLevel;

	private bool P1SequenceOver;

	private bool P2SequenceOver;

	private List<int> SafeSkills;

	private List<int> P1BreakSkills;

	private List<int> P23BreakSkills;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = BalloonSummon;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = SafeSkill2in1_1st_Total2;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = BreakSkill2in1_1st_Total2;
		list.Add(new BaseBranchInfo(1003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = BalloonSummon;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = SafeSkill2in1_2nd_Total2;
		list.Add(new BaseBranchInfo(1005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = BreakSkill2in1_2nd_Total2;
		list.Add(new BaseBranchInfo(1006, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P1End;
		list.Add(new BaseBranchInfo(1007, default, default, default, null, operateIEnumerator));
		operateIEnumerator = StormBlade;
		list.Add(new BaseBranchInfo(2001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = BalloonSummon;
		list.Add(new BaseBranchInfo(2002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = SafeSkill2in1_1st_Total2;
		list.Add(new BaseBranchInfo(2003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P23Skilll4Dash;
		list.Add(new BaseBranchInfo(2004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = BalloonSummon;
		list.Add(new BaseBranchInfo(2005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = SafeSkill2in1_2nd_Total2;
		list.Add(new BaseBranchInfo(2006, default, default, default, null, operateIEnumerator));
		operateIEnumerator = BreakSkill3in1_1st_Total3;
		list.Add(new BaseBranchInfo(2007, default, default, default, null, operateIEnumerator));
		operateIEnumerator = BreakSkill3in1_2nd_Total3;
		list.Add(new BaseBranchInfo(2008, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P2End;
		list.Add(new BaseBranchInfo(2009, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P2Initial;
		list.Add(new BaseBranchInfo(200, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P3Initial;
		list.Add(new BaseBranchInfo(300, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int> { 1001, 1002, 1003, 1004, 1005, 1006, 1007 },
			[2] = new List<int> { 200, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009 },
			[3] = new List<int> { 300, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008 },
			[4] = new List<int> { 1001 }
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void OnActionEnable()
	{
		HasTransformedTo2 = false;
		HasTransformedTo3 = false;
		P1SequenceOver = false;
		P2SequenceOver = false;
		SafeSkills = new List<int>();
		P1BreakSkills = new List<int>();
		P23BreakSkills = new List<int>();
		SafeSkills.AddRange(SafeSkillList);
		P1BreakSkills.AddRange(P1BreakSkillList);
		TmpSkill_Safe = 0;
		TmpSkill_Break = 0;
		CurrentLevel = 0;
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		SetLogicTagToggleValue(_actor, "IsBossRush", value: true);
		StartCoroutine(StageCheck());
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.BattleLevelChange, active: true, LevelUp);
	}

	private void GotoCastSkill(int ID)
	{
		if (Skill_Test != 0)
		{
			ID = Skill_Test;
		}
		CastSkill(ID);
	}

	private void LevelUp(IEvent evt)
	{
		CurrentLevel = (evt as AdventureMonsterBattleLevelChangedEvent).newLevel;
	}

	private IEnumerator StageCheck()
	{
		while (true)
		{
			if ((CurrentLevel >= Stage2RequireLevel || P1SequenceOver) && !HasTransformedTo2)
			{
				SwitchSequence(2);
				HasTransformedTo2 = true;
			}
			else if (((CurrentLevel >= Stage3RequireLevel && GetCurrentSequenceIndex() >= 2 && GetCurrentSequenceIndex() <= 7) || P2SequenceOver) && !HasTransformedTo3)
			{
				SwitchSequence(3);
				HasTransformedTo3 = true;
			}
			yield return null;
		}
	}

	private bool CheckTargetIsNear()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: false) <= FarSkillOutRadius)
		{
			return true;
		}
		return false;
	}

	private IEnumerator BalloonSummon()
	{
		GotoCastSkill(Skill_BalloonSummon);
		yield return WaitSkillFinish();
	}

	private IEnumerator StormBlade()
	{
		GotoCastSkill(Skill_StormBlade);
		yield return WaitSkillFinish();
	}

	private IEnumerator SafeSkill2in1_1st_Total2()
	{
		int num = ((!CheckTargetIsNear()) ? Skill_SpinShoot : Skill_ShootTwice);
		GotoCastSkill(num);
		SafeSkills.Remove(num);
		yield return WaitSkillFinish();
	}

	private IEnumerator BreakSkill2in1_1st_Total2()
	{
		int num = ((!CheckTargetIsNear()) ? Skill_WindBlade : Skill_Crush);
		GotoCastSkill(num);
		P1BreakSkills.Remove(num);
		yield return WaitSkillFinish();
	}

	private IEnumerator SafeSkill2in1_2nd_Total2()
	{
		GotoCastSkill(SafeSkills.get_Item(0));
		yield return WaitSkillFinish();
	}

	private IEnumerator BreakSkill2in1_2nd_Total2()
	{
		GotoCastSkill(P1BreakSkills.get_Item(0));
		yield return WaitSkillFinish();
	}

	private IEnumerator BreakSkill3in1_1st_Total3()
	{
		int num;
		if (CheckTargetIsNear())
		{
			num = ((!(GetRandomValue(0, 1) < 0.5)) ? Skill_WindBlast : Skill_Crush);
		}
		else
		{
			num = Skill_WindBlade;
		}
		GotoCastSkill(num);
		P23BreakSkills.Remove(num);
		yield return WaitSkillFinish();
	}

	private IEnumerator BreakSkill3in1_2nd_Total3()
	{
		int num;
		if (P23BreakSkills.Contains(P23BreakSkillList.get_Item(2)))
		{
			num = ((!CheckTargetIsNear()) ? P23BreakSkills.get_Item(1) : P23BreakSkills.get_Item(0));
		}
		else
		{
			num = ((!(GetRandomValue(0, 1) < 0.5)) ? P23BreakSkills.get_Item(1) : P23BreakSkills.get_Item(0));
		}
		GotoCastSkill(num);
		P23BreakSkills.Remove(num);
		yield return WaitSkillFinish();
	}

	private IEnumerator BreakSkill3in1_3rd_Total3()
	{
		GotoCastSkill(P23BreakSkills.get_Item(0));
		yield return WaitSkillFinish();
	}

	private IEnumerator P1End()
	{
		P1SequenceOver = true;
		yield break;
	}

	private IEnumerator P2End()
	{
		P2SequenceOver = true;
		yield break;
	}

	private IEnumerator P2Initial()
	{
		SafeSkills.Clear();
		SafeSkills.AddRange(SafeSkillList);
		P23BreakSkills.Clear();
		P23BreakSkills.AddRange(P23BreakSkillList);
		SetLogicTagFpValue(_actor, "BattleStage", 2);
		yield break;
	}

	private IEnumerator P3Initial()
	{
		SafeSkills.Clear();
		SafeSkills.AddRange(SafeSkillList);
		P23BreakSkills.Clear();
		P23BreakSkills.AddRange(P23BreakSkillList);
		SetLogicTagFpValue(_actor, "BattleStage", 3);
		yield break;
	}

	private IEnumerator P23Skilll4Dash()
	{
		GotoCastSkill(Skill_Crush);
		yield return WaitSkillFinish();
	}
}
