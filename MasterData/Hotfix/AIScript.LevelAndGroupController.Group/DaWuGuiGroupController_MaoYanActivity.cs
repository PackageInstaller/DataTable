using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.LevelAndGroupController.Group;

public class DaWuGuiGroupController_MaoYanActivity : GroupControllerBase
{
	private readonly int LeaderMonsterID = 3120101;

	private readonly int MemberMonsterID = 3120111;

	private LogicEntity Leader;

	private LogicEntity Member1;

	private List<LogicEntity> FreeMonsters;

	private FP SkillTimes01;

	private int SkillTimes02;

	private int SkillTimes03;

	private int P1AttackMark;

	private FP P2AttackMark1;

	private FP P3AttackMark1;

	protected override void OnStart()
	{
		base.OnStart();
		Leader = GetTargetsByDataId(LeaderMonsterID).get_Item(0);
		Member1 = GetTargetsByDataId(MemberMonsterID).get_Item(0);
		FreeMonsters = new List<LogicEntity>();
		SkillTimes01 = GetRandomValue(0, 1.5, isInt: true);
		SkillTimes02 = 0;
		SkillTimes03 = 0;
		P1AttackMark = 0;
		P2AttackMark1 = GetRandomValue(0, 1);
		P3AttackMark1 = GetRandomValue(0, 1.5, isInt: true);
	}

	protected override void OnUpdate()
	{
	}

	protected override void SetConfig()
	{
		GroupAIType = GroupAIType.POOL;
		List<PoolGroupBranchesInfo> poolBranches = new List<PoolGroupBranchesInfo>
		{
			new PoolGroupBranchesInfo
			{
				index = 1,
				braches = new List<PoolGroupBranchInfo>
				{
					new PoolGroupBranchInfo(1001, 1, 0.1, 0, active: true, null, P1Attack, Reset1001CD),
					new PoolGroupBranchInfo(1002, 1, 0.5, 0, active: false, null, P2Attack, Reset1002CD),
					new PoolGroupBranchInfo(1003, 1, 0.5, 0, active: false, null, P3Attack, Reset1003CD),
					new PoolGroupBranchInfo(1004, 1, 99999, 0, active: false, null, P4Attack),
					new PoolGroupBranchInfo(1005, 1, 99999, 0, active: false, null, P5Attack)
				}
			}
		};
		InitPoolBranches(1, poolBranches);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(GroupEventType.ReceiveMonsterOperation, active: true, FreeMonsterListOperate);
		InitListenEvent(GroupEventType.MonsterDie, true, OnMonsterDie, LeaderMonsterID, MemberMonsterID);
		InitListenEvent(GroupEventType.ToughnessBroken, active: true, OnToughnessBroken);
		InitListenEvent(GroupEventType.ExitToughnessBroken, active: true, OnExitToughnessBroken);
	}

	private void OnMonsterDie(IEvent evt)
	{
		int monsterID = (evt as AdventureMonsterDiedEvent).monsterID;
		if (monsterID == LeaderMonsterID)
		{
			SetPoolBranchActive(1001, active: false);
			SetPoolBranchActive(1002, active: false);
			SetPoolBranchActive(1003, active: false);
			SetPoolBranchActive(1005, active: true);
			FreeMonsters.Add(Member1);
		}
		else if (monsterID == MemberMonsterID)
		{
			SetPoolBranchActive(1001, active: false);
			SetPoolBranchActive(1002, active: false);
			SetPoolBranchActive(1003, active: false);
			SetPoolBranchActive(1004, active: true);
			FreeMonsters.Add(Leader);
		}
	}

	private void FreeMonsterListOperate(IEvent evt)
	{
		AdventureMonsterToGroupControllerMessage adventureMonsterToGroupControllerMessage = evt as AdventureMonsterToGroupControllerMessage;
		string operationType = adventureMonsterToGroupControllerMessage.operationType;
		LogicEntity targetByID = GetTargetByID(adventureMonsterToGroupControllerMessage.monsterId);
		if (operationType == "Free")
		{
			FreeMonsters.Add(targetByID);
		}
		else if (operationType == "Busy" && FreeMonsters.Contains(targetByID))
		{
			FreeMonsters.Remove(targetByID);
		}
	}

	private void OnToughnessBroken(IEvent evt)
	{
		FreeMonsters.Remove(Leader);
		FreeMonsters.Remove(Member1);
	}

