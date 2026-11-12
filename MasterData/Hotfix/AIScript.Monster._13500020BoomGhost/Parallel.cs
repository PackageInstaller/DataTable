using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._13500020BoomGhost;

public class Parallel : ParallelBase
{
	private int buffId_DarkMark = 5011;

	private int hitTag_boom = CommonHelper.StringToHash("BoomGhostAtk");

	private const int perkId_21 = 513521;

	private const int once_21 = 13521011;

	private int buffId_fate2_1 = 13580111;

	private int buffId_fate2_2 = 13580112;

	public int paramId_cd_fate = 13550001;

	public int paramId_prob_fate = 13550002;

	private PlayerAdventureActor summoner;

	private FP fateCD;

	public override void OnEnable()
	{
		base.OnEnable();
		fateCD = 0;
		summoner = (_actor as MonsterAdventureActor).monsterSummonInfo.SummonActor as PlayerAdventureActor;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		_actor.EnableSearchedImmunity();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		summoner = null;
		_actor.DisableSearchedImmunity();
	}

	public void OnUpdate()
	{
	}

	private void OnReceiveBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (_actor != null && adventureActorReceiveDamageBeforeHitEvent.from.Id == _actor.Id)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeHitEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnBeforeHit(adventureActorReceiveDamageBeforeHitEvent, monsterAdventureActor);
			}
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.from.Id)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnHitPost(adventureActorReceiveDamageEvent, monsterAdventureActor);
			}
		}
	}

	private void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_boom))
		{
			monster.buffComponent.AddBuff(buffId_DarkMark, _actor);
			if (GetPerkLv(513521, out var _))
			{
				AdventureActor.AddFromAttr(13521011, _actor);
			}
		}
	}

	private void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_boom))
		{
			monster.buffComponent.AddBuff(buffId_DarkMark, _actor);
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(summoner.dataID, perkId, out lv);
	}
}
