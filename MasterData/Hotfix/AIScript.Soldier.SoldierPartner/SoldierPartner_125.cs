using System.Collections.Generic;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_125 : SoldierPartnerBase
{
	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.WangPaiTeGong;

	private const int BUFF_ID_DEF_DOWN = 260112511;

	private const int DEF_DOWN_MIN_LV = 2;

	private SoldierLevelController _levelCtrl;

	private readonly List<SoldierActor> _actorBuffer = new List<SoldierActor>();

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (_levelCtrl != null)
		{
			partnerLv = _levelCtrl.GetPartnerLv(partnerTypes);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnCritDamage);
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnCritDamage);
		_actorBuffer.Clear();
		_levelCtrl = null;
	}

	protected override void OnPartnerBattleStart()
	{
		base.OnPartnerBattleStart();
		if (partnerLv >= 1)
		{
			_ = _levelCtrl == null;
		}
	}

	private void OnCritDamage(IEvent evt)
	{
		if (partnerLv >= 2 && evt is AdventureActorReceiveCritDamageEvent { from: SoldierActor { isEnemyCamp: false } soldierActor } adventureActorReceiveCritDamageEvent && soldierActor.HasPartnerType(partnerTypes) && adventureActorReceiveCritDamageEvent.to is SoldierActor { isEnemyCamp: not false, isDead: false } soldierActor2 && !(soldierActor2.buffComponent == null))
		{
			soldierActor2.buffComponent.AddBuff(260112511, soldierActor);
		}
	}

	private void AddBuff(SoldierActor target, int buffId, SoldierActor fromActor)
	{
		if (buffId > 0)
		{
			target.buffComponent.AddBuff(buffId, fromActor);
		}
	}
}
