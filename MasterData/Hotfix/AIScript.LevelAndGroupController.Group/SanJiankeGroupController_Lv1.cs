#define LOG_ERROR
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.LevelAndGroupController.Group;

public class SanJiankeGroupController_Lv1 : GroupControllerBase
{
	private int killTime = 15;

	private FP curTime;

	private int count;

	private readonly int LeaderMonsterID = 5050500;

	private readonly int MemberMonsterID = 5050501;

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
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_BREAK_SHIELD", OnShieldBreak);
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
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_BREAK_SHIELD", OnShieldBreak);
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
					new PoolGroupBranchInfo(1001, 1, 0.5, 0, active: false, null, P1Attack, Reset1001CD),
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
		SetPoolBranchActive(1099, active: false);
		yield return WaitCertainOperations(WaitMessage_LeaderWakeUp, Leader.Id);
		SetPoolBranchActive(1001, active: true);
	}

	private IEnumerator P1Attack()
	{
		while (FreeMonsters.Count <= 0)
		{
			yield return null;
		}
		LogicEntity logicEntity = FreeMonsters.get_Item(0);
		string operationType = ChooseSkillP1();
		SendMessageToMonster(logicEntity.Id, operationType);
		FreeMonsters.Remove(logicEntity);
		yield return WaitCertainOperations(FreeMessage, logicEntity.Id);
	}

	private void OnShieldBreak(IEvent evt)
	{
		if (((evt as AdventureActorBreakShield).sender as AdventureActor).Id == Leader.Id)
		{
			RemoveBuffFromTarget(Leader, ShieldBuffId);
			InterruptCurrentBranch();
			SetPoolBranchActive(1001, active: false);
			SendMessageToMonster(Leader.Id, "Skill_Summon");
			StartCor(P1ToP2());
		}
	}

	private IEnumerator P1ToP2()
	{
		yield return WaitCertainOperations(WakeTeammatesMessage, Leader.Id);
		SendMessageToMonster(Member1.Id, "WakeUp");
		SendMessageToMonster(Member2.Id, "WakeUp");
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
		}
		else
		{
			SkillListP2.Clear();
			SkillIndexP2 = 0;
		}
	}

	private void Reset1001CD()
	{
		SetPoolBranchCD(1001, 0.5);
	}

	private void Reset1002CD()
	{
		SetPoolBranchCD(1002, 3);
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

	private string ChooseSkillP1()
	{
		switch (randomWeight(new int[3] { SkillWeightP1, SkillWeightP2, SkillWeightP3 }))
		{
		case 0:
			SkillWeightP1--;
			SkillWeightP2++;
			SkillWeightP3++;
			return "Skill_Dash";
		case 1:
			SkillWeightP1++;
			SkillWeightP2--;
			SkillWeightP3++;
			return "Skill_Shoot";
		case 2:
			SkillWeightP1++;
			SkillWeightP2++;
			SkillWeightP3--;
			return "Skill_TopDown";
		default:
			NovaLogger.Error("1阶段选择技能出错，检查逻辑");
			return "Skill_Dash";
		}
	}

	private void MakeSkillListInP2()
	{
		SkillListP2.AddRange(skillGroupConfig.get_Item((int)(long)GetRandomValue(0, 1.5, isInt: true)));
		SkillListP2.AddRange(skillGroupConfig.get_Item((int)(long)GetRandomValue(2, 3.5, isInt: true)));
		SkillListP2.AddRange(skillGroupConfig.get_Item((int)(long)GetRandomValue(4, 5.5, isInt: true)));
	}
}
