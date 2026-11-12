using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._11031FaMuXie;

public class Action_Lv2 : MonsterActionBase
{
	private static readonly int Skill_Attack01 = 1103101;

	private static readonly int Skill_Attack02 = 1103102;

	private static readonly int Skill_Attack03 = 1103103;

	private static readonly int Skill_Attack04 = 1103104;

	private static readonly int Skill_Attack05 = 1103105;

	private static readonly int Skill_Attack06 = 1103106;

	private static readonly int Skill_Attack07 = 1103107;

	private static readonly int Skill_Linger = 1103108;

	private List<long> WeaponIds = new List<long>();

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		SetLogicTagFpValue(_actor, "FaMuXieRebound", 0);
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, InterruptStrong);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		FP releaseDistance = 30;
		FP releaseAngle = 360;
		OperateDelegate operateIEnumerator = Attack01;
		list.Add(new BaseBranchInfo(1001, releaseDistance, releaseAngle, default, null, operateIEnumerator));
		FP releaseDistance2 = 5;
		FP releaseAngle2 = 40;
		operateIEnumerator = Attack02;
		list.Add(new BaseBranchInfo(1002, releaseDistance2, releaseAngle2, default, null, operateIEnumerator));
		FP releaseDistance3 = 6;
		FP releaseAngle3 = 60;
		operateIEnumerator = Attack03;
		list.Add(new BaseBranchInfo(1003, releaseDistance3, releaseAngle3, default, null, operateIEnumerator));
		FP releaseDistance4 = 5;
		FP releaseAngle4 = 40;
		operateIEnumerator = Attack04;
		list.Add(new BaseBranchInfo(1004, releaseDistance4, releaseAngle4, default, null, operateIEnumerator));
		FP releaseDistance5 = 30;
		FP releaseAngle5 = 60;
		operateIEnumerator = Attack05;
		list.Add(new BaseBranchInfo(1005, releaseDistance5, releaseAngle5, default, null, operateIEnumerator));
		FP releaseDistance6 = 30;
		FP releaseAngle6 = 15;
		operateIEnumerator = Attack06;
		list.Add(new BaseBranchInfo(1006, releaseDistance6, releaseAngle6, default, null, operateIEnumerator));
		FP releaseDistance7 = 30;
		FP releaseAngle7 = 360;
		operateIEnumerator = Attack07;
		list.Add(new BaseBranchInfo(1007, releaseDistance7, releaseAngle7, default, null, operateIEnumerator));
		FP releaseDistance8 = 30;
		FP releaseAngle8 = 360;
		operateIEnumerator = Linger;
		list.Add(new BaseBranchInfo(1008, releaseDistance8, releaseAngle8, default, null, operateIEnumerator));
		FP releaseDistance9 = 30;
		FP releaseAngle9 = 15;
		operateIEnumerator = CheckSkill01;
		list.Add(new BaseBranchInfo(1009, releaseDistance9, releaseAngle9, default, null, operateIEnumerator));
		FP releaseDistance10 = 30;
		FP releaseAngle10 = 15;
		operateIEnumerator = CheckSkill02;
		list.Add(new BaseBranchInfo(1010, releaseDistance10, releaseAngle10, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int> { 1009, 1003, 1006, 1010, 1008, 1006, 1009, 1003, 1010, 1007 } };
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	private void InterruptStrong(IEvent evt)
	{
		RemoveBuffFromTarget(_actor, 110310010);
		WeaponIds = GetLogicTagListLongValue(_actor, "FaMuXieWeaponList");
		if (WeaponIds != null && WeaponIds.Count > 0)
		{
			for (int i = 0; i < WeaponIds.Count; i++)
			{
				FinishWeapon(WeaponIds.get_Item(i));
			}
		}
	}

	private void GotoCastskill(int id)
	{
		CastSkill(id);
	}

	private IEnumerator CheckSkill01()
	{
		if (Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) > 6)
		{
			GotoCastskill(Skill_Attack01);
		}
		else
		{
			GotoCastskill(Skill_Attack02);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator CheckSkill02()
	{
		if (Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) > 6)
		{
			GotoCastskill(Skill_Attack05);
		}
		else
		{
			GotoCastskill(Skill_Attack04);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack01()
	{
		if (Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) > 6)
		{
			if (GetRandomValue(0, 1, isInt: true) == 0)
			{
				GotoCastskill(Skill_Attack01);
			}
			else
			{
				GotoCastskill(Skill_Attack01);
			}
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack02()
	{
		GotoCastskill(Skill_Attack02);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack03()
	{
		GotoCastskill(Skill_Attack03);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack04()
	{
		GotoCastskill(Skill_Attack04);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack05()
	{
		GotoCastskill(Skill_Attack05);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack06()
	{
		GotoCastskill(Skill_Attack06);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack07()
	{
		GotoCastskill(Skill_Attack07);
		yield return WaitSkillFinish();
		GotoCastskill(Skill_Attack06);
		yield return WaitSkillFinish();
	}

	private IEnumerator Linger()
	{
		GotoCastskill(Skill_Linger);
		yield return WaitSkillFinish();
	}
}
