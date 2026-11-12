#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50541ChuShi;

public class Action_BossRush : MonsterActionBase
{
	private static readonly int Skill_Test = 0;

	private static readonly int Skill_SlashTwice = 5054101;

	private static readonly int Skill_Slash3Times = 5054102;

	private static readonly int Skill_ThrowKnife_Straight = 5054113;

	private static readonly int Skill_ThrowKnife_Parabola = 5054110;

	private static readonly int Skill_DashSlash = 5054111;

	private static readonly int Skill_JumpSlash = 5054112;

	private static readonly int Skill_CallKnife = 5054109;

	private static readonly int Skill_UltraSkill_Lv2 = 5054106;

	private static readonly int Skill_UltraSkill_Lv3 = 5054108;

	private static readonly int Skill_TransformTo2 = 5054150;

	private static readonly int Skill_TransformTo3 = 5054154;

	private static readonly int Stage2RequireLevel = 15;

	private static readonly int Stage3RequireLevel = 25;

	private static readonly int DistanceBoundary = 4;

	private static readonly int KnifeAmountCondition = 10;

	private int Skill_UltraSkill;

	private int Skill_NormalAttack;

	private int Skill_SkillAttack;

	private int BattleStage;

	private bool IsStage2;

	private bool IsStage3;

	private bool IsFirstSkill;

	private bool HasTransformed;

	private int ContinuiousSkillCount;

	private int NormalAttackIDTmp;

	private int FarNormalAttackIDTmp;

	private bool NormalAttackGuarantee;

	private int NearNormalAttackCount;

	private int SkillAttackIDTmp;

	private bool ReadyToCallBackKnife;

