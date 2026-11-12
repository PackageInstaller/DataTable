using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50541ChuShi;

public class Action_Lv1 : MonsterActionBase
{
	private static readonly int Skill_SlashTwice = 5054101;

	private static readonly int Skill_Slash3Times = 5054102;

	private static readonly int Skill_DashSlash = 5054103;

	private static readonly int Skill_JumpSlash = 5054104;

	private static readonly int Skill_ThrowKnife = 5054105;

	private static readonly int Skill_UltraSkill_CallKnife = 5054107;

	private static readonly int Skill_Transform = 5054150;

	private static readonly int Skill_ToRandomPoint = 5054155;

	private static readonly int testSkillId = 0;

	private static readonly FP HpPercentStage2 = 0.6;

	private bool IsPhase2;

	private bool IsTransformed;

	private bool IsWander;

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
		operateIEnumerator = CastToRandomPoint;
		list.Add(new BaseBranchInfo(1009, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int> { 1001, 1005, 1003, 1009, 1001, 1005, 1004, 1009 },
			[2] = new List<int> { 1007, 1006, 1009, 1002, 1005, 1004, 1009, 1002, 1003 }
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfHpChanged, active: true, PhaseChange);
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, ToughnessBroken);
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

	private void ToughnessBroken(IEvent evt)
	{
		IsWander = false;
	}

	protected override void OnActionEnable()
	{
		IsPhase2 = false;
		IsTransformed = false;
		IsWander = true;
		SetLogicTagFpValue(_actor, "Difficulty", 1);
		SetLogicTagFpValue(_actor, "actionPhase", 1);
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

	private IEnumerator CastToRandomPoint()
	{
		if (IsWander)
		{
			GotoCastSkill(Skill_ToRandomPoint);
			yield return WaitSkillFinish();
		}
		else
		{
			IsWander = true;
		}
	}
}
