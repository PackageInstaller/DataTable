using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50541ChuShi;

public class Action_Lv3 : MonsterActionBase
{
	private static readonly int Skill_SlashTwice = 5054101;

	private static readonly int Skill_Slash3Times = 5054102;

	private static readonly int Skill_DashSlash = 5054103;

	private static readonly int Skill_JumpSlash = 5054104;

	private static readonly int Skill_ThrowKnife = 5054105;

	private static readonly int Skill_UltraSkill_CallKnife = 5054108;

	private static readonly int Skill_Transform = 5054150;

	private static readonly int Skill_CallKnife = 5054109;

	private static readonly int testSkillId = 0;

	private static readonly FP HpPercentStage2 = 0.7;

	private bool IsPhase2;

	private bool IsTransformed;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		FP releaseDistance = 8;
		FP releaseAngle = 30;
		OperateDelegate operateIEnumerator = CastSlashTwice;
		list.Add(new BaseBranchInfo(1001, releaseDistance, releaseAngle, default, null, operateIEnumerator));
		FP releaseAngle2 = 8;
		FP traceDuration = 30;
		operateIEnumerator = CastSlash3Times;
		list.Add(new BaseBranchInfo(1002, default, releaseAngle2, traceDuration, null, operateIEnumerator));
		FP releaseDistance2 = 12;
		FP releaseAngle3 = 30;
		operateIEnumerator = CastDashSlash;
		list.Add(new BaseBranchInfo(1003, releaseDistance2, releaseAngle3, default, null, operateIEnumerator));
		operateIEnumerator = CastJumpSlash;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		FP releaseDistance3 = 12;
		FP releaseAngle4 = 30;
		operateIEnumerator = CastThrowKnife;
		list.Add(new BaseBranchInfo(1005, releaseDistance3, releaseAngle4, default, null, operateIEnumerator));
		operateIEnumerator = CastUltraSkill;
		list.Add(new BaseBranchInfo(1006, default, default, default, null, operateIEnumerator));
		operateIEnumerator = CastTransform;
		list.Add(new BaseBranchInfo(1007, default, default, default, null, operateIEnumerator));
		traceDuration = 30;
		operateIEnumerator = CastCallKnife;
		list.Add(new BaseBranchInfo(1008, default, traceDuration, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int> { 1001, 1005, 1003, 1008, 1001, 1005, 1004 },
			[2] = new List<int> { 1007, 1006, 1002, 1005, 1004, 1008, 1002, 1003 }
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfHpChanged, active: true, PhaseChange);
	}

	private void PhaseChange(IEvent evt)
	{
		if (_actor.actorHealthInfo.hpPercentage <= HpPercentStage2 && !IsPhase2)
		{
			SetLogicTagFpValue(_actor, "actionPhase", 2);
			SwitchSequence(2);
			IsPhase2 = true;
		}
	}

	protected override void OnActionEnable()
	{
		IsPhase2 = false;
		IsTransformed = false;
		SetLogicTagFpValue(_actor, "actionPhase", 1);
		SetLogicTagFpValue(_actor, "Difficulty", 3);
		SummonTeammate(3, GetPlaceHolderPosition("CommonSummonPoint1"), TSVector2.down, 4);
		SummonTeammate(3, GetPlaceHolderPosition("CommonSummonPoint2"), TSVector2.down, 4);
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		CastSkill(ID);
	}

	private IEnumerator CastSlashTwice()
	{
		GotoCastSkill(Skill_SlashTwice);
		yield return WaitSkillFinish();
	}

	private IEnumerator CastSlash3Times()
	{
		GotoCastSkill(Skill_Slash3Times);
		yield return WaitSkillFinish();
	}

	private IEnumerator CastDashSlash()
	{
		GotoCastSkill(Skill_DashSlash);
		yield return WaitSkillFinish();
	}

	private IEnumerator CastJumpSlash()
	{
		GotoCastSkill(Skill_JumpSlash);
		yield return WaitSkillFinish();
	}

	private IEnumerator CastThrowKnife()
	{
		GotoCastSkill(Skill_ThrowKnife);
		yield return WaitSkillFinish();
	}

	private IEnumerator CastUltraSkill()
	{
		GotoCastSkill(Skill_UltraSkill_CallKnife);
		yield return WaitSkillFinish();
		SummonTeammate(3, GetPlaceHolderPosition("CommonSummonPoint1"), TSVector2.down, 4);
		SummonTeammate(3, GetPlaceHolderPosition("CommonSummonPoint2"), TSVector2.down, 4);
	}

	private IEnumerator CastTransform()
	{
		if (!IsTransformed)
		{
			IsTransformed = true;
			GotoCastSkill(Skill_Transform);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator CastCallKnife()
	{
		if (GetTargetByTeammateIndexes(new List<int> { 1, 2 }).Count != 0)
		{
			GotoCastSkill(Skill_CallKnife);
			yield return WaitSkillFinish();
		}
	}
}
