using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50541ChuShi;

public class Parrallel_BossRush : Parallel_BossRush
{
	private int teamMate_1 = 1;

	private int teamMate_2 = 2;

	private int teamMate_3 = 5;

	private int teamMate_4 = 4;

	private int killCount = 1;

	private int collectCount = 1;

	private string bossTagId = "100002";

	private string areaEffect_fire = "AreaEffect_ChuShi_FireRing";

	private int buff_dmg = 631002001;

	private int interval = 5;

	private int accumulate = 3;

	private int buff_atk = 631002002;

	private int lost_time = 10;

	private FP cd = 2;

	private const string perkTagId_FireAtk = "100017";

	private const string areaAlias_FireAtk = "AreaEffect_ChuShi_FireRing";

	private const int buffId_TeamAtk_FireAtk = 631017010;

	private const int fireatk_Threshold = 5;

	private static readonly FP fireatk_LostDuration = 10;

	private string bossTagId_2 = "100007";

	private int buff_atk_2 = 631008010;

	private int buff_Count_2 = 3;

	private int buff_fight_1 = 631008020;

	private int summonId_1;

	private int summonId_2;

	private int summonId_3;

	private int summonId_4;

	private int count_kill;

	private int count_collect;

	private bool hasTag;

	private bool hasTag_2;

	private List<FP> triggerTimes = new List<FP>();

	private FP curTime;

	private CoroutineNode corBuff;

	private CoroutineNode corArea;

	private long areaId;

	private bool hasTag_FireAtk;

	private bool inLost_FireAtk;

	private long areaId_FireAtk;

	private int triggerCount_FireAtk;

	private CoroutineNode cor_FireAtkLost;

	private CoroutineNode cor_FireAtkArea;

	private bool inLost;

	private int summonCount;

	private int readyToRemoveBuffNum;

	private List<MonsterAdventureActor> monsters = new List<MonsterAdventureActor>();

	private List<CoroutineNode> corList = new List<CoroutineNode>();

