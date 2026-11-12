using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Monster.Soldier._118;

public class Parallel : AIBase
{
	private int PotentialLv = 1;

	public void OnEnable()
	{
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	private void OnDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && PotentialLv >= 3 && !(adventureActorReceiveDamageEvent.from as AdventureActor != _actor) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, SupportSkill.hitTag_bullet) && adventureActorReceiveDamageEvent.to is AdventureActor adventureActor)
		{
			int num = _actor.logicVariable.GetLogicTagValue("areaEffectCount_p3").AsInt();
			if (num <= 0)
			{
				_actor.logicVariable.SetLogicTagValue("areaEffectCount_p3", num += 1);
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_Soldier_118_Support_Dot", adventureActor.tsTransform.Position);
			}
		}
	}
}
