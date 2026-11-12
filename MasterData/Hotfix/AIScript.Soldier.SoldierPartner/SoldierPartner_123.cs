using System.Collections.Generic;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_123 : SoldierPartnerBase
{
	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.LiMingJinWei;

	private const int buffId_ZhuiLie = 260112311;

	private const int buffId_ZhuiLie2 = 260112312;

	private static readonly FP energyChargePercent_2 = 0.4;

	private const int ENERGY_MIN_LV = 2;

	private SoldierLevelController _levelCtrl;

	private readonly List<SoldierActor> _memberBuffer = new List<SoldierActor>();

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (_levelCtrl != null)
		{
			partnerLv = _levelCtrl.GetPartnerLv(partnerTypes);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		_memberBuffer.Clear();
		_levelCtrl = null;
	}

	private void OnActorDied(IEvent evt)
	{
		if (!(evt is AdventureActorDiedEvent adventureActorDiedEvent) || adventureActorDiedEvent.actor == null || _levelCtrl == null)
		{
			return;
		}
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null || !adventureActorDiedEvent.actor.IsConfrontWith(mainControlActor))
		{
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _memberBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (soldierActor == null || soldierActor.isDead || soldierActor.buffComponent == null || !soldierActor.HasPartnerType(partnerTypes))
			{
				continue;
			}
			soldierActor.buffComponent.AddBuffNum(260112311, 1, soldierActor);
			soldierActor.buffComponent.AddBuffNum(260112312, 1, soldierActor);
			if (partnerLv >= 2)
			{
				int num = (int)(long)(soldierActor.maxEnergy * energyChargePercent_2);
				if (num > 0)
				{
					soldierActor.SetEnergy(soldierActor.energy + num);
				}
			}
		}
	}

	protected override void OnOurSoldierCastSkill(SoldierActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnOurSoldierCastSkill(actor, castSkillEvent);
		if (actor.HasPartnerType(partnerTypes) && castSkillEvent.skillEventInfo != null && castSkillEvent.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.NORMAL)
		{
			if (actor.buffComponent.GetBuffNumByID(260112311) > 0)
			{
				actor.buffComponent.RemoveBuffByBuffId(260112311, 1);
			}
			else
			{
				actor.buffComponent.RemoveBuffByBuffId(260112312);
			}
		}
	}
}
