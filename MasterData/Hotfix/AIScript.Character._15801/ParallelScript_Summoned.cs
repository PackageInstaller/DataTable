using System.Collections;
using AIScript.Utils;

namespace AIScript.Character._15801;

public class ParallelScript_Summoned : AIBase
{
	protected PlayerAdventureActor _summoner;

	public virtual void OnEnable()
	{
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent != null)
		{
			_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		}
		_actor.EnableUnparalleled();
		_actor.EnableImmuneControl();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	private void OnBattleReady(IEvent _)
	{
		OnBattleReady();
	}

	protected virtual void OnBattleReady()
	{
	}

	private void OnGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff { sender: PlayerAdventureActor sender } adventureActorGetBuff && sender == _summoner)
		{
			OnSummonerGetBuff(adventureActorGetBuff);
		}
	}

	protected virtual void OnSummonerGetBuff(AdventureActorGetBuff getBuffEvent)
	{
	}

	private void OnRemoveBuff(IEvent evt)
	{
		if (evt is AdventureActorRemoveBuff { sender: PlayerAdventureActor sender } adventureActorRemoveBuff && sender == _summoner)
		{
			OnSummonerRemoveBuff(adventureActorRemoveBuff);
		}
	}

	protected virtual void OnSummonerRemoveBuff(AdventureActorRemoveBuff removeBuffEvent)
	{
	}

	private void OnBeforeHit(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent && adventureActorReceiveDamageBeforeHitEvent.from == _actor && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor monsterAdventureActor)
		{
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_summoner.dataID, 3) && (monsterAdventureActor.IsBossMonster() || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE))
			{
				AdventureActor.AddFromAttr(15896511, _summoner);
			}
			OnSelfBeforeHit(adventureActorReceiveDamageBeforeHitEvent);
		}
	}

	protected virtual void OnSelfBeforeHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && adventureActorReceiveDamageEvent.from == _actor && adventureActorReceiveDamageEvent.to is MonsterAdventureActor)
		{
			OnSelfDamaged(adventureActorReceiveDamageEvent);
		}
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	protected void DestroySelf()
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
		_actor.DestroySelf();
	}

	protected bool HavePersonalPerk(int perkId, out int perkLevel)
	{
		perkLevel = 0;
		if (_summoner == null)
		{
			return false;
		}
		return CommonUtils.HavePersonalPerk(_summoner.dataID, perkId, out perkLevel);
	}

	public virtual void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		_actor.DisableUnparalleled();
		_actor.DisableImmuneControl();
	}
}
