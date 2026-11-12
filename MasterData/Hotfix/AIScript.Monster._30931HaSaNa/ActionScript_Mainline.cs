using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._30931HaSaNa;

public class ActionScript_Mainline : MonsterActionBase
{
	private readonly int skillId_Test;

	private readonly int Ini_Seq = 1;

	private readonly int skillId_HorizontalSlash = 3093101;

	private readonly int skillId_RushAttack = 3093102;

	private readonly int skillId_Burrow = 3093103;

	private readonly int skillId_DustSpraying = 3093105;

	private readonly int skillId_BeginTransform_Transform = 3093108;

	private readonly int skillId_HammerDoubleAttack_Transform = 3093126;

	private readonly int skillId_MeleeAttack_Transform = 3093109;

	private readonly int skillId_Hammering_Transform = 3093110;

	private readonly int skillId_DustSpraying_Transform = 3093127;

	private readonly int skillId_DustExplosion_Transform = 3093128;

	private readonly int skillId_TransformBack_Transform = 3093119;

	private readonly int skillId_Alert = 3093113;

	private int CurSequence;

	private bool isStop;

	private bool isBB5;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = Operate_Skill_HorizontalSlash;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Skill_RushAttack;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Alert;
		list.Add(new BaseBranchInfo(1003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Skill_Burrow;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Skill_DustSpraying;
		list.Add(new BaseBranchInfo(1005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Transform;
		list.Add(new BaseBranchInfo(3001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_MeleeAttack_Transform;
		list.Add(new BaseBranchInfo(3002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_DustSpraying_Transform;
		list.Add(new BaseBranchInfo(3003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Hammering_Transform;
		list.Add(new BaseBranchInfo(3004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_HammerDoubleAttack_Transform;
		list.Add(new BaseBranchInfo(3005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_DustExplosion_Transform;
		list.Add(new BaseBranchInfo(3006, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_TransformBack;
		list.Add(new BaseBranchInfo(3007, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Test;
		list.Add(new BaseBranchInfo(9999, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_TestJuRen;
		list.Add(new BaseBranchInfo(9997, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int> { 1001, 1002, 1003, 1004, 1005 },
			[2] = new List<int> { 3001, 3002, 3003, 3004, 3005, 3006, 3007 },
			[94] = new List<int> { 9999 },
			[96] = new List<int> { 9997 }
		};
		InitSequenceBranches(Ini_Seq, sequenceBranches, sequenceDict);
	}

	protected override void OnActionEnable()
	{
		SetLogicTagToggleValue(_actor, "IsMainline", value: true);
		isBB5 = false;
	}

	protected override void OnActionStart()
	{
		base.OnActionStart();
		isStop = false;
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, OnToughnessBroken);
	}

	private void OnToughnessBroken(IEvent evt)
	{
		if (!isBB5)
		{
			TriggerOpLisener("BB5");
			isBB5 = true;
		}
	}

	protected override void OnActionStop()
	{
		base.OnActionStop();
		isStop = true;
	}

	protected override void OnSequenceBranchOperateComplete(int curSeqIndex, int curBranchIndex, bool isSeqEnd)
	{
		if (isSeqEnd)
		{
			switch (curSeqIndex)
			{
			case 1:
				SetLockToughnessEnable(autoDisableWhenSkillDisable: false);
				CurSequence = 2;
				SwitchSequence(CurSequence);
				break;
			case 2:
				CurSequence = 1;
				SwitchSequence(CurSequence);
				break;
			case 96:
				SwitchSequence(94);
				break;
			}
		}
	}

	private IEnumerator Operate_Test()
	{
		CastSkill(skillId_Test);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_TestJuRen()
	{
		CastSkill(skillId_BeginTransform_Transform);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_Alert()
	{
		CastSkill(skillId_Alert);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_Skill_HorizontalSlash()
	{
		TriggerOpLisener("BB2");
		CastSkill(skillId_HorizontalSlash);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_Skill_RushAttack()
	{
		CastSkill(skillId_RushAttack);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_Skill_Burrow()
	{
		CastSkill(skillId_Burrow);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_Skill_DustSpraying()
	{
		CastSkill(skillId_DustSpraying);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_Transform()
	{
		CastSkill(skillId_BeginTransform_Transform);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_HammerDoubleAttack_Transform()
	{
		CastSkill(skillId_HammerDoubleAttack_Transform);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_MeleeAttack_Transform()
	{
		CastSkill(skillId_MeleeAttack_Transform);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_DustSpraying_Transform()
	{
		CastSkill(skillId_DustSpraying_Transform);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_Hammering_Transform()
	{
		CastSkill(skillId_Hammering_Transform);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_DustExplosion_Transform()
	{
		CastSkill(skillId_DustExplosion_Transform);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_TransformBack()
	{
		CastSkill(skillId_TransformBack_Transform);
		yield return WaitSkillFinish();
	}
}
