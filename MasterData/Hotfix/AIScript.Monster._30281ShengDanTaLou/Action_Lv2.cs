using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30281ShengDanTaLou;

public class Action_Lv2 : MonsterActionBase
{
	private readonly int Skill_Attack01 = 3028101;

	private readonly int Skill_Attack02 = 3028102;

	private readonly int Skill_Attack03 = 3028103;

	private readonly int Skill_Attack04 = 3028104;

	private readonly int Skill_Attack05 = 3028105;

	private readonly int Skill_Attack06 = 3028106;

	private readonly int Skill_Attack07 = 3028107;

	private readonly int Skill_Attack08 = 3028108;

	private readonly int Skill_Attack09 = 3028109;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		List<BaseBranchInfo> list = new List<BaseBranchInfo>
		{
			new BaseBranchInfo(1, 15, 60, 3, null, Attack01),
			new BaseBranchInfo(2, 3, 60, 3, null, Attack02)
		};
		FP releaseDistance = 30;
		FP releaseAngle = 90;
		OperateDelegate operateIEnumerator = Attack03;
		list.Add(new BaseBranchInfo(3, releaseDistance, releaseAngle, default, null, operateIEnumerator));
		FP releaseDistance2 = 30;
		FP releaseAngle2 = 360;
		operateIEnumerator = Attack04;
		list.Add(new BaseBranchInfo(4, releaseDistance2, releaseAngle2, default, null, operateIEnumerator));
		FP releaseDistance3 = 30;
		FP releaseAngle3 = 360;
		operateIEnumerator = Attack05;
		list.Add(new BaseBranchInfo(5, releaseDistance3, releaseAngle3, default, null, operateIEnumerator));
		FP releaseDistance4 = 30;
		FP releaseAngle4 = 180;
		operateIEnumerator = Attack06;
		list.Add(new BaseBranchInfo(6, releaseDistance4, releaseAngle4, default, null, operateIEnumerator));
		FP releaseDistance5 = 30;
		FP releaseAngle5 = 360;
		operateIEnumerator = Attack07;
		list.Add(new BaseBranchInfo(7, releaseDistance5, releaseAngle5, default, null, operateIEnumerator));
		FP releaseDistance6 = 30;
		FP releaseAngle6 = 180;
		operateIEnumerator = Attack08;
		list.Add(new BaseBranchInfo(8, releaseDistance6, releaseAngle6, default, null, operateIEnumerator));
		FP releaseDistance7 = 30;
		FP releaseAngle7 = 360;
		operateIEnumerator = Attack09;
		list.Add(new BaseBranchInfo(9, releaseDistance7, releaseAngle7, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int>
		{
			3, 2, 4, 8, 1, 9, 6, 3, 4, 1,
			2, 7
		} };
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	private IEnumerator Attack01()
	{
		if (Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) < 5)
		{
			CastSkill(Skill_Attack01);
		}
		else
		{
			CastSkill(Skill_Attack03);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack02()
	{
		CastSkill(Skill_Attack02);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack03()
	{
		CastSkill(Skill_Attack03);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack04()
	{
		CastSkill(Skill_Attack04);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack05()
	{
		CastSkill(Skill_Attack05);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack06()
	{
		CastSkill(Skill_Attack06);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack07()
	{
		CastSkill(Skill_Attack07);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack08()
	{
		if (GetTargetByTeammateIndex(1).Count == 0)
		{
			CastSkill(Skill_Attack08);
			yield return WaitSkillFinish();
		}
		else
		{
			yield return null;
		}
	}

	private IEnumerator Attack09()
	{
		if (GetTargetByTeammateIndex(1).Count == 0)
		{
			CastSkill(Skill_Attack08);
			yield return WaitSkillFinish();
			yield return WaitTime(3);
			CastSkill(Skill_Attack09);
			yield return WaitSkillFinish();
		}
		else
		{
			CastSkill(Skill_Attack09);
			yield return WaitSkillFinish();
		}
	}
}
