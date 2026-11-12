#define LOG_ERROR
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Trigger;

public class BianSuCiKeController_Lv2 : AIBase
{
	private int killTime = 15;

	private FP curTime;

	private int count;

	private readonly int TeamId = 5060500;

	private readonly FP wakeupDistance = 9;

	private FP attackInterval_phase2 = 2.5;

	private readonly FP attackInterval_phase2_min = 2.5;

	private readonly FP attackInterval_phase2_decrease = 0;

	private readonly FP VollyWaitTime = 7;

	private readonly List<List<int>> skillGroupConfig = new List<List<int>>
	{
		new List<int> { 1, 3, 1 },
		new List<int> { 3, 1, 3 },
		new List<int> { 2, 1, 3 },
		new List<int> { 2, 3, 1 },
		new List<int> { 2, 1, 2 },
		new List<int> { 2, 3, 2 }
	};

	private readonly FP shootLoopTimeAdditional = 1;

	private int leaderMonsterId;

	private int monsterId;

	private AdventureMonsterBiansucikeMessage messageEvent;

	private List<string> optionSkillNames = new List<string> { "castSkill_dash", "castSkill_shoot", "castSkill_topDown" };

	private bool wakeupChecked;

	private List<LogicEntity> monsters;

	private long leaderId;

	private AdventureActor leader;

	private int summonCount;

	private bool summonFinish;

	private int actionPhase;

	private FP time_count_phase;

	private Queue<int> selectedSkills = new Queue<int>();

	private List<int> options = new List<int>();

	private List<long> freeMonsters = new List<long>();

	private int skillIndexCount;

	private List<int> selectedSkillGroup;

	private bool isVolley;

	private bool isVolleyDuring;

	private bool isReadyVolley;

	private int liveMonsterCount;

	private FP VollyWaitTimeCount;

	private PlayerAdventureActor mainCtr => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	public void OnEnable_Partial()
	{
		curTime = 0;
		count = 0;
	}

