using System.Collections.Generic;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_131 : SoldierPartnerBase
{
	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.QiShiJingShen;

	private const int buffId_Ally = 260113111;

	private const int buffId_Self = 260113121;

	private const int _maxTrigger = 4;

	private const int _maxTrigger_2 = 8;

	private const int SELF_SHIELD_MIN_LV = 2;

	private SoldierLevelController _levelCtrl;

	private readonly List<SoldierActor> _battleBuffer = new List<SoldierActor>();

	private readonly Dictionary<long, int> _triggered = new Dictionary<long, int>();

	private int maxTrigger
	{
		get
		{
			if (partnerLv >= 2)
			{
				return 8;
			}
			return 4;
		}
	}

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (_levelCtrl != null)
		{
			partnerLv = _levelCtrl.GetPartnerLv(partnerTypes);
		}
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		_battleBuffer.Clear();
		_triggered.Clear();
		_levelCtrl = null;
	}

	protected override void OnOurSoldierCastSkill(SoldierActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
		if (partnerLv < 1 || _levelCtrl == null || actor == null || actor.isDead || !actor.HasPartnerType(partnerTypes) || castSkillEvent.skillEventInfo == null || castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.NORMAL)
		{
			return;
		}
		_triggered.TryGetValue(actor.Id, out var value);
		if (maxTrigger <= 0 || value < maxTrigger)
		{
			bool flag = false;
			SoldierActor soldierActor = FindLowestShieldBattleActor(actor);
			if (soldierActor != null && soldierActor.buffComponent != null)
			{
				soldierActor.buffComponent.AddBuff(260113111, actor);
				flag = true;
			}
			if (partnerLv >= 2 && actor.buffComponent != null)
			{
				actor.buffComponent.AddBuff(260113121, actor);
				flag = true;
			}
			if (flag)
			{
				_triggered.set_Item(actor.Id, value + 1);
			}
		}
	}

	private SoldierActor FindLowestShieldBattleActor(SoldierActor self)
	{
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return null;
		}
		List<SoldierActor> battleActors = _levelCtrl.GetBattleActors(mainControlActor, _battleBuffer);
		SoldierActor soldierActor = null;
		long num = 0L;
		for (int i = 0; i < battleActors.Count; i++)
		{
			SoldierActor soldierActor2 = battleActors.get_Item(i);
			if (!(soldierActor2 == null) && !(soldierActor2 == self) && !soldierActor2.isDead && !(soldierActor2.actorShield == null))
			{
				long shiledValue = soldierActor2.actorShield.shiledValue;
				if (soldierActor == null || shiledValue < num)
				{
					soldierActor = soldierActor2;
					num = shiledValue;
				}
			}
		}
		return soldierActor;
	}
}
