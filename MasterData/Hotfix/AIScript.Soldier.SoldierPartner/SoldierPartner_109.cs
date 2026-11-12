using System.Collections.Generic;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_109 : SoldierPartnerBase
{
	private const HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.HuiFengJuLeBu;

	private const int ONCE_DMG_BONUS_ID = 260110911;

	private const int BUFF_ID_SIEGE_L1 = 260110911;

	private const int BUFF_ID_SIEGE_L2 = 260110912;

	private const int BUFF_ID_ATK_BONUS = 260110921;

	private const int BUFF_ID_SIEGE_L3 = 260110913;

	private const int BUFF_ID_ATK_BOOST_L3 = 260110931;

	private static readonly FP ENERGY_BONUS_PER_SIEGE_UNIT = 0.2;

	private static readonly FP SUPPORT_ENERGY_BONUS_L4 = 1.0;

	private SoldierLevelController _levelCtrl;

	private List<SoldierActor> _actorBuffer = new List<SoldierActor>();

	private List<(SoldierActor actor, FP delta)> _supportRatePatched = new List<(SoldierActor, FP)>();

	private Dictionary<long, FP> _appliedSiegeDelta = new Dictionary<long, FP>();

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (_levelCtrl != null)
		{
			partnerLv = _levelCtrl.GetPartnerLv(HotfixEnum.ChessPartnerType.HuiFengJuLeBu);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnCanCauseDead);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnBeforeSettlement);
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnCanCauseDead);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnBeforeSettlement);
		for (int i = 0; i < _supportRatePatched.Count; i++)
		{
			var (soldierActor, fP) = _supportRatePatched.get_Item(i);
			if (soldierActor != null)
			{
				soldierActor.ModifyEnergyRecoverRatePercent(-fP);
			}
		}
		_supportRatePatched.Clear();
		SoldierActor soldierActor2 = _levelCtrl?.mainControlActor;
		if (soldierActor2 != null)
		{
			List<SoldierActor> allActors = _levelCtrl.GetAllActors(soldierActor2, _actorBuffer);
			for (int j = 0; j < allActors.Count; j++)
			{
				SoldierActor soldierActor3 = allActors.get_Item(j);
				if (soldierActor3 != null && _appliedSiegeDelta.TryGetValue(soldierActor3.Id, out var value))
				{
					soldierActor3.ModifyEnergyRecoverRatePercent(-value);
				}
			}
		}
		_appliedSiegeDelta.Clear();
		_actorBuffer.Clear();
		_levelCtrl = null;
	}

	protected override void OnPartnerBattleStart()
	{
		base.OnPartnerBattleStart();
		if (_levelCtrl == null)
		{
			return;
		}
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (!(mainControlActor == null))
		{
			List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _actorBuffer);
			if (partnerLv >= 4)
			{
				ApplySupportEnergyBonus_L4(allActors);
			}
		}
	}

	private void ApplySupportEnergyBonus_L4(List<SoldierActor> allMembers)
	{
		for (int i = 0; i < allMembers.Count; i++)
		{
			SoldierActor soldierActor = allMembers.get_Item(i);
			if (!(soldierActor == null) && soldierActor.isSupport && soldierActor.HasPartnerType(HotfixEnum.ChessPartnerType.HuiFengJuLeBu))
			{
				soldierActor.ModifyEnergyRecoverRatePercent(SUPPORT_ENERGY_BONUS_L4);
				_supportRatePatched.Add((soldierActor, SUPPORT_ENERGY_BONUS_L4));
			}
		}
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (partnerLv < 1 || _levelCtrl == null)
		{
			return;
		}
		SoldierActor soldierActor = damageEvent.from as SoldierActor;
		if (soldierActor == null || soldierActor.isDead || !soldierActor.HasPartnerType(HotfixEnum.ChessPartnerType.HuiFengJuLeBu))
		{
			return;
		}
		SoldierActor soldierActor2 = damageEvent.to as SoldierActor;
		if (!(soldierActor2 == null) && !soldierActor2.isDead && !(soldierActor2.buffComponent == null) && soldierActor2.isEnemyCamp)
		{
			if (partnerLv == 1)
			{
				soldierActor2.buffComponent.AddBuffNum(260110911, 1, soldierActor);
			}
			else if (partnerLv == 2)
			{
				soldierActor2.buffComponent.AddBuffNum(260110912, 1, soldierActor);
				RecalcSiegeBonusAll();
			}
			else
			{
				soldierActor2.buffComponent.AddBuffNum(260110913, 1, soldierActor);
				RecalcSiegeBonusAll();
			}
		}
	}

	protected override void OnRemoveBuff(IEvent evt)
	{
		if (partnerLv < 2 || !(evt is AdventureActorRemoveBuff adventureActorRemoveBuff))
		{
			return;
		}
		int buffId = adventureActorRemoveBuff.eventInfo.buffId;
		if (buffId == 260110912 || buffId == 260110913)
		{
			SoldierActor soldierActor = adventureActorRemoveBuff.sender as SoldierActor;
			if (!(soldierActor == null) && soldierActor.isEnemyCamp && !soldierActor.isDead)
			{
				RecalcSiegeBonusAll();
			}
		}
	}

	private void OnBeforeSettlement(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageBeforeSettlementEvent adventureActorReceiveDamageBeforeSettlementEvent))
		{
			return;
		}
		SoldierActor soldierActor = adventureActorReceiveDamageBeforeSettlementEvent.from as SoldierActor;
		if (!(soldierActor == null) && !soldierActor.isEnemyCamp && !soldierActor.isDead && soldierActor.HasPartnerType(HotfixEnum.ChessPartnerType.HuiFengJuLeBu))
		{
			SoldierActor soldierActor2 = adventureActorReceiveDamageBeforeSettlementEvent.to as SoldierActor;
			if (!(soldierActor2 == null) && soldierActor2.isEnemyCamp && !(soldierActor2.buffComponent == null) && (soldierActor2.buffComponent.GetBuffNumByID(260110911) > 0 || soldierActor2.buffComponent.GetBuffNumByID(260110912) > 0 || soldierActor2.buffComponent.GetBuffNumByID(260110913) > 0))
			{
				AdventureActor.AddFromAttr(260110911, soldierActor);
			}
		}
	}

	private void OnCanCauseDead(IEvent evt)
	{
		if (_levelCtrl == null || partnerLv < 2 || !(evt is AdventureActorReceiveDamageCanCauseDeadEvent adventureActorReceiveDamageCanCauseDeadEvent))
		{
			return;
		}
		SoldierActor soldierActor = adventureActorReceiveDamageCanCauseDeadEvent.to as SoldierActor;
		if (soldierActor == null || soldierActor.buffComponent == null || !soldierActor.isEnemyCamp)
		{
			return;
		}
		int num = ((partnerLv == 2) ? 260110912 : 260110913);
		if (num > 0 && soldierActor.buffComponent.GetBuffNumByID(num) > 0)
		{
			RecalcSiegeBonusAll();
		}
		if (partnerLv >= 3 && soldierActor.buffComponent.GetBuffNumByID(260110913) > 0)
		{
			SoldierActor soldierActor2 = adventureActorReceiveDamageCanCauseDeadEvent.from as SoldierActor;
			if (soldierActor2 != null && !soldierActor2.isDead && soldierActor2.HasPartnerType(HotfixEnum.ChessPartnerType.HuiFengJuLeBu))
			{
				soldierActor2.buffComponent?.AddBuff(260110931, soldierActor2);
			}
		}
	}

	private void RecalcSiegeBonusAll()
	{
		if (_levelCtrl == null)
		{
			return;
		}
		int num = ((partnerLv == 2) ? 260110912 : 260110913);
		if (num <= 0)
		{
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(_levelCtrl.enemyMainControlActor, _actorBuffer);
		int num2 = 0;
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && !(soldierActor.buffComponent == null) && soldierActor.buffComponent.GetBuffNumByID(num) > 0)
			{
				num2++;
			}
		}
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return;
		}
		List<SoldierActor> allActors2 = _levelCtrl.GetAllActors(mainControlActor, _actorBuffer);
		for (int j = 0; j < allActors2.Count; j++)
		{
			SoldierActor soldierActor2 = allActors2.get_Item(j);
			if (soldierActor2 == null || soldierActor2.isDead || !soldierActor2.HasPartnerType(HotfixEnum.ChessPartnerType.HuiFengJuLeBu))
			{
				continue;
			}
			if (soldierActor2.buffComponent != null && soldierActor2.buffComponent.GetBuffNumByID(260110921) != num2)
			{
				soldierActor2.buffComponent.RemoveBuffByBuffId(260110921);
				if (num2 > 0)
				{
					soldierActor2.buffComponent.AddBuffNum(260110921, num2, soldierActor2);
				}
			}
			FP fP = num2 * ENERGY_BONUS_PER_SIEGE_UNIT;
			_appliedSiegeDelta.TryGetValue(soldierActor2.Id, out var value);
			FP fP2 = fP - value;
			if (fP2 != FP.Zero)
			{
				soldierActor2.ModifyEnergyRecoverRatePercent(fP2);
				_appliedSiegeDelta.set_Item(soldierActor2.Id, fP);
			}
		}
	}
}