	public void OnDied_Partial(int _monsterId)
	{
		if (_monsterId == leaderMonsterId || _monsterId == monsterId)
		{
			if (curTime <= 0)
			{
				curTime = mainCtr.LogicTime;
			}
			count++;
			if (count >= 3 && mainCtr.LogicTime - curTime < killTime && !ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.SanJianKe_002))
			{
				ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.SanJianKe_002);
				NovaLogger.Error("完成成就2");
			}
		}
	}

	public void OnEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("MONSTER_BIANSUCIKE_MESSAGE", OnReceiveMessage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		monsters = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(CommonHelper.GetMonsterTeammateId(TeamId, 1));
		leader = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(CommonHelper.GetMonsterTeammateId(TeamId, 0))?.get_Item(0) as AdventureActor;
		if (leader != null)
		{
			leaderId = leader.Id;
			leaderMonsterId = leader.dataID;
			monsters.Add(leader);
			monsterId = (monsters.get_Item(0) as AdventureActor).dataID;
		}
		liveMonsterCount = monsters.Count;
		OnEnable_Partial();
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_BIANSUCIKE_MESSAGE", OnReceiveMessage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		wakeupChecked = false;
		leaderId = 0L;
		summonCount = 0;
		summonFinish = false;
		actionPhase = 0;
		time_count_phase = 0;
		VollyWaitTimeCount = 0;
		monsters?.Clear();
		selectedSkills?.Clear();
		options?.Clear();
		freeMonsters?.Clear();
		skillIndexCount = 0;
		selectedSkillGroup?.Clear();
		isVolley = false;
		isVolleyDuring = false;
		isReadyVolley = false;
	}

	private void OnActorDied(IEvent evt)
	{
		if (evt is AdventureActorDiedEvent adventureActorDiedEvent)
		{
			if (freeMonsters.Contains(adventureActorDiedEvent.actor.Id))
			{
				freeMonsters.Remove(adventureActorDiedEvent.actor.Id);
			}
			if (monsters.Contains(adventureActorDiedEvent.actor))
			{
				monsters.Remove(adventureActorDiedEvent.actor);
			}
			liveMonsterCount = monsters.Count;
			if (actionPhase == 2 && freeMonsters.Count == liveMonsterCount)
			{
				isVolleyDuring = false;
			}
			OnDied_Partial(adventureActorDiedEvent.actor.dataID);
		}
	}

	public void OnUpdate()
	{
		if (!wakeupChecked && ILRuntimeAPI.CalcDistanceBetweenMonsterAndPlayer(leader) <= wakeupDistance)
		{
			SendOperateMessage(leaderId, "wakeUpLeader");
			AdventureMonsterBiansucikeMessage adventureMonsterBiansucikeMessage = AdventureMonsterBiansucikeMessage.Generate();
			adventureMonsterBiansucikeMessage.operationType = "wakeUpTeammate";
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterBiansucikeMessage);
			wakeupChecked = true;
		}
		if (!summonFinish && summonCount == 2)
		{
			summonFinish = true;
			actionPhase = 2;
			time_count_phase = 1.25;
			foreach (LogicEntity monster in monsters)
			{
				string message = "castSkill_hide_1";
				if (monster.Id == leaderId)
				{
					message = "castSkill_hide_2";
				}
				SendOperateMessage(monster.Id, message);
			}
		}
		if (actionPhase != 2)
		{
			return;
		}
		if (!isReadyVolley)
		{
			time_count_phase += LockStepManager.deltaTime;
			if (!isVolleyDuring && time_count_phase >= attackInterval_phase2 && freeMonsters.Count > 0)
			{
				time_count_phase = 0;
				long num = freeMonsters.get_Item(0);
				freeMonsters.RemoveAt(0);
				if (skillIndexCount == 0)
				{
					selectedSkillGroup = skillGroupConfig.get_Item(TSRandom.Range(0, 2));
				}
				else if (skillIndexCount == 3)
				{
					selectedSkillGroup = skillGroupConfig.get_Item(TSRandom.Range(2, 4));
				}
				else if (skillIndexCount == 6)
				{
					selectedSkillGroup = skillGroupConfig.get_Item(TSRandom.Range(4, 6));
				}
				if (selectedSkillGroup == null || selectedSkillGroup.Count < 3)
				{
					selectedSkillGroup = skillGroupConfig.get_Item(0);
				}
				int index = skillIndexCount % 3;
				index = selectedSkillGroup.get_Item(index);
				skillIndexCount++;
				if (skillIndexCount == 9)
				{
					skillIndexCount = 0;
					isReadyVolley = true;
					attackInterval_phase2 -= attackInterval_phase2_decrease;
					attackInterval_phase2 = TSMath.Max(attackInterval_phase2, attackInterval_phase2_min);
				}
				SendOperateMessage(num, optionSkillNames.get_Item(index - 1));
			}
			return;
		}
		if (VollyWaitTimeCount < VollyWaitTime || isVolley)
		{
			if (liveMonsterCount == freeMonsters.Count)
			{
				isVolley = true;
			}
			VollyWaitTimeCount += (FP)0.03;
		}
		else if (VollyWaitTimeCount >= VollyWaitTime)
		{
			isVolley = true;
		}
		if (!isVolley)
		{
			return;
		}
		VollyWaitTimeCount = 0;
		isVolley = false;
		isVolleyDuring = true;
		isReadyVolley = false;
		freeMonsters.Clear();
		foreach (LogicEntity monster2 in monsters)
		{
			if (!(monster2 as AdventureActor).actorSkillManage.HaveRunningSkill())
			{
				(monster2 as AdventureActor).logicVariable.ToggleLogicTag("isVolley", value: true);
				(monster2 as AdventureActor).logicVariable.SetLogicTagValue("shootLoopTimeAdditional", shootLoopTimeAdditional);
				SendOperateMessage(monster2.Id, optionSkillNames.get_Item(1));
			}
		}
	}

	private void SendOperateMessage(long monsterId, string message)
	{
		messageEvent = AdventureMonsterBiansucikeMessage.Generate();
		messageEvent.monsterId = monsterId;
		messageEvent.operationType = message;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(messageEvent);
	}

	private void OnReceiveMessage(IEvent evt)
	{
		if (!(evt is AdventureMonsterBiansucikeMessage adventureMonsterBiansucikeMessage))
		{
			return;
		}
		if (adventureMonsterBiansucikeMessage.operationType == "summonFinish")
		{
			actionPhase = 2;
			if (adventureMonsterBiansucikeMessage.monsterId != leaderId)
			{
				summonCount++;
			}
		}
		else if (adventureMonsterBiansucikeMessage.operationType == "skillFinish")
		{
			if (!freeMonsters.Contains(adventureMonsterBiansucikeMessage.monsterId))
			{
				freeMonsters.Add(adventureMonsterBiansucikeMessage.monsterId);
			}
			if (freeMonsters.Count == liveMonsterCount)
			{
				isVolleyDuring = false;
			}
		}
	}
}
