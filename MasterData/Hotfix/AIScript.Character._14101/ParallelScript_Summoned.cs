using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14101;

public class ParallelScript_Summoned : AIBase
{
	protected PlayerAdventureActor _summoner;

	private bool _isValid;

	private CoroutineNode _perkLogicCor_P28;

	private FP _lastTriggerTime_P29;

	private bool IsValid
	{
		get
		{
			return _isValid;
		}
		set
		{
			if (value == _isValid)
			{
				return;
			}
			_isValid = value;
			if (_summoner != null)
			{
				int num = _summoner.logicVariable.GetLogicTagValue("SummonedCount").AsInt();
				if (_isValid)
				{
					num++;
					_actor.logicVariable.ToggleLogicTag("IsFirstSummoned", num == 1);
				}
				else
				{
					num--;
					_actor.logicVariable.ToggleLogicTag("IsFirstSummoned", value: false);
				}
				_summoner.logicVariable.SetLogicTagValue("SummonedCount", num);
			}
		}
	}

	public virtual void OnEnable()
	{
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent != null)
		{
			_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		}
		IsValid = true;
		_actor.EnableUnparalleled();
		_actor.EnableCloseBlock();
		if (HavePersonalPerk(514121))
		{
			_actor.buffComponent.AddBuff(14121011, _summoner);
		}
		if (HavePersonalPerk(514128))
		{
			_perkLogicCor_P28 = _actor.StartLogicCoroutine(PerkLogic_P28());
		}
		if (HavePersonalPerk(514131))
		{
			_actor.buffComponent.AddBuff(14131011, _summoner);
		}
		_lastTriggerTime_P29 = 0;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
	}

	protected bool HavePersonalPerk(int perkId)
	{
		if (_summoner == null)
		{
			return false;
		}
		int perkLevel;
		return CommonUtils.HavePersonalPerk(_summoner.dataID, perkId, out perkLevel);
	}

	private IEnumerator PerkLogic_P28()
	{
		FP interval = Config_Support.addBuffInterval_P28;
		while (IsValid)
		{
			if (interval > 0)
			{
				interval -= _actor.LogicDeltaTime;
			}
			else
			{
				_actor.buffComponent.AddBuff(14128011, _summoner);
				interval = Config_Support.addBuffInterval_P28;
			}
			yield return null;
		}
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (adventureActorReceiveDamageBeforeHitEvent.from == _actor && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor bEntity && HavePersonalPerk(514130) && _actor.DistanceWithRadius(bEntity) <= Config_Support.triggerRadius_P30)
		{
			AdventureActor.AddFromAttr(14130001, _summoner);
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(adventureActorReceiveDamageEvent.from == _actor) || !(adventureActorReceiveDamageEvent.to is MonsterAdventureActor bEntity) || !HavePersonalPerk(514129) || (!(_lastTriggerTime_P29 <= 0) && !(_actor.LogicTime - _lastTriggerTime_P29 > Config_Support.triggerCD_P29)))
		{
			return;
		}
		foreach (LogicEntity item in ILRuntimeAPI.SearchAllFriendActors(_summoner, includeSelf: true))
		{
			if (item is AdventureActor adventureActor && adventureActor.DistanceWithRadius(bEntity) <= Config_Support.triggerRadius_P29)
			{
				adventureActor.buffComponent.AddBuff(14129011, _summoner);
			}
		}
		_lastTriggerTime_P29 = _actor.LogicTime;
	}

	private void OnCastSkill(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEvent { sender: PlayerAdventureActor sender } adventureActorCastSkillEvent && sender == _summoner && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			DestroySelf();
		}
	}

	private void OnBattleReady(IEvent evt)
	{
		DestroySelf();
	}

	private void DestroySelf()
	{
		if (_actor.state == ActorState.Spawn)
		{
			_actor.StartLogicCoroutine(WaitForDestroySelf());
		}
		else
		{
			_actor.DestroySelf();
		}
		IsValid = false;
	}

	private IEnumerator WaitForDestroySelf()
	{
		while (_actor.state == ActorState.Spawn)
		{
			yield return null;
		}
		_actor.DestroySelf();
	}

	public virtual void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		IsValid = false;
		_actor.DisableUnparalleled();
		_actor.DisableCloseBlock();
		if (_perkLogicCor_P28 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P28);
		}
		_perkLogicCor_P28 = null;
		_lastTriggerTime_P29 = 0;
	}
}
