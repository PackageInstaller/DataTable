using AdventureBehaviour;
using TrueSync;

namespace AIScript.Utils;

public class PassiveSkill_ListenEvent_CircleDamage
{
	private AdventureActor _actor;

	private AdventureSkill _skill;

	private int _hitDamageId;

	private FP _circleRadius;

	public void OnEnable(AdventureActor actor, AdventureSkill skill, int hitdamageId, FP circleRadius)
	{
		_actor = actor;
		_skill = skill;
		_hitDamageId = hitdamageId;
		_circleRadius = circleRadius;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	private void OnDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && !(adventureActorReceiveDamageEvent.from != _actor) && adventureActorReceiveDamageEvent.hitDamageId != _hitDamageId)
		{
			CommomAreaHitConfig commomAreaHitConfig = new CommomAreaHitConfig();
			commomAreaHitConfig.hitDamageId = _hitDamageId;
			commomAreaHitConfig.position = ((AdventureActor)adventureActorReceiveDamageEvent.to).tsTransform.Position;
			ILRuntimeAPI.CircleAreaHit(_actor, commomAreaHitConfig, _circleRadius, 0);
			_skill.Clear();
		}
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}
}
