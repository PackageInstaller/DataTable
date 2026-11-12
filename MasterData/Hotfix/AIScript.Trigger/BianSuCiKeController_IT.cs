using System;
using System.Collections.Generic;
using System.Linq;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Trigger;

public class BianSuCiKeController_IT : AIBase
{
	private readonly int leaderMonsterId = 7150800;

	private readonly int monsterId = 7150801;

	private readonly int shieldBuffId = 501619910;

	private readonly FP wakeupDistance = 9;

	private readonly FP attackInterval_phase1 = 0.5;

	private FP attackInterval_phase2 = 2.25;

	private readonly FP attackInterval_phase2_min = 2;

	private readonly FP attackInterval_phase2_decrease = 0.25;

	private readonly List<List<int>> skillGroupConfig = new List<List<int>>
	{
		new List<int> { 1, 1, 2 },
		new List<int> { 1, 1, 3 },
		new List<int> { 1, 2, 3 },
		new List<int> { 2, 2, 3 },
		new List<int> { 2, 2, 3 },
		new List<int> { 2, 1, 3 }
	};

	private readonly FP shootLoopTimeAdditional = 1;

	private AdventureMonsterBiansucikeMessage messageEvent;

	private List<string> optionSkillNames = new List<string> { "castSkill_dash", "castSkill_shoot", "castSkill_topDown" };

	private bool wakeupChecked;

	private List<LogicEntity> monsters;

	private long leaderId;

	private AdventureActor leader;

	private int summonCount;

	private bool summonFinish;

	private bool summonBegin;

	private int actionPhase;

	private FP time_count_phase;

	private Queue<int> selectedSkills = new Queue<int>();

	private List<int> options = new List<int>();

	private List<long> freeMonsters = new List<long>();

	private int skillIndexCount;

	private List<int> selectedSkillGroup;

	private bool isVolley;

	private bool isVolleyDuring;

	private int liveMonsterCount;

	private bool castingSkill;

	private bool leaderHide;

