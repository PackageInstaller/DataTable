using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_115 : SoldierPartnerBase
{
	private const int _critDmgBuffId = 260111511;

	private static readonly FP _critThreshold = 0.7;

	private const HotfixEnum.ChessPartnerType partnerType = HotfixEnum.ChessPartnerType.BaiBuChuanYang;

	private SoldierLevelController _levelCtrl;

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (_levelCtrl != null)
		{
			partnerLv = _levelCtrl.GetPartnerLv(HotfixEnum.ChessPartnerType.BaiBuChuanYang);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnBeforeSettlement);
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnBeforeSettlement);
		_levelCtrl = null;
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (partnerLv >= 3 && damageEvent.isCrit)
		{
			SoldierActor soldierActor = damageEvent.from as SoldierActor;
			if (!(soldierActor == null) && !soldierActor.isEnemyCamp && !soldierActor.isDead && soldierActor.HasPartnerType(HotfixEnum.ChessPartnerType.BaiBuChuanYang) && !(soldierActor.buffComponent == null))
			{
				soldierActor.buffComponent.AddBuffNum(260111511, 1, soldierActor);
			}
		}
	}

	private void OnBeforeSettlement(IEvent evt)
	{
		if (partnerLv < 4 || !(evt is AdventureActorReceiveDamageBeforeSettlementEvent adventureActorReceiveDamageBeforeSettlementEvent))
		{
			return;
		}
		SoldierActor soldierActor = adventureActorReceiveDamageBeforeSettlementEvent.from as SoldierActor;
		if (!(soldierActor == null) && !soldierActor.isEnemyCamp && !soldierActor.isDead && soldierActor.HasPartnerType(HotfixEnum.ChessPartnerType.BaiBuChuanYang))
		{
			SoldierActor soldierActor2 = adventureActorReceiveDamageBeforeSettlementEvent.to as SoldierActor;
			if (!(soldierActor2 == null) && !soldierActor2.isDead && soldierActor2.isEnemyCamp && !((FP)soldierActor2.actorHealthInfo.hpPercentage > _critThreshold))
			{
				AdventureActor.SetFromForceCrit(val: true);
			}
		}
	}
}
