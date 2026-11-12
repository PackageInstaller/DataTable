using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._10005JiaMianYeZhu;

public class Action_Sequence : MonsterActionBase
{
	private static readonly int Skill_Test = 0;

	private static readonly int Skill_Turn = 1000508;

	private static readonly int Skill_Impact = 1000501;

	private static readonly int Skill_StrikeFly = 1000503;

	private static readonly int Skill_Crush = 1000504;

	private static readonly int Skill_Dash_Common = 1000502;

	private static readonly int Skill_Dash_Plus = 1000512;

	private static readonly int Skill_ThousandDash_Common = 1000505;

	private static readonly int Skill_ThousandDash_Plus = 1000511;

	private static readonly int Skill_LighteningDash = 1000507;

	private static readonly int Skill_Angry = 1000506;

	private static readonly int Skill_CommonSummon = 1000514;

	private static readonly FP HpPercentage_Stage1To2 = 0.75;

	private static readonly FP HpPercentage_Stage2To3 = 0.4;

	private static readonly FP AngryBuffMaxTime_Stage2 = 15;

	private static readonly FP AngryBuffMaxTime_Stage3 = 9999;

	private static readonly int ContinuousDashTimesMax_Stage1 = 3;

	private static readonly int ContinuousDashTimesMax_Stage2 = 5;

	private static readonly int ContinuousDashTimesMax_Stage3 = 5;

	private static readonly int ContinuousImpactAndStrikeFlyTimesMax = 2;

	private static readonly int LighteningDashIntervalTimes = 6;

	private static readonly int CrushIntervalTimes = 4;

	private FP AngryBuffMaxTime;

	private FP AngryContinuousTime;

	private bool IsPhase2;

	private bool IsPhase3;

	private bool IsFirstSpAttack;

	private int NormalAttackIndex;

	private int ContinuousDashTimesCount;

	private int ImpactAndStrikeFlyTimesCount;

	private int LighteningDashSkillIndex;

	private int CrushSkillIndex;

	private int ImpactAndStrikeFlyIndex;

	private int BattleStage;

	private int ChosenSkillID;

	private int ContinuousDashTimesMax;

