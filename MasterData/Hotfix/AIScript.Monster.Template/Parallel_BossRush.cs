using System.Collections.Generic;
using System.Linq;
using TrueSync;

namespace AIScript.Monster.Template;

public class Parallel_BossRush : Parallel
{
	private static readonly FP triggerTime_ContinuousAttack = 5;

	private static readonly FP interruptTime_ContinuousAttack = 1;

	protected AdventureActor mainActor;

	protected MonsterAdventureActor _monster;

	private List<FP> _receiveDamageTimeList;

	public override void OnStart()
	{
		base.OnStart();
		_monster = _actor as MonsterAdventureActor;
		mainActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnActorCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnActorCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnMonsterToughtnessStateChange);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
	}

	private void OnActorCastSkill(IEvent evt)
	{
		if (!(evt is AdventureActorCastSkillEvent adventureActorCastSkillEvent))
		{
			return;
		}
		if (adventureActorCastSkillEvent.sender as AdventureActor is PlayerAdventureActor playerAdventureActor)
		{
			if (adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
			{
				if (_monster.CheckScoreBossBehaviour(10))
				{
					_monster.TriggerScoreBossBehaviour(10);
				}
			}
			else if (playerAdventureActor.isAssist && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && _monster.CheckScoreBossBehaviour(9))
			{
				_monster.TriggerScoreBossBehaviour(9);
			}
		}
		OnActorCastSkill(adventureActorCastSkillEvent);
	}

	private void OnActorCastSkillEnd(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEndEvent castSkillEndEvent)
		{
			OnActorCastEndSkill(castSkillEndEvent);
		}
	}

	protected virtual void OnActorCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
	}

	protected virtual void OnActorCastEndSkill(AdventureActorCastSkillEndEvent castSkillEndEvent)
	{
	}

	private void OnMonsterToughtnessStateChange(IEvent evt)
	{
		if (evt is MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent)
		{
			if (monsterToughnessStateChangeEvent.actor == _actor && monsterToughnessStateChangeEvent.isToughnessBroken && _monster.CheckScoreBossBehaviour(7))
			{
				_monster.TriggerScoreBossBehaviour(7);
			}
			OnMonsterToughtnessStateChange(monsterToughnessStateChangeEvent);
		}
	}

	protected virtual void OnMonsterToughtnessStateChange(MonsterToughnessStateChangeEvent toughtnessStateChangeEvent)
	{
	}

	private void OnActorReceiveDamage(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent))
		{
			return;
		}
		if (adventureActorReceiveDamageEvent.to == _actor && _monster.CheckScoreBossBehaviour(8))
		{
			if (_receiveDamageTimeList == null)
			{
				_receiveDamageTimeList = new List<FP>();
			}
			if (_receiveDamageTimeList.Count > 0)
			{
				FP fP = _receiveDamageTimeList.Last();
				if (_actor.LogicTime - fP > interruptTime_ContinuousAttack)
				{
					_receiveDamageTimeList.Clear();
				}
				else
				{
					FP fP2 = _receiveDamageTimeList.First();
					if (_actor.LogicTime - fP2 > triggerTime_ContinuousAttack)
					{
						_monster.TriggerScoreBossBehaviour(8);
						_receiveDamageTimeList.Clear();
					}
				}
			}
			_receiveDamageTimeList.Add(_actor.LogicTime);
		}
		OnActorReceiveDamage(adventureActorReceiveDamageEvent);
	}

	protected virtual void OnActorReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		if (!(evt is AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent))
		{
			return;
		}
		if (adventureElementMarkTriggerEvent.markActor == _actor)
		{
			switch (adventureElementMarkTriggerEvent.elementType)
			{
			case HotfixEnum.elementType.WE:
				if (_monster.CheckScoreBossBehaviour(3))
				{
					_monster.TriggerScoreBossBehaviour(3);
				}
				break;
			case HotfixEnum.elementType.FE:
				if (_monster.CheckScoreBossBehaviour(2))
				{
					_monster.TriggerScoreBossBehaviour(2);
				}
				break;
			case HotfixEnum.elementType.SE:
				if (_monster.CheckScoreBossBehaviour(1))
				{
					_monster.TriggerScoreBossBehaviour(1);
				}
				break;
			case HotfixEnum.elementType.AE:
				if (_monster.CheckScoreBossBehaviour(4))
				{
					_monster.TriggerScoreBossBehaviour(4);
				}
				break;
			case HotfixEnum.elementType.LE:
				if (_monster.CheckScoreBossBehaviour(5))
				{
					_monster.TriggerScoreBossBehaviour(5);
				}
				break;
			case HotfixEnum.elementType.DE:
				if (_monster.CheckScoreBossBehaviour(6))
				{
					_monster.TriggerScoreBossBehaviour(6);
				}
				break;
			}
		}
		OnElementMarkTrigger(adventureElementMarkTriggerEvent);
	}

	protected virtual void OnElementMarkTrigger(AdventureElementMarkTriggerEvent elementMarkTriggerEvent)
	{
	}

	protected virtual void OnReceiveBeforeHit(IEvent evt)
	{
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnActorCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnActorCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnMonsterToughtnessStateChange);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		_receiveDamageTimeList?.Clear();
	}
}