	private CoroutineNode CallBackKnifeNode;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		FP releaseDistance = 10;
		FP releaseAngle = 30;
		OperateDelegate operateIEnumerator = NormalAttackCast1;
		list.Add(new BaseBranchInfo(1001, releaseDistance, releaseAngle, default, null, operateIEnumerator));
		FP releaseDistance2 = 10;
		FP releaseAngle2 = 30;
		operateIEnumerator = NormalAttackCast2;
		list.Add(new BaseBranchInfo(1011, releaseDistance2, releaseAngle2, default, null, operateIEnumerator));
		FP releaseDistance3 = 12;
		FP releaseAngle3 = 30;
		operateIEnumerator = SkillAttackCast1;
		list.Add(new BaseBranchInfo(1002, releaseDistance3, releaseAngle3, default, null, operateIEnumerator));
		FP releaseDistance4 = 12;
		FP releaseAngle4 = 30;
		operateIEnumerator = SkillAttackCast2;
		list.Add(new BaseBranchInfo(1012, releaseDistance4, releaseAngle4, default, null, operateIEnumerator));
		operateIEnumerator = UltraSkillCast;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = TransformCast;
		list.Add(new BaseBranchInfo(1005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = TransformCast;
		list.Add(new BaseBranchInfo(1015, default, default, default, null, operateIEnumerator));
		operateIEnumerator = InitialCastP1;
		list.Add(new BaseBranchInfo(1090, default, default, default, null, operateIEnumerator));
		operateIEnumerator = InitialCastP2;
		list.Add(new BaseBranchInfo(1091, default, default, default, null, operateIEnumerator));
		operateIEnumerator = InitialCastP3;
		list.Add(new BaseBranchInfo(1092, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int> { 1090, 1001, 1001, 1002, 1001, 1011, 1012 },
			[2] = new List<int> { 1091, 1005, 1004, 1001, 1001, 1002, 1011, 1012 },
			[3] = new List<int> { 1092, 1015, 1004, 1001, 1002, 1001, 1002 }
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void OnActionEnable()
	{
		BattleStage = 1;
		IsStage2 = false;
		IsStage3 = false;
		IsFirstSkill = true;
		HasTransformed = false;
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		SetLogicTagToggleValue(_actor, "IsBossRush", value: true);
		FarNormalAttackIDTmp = Skill_ThrowKnife_Straight;
		ReadyToCallBackKnife = false;
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfLostControl, active: true, StopCallBackKnife);
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

	private IEnumerator InitialCastP1()
	{
		NormalAttackIDTmp = 0;
		SkillAttackIDTmp = 0;
		NearNormalAttackCount = 0;
		NormalAttackGuarantee = true;
		yield break;
	}

	private IEnumerator InitialCastP2()
	{
		if (!IsStage2)
		{
			BattleStage = 2;
			SetLogicTagFpValue(_actor, "BattleStage", 2);
			IsStage2 = true;
		}
		NormalAttackIDTmp = 0;
		SkillAttackIDTmp = 0;
		NearNormalAttackCount = 0;
		NormalAttackGuarantee = true;
		SetLogicTagToggleValue(_actor, "TmpUpgrade", value: false);
		yield break;
	}

	private IEnumerator InitialCastP3()
	{
		if (!IsStage3)
		{
			BattleStage = 3;
			SetLogicTagFpValue(_actor, "BattleStage", 3);
			IsStage3 = true;
			HasTransformed = false;
		}
		NormalAttackIDTmp = 0;
		SkillAttackIDTmp = 0;
		NearNormalAttackCount = 0;
		NormalAttackGuarantee = true;
		SetLogicTagToggleValue(_actor, "TmpUpgrade", value: false);
		yield break;
	}

	private IEnumerator NormalAttackCast1()
	{
		if (BattleStage == 1)
		{
			if (CheckDistanceToTarget() && !IsFirstSkill)
			{
				Skill_NormalAttack = Skill_ThrowKnife_Parabola;
			}
			else
			{
				Skill_NormalAttack = Skill_SlashTwice;
				NearNormalAttackCount++;
			}
			if (IsFirstSkill)
			{
				IsFirstSkill = false;
			}
		}
		else if (BattleStage == 2)
		{
			if (CheckDistanceToTarget())
			{
				Skill_NormalAttack = Skill_ThrowKnife_Straight;
			}
			else
			{
				Skill_NormalAttack = Skill_SlashTwice;
				NearNormalAttackCount++;
			}
		}
		else if (CheckDistanceToTarget())
		{
			Skill_NormalAttack = ((FarNormalAttackIDTmp == Skill_ThrowKnife_Straight) ? Skill_ThrowKnife_Parabola : Skill_ThrowKnife_Straight);
			FarNormalAttackIDTmp = Skill_NormalAttack;
		}
		else
		{
			Skill_NormalAttack = Skill_Slash3Times;
		}
		if (NormalAttackIDTmp != Skill_NormalAttack && NormalAttackIDTmp != 0)
		{
			NormalAttackGuarantee = false;
		}
		NormalAttackIDTmp = Skill_NormalAttack;
		GotoCastSkill(Skill_NormalAttack);
		yield return WaitSkillFinish();
		CallBackKnifeNode = StartCor(GotoCallBackKnife());
		yield return CallBackKnifeNode;
	}

	private IEnumerator NormalAttackCast2()
	{
		if (BattleStage == 1)
		{
			if (NormalAttackGuarantee)
			{
				Skill_NormalAttack = ((NormalAttackIDTmp == Skill_ThrowKnife_Parabola) ? Skill_SlashTwice : Skill_ThrowKnife_Parabola);
			}
			else
			{
				Skill_NormalAttack = (CheckDistanceToTarget() ? Skill_ThrowKnife_Parabola : Skill_SlashTwice);
			}
		}
		else if (BattleStage == 2)
		{
			if (NormalAttackGuarantee)
			{
				if (NormalAttackIDTmp == Skill_SlashTwice)
				{
					Skill_NormalAttack = Skill_ThrowKnife_Straight;
					SetLogicTagToggleValue(_actor, "TmpUpgrade", value: true);
				}
				else
				{
					Skill_NormalAttack = Skill_Slash3Times;
				}
			}
			else
			{
				Skill_NormalAttack = (CheckDistanceToTarget() ? Skill_ThrowKnife_Straight : Skill_SlashTwice);
			}
		}
		GotoCastSkill(Skill_NormalAttack);
		yield return WaitSkillFinish();
		CallBackKnifeNode = StartCor(GotoCallBackKnife());
		yield return CallBackKnifeNode;
	}

	private IEnumerator SkillAttackCast1()
	{
		if (BattleStage == 1 || BattleStage == 2)
		{
			if (NearNormalAttackCount == 2)
			{
				Skill_SkillAttack = Skill_DashSlash;
			}
			else
			{
				Skill_SkillAttack = Skill_JumpSlash;
			}
		}
		else if (NormalAttackIDTmp == Skill_Slash3Times)
		{
			Skill_SkillAttack = Skill_DashSlash;
		}
		else
		{
			Skill_SkillAttack = Skill_JumpSlash;
		}
		SkillAttackIDTmp = Skill_SkillAttack;
		GotoCastSkill(Skill_SkillAttack);
		yield return WaitSkillFinish();
		CallBackKnifeNode = StartCor(GotoCallBackKnife());
		yield return CallBackKnifeNode;
	}

	private IEnumerator SkillAttackCast2()
	{
		Skill_SkillAttack = ((SkillAttackIDTmp == Skill_DashSlash) ? Skill_JumpSlash : Skill_DashSlash);
		GotoCastSkill(Skill_SkillAttack);
		yield return WaitSkillFinish();
		CallBackKnifeNode = StartCor(GotoCallBackKnife());
		yield return CallBackKnifeNode;
	}

	private IEnumerator UltraSkillCast()
	{
		if (BattleStage == 2)
		{
			Skill_UltraSkill = Skill_UltraSkill_Lv2;
		}
		else
		{
			Skill_UltraSkill = Skill_UltraSkill_Lv3;
		}
		GotoCastSkill(Skill_UltraSkill);
		yield return WaitSkillFinish();
	}

	private IEnumerator TransformCast()
	{
		if (!HasTransformed)
		{
			if (BattleStage == 2)
			{
				GotoCastSkill(Skill_TransformTo2);
			}
			else
			{
				GotoCastSkill(Skill_TransformTo3);
			}
			HasTransformed = true;
			yield return WaitSkillFinish();
		}
		else
		{
			yield return null;
		}
	}

	private void LevelUp(IEvent evt)
	{
		int newLevel = (evt as AdventureMonsterBattleLevelChangedEvent).newLevel;
		if (newLevel == Stage2RequireLevel)
		{
			SwitchSequence(2);
		}
		else if (newLevel >= Stage3RequireLevel && IsStage2 && !IsStage3)
		{
			SwitchSequence(3);
			HasTransformed = false;
		}
	}

	private bool CheckDistanceToTarget()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: false) >= DistanceBoundary)
		{
			return true;
		}
		return false;
	}

	private bool CheckCallbackKnife()
	{
		int count = GetTargetByTeammateIndexes(new List<int> { 1, 2, 4, 5 }).Count;
		if (count >= KnifeAmountCondition)
		{
			return true;
		}
		if (ContinuiousSkillCount >= 6 && count >= 2 && BattleStage < 3)
		{
			return true;
		}
		return false;
	}

	private IEnumerator GotoCallBackKnife()
	{
		if (CheckCallbackKnife())
		{
			if (!ReadyToCallBackKnife)
			{
				ReadyToCallBackKnife = true;
				ContinuiousSkillCount++;
				yield return null;
			}
			else
			{
				GotoCastSkill(Skill_CallKnife);
				ReadyToCallBackKnife = false;
				ContinuiousSkillCount = 0;
				yield return WaitSkillFinish();
			}
		}
		else
		{
			ReadyToCallBackKnife = false;
			ContinuiousSkillCount++;
			yield return null;
		}
	}

	private void StopCallBackKnife(IEvent evt)
	{
		StopCor(CallBackKnifeNode);
	}

	private IEnumerator StageTimeCount()
	{
		yield return WaitTime(45);
		SwitchSequence(2);
		yield return WaitTime(75);
		SwitchSequence(3);
		yield return WaitTime(60);
		NovaLogger.Debug("3分钟到了");
	}
}