	private void OnExitToughnessBroken(IEvent evt)
	{
		FreeMonsters.Add(Leader);
		FreeMonsters.Add(Member1);
	}

	private IEnumerator P1Attack()
	{
		if (!FreeMonsters.Contains(Leader) || !FreeMonsters.Contains(Member1))
		{
			yield break;
		}
		if (SkillTimes01 >= 1 && SkillTimes02 < 3 && SkillTimes03 < 5)
		{
			string operationType = ChooseSkillP1Gui();
			SendMessageToMonster(Member1.Id, operationType);
			FreeMonsters.Remove(Member1);
			yield return WaitTime(2.2);
			string operationType2 = ChooseSkillP6MenMove();
			SendMessageToMonster(Leader.Id, operationType2);
			FreeMonsters.Remove(Leader);
			SkillTimes01 = 0;
			SkillTimes02++;
			SkillTimes03++;
		}
		else if (SkillTimes01 < 1 && SkillTimes02 < 3 && SkillTimes03 < 5)
		{
			string operationType3 = ChooseSkillP1Men();
			SendMessageToMonster(Leader.Id, operationType3);
			FreeMonsters.Remove(Leader);
			if (P1AttackMark == 0)
			{
				P1AttackMark = 1;
				yield return WaitTime(2);
			}
			string operationType4 = ChooseSkillP6Gui();
			SendMessageToMonster(Member1.Id, operationType4);
			FreeMonsters.Remove(Member1);
			SkillTimes01 = 1;
			SkillTimes02++;
			SkillTimes03++;
		}
		else if (SkillTimes01 < 1 && SkillTimes03 < 5 && SkillTimes02 == 3)
		{
			if (P2AttackMark1 >= 0.5)
			{
				string operationType5 = ChooseSkillP2Men();
				SendMessageToMonster(Leader.Id, operationType5);
				FreeMonsters.Remove(Leader);
				string operationType6 = ChooseSkillP6Gui();
				SendMessageToMonster(Member1.Id, operationType6);
				FreeMonsters.Remove(Member1);
				SkillTimes02++;
				SkillTimes03++;
				SkillTimes01 = 1;
				P2AttackMark1 = GetRandomValue(0, 1);
			}
			else
			{
				SetPoolBranchActive(1001, active: false);
				SetPoolBranchActive(1002, active: true);
				SkillTimes02 = 0;
			}
		}
		else if (SkillTimes01 >= 1 && SkillTimes03 < 5 && SkillTimes02 == 3)
		{
			if (P2AttackMark1 >= 0.5)
			{
				string operationType7 = ChooseSkillP2Gui();
				SendMessageToMonster(Member1.Id, operationType7);
				FreeMonsters.Remove(Member1);
				yield return WaitTime(2.2);
				string operationType8 = ChooseSkillP6MenMove();
				SendMessageToMonster(Leader.Id, operationType8);
				FreeMonsters.Remove(Leader);
				SkillTimes02++;
				SkillTimes03++;
				SkillTimes01 = 0;
			}
			else
			{
				SetPoolBranchActive(1001, active: false);
				SetPoolBranchActive(1002, active: true);
				SkillTimes02 = 0;
			}
		}
		else if (SkillTimes02 >= 4 && SkillTimes03 < 5)
		{
			SetPoolBranchActive(1001, active: false);
			SetPoolBranchActive(1002, active: true);
			SkillTimes02 = 0;
		}
		else if (SkillTimes03 >= 5)
		{
			SetPoolBranchActive(1001, active: false);
			SetPoolBranchActive(1002, active: false);
			SetPoolBranchActive(1003, active: true);
			SkillTimes03 = 0;
			SkillTimes02 = 0;
		}
	}

