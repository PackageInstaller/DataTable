using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._12101;

public abstract class ParallelScript : ParallelBase
{
	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent { from: PlayerAdventureActor playerAdventureActor } adventureActorReceiveDamageEvent && playerAdventureActor == _actor && adventureActorReceiveDamageEvent.to is MonsterAdventureActor monster)
		{
			OnSelfDamaged(adventureActorReceiveDamageEvent, monster);
		}
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent, MonsterAdventureActor monster)
	{
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config.hitTag_TriggerFire))
		{
			TriggerFireMark(monster);
		}
	}

	private void TriggerFireMark(MonsterAdventureActor monster)
	{
		if (CommonUtils.CheckElementMark(CommonDefine.Fire, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
		{
			monster.buffComponent.RemoveBuffByTag(CommonDefine.FireMark1);
			CommonUtils.TriggerElementMarkEvent(CommonDefine.Fire, HotfixEnum.AdventureActorElementTriggerType.FireElementTriggerType2, _actor, monster, "FireMark_Trigger_Effect_02");
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_114_FireTag1_Boom", monster.tsTransform.Position);
		}
	}
}
