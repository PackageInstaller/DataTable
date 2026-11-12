using System.Collections.Generic;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_137 : SoldierPartnerBase
{
	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.ShouYeRen;

	private const int hpToAtkMyriad = 100;

	private const int defToAtkMyriad = 5000;

	private const int onceAttrId_ShieldBoost = 260113711;

	private SoldierLevelController _levelCtrl;

	private readonly List<SoldierActor> _memberBuffer = new List<SoldierActor>();

	private readonly Dictionary<long, FDP> _appliedAtk = new Dictionary<long, FDP>();

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (_levelCtrl != null)
		{
			partnerLv = _levelCtrl.GetPartnerLv(partnerTypes);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		RevertAllAtk();
		_memberBuffer.Clear();
		_appliedAtk.Clear();
		_levelCtrl = null;
	}

	public void OnUpdate()
	{
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return;
		}
		FDP fDP = FDP.FromMyriad(100L);
		FDP fDP2 = FDP.FromMyriad(5000L);
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _memberBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && soldierActor.attributeList != null && soldierActor.HasPartnerType(partnerTypes))
			{
				FDP fDP3 = FDP.FromLong(soldierActor.actorHealthInfo.hpMax) * fDP + soldierActor.actorInfo.def * fDP2;
				_appliedAtk.TryGetValue(soldierActor.Id, out var value);
				FDP fDP4 = fDP3 - value;
				if (!(fDP4 == FDP.Zero))
				{
					soldierActor.attributeList.ChangeValue(1, 3, fDP4);
					_appliedAtk.set_Item(soldierActor.Id, fDP3);
				}
			}
		}
	}

	private void OnBeforeHit(IEvent evt)
	{
		if (partnerLv >= 1 && evt is AdventureActorReceiveDamageBeforeHitEvent { from: SoldierActor { isDead: false, isEnemyCamp: false } soldierActor } adventureActorReceiveDamageBeforeHitEvent && soldierActor.HasPartnerType(partnerTypes) && adventureActorReceiveDamageBeforeHitEvent.damageType == HotfixEnum.damageType.SKILL && !(soldierActor.actorShield == null))
		{
			int num = (int)soldierActor.actorShield.shiledValue;
			if (num > 0)
			{
				AdventureActor.AddFromAttr(260113711, soldierActor, num);
				soldierActor.actorShield.RemoveAllShield();
			}
		}
	}

	private void RevertAllAtk()
	{
		if (_levelCtrl == null || _appliedAtk.Count == 0)
		{
			return;
		}
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _memberBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && soldierActor.attributeList != null && _appliedAtk.TryGetValue(soldierActor.Id, out var value) && value != FDP.Zero)
			{
				soldierActor.attributeList.ChangeValue(1, 3, -value);
			}
		}
	}
}