	private IEnumerator P2Attack()
	{
		if (FreeMonsters.Contains(Leader) && FreeMonsters.Contains(Member1))
		{
			if (SkillTimes02 < 1 && SkillTimes03 < 5)
			{
				yield return WaitTime(1);
				string member1Skill = ChooseSkillP2Gui();
				string operationType = ChooseSkillP2Men();
				SendMessageToMonster(Leader.Id, operationType);
				FreeMonsters.Remove(Leader);
				yield return WaitTime(2.6);
				SendMessageToMonster(Member1.Id, member1Skill);
				FreeMonsters.Remove(Member1);
				SkillTimes02++;
				SkillTimes03++;
			}
			else if (SkillTimes02 >= 1 && SkillTimes03 < 5)
			{
				SetPoolBranchActive(1001, active: true);
				SetPoolBranchActive(1002, active: false);
				SetPoolBranchActive(1003, active: false);
				SkillTimes01 = GetRandomValue(0, 1.5, isInt: true);
				SkillTimes02 = 0;
			}
			else if (SkillTimes03 >= 5)
			{
				SetPoolBranchActive(1001, active: false);
				SetPoolBranchActive(1002, active: false);
				SetPoolBranchActive(1003, active: true);
				SkillTimes03 = 0;
				SkillTimes02 = 0;
			}
		}
	}

	private IEnumerator P3Attack()
	{
		if (FreeMonsters.Contains(Leader) && FreeMonsters.Contains(Member1))
		{
			if (P3AttackMark1 >= 1)
			{
				string operationType = ChooseSkillP3Gui();
				string leaderSkill = ChooseSkillP5Men();
				SendMessageToMonster(Member1.Id, operationType);
				FreeMonsters.Remove(Member1);
				SkillTimes01 = 1;
				SkillTimes02 = 0;
				SkillTimes03 = 0;
				yield return WaitTime(1);
				P3AttackMark1 = 0;
				SendMessageToMonster(Leader.Id, leaderSkill);
				FreeMonsters.Remove(Leader);
				SetPoolBranchActive(1001, active: true);
				SetPoolBranchActive(1002, active: false);
				SetPoolBranchActive(1003, active: false);
			}
			else if (P3AttackMark1 < 1)
			{
				string operationType2 = ChooseSkillP3Men();
				string leaderSkill = ChooseSkillP5Gui();
				SendMessageToMonster(Leader.Id, operationType2);
				FreeMonsters.Remove(Leader);
				SkillTimes02 = 0;
				SkillTimes03 = 0;
				yield return WaitTime(2);
				SendMessageToMonster(Member1.Id, leaderSkill);
				yield return WaitTime(5);
				SendMessageToMonster(Member1.Id, leaderSkill);
				FreeMonsters.Remove(Member1);
				P3AttackMark1 = 1;
				SetPoolBranchActive(1001, active: true);
				SetPoolBranchActive(1002, active: false);
				SetPoolBranchActive(1003, active: false);
			}
		}
	}

	private IEnumerator P4Attack()
	{
		yield return WaitTime(0.1);
		if (EntityInSkill(Leader, 5018199))
		{
			InterruptSkill(Leader as AdventureActor);
		}
		ResetMonsterAI(Leader, 5018123, interruptSkill: false);
		SetPoolBranchActive(1004, active: false);
	}

	private IEnumerator P5Attack()
	{
		yield return WaitTime(0.1);
		if (EntityInSkill(Member1, 5031198))
		{
			InterruptSkill(Member1 as AdventureActor);
		}
		ResetMonsterAI(Member1, 5031101, interruptSkill: false);
		SetPoolBranchActive(1005, active: false);
	}

	private void Reset1001CD()
	{
		SetPoolBranchCD(1001, 0.1);
	}

	private void Reset1002CD()
	{
		SetPoolBranchCD(1002, 1);
	}

	private void Reset1003CD()
	{
		SetPoolBranchCD(1003, 1);
	}

	private string ChooseSkillP1Gui()
	{
		return "Skill_Attack04";
	}

	private string ChooseSkillP2Gui()
	{
		return "Skill_Attack04And03";
	}

	private string ChooseSkillP3Gui()
	{
		return "Skill_Attack07";
	}

	private string ChooseSkillP5Gui()
	{
		return "Skill_Attack06";
	}

	private string ChooseSkillP6Gui()
	{
		return "Skill_Attack09";
	}

	private string ChooseSkillP1Men()
	{
		return "Skill_Attack01And02";
	}

	private string ChooseSkillP2Men()
	{
		return "Skill_Attack03And04";
	}

	private string ChooseSkillP3Men()
	{
		return "Skill_Attack05";
	}

	private string ChooseSkillP5Men()
	{
		return "TeleportAttack02";
	}

	private string ChooseSkillP6MenMove()
	{
		return "Teleport";
	}
}
