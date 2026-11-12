using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.LevelAndGroupController.Group;

public class SanJiankeGroupController_Lv2 : GroupControllerBase
{
	private int killTime = 15;

	private FP curTime;

	private int count;

	private readonly int LeaderMonsterID = 5060500;

	private readonly int MemberMonsterID = 5060501;

	private readonly List<string> WaitMessage_LeaderWakeUp = new List<string> { "ImWakeUp" };

	private readonly List<string> FreeMessage = new List<string> { "Free" };

	private readonly List<string> WakeTeammatesMessage = new List<string> { "WakeTeammates" };

	private readonly int ShieldBuffId = 501619910;

	private readonly List<List<string>> skillGroupConfig = new List<List<string>>
	{
		new List<string> { "Skill_Dash", "Skill_Dash", "Skill_Shoot" },
		new List<string> { "Skill_Dash", "Skill_Dash", "Skill_TopDown" },
		new List<string> { "Skill_Dash", "Skill_Shoot", "Skill_TopDown" },
		new List<string> { "Skill_Shoot", "Skill_Shoot", "Skill_TopDown" },
		new List<string> { "Skill_Shoot", "Skill_Shoot", "Skill_TopDown" },
		new List<string> { "Skill_Shoot", "Skill_Dash", "Skill_TopDown" }
	};

	private LogicEntity Leader;

	private LogicEntity Member1;

	private LogicEntity Member2;

	private List<LogicEntity> FreeMonsters;

	private List<string> SkillListP2;

	private int SkillWeightP1;

	private int SkillWeightP2;

	private int SkillWeightP3;

	private int SkillIndexP2;

	private int MonsterCount;

	public void OnEnable_Partial()
	{
		curTime = 0;
		count = 0;
	}

	public void MonsterDie(IEvent iEvt)
	{
		if (curTime <= 0)
		{
			curTime = LockStepManager.time;
		}
		count++;
		if (count >= 3 && LockStepManager.time - curTime < killTime && !ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(null, HotfixEnum.questCompleteCondClient.SanJianKe_002))
		{
			ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.SanJianKe_002);
		}
	}

	protected override void OnStart()
	{
		base.OnStart();
		Leader = GetTargetsByDataId(LeaderMonsterID).get_Item(0);
		Member1 = GetTargetsByDataId(MemberMonsterID).get_Item(0);
		Member2 = GetTargetsByDataId(MemberMonsterID).get_Item(1);
		FreeMonsters = new List<LogicEntity>();
		SkillWeightP1 = 2;
		SkillWeightP2 = 2;
		SkillWeightP3 = 2;
		SkillIndexP2 = 0;
		SkillListP2 = new List<string>();
		OnEnable_Partial();
	}

	protected override void OnUpdate()
	{
		base.OnUpdate();
		int num = GetTargetsByDataId(LeaderMonsterID).Count;
		int num2 = GetTargetsByDataId(MemberMonsterID).Count;
		MonsterCount = num + num2;
	}

	protected override void OnStop()
	{
		base.OnStop();
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
					new PoolGroupBranchInfo(1099, 99, 1, 0, active: true, null, FirstAwake),
					new PoolGroupBranchInfo(1002, 1, 3, 0, active: false, null, P2Attack, Reset1002CD)
				}
			}
		};
		InitPoolBranches(1, poolBranches);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(GroupEventType.ReceiveMonsterOperation, active: true, FreeMonsterListOperate);
		InitListenEvent(GroupEventType.MonsterDie, true, MonsterDie, LeaderMonsterID, MemberMonsterID);
	}

	private IEnumerator FirstAwake()
	{
		yield return WaitTime(0.5);
		SendMessageToMonster(Leader.Id, "WakeUp");
		SendMessageToMonster(Member1.Id, "WakeUp");
		SendMessageToMonster(Member2.Id, "WakeUp");
		SetPoolBranchActive(1099, active: false);
		while (FreeMonsters.Count < MonsterCount)
		{
			yield return null;
		}
		SetPoolBranchActive(1002, active: true);
	}

	private IEnumerator P2Attack()
	{
		while (FreeMonsters.Count <= 0)
		{
			yield return null;
		}
		if (SkillIndexP2 == 0)
		{
			MakeSkillListInP2();
		}
		if (SkillIndexP2 <= 8)
		{
			LogicEntity logicEntity = FreeMonsters.get_Item(0);
			SendMessageToMonster(logicEntity.Id, SkillListP2.get_Item(SkillIndexP2));
			FreeMonsters.Remove(logicEntity);
			SkillIndexP2++;
			yield break;
		}
		SkillListP2.Clear();
		FP timecount = 0;
		while (FreeMonsters.Count < MonsterCount && timecount <= 5)
		{
			timecount += (FP)0.03;
			yield return null;
		}
		foreach (LogicEntity freeMonster in FreeMonsters)
		{
			SendMessageToMonster(freeMonster.Id, "Skill_Shoot");
			SendMessageToMonster(freeMonster.Id, "Volley");
		}
		FreeMonsters.Clear();
		SkillIndexP2 = 0;
	}

	private void Reset1002CD()
	{
		SetPoolBranchCD(1002, 2.5);
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

	private void MakeSkillListInP2()
	{
		SkillListP2.AddRange(skillGroupConfig.get_Item((int)(long)GetRandomValue(0, 1.5, isInt: true)));
		SkillListP2.AddRange(skillGroupConfig.get_Item((int)(long)GetRandomValue(2, 3.5, isInt: true)));
		SkillListP2.AddRange(skillGroupConfig.get_Item((int)(long)GetRandomValue(4, 5.5, isInt: true)));
	}
}
