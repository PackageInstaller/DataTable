using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13001;

public class ParallelScript_Summoned : AIBase
{
	private PlayerAdventureActor _summoner;

	private PlayFX _playFX;

	private FP _lastTriggerTime_9;

	public void OnEnable()
	{
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent != null)
		{
			_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		}
		_lastTriggerTime_9 = 0;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_REMOVE_SHIELD", OnRemoveShield);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (adventureActorReceiveDamageBeforeHitEvent.from == _actor && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_Summon))
		{
			AdventureActor.AddFromAttr(13093002, _actor);
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(adventureActorReceiveDamageEvent.to is MonsterAdventureActor))
		{
			return;
		}
		_ = adventureActorReceiveDamageEvent.to;
		bool flag = adventureActorReceiveDamageEvent.from == _actor;
		bool flag2 = adventureActorReceiveDamageEvent.from == _summoner;
		if (!(flag | flag2) || !(_summoner != null) || !ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_summoner.dataID, 513009, out var _))
		{
			return;
		}
		FP scriptValue = CommonUtils.GetScriptValue(_summoner, 13009011);
		if ((!(_lastTriggerTime_9 <= 0) && !(_actor.LogicTime - _lastTriggerTime_9 > scriptValue)) || !_actor.actorHealthInfo.isAlive)
		{
			return;
		}
		_actor.effectManage.AddEffectByAI(13009012);
		_actor.buffComponent?.AddBuff(13009011, _actor);
		if (!string.IsNullOrEmpty("fx_13001_base_B1_Skill_Summon_Perk09_Healing"))
		{
			if (_playFX == null)
			{
				_playFX = new PlayFX();
			}
			else
			{
				_playFX.Clear();
			}
			_playFX.Play(_actor, null, "fx_13001_base_B1_Skill_Summon_Perk09_Healing", 0, _actor.tsTransform.Position, TSVector2.zero);
		}
		_lastTriggerTime_9 = _actor.LogicTime;
	}

	private void OnRemoveShield(IEvent evt)
	{
		if (evt is AdventureActorRemoveShield adventureActorRemoveShield && adventureActorRemoveShield.sender as AdventureActor == _actor && _summoner != null && CommonUtils.HavePersonalPerk(_summoner.dataID, 513010, out var perkLevel) && adventureActorRemoveShield.shieldId == 13010001)
		{
			string fxAlias = "AreaEffect_130_Main_Skill_P10_Shield_Boom";
			if (_summoner != null && CommonUtils.HavePersonalPerk(_summoner.dataID, 513008, out perkLevel))
			{
				fxAlias = "AreaEffect_130_Main_Skill_P10_Shield_Boom_Strengthen";
			}
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, _actor.tsTransform.Position);
		}
	}

	private void OnBattleReady(IEvent evt)
	{
		if (_actor.state == ActorState.Spawn)
		{
			_actor.StartLogicCoroutine(WaitForDestroySelf());
		}
		else
		{
			_actor.DestroySelf();
		}
	}

	private IEnumerator WaitForDestroySelf()
	{
		while (_actor.state == ActorState.Spawn)
		{
			yield return null;
		}
		_actor.logicVariable.ToggleLogicTag("BattleReadyDestroySelf_Summon", value: true);
		_actor.DestroySelf();
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_SHIELD", OnRemoveShield);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		_playFX?.Clear();
		_lastTriggerTime_9 = 0;
		_summoner = null;
	}
}