	private CoroutineNode CloseCameraAfterSecondsNode;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = NormalAttackCast;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = ThousandDashCast;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = SPAttackCast;
		list.Add(new BaseBranchInfo(2000, default, default, default, null, operateIEnumerator));
		operateIEnumerator = NormalAttackCast;
		list.Add(new BaseBranchInfo(2001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = ThousandDashCast;
		list.Add(new BaseBranchInfo(2002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = SPAttackCast;
		list.Add(new BaseBranchInfo(3000, default, default, default, null, operateIEnumerator));
		operateIEnumerator = SummonCast;
		list.Add(new BaseBranchInfo(3001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = ThousandDashCast;
		list.Add(new BaseBranchInfo(3002, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int> { 1001, 1002 },
			[2] = new List<int> { 2000, 2002, 2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001 },
			[3] = new List<int>
			{
				3000, 3002, 2001, 2001, 2001, 2001, 3001, 2001, 2001, 2001,
				2001
			}
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void OnActionEnable()
	{
		IsPhase2 = false;
		IsPhase3 = false;
		IsFirstSpAttack = false;
		NormalAttackIndex = 0;
		ImpactAndStrikeFlyIndex = 0;
		ContinuousDashTimesCount = 0;
		ImpactAndStrikeFlyTimesCount = 0;
		LighteningDashSkillIndex = -LighteningDashIntervalTimes;
		CrushSkillIndex = -CrushIntervalTimes;
		ChosenSkillID = 0;
		ContinuousDashTimesMax = ContinuousDashTimesMax_Stage1;
		BattleStage = 1;
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, InterruptAngry);
		InitListenEvent(MonsterEventType.SelfHpChanged, active: true, PhaseChange);
		InitListenEvent(MonsterEventType.SelfLostControl, active: true, CloseCamera);
	}

	private void GotoCastSkill(int ID)
	{
		if (Skill_Test != 0)
		{
			ID = Skill_Test;
		}
		CastSkill(ID);
	}

	private IEnumerator NormalAttackCast()
	{
		if (BattleStage != 1 && (BattleStage <= 1 || ContinuousDashTimesCount >= ContinuousDashTimesMax))
		{
			yield break;
		}
		if (GetBuffNum(_actor, 100050110) > 0 && GetDistanceWithTarget(calcDistanceWithoutEntityRadius: false) >= 5 && GetDistanceWithTarget(calcDistanceWithoutEntityRadius: false) <= 9 && NormalAttackIndex - LighteningDashSkillIndex >= LighteningDashIntervalTimes)
		{
			ChosenSkillID = Skill_LighteningDash;
		}
		else if (CheckTargetAtSide() && BattleStage > 1 && NormalAttackIndex - CrushSkillIndex >= CrushIntervalTimes)
		{
			ChosenSkillID = Skill_Crush;
		}
		else if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: false) <= 4 && ImpactAndStrikeFlyTimesCount < ContinuousImpactAndStrikeFlyTimesMax)
		{
			if (ImpactAndStrikeFlyIndex % 2 == 0)
			{
				ChosenSkillID = Skill_Impact;
			}
			else
			{
				ChosenSkillID = Skill_StrikeFly;
			}
		}
		else if (BattleStage == 3 && GetBuffNum(_actor, 100050110) > 0)
		{
			ChosenSkillID = Skill_Dash_Plus;
		}
		else
		{
			ChosenSkillID = Skill_Dash_Common;
		}
		if (ChosenSkillID == Skill_LighteningDash)
		{
			LighteningDashSkillIndex = NormalAttackIndex;
		}
		else if (ChosenSkillID == Skill_Crush)
		{
			CrushSkillIndex = NormalAttackIndex;
		}
		else if (ChosenSkillID == Skill_Impact || ChosenSkillID == Skill_StrikeFly)
		{
			ImpactAndStrikeFlyTimesCount++;
			ImpactAndStrikeFlyIndex++;
		}
		else if (ChosenSkillID == Skill_Dash_Common || ChosenSkillID == Skill_Dash_Plus)
		{
			ContinuousDashTimesCount++;
		}
		if (ChosenSkillID != Skill_Impact && ChosenSkillID != Skill_StrikeFly)
		{
			ImpactAndStrikeFlyTimesCount = 0;
		}
		NormalAttackIndex++;
		if (ChosenSkillID != Skill_Crush)
		{
			GotoCastSkill(Skill_Turn);
			yield return WaitSkillFinish();
		}
		GotoCastSkill(ChosenSkillID);
		yield return WaitSkillFinish();
		CheckAngry();
	}

	private IEnumerator SPAttackCast()
	{
		if (IsFirstSpAttack)
		{
			IsFirstSpAttack = false;
			BattleStage++;
			if (ChosenSkillID == Skill_ThousandDash_Common)
			{
				ChosenSkillID = Skill_Dash_Common;
				GotoCastSkill(Skill_Turn);
				yield return WaitSkillFinish();
				GotoCastSkill(ChosenSkillID);
				yield return WaitSkillFinish();
				CheckAngry();
			}
		}
		ContinuousDashTimesCount = 0;
	}

	private IEnumerator ThousandDashCast()
	{
		if (BattleStage == 1)
		{
			if (ContinuousDashTimesCount >= ContinuousDashTimesMax)
			{
				ContinuousDashTimesCount = 0;
				ChosenSkillID = Skill_ThousandDash_Common;
				GotoCastSkill(ChosenSkillID);
				yield return WaitSkillFinish();
				CheckAngry();
			}
		}
		else if (BattleStage == 2)
		{
			ChosenSkillID = Skill_ThousandDash_Common;
			GotoCastSkill(ChosenSkillID);
			yield return WaitSkillFinish();
			GotoCastSkill(Skill_Angry);
			yield return WaitSkillFinish();
		}
		else if (BattleStage == 3)
		{
			ChosenSkillID = Skill_ThousandDash_Plus;
			GotoCastSkill(ChosenSkillID);
			yield return WaitSkillFinish();
			StartCoroutine(ref CloseCameraAfterSecondsNode, CloseCameraAfterSeconds());
		}
	}

	private IEnumerator SummonCast()
	{
		GotoCastSkill(Skill_CommonSummon);
		yield return WaitSkillFinish();
	}

	private void PhaseChange(IEvent evt)
	{
		if (_actor.actorHealthInfo.hpPercentage <= HpPercentage_Stage1To2 && !IsPhase2)
		{
			SwitchSequence(2);
			IsPhase2 = true;
			IsFirstSpAttack = true;
			ContinuousDashTimesMax = ContinuousDashTimesMax_Stage2;
			AngryBuffMaxTime = AngryBuffMaxTime_Stage2;
		}
		else if (_actor.actorHealthInfo.hpPercentage <= HpPercentage_Stage2To3 && !IsPhase3)
		{
			SwitchSequence(3);
			IsPhase3 = true;
			IsFirstSpAttack = true;
			ContinuousDashTimesMax = ContinuousDashTimesMax_Stage3;
			AngryBuffMaxTime = AngryBuffMaxTime_Stage3;
		}
	}

	private void CheckAngry()
	{
		AngryContinuousTime = _actor.LogicTime - GetLogicTagFpValue(_actor, "AngryBuffStartTime");
		if (GetBuffNum(_actor, 100050110) > 0 && AngryContinuousTime > AngryBuffMaxTime)
		{
			RemoveBuffFromTarget(_actor, 100050110);
		}
	}

	private void InterruptAngry(IEvent evt)
	{
		RemoveBuffFromTarget(_actor, 100050110);
	}

	private bool CheckTargetAtSide()
	{
		TSVector2 position = GetPosition();
		FP width = 8;
		FP length = 2;
		FP rotation = GetRotation();
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width, length, default, default, default, rotation);
		return AreaCheckMonsterTarget(shapeData);
	}

	private IEnumerator CloseCameraAfterSeconds()
	{
		yield return WaitTime(7);
		SwitchCameraSetting(active: false, "Summon");
		SwitchCameraSetting(active: false, "Summon_Start");
		yield return WaitTime(6);
		SetLogicTagToggleValue(_actor, "ThousandDashing", value: true);
	}

	private void CloseCamera(IEvent evt)
	{
		if (BattleStage == 3)
		{
			StopCoroutine(CloseCameraAfterSecondsNode);
			SwitchCameraSetting(active: false, "Summon");
			SwitchCameraSetting(active: false, "Summon_Start");
		}
	}
}
