using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Action_Lv1 : MonsterActionBase
{
	private static readonly int Skill_Dash = 1551001;

	private static readonly int Skill_FlyUp = 1551002;

	private static readonly int Skill_ContiniousPeck = 1551003;

	private static readonly int Skill_TailAttack = 1551008;

	private static readonly int Skill_LaserShoot = 1551005;

	private static readonly int Skill_LaserStrafe = 1551006;

	private static readonly int Skill_FlowerAwaken = 1551004;

	private static readonly int Skill_UltraBirdBomb = 1551007;

	private static readonly int Skill_TransformTo2 = 1551093;

	private static readonly FP HpPercentStage2 = 0.7;

	private static readonly FP FarSkillOutRadius = 7;

	private static readonly int testSkillId = 0;

	private int[] WeightInSkill;

	private int TmpSmallSkillID;

	private bool CheckSameSmallSkill;

	private int RandomSkillIndex;

	private FP BaseSummonProbability;

	private int Phase2Skill1Count;

	private bool IsPhase2;

	private bool HasPhaseChanged;

	private bool FirstTimeInitial;

	private List<LogicEntity> FlowerList;

	protected override void SetConfig()
	{
		FlowerList = new List<LogicEntity>();
		_monsterAIType = MonsterAIType.SEQUENCE;
		TmpSmallSkillID = 0;
		BaseSummonProbability = 0;
		Phase2Skill1Count = 0;
		CheckSameSmallSkill = false;
		IsPhase2 = false;
		HasPhaseChanged = false;
		FirstTimeInitial = true;
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		SetLogicTagToggleValue(_actor, "FastRecoverFlower", value: false);
		SetLogicTagToggleValue(_actor, "FlowerAwakening", value: false);
		SetLogicTagToggleValue(_actor, "UltraSkilling", value: false);
		SetLogicTagToggleValue(_actor, "InFlowerAwakenSkill", value: false);
		SetLogicTagFpValue(_actor, "LightDistance", 6.5);
		SetLogicTagFpValue(_actor, "Difficulty", 1);
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = Phase1Initial;
		list.Add(new BaseBranchInfo(1000, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Phase1Skill1Cast;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Phase1Skill2Cast;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Phase1Skill3Cast;
		list.Add(new BaseBranchInfo(1003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Phase1Skill4Cast;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Phase1Skill5Cast;
		list.Add(new BaseBranchInfo(1005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = RandomSkillP1;
		list.Add(new BaseBranchInfo(1006, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Phase2Initial;
		list.Add(new BaseBranchInfo(2000, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Phase2Skill1Cast;
		list.Add(new BaseBranchInfo(2001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Phase2Skill2Cast;
		list.Add(new BaseBranchInfo(2002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Phase2Skill3Cast;
		list.Add(new BaseBranchInfo(2003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Phase2Skill4Cast;
		list.Add(new BaseBranchInfo(2004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Phase2Skill5Cast;
		list.Add(new BaseBranchInfo(2005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Phase2Skill6Cast;
		list.Add(new BaseBranchInfo(2006, default, default, default, null, operateIEnumerator));
		operateIEnumerator = TestCast;
		list.Add(new BaseBranchInfo(9999, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int> { 1000, 1001, 1002, 1003, 1004, 1005 },
			[2] = new List<int> { 2000, 2001, 2002, 2003, 2004, 2005, 2006 },
			[3] = new List<int> { 9999 }
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfHpChanged, active: true, PhaseChange);
		InitListenEvent(MonsterEventType.SelfLostControl, active: true, LostControlKillBirds);
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		CastSkill(ID);
	}

	private IEnumerator Phase1Initial()
	{
		if (FirstTimeInitial)
		{
			StartCoroutine(CheckBuffAndSetLightDistance());
			FirstTimeInitial = false;
		}
		WeightInSkill = new int[3] { 1702064961, 1398567796, 1214210930 };
		switch (randomWeight(WeightInSkill))
		{
		case 0:
			RandomSkillIndex = 2;
			break;
		case 1:
			RandomSkillIndex = 4;
			break;
		case 2:
			RandomSkillIndex = 99;
			break;
		}
		yield break;
	}

	private IEnumerator Phase1Skill1Cast()
	{
		WeightInSkill = new int[2] { 2, 1 };
		if (CheckTargetIsNear())
		{
			WeightInSkill[0]++;
		}
		else
		{
			WeightInSkill[1]++;
		}
		if (CheckSameSmallSkill)
		{
			if (TmpSmallSkillID == Skill_ContiniousPeck)
			{
				WeightInSkill[0] = 0;
			}
			else
			{
				WeightInSkill[1] = 0;
			}
			CheckSameSmallSkill = false;
		}
		switch (randomWeight(WeightInSkill))
		{
		case 0:
			GotoCastSkill(Skill_ContiniousPeck);
			TmpSmallSkillID = Skill_ContiniousPeck;
			break;
		case 1:
			GotoCastSkill(Skill_LaserShoot);
			TmpSmallSkillID = Skill_LaserShoot;
			break;
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator Phase1Skill2Cast()
	{
		if (RandomSkillIndex != 2)
		{
			WeightInSkill = new int[2] { 1, 0 };
			switch (randomWeight(WeightInSkill))
			{
			case 0:
				GotoCastSkill(Skill_FlyUp);
				break;
			case 1:
				GotoCastSkill(Skill_Dash);
				break;
			}
			yield return WaitSkillFinish();
		}
		else
		{
			yield return StartCoroutine(RandomSkillP1());
			if (!IsPhase2)
			{
				SetCurrentSequenceIndex(2);
			}
			RandomSkillIndex = 99;
		}
	}

	private IEnumerator Phase1Skill3Cast()
	{
		WeightInSkill = new int[2] { 0, 1 };
		switch (randomWeight(WeightInSkill))
		{
		case 0:
			GotoCastSkill(Skill_FlyUp);
			break;
		case 1:
			GotoCastSkill(Skill_Dash);
			break;
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator Phase1Skill4Cast()
	{
		if (RandomSkillIndex != 4)
		{
			WeightInSkill = new int[2] { 1, 1 };
			if (CheckTargetIsNear())
			{
				WeightInSkill[1] += 2;
			}
			else
			{
				WeightInSkill[1] = 0;
			}
			switch (randomWeight(WeightInSkill))
			{
			case 0:
				GotoCastSkill(Skill_LaserStrafe);
				break;
			case 1:
				GotoCastSkill(Skill_TailAttack);
				break;
			}
			yield return WaitSkillFinish();
		}
		else
		{
			yield return StartCoroutine(RandomSkillP1());
			if (!IsPhase2)
			{
				SetCurrentSequenceIndex(4);
			}
			RandomSkillIndex = 99;
		}
	}

	private IEnumerator Phase1Skill5Cast()
	{
		if (CheckFlowerAwaken())
		{
			GotoCastSkill(Skill_FlowerAwaken);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Phase2Initial()
	{
		TmpSmallSkillID = 0;
		BaseSummonProbability = 0;
		if (!HasPhaseChanged)
		{
			GotoCastSkill(Skill_TransformTo2);
			SetLogicTagFpValue(_actor, "BattleStage", 2);
			yield return WaitSkillFinish();
			HasPhaseChanged = true;
		}
	}

	private IEnumerator Phase2Skill1Cast()
	{
		if (Phase2Skill1Count % 2 == 0)
		{
			GotoCastSkill(Skill_UltraBirdBomb);
			yield return WaitSkillFinish();
		}
		Phase2Skill1Count++;
	}

	private IEnumerator Phase2Skill2Cast()
	{
		WeightInSkill = new int[2] { 1, 1 };
		if (CheckTargetIsNear())
		{
			WeightInSkill[0]++;
		}
		else
		{
			WeightInSkill[1]++;
		}
		switch (randomWeight(WeightInSkill))
		{
		case 0:
			GotoCastSkill(Skill_ContiniousPeck);
			TmpSmallSkillID = Skill_ContiniousPeck;
			break;
		case 1:
			GotoCastSkill(Skill_LaserShoot);
			TmpSmallSkillID = Skill_LaserShoot;
			break;
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator Phase2Skill3Cast()
	{
		if (!CheckFlowerAwaken())
		{
			WeightInSkill = new int[2] { 1, 1 };
			switch (randomWeight(WeightInSkill))
			{
			case 0:
				GotoCastSkill(Skill_FlyUp);
				break;
			case 1:
				GotoCastSkill(Skill_Dash);
				break;
			}
			BaseSummonProbability += (FP)20;
			yield return WaitSkillFinish();
		}
		else
		{
			GotoCastSkill(Skill_FlowerAwaken);
			BaseSummonProbability = -999;
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Phase2Skill4Cast()
	{
		if (!CheckFlowerAwaken())
		{
			if (TmpSmallSkillID == Skill_ContiniousPeck)
			{
				GotoCastSkill(Skill_LaserShoot);
			}
			else
			{
				WeightInSkill = new int[2] { 1, 1 };
				if (CheckTargetIsNear())
				{
					WeightInSkill[0]++;
				}
				else
				{
					WeightInSkill[1]++;
				}
				switch (randomWeight(WeightInSkill))
				{
				case 0:
					GotoCastSkill(Skill_ContiniousPeck);
					break;
				case 1:
					GotoCastSkill(Skill_LaserShoot);
					break;
				}
			}
			BaseSummonProbability += (FP)20;
			yield return WaitSkillFinish();
		}
		else
		{
			GotoCastSkill(Skill_FlowerAwaken);
			BaseSummonProbability = -999;
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Phase2Skill5Cast()
	{
		if (!CheckFlowerAwaken())
		{
			WeightInSkill = new int[2] { 1, 1 };
			if (CheckTargetIsNear())
			{
				WeightInSkill[1]++;
			}
			else
			{
				WeightInSkill[1] = 0;
			}
			switch (randomWeight(WeightInSkill))
			{
			case 0:
				GotoCastSkill(Skill_LaserStrafe);
				break;
			case 1:
				GotoCastSkill(Skill_TailAttack);
				break;
			}
			BaseSummonProbability += (FP)20;
			yield return WaitSkillFinish();
		}
		else
		{
			GotoCastSkill(Skill_FlowerAwaken);
			BaseSummonProbability = -999;
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Phase2Skill6Cast()
	{
		if (BaseSummonProbability <= 0)
		{
			WeightInSkill = new int[2] { 1, 1 };
			switch (randomWeight(WeightInSkill))
			{
			case 0:
				GotoCastSkill(Skill_FlyUp);
				break;
			case 1:
				GotoCastSkill(Skill_Dash);
				break;
			}
			yield return WaitSkillFinish();
		}
		else if (CheckFlowerAwaken())
		{
			GotoCastSkill(Skill_FlowerAwaken);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator RandomSkillP1()
	{
		if (TmpSmallSkillID == Skill_ContiniousPeck)
		{
			GotoCastSkill(Skill_LaserShoot);
		}
		else
		{
			GotoCastSkill(Skill_ContiniousPeck);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator TestCast()
	{
		if (FirstTimeInitial)
		{
			StartCoroutine(CheckBuffAndSetLightDistance());
			FirstTimeInitial = false;
		}
		GotoCastSkill(testSkillId);
		yield return WaitSkillFinish();
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
		FP fP = 0;
		switch (count)
		{
		case 0:
		case 1:
			fP = BaseSummonProbability + 100;
			break;
		case 2:
			fP = BaseSummonProbability + 80;
			break;
		case 3:
			fP = BaseSummonProbability + 50;
			break;
		case 4:
			fP = BaseSummonProbability + 10;
			break;
		case 5:
		case 6:
			fP = BaseSummonProbability;
			break;
		}
		if (GetRandomValue(1, 100) > 100 - fP)
		{
			return true;
		}
		return false;
	}

	private void PhaseChange(IEvent evt)
	{
		if (_actor.actorHealthInfo.hpPercentage <= HpPercentStage2 && !IsPhase2)
		{
			IsPhase2 = true;
			SwitchSequence(2);
		}
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
}
