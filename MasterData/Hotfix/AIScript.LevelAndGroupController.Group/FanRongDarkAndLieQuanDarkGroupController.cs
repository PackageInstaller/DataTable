using System.Collections;
using System.Collections.Generic;

namespace AIScript.LevelAndGroupController.Group;

public class FanRongDarkAndLieQuanDarkGroupController : GroupControllerBase
{
	private readonly int LeaderMonsterID = 5050601;

	private readonly int MemberMonsterID = 5050910;

	private LogicEntity Leader;

	private LogicEntity Member;

	private int SkillTimes01;

	private int SkillTimes02;

	protected override void OnStart()
	{
		base.OnStart();
		Leader = GetTargetsByDataId(LeaderMonsterID).get_Item(0);
		Member = GetTargetsByDataId(MemberMonsterID).get_Item(0);
		SkillTimes01 = 0;
		SkillTimes02 = 0;
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
					new PoolGroupBranchInfo(1001, 999, 0, 0, active: true, Condition01, LieQuanAttack1),
					new PoolGroupBranchInfo(1002, 999, 0, 0, active: true, Condition02, FanRongAttack1)
				}
			}
		};
		InitPoolBranches(1, poolBranches);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(GroupEventType.ReceiveMonsterOperation, active: true, FreeMonsterListOperate);
		InitListenEvent(GroupEventType.MonsterDie, true, OnMonsterDie, LeaderMonsterID, MemberMonsterID);
	}

	private void OnMonsterDie(IEvent evt)
	{
		int monsterID = (evt as AdventureMonsterDiedEvent).monsterID;
		if (monsterID == LeaderMonsterID)
		{
			SendMessageToMonster(Member.Id, "FanRongDeath");
		}
		else if (monsterID == MemberMonsterID)
		{
			SendMessageToMonster(Leader.Id, "LieQuanDeath");
		}
	}

	private void FreeMonsterListOperate(IEvent evt)
	{
		switch ((evt as AdventureMonsterToGroupControllerMessage).operationType)
		{
		case "FanRongDaZhao":
			SkillTimes01 = 1;
			break;
		case "LieQuanDaZhao":
			SkillTimes02 = 1;
			break;
		case "FanRongDaZhaoEnd":
			SendMessageToMonster(Member.Id, "LieQuanStopAttack");
			break;
		case "LieQuanDaZhaoEnd":
			SendMessageToMonster(Leader.Id, "FanRongStopAttack");
			break;
		}
	}

	private bool Condition01()
	{
		if (SkillTimes01 >= 1)
		{
			return true;
		}
		return false;
	}

	private bool Condition02()
	{
		if (SkillTimes02 >= 1)
		{
			return true;
		}
		return false;
	}

	private IEnumerator LieQuanAttack1()
	{
		if (!EntityInSkill(Member))
		{
			SendMessageToMonster(Member.Id, "LieQuanAttack");
			SkillTimes02 = 0;
			SetPoolBranchCD(1001, 10);
		}
		yield return null;
	}

	private IEnumerator FanRongAttack1()
	{
		if (!EntityInSkill(Leader))
		{
			SendMessageToMonster(Leader.Id, "FanRongAttack");
			SkillTimes02 = 0;
			SetPoolBranchCD(1002, 10);
		}
		yield return null;
	}
}
