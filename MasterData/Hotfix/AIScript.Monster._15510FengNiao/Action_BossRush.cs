#define LOG_ERROR
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Action_BossRush : MonsterActionBase
{
	private readonly int Skill_Test;

	private readonly int Skill_Dash = 1551001;

	private readonly int Skill_FlyUp = 1551002;

	private readonly int Skill_ContiniousPeck = 1551003;

	private readonly int Skill_TailAttack = 1551008;

	private readonly int Skill_LaserShoot = 1551005;

	private readonly int Skill_LaserStrafe = 1551006;

	private readonly int Skill_FlowerAwaken = 1551004;

	private readonly int Skill_UltraBirdBomb = 1551007;

	private readonly int Skill_TransformTo2 = 1551093;

	private readonly int Stage2RequireLevel = 15;

	private readonly int Stage3RequireLevel = 25;

	private readonly FP FarSkillOutRadius = 7;

	private readonly List<int> SummonProbabilityList = new List<int> { 100, 100, 80, 50, 25, 10, 10 };

	private bool HasTransformedTo2;

	private bool HasTransformedTo3;

	private bool HasTransformSkillCasted;

	private int TmpSkillP1;

	private int TmpSkillP23_1;

	private int TmpSkillP23_2;

	private int CurrentLevel;

	private bool P1SequenceOver;

	private bool P2SequenceOver;

	private int AwakenTimesInP23;

	private int AwakenIndexDifference;

	private List<LogicEntity> FlowerList;

	private CoroutineNode StageCheckNode;

	private CoroutineNode CheckBuffAndSetLightDistanceNode;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = P1Skill1Cast;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P1Skill2Cast;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P1Skill3Cast;
		list.Add(new BaseBranchInfo(1003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P1Skill4Cast;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P1Skill5Cast;
		list.Add(new BaseBranchInfo(1005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P1Skill6Cast;
		list.Add(new BaseBranchInfo(1006, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P1Skill7Cast;
		list.Add(new BaseBranchInfo(1007, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P1Skill8Cast;
		list.Add(new BaseBranchInfo(1008, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P1Skill9Cast;
		list.Add(new BaseBranchInfo(1009, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P1Skill10Cast;
		list.Add(new BaseBranchInfo(1010, default, default, default, null, operateIEnumerator));
		operateIEnumerator = TransformCast;
		list.Add(new BaseBranchInfo(2000, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P2Skill1Cast;
		list.Add(new BaseBranchInfo(2001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P2Skill2Cast;
		list.Add(new BaseBranchInfo(2002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P2Skill3Cast;
		list.Add(new BaseBranchInfo(2003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P2Skill4Cast;
		list.Add(new BaseBranchInfo(2004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P2Skill5Cast;
		list.Add(new BaseBranchInfo(2005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P2Skill6Cast;
		list.Add(new BaseBranchInfo(2006, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P2Skill7Cast;
		list.Add(new BaseBranchInfo(2007, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P2Initial;
		list.Add(new BaseBranchInfo(200, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P3Initial;
		list.Add(new BaseBranchInfo(300, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int> { 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010 },
			[2] = new List<int> { 200, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007 },
			[3] = new List<int> { 300, 2001, 2002, 2003, 2004, 2005, 2006, 2007 }
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void OnActionEnable()
	{
		HasTransformedTo2 = false;
		HasTransformedTo3 = false;
		P1SequenceOver = false;
		P2SequenceOver = false;
		HasTransformSkillCasted = false;
		TmpSkillP1 = 0;
		TmpSkillP23_1 = 0;
		TmpSkillP23_2 = 0;
		CurrentLevel = 0;
		FlowerList = new List<LogicEntity>();
		AwakenTimesInP23 = 0;
		AwakenIndexDifference = 0;
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		SetLogicTagToggleValue(_actor, "IsBossRush", value: true);
		StartCoroutine(ref StageCheckNode, StageCheck());
		StartCoroutine(ref CheckBuffAndSetLightDistanceNode, CheckBuffAndSetLightDistance());
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.BattleLevelChange, active: true, LevelUp);
		InitListenEvent(MonsterEventType.SelfLostControl, active: true, LostControlKillBirds);
	}

	protected override void OnActionDisable()
	{
		StopCoroutine(ref StageCheckNode);
		StopCoroutine(ref CheckBuffAndSetLightDistanceNode);
	}

	private void GotoCastSkill(int ID)
	{
		if (Skill_Test != 0)
		{
			ID = Skill_Test;
		}
		CastSkill(ID);
	}

	private void GotoCastSkillWithCheckFlowerAwaken(int ID)
	{
		int skillId = ID;
		if (CheckFlowerAwaken())
		{
			skillId = Skill_FlowerAwaken;
			SetCurrentSequenceIndex(GetCurrentSequenceIndex(IsOperateSuccess: false));
		}
		if (Skill_Test != 0)
		{
			skillId = Skill_Test;
		}
		CastSkill(skillId);
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
			else if (((CurrentLevel >= Stage3RequireLevel && GetCurrentSequenceIndex() >= 6 && GetCurrentSequenceIndex() <= 8) || P2SequenceOver) && !HasTransformedTo3)
			{
				SwitchSequence(3);
				HasTransformedTo3 = true;
			}
			yield return null;
		}
	}

	private IEnumerator StageTimeCount()
	{
		yield return WaitTime(45);
		CurrentLevel = Stage2RequireLevel;
		NovaLogger.Error("阶段2开始了");
		yield return WaitTime(75);
		CurrentLevel = Stage3RequireLevel;
		NovaLogger.Error("阶段3开始了");
		yield return WaitTime(60);
		NovaLogger.Error("3分钟到了");
		_actor.DestroySelf();
	}

	private bool CheckTargetIsNear()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: false) <= FarSkillOutRadius)
		{
			return true;
		}
		return false;
	}

	private bool CheckFlowerAwaken()
	{
		GetAwakenFlowerEntities();
		int count = FlowerList.Count;
		FP fP = SummonProbabilityList.get_Item(count);
		if (AwakenTimesInP23 >= 2)
		{
			fP = 0;
		}
		if (AwakenIndexDifference <= 2)
		{
			fP = 0;
		}
		if (GetRandomValue(1, 100) > 100 - fP)
		{
			AwakenTimesInP23++;
			AwakenIndexDifference = 0;
			return true;
		}
		AwakenIndexDifference++;
		return false;
	}

	private void GetAwakenFlowerEntities()
	{
		FlowerList.Clear();
		FlowerList = GetTargetsByLogicTag(LogicTagType._Bool, "Awaken", GetTargetByTeammateIndexes(new List<int> { 1, 2 }), value1: true);
	}

	private void LostControlKillBirds(IEvent evt)
	{
		ClearActors(GetTargetByTeammateIndexes(new List<int> { 3, 4 }));
		GetAwakenFlowerEntities();
		foreach (AdventureActor flower in FlowerList)
		{
			DirectDamage(flower, (int)_actor.actorHealthInfo.hpMax, null, showHud: false);
		}
	}

	private IEnumerator CheckBuffAndSetLightDistance()
	{
		while (true)
		{
			if (!GetLogicTagToggleValue(_actor, "InFlowerAwakenSkill") || _actor.state == ActorState.LostControl)
			{
				List<int> list = new List<int> { 155109330, 155109340, 155109350, 155109360, 155109370, 155109380, 155109390, 155109400 };
				int num = 0;
				foreach (int item in list)
				{
					if (GetBuffNum(_actor, item) == 0)
					{
						num++;
						continue;
					}
					break;
				}
				switch (num)
				{
				case 0:
				case 1:
				case 6:
					SetLogicTagFpValue(_actor, "LightDistance", 6.5);
					break;
				case 2:
				case 3:
				case 7:
					SetLogicTagFpValue(_actor, "LightDistance", 11.5);
					break;
				case 4:
				case 5:
					SetLogicTagFpValue(_actor, "LightDistance", 0);
					break;
				}
			}
			yield return WaitTime(0.1);
		}
	}

	private IEnumerator P1Skill1Cast()
	{
		GotoCastSkill(Skill_ContiniousPeck);
		yield return WaitSkillFinish();
	}

	private IEnumerator P1Skill2Cast()
	{
		int num = ((!CheckTargetIsNear()) ? Skill_LaserShoot : Skill_Dash);
		GotoCastSkill(num);
		TmpSkillP1 = num;
		yield return WaitSkillFinish();
	}

	private IEnumerator P1Skill3Cast()
	{
		GotoCastSkill(Skill_FlyUp);
		yield return WaitSkillFinish();
	}

	private IEnumerator P1Skill4Cast()
	{
		int iD = ((TmpSkillP1 != Skill_Dash) ? Skill_Dash : Skill_LaserShoot);
		GotoCastSkill(iD);
		yield return WaitSkillFinish();
	}

	private IEnumerator P1Skill5Cast()
	{
		GotoCastSkill(Skill_FlowerAwaken);
		yield return WaitSkillFinish();
	}

	private IEnumerator P1Skill6Cast()
	{
		int num = ((!CheckTargetIsNear()) ? Skill_LaserShoot : Skill_ContiniousPeck);
		GotoCastSkill(num);
		TmpSkillP1 = num;
		yield return WaitSkillFinish();
	}

	private IEnumerator P1Skill7Cast()
	{
		GotoCastSkill(Skill_Dash);
		yield return WaitSkillFinish();
	}

	private IEnumerator P1Skill8Cast()
	{
		GotoCastSkill(Skill_FlyUp);
		yield return WaitSkillFinish();
	}

	private IEnumerator P1Skill9Cast()
	{
		int iD = ((TmpSkillP1 != Skill_ContiniousPeck) ? Skill_ContiniousPeck : Skill_LaserShoot);
		GotoCastSkill(iD);
		yield return WaitSkillFinish();
	}

	private IEnumerator P1Skill10Cast()
	{
		P1SequenceOver = true;
		GotoCastSkill(Skill_FlowerAwaken);
		yield return WaitSkillFinish();
	}

	private IEnumerator TransformCast()
	{
		if (!HasTransformSkillCasted)
		{
			GotoCastSkill(Skill_TransformTo2);
			HasTransformSkillCasted = true;
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator P2Skill1Cast()
	{
		GotoCastSkill(Skill_UltraBirdBomb);
		yield return WaitSkillFinish();
	}

	private IEnumerator P2Skill2Cast()
	{
		int num = ((!CheckTargetIsNear()) ? Skill_LaserShoot : Skill_ContiniousPeck);
		GotoCastSkillWithCheckFlowerAwaken(num);
		TmpSkillP23_1 = num;
		yield return WaitSkillFinish();
	}

	private IEnumerator P2Skill3Cast()
	{
		int num = ((!CheckTargetIsNear()) ? Skill_FlyUp : Skill_TailAttack);
		GotoCastSkillWithCheckFlowerAwaken(num);
		TmpSkillP23_2 = num;
		yield return WaitSkillFinish();
	}

	private IEnumerator P2Skill4Cast()
	{
		GotoCastSkillWithCheckFlowerAwaken(Skill_Dash);
		yield return WaitSkillFinish();
	}

	private IEnumerator P2Skill5Cast()
	{
		int iD = ((TmpSkillP23_1 != Skill_ContiniousPeck) ? Skill_ContiniousPeck : Skill_LaserShoot);
		GotoCastSkillWithCheckFlowerAwaken(iD);
		yield return WaitSkillFinish();
	}

	private IEnumerator P2Skill6Cast()
	{
		int iD = ((TmpSkillP23_2 != Skill_TailAttack) ? Skill_TailAttack : Skill_FlyUp);
		GotoCastSkillWithCheckFlowerAwaken(iD);
		yield return WaitSkillFinish();
	}

	private IEnumerator P2Skill7Cast()
	{
		if (!P2SequenceOver)
		{
			P2SequenceOver = true;
		}
		GotoCastSkill(Skill_LaserStrafe);
		yield return WaitSkillFinish();
	}

	private IEnumerator P2Initial()
	{
		TmpSkillP23_1 = 0;
		TmpSkillP23_2 = 0;
		AwakenTimesInP23 = 0;
		SetLogicTagFpValue(_actor, "BattleStage", 2);
		yield break;
	}

	private IEnumerator P3Initial()
	{
		TmpSkillP23_1 = 0;
		TmpSkillP23_2 = 0;
		AwakenTimesInP23 = 0;
		SetLogicTagFpValue(_actor, "BattleStage", 3);
		yield break;
	}
}
