using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._145;

public class Parallel : AIBase
{
	private readonly int _hitTagBullet = CommonHelper.StringToHash("Bullet_Skill_Soldier_145_Main");

	private readonly string _areaEffectKey = "AreaEffect_Soldier_145_MainSkill_BulletBoom";

	private readonly int HitTag_SteelRain = CommonHelper.StringToHash("Soldier_145_Support_SteelRain");

	private const string AreaEffectKey_Potential3Ex = "AreaEffect_Soldier_145_Support_ex";

	private const int TriggerPercent_Potential3 = 30;

	public void OnEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	private void OnDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && !(adventureActorReceiveDamageEvent.from != _actor) && adventureActorReceiveDamageEvent.hitDamageTag != null && adventureActorReceiveDamageEvent.to is SoldierActor soldierActor && soldierActor.actorHealthInfo.isAlive)
		{
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, HitTag_SteelRain))
			{
				OnSteelRainDamage(soldierActor);
			}
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, _hitTagBullet))
			{
				TSVector2 position = soldierActor.tsTransform.Position;
				TSVector2 position2 = _actor.tsTransform.Position;
				TSVector2 normalized = (position - position2).normalized;
				ILRuntimeAPI.PlayAreaEffect(_actor, _areaEffectKey, position, normalized.GetAngle());
			}
		}
	}

	private void OnSteelRainDamage(SoldierActor target)
	{
		if (TSRandom.Range(0, 100) < 30)
		{
			TSVector2 position = target.tsTransform.Position;
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_Soldier_145_Support_ex", position);
		}
	}
}