	public override void OnStart()
	{
		base.OnStart();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawned);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		summonId_1 = CommonHelper.GetMonsterTeammateId(monsterAdventureActor.monsterInfo.teamId, teamMate_1);
		summonId_2 = CommonHelper.GetMonsterTeammateId(monsterAdventureActor.monsterInfo.teamId, teamMate_2);
		summonId_3 = CommonHelper.GetMonsterTeammateId(monsterAdventureActor.monsterInfo.teamId, teamMate_3);
		summonId_4 = CommonHelper.GetMonsterTeammateId(monsterAdventureActor.monsterInfo.teamId, teamMate_4);
		count_collect = 0;
		count_kill = 0;
		curTime = 0;
		inLost = false;
		summonCount = 0;
		readyToRemoveBuffNum = 0;
		hasTag = _actor.CheckTag(bossTagId);
		hasTag_2 = _actor.CheckTag(bossTagId_2);
		InitFireAtk();
		if (hasTag)
		{
			_actor.buffComponent.AddBuff(buff_dmg, _actor);
			areaId = ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_fire, _actor.tsTransform.Position);
			StartCoroutine(ref corArea, CheckAreaEffect());
		}
		if (!hasTag_2)
		{
			return;
		}
		_actor.buffComponent.AddBuffNum(buff_atk_2, buff_Count_2, _actor);
		CommonUtils.GetAllSummons(monsters);
		for (int i = 0; i < monsters.Count; i++)
		{
			if (monsters.get_Item(i).IsPlayerMinion(out var _))
			{
				summonCount++;
				_actor.buffComponent.AddBuff(buff_fight_1, _actor);
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawned);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		if (hasTag)
		{
			_actor.buffComponent.RemoveBuffByBuffId(buff_atk);
			if (areaId != 0L)
			{
				ILRuntimeAPI.StopAreaEffect(areaId);
				areaId = 0L;
			}
			StopCoroutine(ref corBuff);
			StopCoroutine(ref corArea);
			triggerTimes.Clear();
		}
		if (hasTag_FireAtk)
		{
			if (areaId_FireAtk != 0L)
			{
				ILRuntimeAPI.StopAreaEffect(areaId_FireAtk);
				areaId_FireAtk = 0L;
			}
			StopCoroutine(ref cor_FireAtkLost);
			StopCoroutine(ref cor_FireAtkArea);
		}
		monsters.Clear();
		for (int i = 0; i < corList.Count; i++)
		{
			StopCoroutine(corList.get_Item(i));
		}
		corList.Clear();
	}

	protected override void OnActorDied(IEvent e)
	{
		if (!(e is AdventureActorDiedEvent adventureActorDiedEvent))
		{
			return;
		}
		if ((adventureActorDiedEvent.actor.dataID == summonId_1 || adventureActorDiedEvent.actor.dataID == summonId_2 || adventureActorDiedEvent.actor.dataID == summonId_3 || adventureActorDiedEvent.actor.dataID == summonId_4) && (adventureActorDiedEvent.deadType == DeadType.NormalDmgkill || adventureActorDiedEvent.deadType == DeadType.DirectDmgKill || adventureActorDiedEvent.deadType == DeadType.Kill))
		{
			count_kill++;
			if (count_kill >= killCount)
			{
				count_kill = 0;
				if (_monster.CheckScoreBossBehaviour(13))
				{
					_monster.TriggerScoreBossBehaviour(13);
				}
			}
		}
		if (hasTag_2 && adventureActorDiedEvent.actor is MonsterAdventureActor entity && entity.IsPlayerMinion(out var _))
		{
			summonCount--;
			if (summonCount < buff_Count_2)
			{
				CoroutineNode item = StartCoroutine(GotoRemoveBuff());
				corList.Add(item);
				readyToRemoveBuffNum++;
			}
		}
	}

	private void OnReceiveCustomEvent(IEvent _evt)
	{
		if (!(_evt is AdventureActorCustomEvent adventureActorCustomEvent) || !(adventureActorCustomEvent.actor != null) || (adventureActorCustomEvent.actor.dataID != summonId_1 && adventureActorCustomEvent.actor.dataID != summonId_2 && adventureActorCustomEvent.actor.dataID != summonId_3 && adventureActorCustomEvent.actor.dataID != summonId_4) || !adventureActorCustomEvent.eventName.Equals("BossRush_KnifeAndFork_CallBack"))
		{
			return;
		}
		count_collect++;
		if (count_collect >= collectCount)
		{
			count_collect = 0;
			if (_monster.CheckScoreBossBehaviour(14))
			{
				_monster.TriggerScoreBossBehaviour(14);
			}
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent elementMarkTriggerEvent)
	{
		OnElementMarkTrigger_FireAtk(elementMarkTriggerEvent);
		if (!hasTag || !(elementMarkTriggerEvent.markActor == _actor) || (!(_actor.LogicTime - curTime > cd) && !(curTime <= 0)))
		{
			return;
		}
		triggerTimes.Add(_actor.LogicTime);
		_ = _actor.LogicTime;
		FP fP = _actor.LogicTime - interval;
		for (int num = triggerTimes.Count - 1; num >= 0; num--)
		{
			if (triggerTimes.get_Item(num) < fP)
			{
				triggerTimes.RemoveAt(num);
			}
		}
		if (triggerTimes.Count >= accumulate)
		{
			Singleton<BuffManager>.Instance.AddBufftoGroup(buff_atk, _actor);
			triggerTimes.Clear();
			curTime = _actor.LogicTime;
			StartCoroutine(ref corBuff, DoLost());
		}
	}

	private void OnActorSpawned(IEvent _evt)
	{
		if (hasTag_2)
		{
			AdventurActorSpawned adventurActorSpawned = (AdventurActorSpawned)_evt;
			if (adventurActorSpawned != null && adventurActorSpawned.sender is MonsterAdventureActor entity && entity.IsPlayerMinion(out var _))
			{
				summonCount++;
				_actor.buffComponent.AddBuff(buff_fight_1, _actor);
			}
		}
	}

	private IEnumerator GotoRemoveBuff()
	{
		yield return _actor.WaitTime(3);
		if (summonCount < buff_Count_2 && summonCount + readyToRemoveBuffNum <= buff_Count_2)
		{
			_actor.buffComponent.RemoveBuffByBuffId(buff_fight_1, 1);
		}
		readyToRemoveBuffNum--;
	}

	private IEnumerator DoLost()
	{
		inLost = true;
		yield return _actor.WaitTime(lost_time);
		inLost = false;
	}

	private IEnumerator CheckAreaEffect()
	{
		while (true)
		{
			if (inLost || _actor.isUnparalleled)
			{
				if (areaId != 0L)
				{
					_actor.buffComponent.RemoveBuffByBuffId(buff_dmg);
					ILRuntimeAPI.StopAreaEffect(areaId);
					areaId = 0L;
				}
			}
			else if (areaId == 0L)
			{
				_actor.buffComponent.AddBuff(buff_dmg, _actor);
				areaId = ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_fire, _actor.tsTransform.Position);
			}
			yield return null;
		}
	}

	private void InitFireAtk()
	{
		hasTag_FireAtk = _actor.CheckTag("100017");
		if (hasTag_FireAtk)
		{
			inLost_FireAtk = false;
			areaId_FireAtk = 0L;
			triggerCount_FireAtk = 0;
			areaId_FireAtk = ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_ChuShi_FireRing", _actor.tsTransform.Position, default, (AreaEffectEntity entity) =>
			{
				AreaEffect_FollowComponent areaEffect_FollowComponent = entity.AddOrGetMonoLogicComponent<AreaEffect_FollowComponent>();
				areaEffect_FollowComponent.targetType = AreaEffect_FollowComponent.FollowTargetType.Owner;
				areaEffect_FollowComponent.isSlowMove = false;
			});
			StartCoroutine(ref cor_FireAtkArea, Loop_FireAtkArea());
		}
	}

	private void OnElementMarkTrigger_FireAtk(AdventureElementMarkTriggerEvent evt)
	{
		if (!hasTag_FireAtk || inLost_FireAtk || evt.markActor != _actor)
		{
			return;
		}
		PlayerAdventureActor playerAdventureActor = evt.triggerActor as PlayerAdventureActor;
		if (playerAdventureActor == null || playerAdventureActor.isAssist)
		{
			return;
		}
		triggerCount_FireAtk++;
		if (triggerCount_FireAtk < 5)
		{
			return;
		}
		triggerCount_FireAtk = 0;
		mainActor.buffComponent?.AddBuff(631017010, mainActor);
		foreach (AdventureActor assistantPlayer in ILRuntimeAPI.GetAssistantPlayers())
		{
			assistantPlayer.buffComponent?.AddBuff(631017010, mainActor);
		}
		StartCoroutine(ref cor_FireAtkLost, DoLost_FireAtk());
	}

	private IEnumerator DoLost_FireAtk()
	{
		inLost_FireAtk = true;
		yield return _actor.WaitTime(fireatk_LostDuration);
		inLost_FireAtk = false;
	}

	private IEnumerator Loop_FireAtkArea()
	{
		while (true)
		{
			if (inLost_FireAtk || _actor.isUnparalleled)
			{
				if (areaId_FireAtk != 0L)
				{
					ILRuntimeAPI.StopAreaEffect(areaId_FireAtk);
					areaId_FireAtk = 0L;
				}
			}
			else if (areaId_FireAtk == 0L)
			{
				areaId_FireAtk = ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_ChuShi_FireRing", _actor.tsTransform.Position, default, (AreaEffectEntity entity) =>
				{
					AreaEffect_FollowComponent areaEffect_FollowComponent = entity.AddOrGetMonoLogicComponent<AreaEffect_FollowComponent>();
					areaEffect_FollowComponent.targetType = AreaEffect_FollowComponent.FollowTargetType.Owner;
					areaEffect_FollowComponent.isSlowMove = false;
				});
			}
			yield return null;
		}
	}
}
