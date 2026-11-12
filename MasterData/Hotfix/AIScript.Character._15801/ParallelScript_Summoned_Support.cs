namespace AIScript.Character._15801;

public class ParallelScript_Summoned_Support : ParallelScript_Summoned
{
	public override void OnEnable()
	{
		base.OnEnable();
		if (HavePersonalPerk(515830, out var _))
		{
			_actor.buffComponent.AddBuff(15830011, _actor);
		}
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && adventureActorCustomEvent.eventHashCode == Config_Support.eventHashCode_SummonedDestroySelf)
		{
			DestroySelf();
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		if (!HavePersonalPerk(515830, out var _))
		{
			return;
		}
		_actor.buffComponent.AddBuff(15830012, _actor);
		if (!damageEvent.isCrit)
		{
			return;
		}
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (actorL.actorElementInfo.elementType == HotfixEnum.elementType.FE)
			{
				actorL.buffComponent.AddBuff(15830013, _actor);
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}
}