	public void OnEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("MONSTER_BIANSUCIKE_MESSAGE", OnReceiveMessage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_BREAK_SHIELD", OnShieldBreak);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		monsters = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(monsterId);
		leader = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(leaderMonsterId)?.get_Item(0) as AdventureActor;
		if (leader != null)
		{
			leaderId = leader.Id;
			monsters.Add(leader);
		}
		liveMonsterCount = monsters.Count;
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_BIANSUCIKE_MESSAGE", OnReceiveMessage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_BREAK_SHIELD", OnShieldBreak);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		wakeupChecked = false;
		leaderId = 0L;
		summonCount = 0;
		summonFinish = false;
		summonBegin = false;
		actionPhase = 0;
		time_count_phase = 0;
		monsters?.Clear();
		selectedSkills?.Clear();
		options?.Clear();
		freeMonsters?.Clear();
		skillIndexCount = 0;
		selectedSkillGroup?.Clear();
		isVolley = false;
		castingSkill = false;
		leaderHide = false;
		isVolleyDuring = false;
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
				castingSkill = false;
			}
		}
	}

	public void OnUpdate()
	{
		//IL_01d9: Unknown result type (might be due to invalid IL or missing references)
		//IL_01de: Unknown result type (might be due to invalid IL or missing references)
		if (!wakeupChecked && ILRuntimeAPI.CalcDistanceBetweenMonsterAndPlayer(leader) <= wakeupDistance)
		{
			SendOperateMessage(leaderId, "wakeUpLeader");
			wakeupChecked = true;
		}
		if (summonBegin)
		{
			summonBegin = false;
			SendOperateMessage(leaderId, "castSkill_summon");
		}
		if (!summonFinish && summonCount == 2)
		{
			summonFinish = true;
			actionPhase = 2;
			time_count_phase = 0;
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
		if (leaderHide)
		{
			leaderHide = false;
			SendOperateMessage(leaderId, "castSkill_hide_1");
		}
		if (!castingSkill && actionPhase == 1)
		{
			time_count_phase += LockStepManager.deltaTime;
			if (time_count_phase >= attackInterval_phase1)
			{
				time_count_phase = 0;
				options.Clear();
				options.Add(1);
				options.Add(2);
				options.Add(3);
				if (selectedSkills.Count == 2)
				{
					if (((IEnumerable<int>)selectedSkills).Distinct().Count() == 1)
					{
						options.Remove(selectedSkills.Peek());
					}
				}
				else if (selectedSkills.Count == 3 && ((IEnumerable<int>)selectedSkills).Distinct().Count() == 2)
				{
					Enumerator<int> enumerator2 = selectedSkills.GetEnumerator();
					try
					{
						while (enumerator2.MoveNext())
						{
							int current2 = enumerator2.Current;
							options.Remove(current2);
						}
					}
					finally
					{
						((IDisposable)enumerator2/*cast due to constrained. prefix*/).Dispose();
					}
				}
				SelectRandomSkillForPhase1();
			}
		}
		if (actionPhase != 2)
		{
			return;
		}
		if (!isVolley)
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
					attackInterval_phase2 -= attackInterval_phase2_decrease;
					attackInterval_phase2 = TSMath.Max(attackInterval_phase2, attackInterval_phase2_min);
				}
				SendOperateMessage(num, optionSkillNames.get_Item(index - 1));
			}
		}
		else
		{
			if (freeMonsters.Count != liveMonsterCount)
			{
				return;
			}
			isVolley = false;
			isVolleyDuring = true;
			freeMonsters.Clear();
			foreach (LogicEntity monster2 in monsters)
			{
				(monster2 as AdventureActor).logicVariable.ToggleLogicTag("isVolley", value: true);
				(monster2 as AdventureActor).logicVariable.SetLogicTagValue("shootLoopTimeAdditional", shootLoopTimeAdditional);
				SendOperateMessage(monster2.Id, optionSkillNames.get_Item(1));
			}
		}
	}

	private void SelectRandomSkillForPhase1()
	{
		int index = TSRandom.Range(0, options.Count);
		int num = options.get_Item(index);
		selectedSkills.Enqueue(num);
		if (((IEnumerable<int>)selectedSkills).Count() > 3)
		{
			selectedSkills.Dequeue();
		}
		SendOperateMessage(leaderId, optionSkillNames.get_Item(num - 1));
	}

	private void SendOperateMessage(long monsterId, string message)
	{
		messageEvent = AdventureMonsterBiansucikeMessage.Generate();
		messageEvent.monsterId = monsterId;
		messageEvent.operationType = message;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(messageEvent);
		if (message.Contains("castSkill"))
		{
			castingSkill = true;
		}
	}

	private void OnReceiveMessage(IEvent evt)
	{
		if (!(evt is AdventureMonsterBiansucikeMessage adventureMonsterBiansucikeMessage))
		{
			return;
		}
		if (adventureMonsterBiansucikeMessage.operationType == "summonFinish")
		{
			if (adventureMonsterBiansucikeMessage.monsterId != leaderId)
			{
				summonCount++;
				return;
			}
			leaderHide = true;
			actionPhase = 1;
		}
		else
		{
			if (!(adventureMonsterBiansucikeMessage.operationType == "skillFinish"))
			{
				return;
			}
			if (actionPhase == 0 || actionPhase == 1)
			{
				castingSkill = false;
			}
			else if (actionPhase == 2)
			{
				if (!freeMonsters.Contains(adventureMonsterBiansucikeMessage.monsterId))
				{
					freeMonsters.Add(adventureMonsterBiansucikeMessage.monsterId);
				}
				if (freeMonsters.Count == liveMonsterCount)
				{
					isVolleyDuring = false;
					castingSkill = false;
				}
			}
		}
	}

	private void OnShieldBreak(IEvent evt)
	{
		if (((evt as AdventureActorBreakShield).sender as AdventureActor).Id == leaderId)
		{
			leader?.buffComponent?.RemoveBuffByBuffId(shieldBuffId);
			summonBegin = true;
			actionPhase = 0;
		}
	}
}
