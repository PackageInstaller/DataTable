using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;

namespace AIScript.Monster._30931HaSaNa;

public class Parallel_BossRush : AIScript.Monster.Template.Parallel_BossRush
{
	private readonly string bossTagId = "100011";

	private readonly int skillCount = 1;

	private readonly int buff_1 = 631011010;

	private readonly int damageCount = 50;

	private readonly int buff_2 = 631011020;

	private readonly int sleepCount = 1;

	private List<int> skillIds = new List<int> { 3093101, 3093102, 3093103, 3093104, 3093109, 3093110 };

	private readonly int skillHitTag = CommonHelper.StringToHash("Melee");

	private const string bossTagId2 = "100018";

	private const int initStack = 8;

	private const int buff2 = 631018010;

	private const int buff3 = 631018020;

	private const int buff4 = 631018030;

	private const int countB = 6;

	private const int removeC = 1;

	private const int buff5 = 631018040;

	private const int buff6 = 631018050;

	private const int buff7 = 631018060;

	private bool hasTag;

	private int _sleepCount;

	private int mainSkillCount;

	private int assistDamageCount;

	private bool iBeHit;

	private bool hasTag2;

	private int normalAtkCount;

	private int skillAtkCount;

	private int elementMarkCount;

	public override void OnStart()
	{
		base.OnStart();
		_sleepCount = 0;
		mainSkillCount = 0;
		assistDamageCount = 0;
		iBeHit = false;
		hasTag = _actor.CheckTag(bossTagId);
		hasTag2 = _actor.CheckTag("100018");
		normalAtkCount = 0;
		skillAtkCount = 0;
		elementMarkCount = 0;
		if (hasTag2)
		{
			_actor.buffComponent?.AddBuffNum(631018010, 8, _actor);
			_actor.buffComponent?.AddBuffNum(631018020, 8, _actor);
			_actor.buffComponent?.AddBuffNum(631018030, 8, _actor);
		}
		_actor.ActiveDefaultModelGroup();
		_actor.actorScaleInfo.colliderScale = _actor.actorScaleInfo.originColliderScale;
		_actor.ResumeAnimationGroup();
		OcclusionRendererOccluder[] componentsInChildren = _actor.GetComponentsInChildren<OcclusionRendererOccluder>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].gameObject.SetActive(value: false);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	protected override void OnActorCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnActorCastSkill(castSkillEvent);
		if (_actor != null && castSkillEvent.sender as AdventureActor == _actor && skillIds.Contains(castSkillEvent.skillEventInfo.skillId))
		{
			iBeHit = false;
		}
		if (!hasTag || !(mainActor != null) || !(castSkillEvent.sender as AdventureActor == mainActor) || castSkillEvent.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.B)
		{
			return;
		}
		mainSkillCount++;
		if (mainSkillCount < skillCount)
		{
			return;
		}
		mainSkillCount = 0;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.isAssist)
			{
				playerAdventureActor.buffComponent?.AddBuff(buff_1, mainActor);
			}
		}
	}

	protected override void OnActorReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (damageEvent.to is PlayerAdventureActor && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, skillHitTag))
		{
			iBeHit = true;
		}
		if (hasTag2 && damageEvent.from as AdventureActor == mainActor)
		{
			HotfixEnum.damageType damageType = damageEvent.damageType;
			if (damageType == HotfixEnum.damageType.NORMAL)
			{
				HandleFatigueCount(ref normalAtkCount, 631018010, 631018040);
			}
			if (damageType == HotfixEnum.damageType.SKILL)
			{
				HandleFatigueCount(ref skillAtkCount, 631018020, 631018050);
			}
			if (damageType == HotfixEnum.damageType.MARK)
			{
				HandleFatigueCount(ref elementMarkCount, 631018030, 631018060);
			}
		}
		if (hasTag)
		{
			if (damageEvent.from.IsPlayerMinion(out var summoner) && summoner.isAssist)
			{
				assistDamageCount++;
			}
			else if (damageEvent.from is PlayerAdventureActor { isAssist: not false })
			{
				assistDamageCount++;
			}
			if (assistDamageCount >= damageCount && mainActor != null)
			{
				assistDamageCount = 0;
				mainActor.buffComponent?.AddBuff(buff_2, mainActor);
			}
		}
	}

	protected override void OnActorCastEndSkill(AdventureActorCastSkillEndEvent castSkillEvent)
	{
		base.OnActorCastEndSkill(castSkillEvent);
		if (_actor != null && castSkillEvent.sender as AdventureActor == _actor && skillIds.Contains(castSkillEvent.skillEventInfo.skillId) && !iBeHit && _monster.CheckScoreBossBehaviour(22))
		{
			_monster.TriggerScoreBossBehaviour(22);
		}
	}

	private void HandleFatigueCount(ref int counter, int countBuff, int gainBuff)
	{
		counter++;
		if (counter >= 6)
		{
			counter = 0;
			if (_actor.buffComponent.GetBuffNumByID(countBuff) > 0)
			{
				_actor.buffComponent.RemoveBuffByBuffId(countBuff, 1);
			}
			else
			{
				_actor.buffComponent?.AddBuff(gainBuff, _actor);
			}
		}
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = evt as AdventureActorCustomEvent;
		if (!(adventureActorCustomEvent.actor == null) && adventureActorCustomEvent.eventHashCode == 3093101)
		{
			_sleepCount++;
			if (_sleepCount >= sleepCount && _monster.CheckScoreBossBehaviour(14))
			{
				_sleepCount = 0;
				_monster.TriggerScoreBossBehaviour(14);
			}
		}
	}
}
