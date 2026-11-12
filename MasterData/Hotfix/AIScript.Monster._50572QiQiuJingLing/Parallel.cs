using AIScript.Monster.Template;

namespace AIScript.Monster._50572QiQiuJingLing;

public class Parallel : AIScript.Monster.Template.Parallel
{
	public override void OnStart()
	{
		base.OnStart();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnRecieveDamage);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnRecieveDamage);
	}

	private void OnRecieveDamage(IEvent iEvt)
	{
		if (iEvt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && (adventureActorReceiveDamageEvent.sender as AdventureActor).Id == _actor.Id && adventureActorReceiveDamageEvent.hitDamageId == 50571041)
		{
			_actor.logicVariable.SetLogicTagValue("SkillMode", 1);
		}
	}
}
