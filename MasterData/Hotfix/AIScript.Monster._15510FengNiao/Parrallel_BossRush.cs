using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Parrallel_BossRush : Parallel_BossRush
{
	private readonly int checkHitTime = 1;

	private readonly int skill_U;

	private readonly int hit_count = 2;

	private readonly int flowerFlyHitTag = CommonHelper.StringToHash("BirdStraightShoot");

	private readonly FP checkDuration = 3;

	private readonly string bossTagId = "100008";

	private readonly int beHitCount = 20;

	private readonly int buff_point = 631009010;

	private readonly FP triggerElementCd = 6;

	private readonly int triggerCount = 2;

	private readonly int bossBuff = 631009020;

	private readonly FP checkCd = 15;

	private string xsTagId = "100020";

	private int interval_xs = 1;

	private int buff_xs_self = 631020010;

	private int buff_xs_main_1 = 631020010;

	private int buff_xs_main_2 = 631020020;

	private bool isHit_begin;

	private int iHit_SucsCount;

	private FP checkTime_p3;

	private bool iBeFlyHit;

	private CoroutineNode corWait;

	private Dictionary<long, FP> beHitTimes = new Dictionary<long, FP>();

	private bool hasTag;

	private int _beHitCount;

	private int _triggerCount;

	private FP _triggerTime;

	private FP _checkCd;

	private bool hasXsTag;

	private CoroutineNode corXs;

	public override void OnStart()
	{
		base.OnStart();
		beHitTimes?.Clear();
		isHit_begin = false;
		iHit_SucsCount = 0;
		checkTime_p3 = 0;
		iBeFlyHit = false;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		hasTag = _actor.CheckTag(bossTagId);
		_beHitCount = 0;
		_triggerCount = 0;
		_triggerTime = 0;
		_checkCd = 0;
		if (hasTag)
		{
			StartCoroutine(ref corWait, DoCheckWait());
		}
		hasXsTag = _actor.CheckTag(xsTagId);
		if (hasXsTag)
		{
			StartCoroutine(ref corXs, DoXuShi());
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		beHitTimes?.Clear();
		StopCoroutine(ref corWait);
		StopCoroutine(ref corXs);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	private IEnumerator DoXuShi()
	{
		while (_actor.state != ActorState.Action)
		{
			yield return null;
		}
		List<PlayerAdventureActor> assists = new List<PlayerAdventureActor>();
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.isAssist)
			{
				assists.Add(playerAdventureActor);
			}
		}
		if (assists.Count == 0)
		{
			yield break;
		}
		int[] buffMainMap = new int[assists.Count];
		buffMainMap[0] = buff_xs_main_1;
		if (assists.Count > 1)
		{
			buffMainMap[1] = buff_xs_main_2;
		}
		FP[] timers = new FP[assists.Count];
		while (true)
		{
			PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
			for (int j = 0; j < assists.Count; j++)
			{
				PlayerAdventureActor playerAdventureActor2 = assists.get_Item(j);
				if (playerAdventureActor2 == null || playerAdventureActor2.IsDead())
				{
					continue;
				}
				if (playerAdventureActor2.isResident)
				{
					timers[j] += _actor.LogicDeltaTime;
					if (timers[j] >= interval_xs)
					{
						timers[j] = 0;
						playerAdventureActor2.buffComponent.AddBuff(buff_xs_self, playerAdventureActor2);
						if (activedPlayerActor != null && !activedPlayerActor.IsDead())
						{
							activedPlayerActor.buffComponent.AddBuff(buffMainMap[j], playerAdventureActor2);
						}
					}
				}
				else
				{
					timers[j] = 0;
				}
			}
			yield return null;
		}
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = evt as AdventureActorCustomEvent;
		if (adventureActorCustomEvent.actor == null)
		{
			return;
		}
		if (adventureActorCustomEvent.eventHashCode == 155101)
		{
			if (beHitTimes.ContainsKey(adventureActorCustomEvent.actor.Id))
			{
				beHitTimes.set_Item(adventureActorCustomEvent.actor.Id, _actor.LogicTime);
			}
			else
			{
				beHitTimes.Add(adventureActorCustomEvent.actor.Id, _actor.LogicTime);
			}
		}
		else if (adventureActorCustomEvent.eventHashCode == 155103)
		{
			checkTime_p3 = checkDuration;
			iBeFlyHit = false;
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent elementMarkTriggerEvent)
	{
		if (hasTag && elementMarkTriggerEvent.markActor != null && elementMarkTriggerEvent.markActor.Id == _actor.Id && !(_checkCd > 0))
		{
			if (_triggerTime <= 0)
			{
				_triggerTime = _actor.LogicTime;
			}
			if (_actor.LogicTime - _triggerTime > triggerElementCd)
			{
				_triggerCount = 0;
				_triggerTime = _actor.LogicTime;
			}
			_triggerCount++;
			if (_triggerCount >= triggerCount)
			{
				_checkCd = checkCd;
				_triggerCount = 0;
				_triggerTime = _actor.LogicTime;
				_actor.buffComponent.RemoveBuffByBuffId(buff_point);
				_actor.buffComponent.AddBuff(bossBuff, _actor);
			}
		}
	}

	protected override void OnActorReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (damageEvent.to is MonsterAdventureActor monsterAdventureActor)
		{
			if (beHitTimes.TryGetValue(monsterAdventureActor.Id, out var value) && _actor.LogicTime - value < checkHitTime)
			{
				beHitTimes.Remove(monsterAdventureActor.Id);
				if (isHit_begin)
				{
					iHit_SucsCount++;
				}
				if (_monster.CheckScoreBossBehaviour(20))
				{
					_monster.TriggerScoreBossBehaviour(20);
				}
			}
			if (hasTag && monsterAdventureActor.Id == _actor.Id)
			{
				_beHitCount++;
				if (_beHitCount >= beHitCount)
				{
					_beHitCount = 0;
					_actor.buffComponent.AddBuff(buff_point, _actor);
				}
			}
		}
		else if (damageEvent.to is PlayerAdventureActor)
		{
			isHit_begin = false;
			if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, flowerFlyHitTag))
			{
				iBeFlyHit = true;
			}
		}
	}

	protected override void OnActorCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnActorCastSkill(castSkillEvent);
		if (_actor != null && castSkillEvent.sender as AdventureActor == _actor && castSkillEvent.skillEventInfo.skillId == skill_U)
		{
			isHit_begin = true;
			iHit_SucsCount = 0;
		}
	}

	protected override void OnActorCastEndSkill(AdventureActorCastSkillEndEvent castSkillEvent)
	{
		base.OnActorCastEndSkill(castSkillEvent);
		if (_actor != null && castSkillEvent.sender as AdventureActor == _actor && castSkillEvent.skillEventInfo.skillId == skill_U && isHit_begin)
		{
			isHit_begin = false;
			if (iHit_SucsCount >= hit_count && _monster.CheckScoreBossBehaviour(21))
			{
				_monster.TriggerScoreBossBehaviour(21);
			}
		}
	}

	private IEnumerator DoCheckWait()
	{
		while (true)
		{
			if (hasTag && _checkCd > 0)
			{
				_checkCd -= _actor.LogicDeltaTime;
			}
			if (checkTime_p3 > 0)
			{
				checkTime_p3 -= _actor.LogicDeltaTime;
				if (checkTime_p3 < 0 && !iBeFlyHit && _monster.CheckScoreBossBehaviour(22))
				{
					_monster.TriggerScoreBossBehaviour(22);
				}
			}
			yield return null;
		}
	}
}
