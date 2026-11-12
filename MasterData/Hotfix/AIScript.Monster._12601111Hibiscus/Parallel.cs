using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._12601111Hibiscus;

public class Parallel : ParallelBase
{
	private static readonly int firebirdTag = CommonHelper.StringToHash("126_A1");

	private static readonly int maskTag = CommonHelper.StringToHash("FireMark1");

	private readonly int perkId_8 = 512608;

	private readonly int buffId_8 = 12650811;

	private readonly int perkId_9 = 512609;

	private readonly int buffId_9 = 12650911;

	private readonly int perkId_10 = 512610;

	private readonly int prob_10 = 50;

	private readonly int buffId_10 = 1011;

	private readonly int buffId_fate1 = 12640001;

	private PlayerAdventureActor _summoner;

	public override void OnEnable()
	{
		base.OnEnable();
		CommonUtils_MonsterAPI.SetUnparalleledEnable(_actor);
		_actor.EnableSearchedImmunity();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent != null)
		{
			_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		}
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnReceiveHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
	}

	private void OnReceiveHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeSettlementEvent adventureActorReceiveDamageBeforeSettlementEvent = evt as AdventureActorReceiveDamageBeforeSettlementEvent;
		if (!(_actor != null) || !(adventureActorReceiveDamageBeforeSettlementEvent.from == _actor))
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeSettlementEvent.to as MonsterAdventureActor;
		if (monsterAdventureActor != null && adventureActorReceiveDamageBeforeSettlementEvent.hitDamageTag != null && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeSettlementEvent.hitDamageTag, firebirdTag))
		{
			if (GetPerkLv(perkId_8, out var lv))
			{
				monsterAdventureActor.buffComponent.AddBuff(buffId_8, _actor);
			}
			if (GetPerkLv(perkId_9, out lv))
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(buffId_9, _actor);
			}
			if (GetPerkLv(perkId_10, out lv) && TSRandom.Range(0, 100) < prob_10)
			{
				monsterAdventureActor.buffComponent.AddBuff(buffId_10, _actor);
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnReceiveHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		_summoner = null;
	}

	public bool GetPerkLv(int perkId, out int lv)
	{
		if (_summoner == null)
		{
			lv = 0;
			return false;
		}
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_summoner.dataID, perkId, out lv);
	}

	private void OnGetBuff(IEvent evt)
	{
		_ = (evt as AdventureActorGetBuff).from != _actor;
	}
}
