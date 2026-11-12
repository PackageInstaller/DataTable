using System.Collections.Generic;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_105 : SoldierPartnerBase
{
	private const HotfixEnum.ChessPartnerType partnerType = HotfixEnum.ChessPartnerType.JiQiRen;

	private const int BUFF_ID_ENERGY_FIELD = 260110521;

	private const int BUFF_ID_MAINTENANCE = 260110522;

	private const int BUFF_ID_SKILL_DMG_LV1 = 260110511;

	private const int BUFF_ID_SKILL_DMG_LV2 = 260110512;

	private const int SUPPORT_CAST_COUNT_TO_TRIGGER = 3;

	private SoldierLevelController _levelCtrl;

	private List<SoldierActor> _actorBuffer = new List<SoldierActor>();

	private int _supportCastCount;

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (_levelCtrl == null)
		{
			return;
		}
		partnerLv = _levelCtrl.GetPartnerLv(HotfixEnum.ChessPartnerType.JiQiRen);
		int num = ((partnerLv == 1) ? 260110511 : 260110512);
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return;
		}
		List<SoldierActor> supportActors = _levelCtrl.GetSupportActors(mainControlActor, _actorBuffer);
		for (int i = 0; i < supportActors.Count; i++)
		{
			SoldierActor soldierActor = supportActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && soldierActor.HasPartnerType(HotfixEnum.ChessPartnerType.JiQiRen) && num > 0 && soldierActor.buffComponent != null)
			{
				soldierActor.buffComponent.AddBuff(num, mainControlActor);
			}
		}
	}

	protected override void OnPartnerDisable()
	{
		_actorBuffer.Clear();
		_supportCastCount = 0;
		_levelCtrl = null;
		base.OnPartnerDisable();
	}

	protected override void OnOurSoldierCastSkill(SoldierActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
		if (partnerLv <= 1 || actor == null || actor.isDead || !actor.HasPartnerType(HotfixEnum.ChessPartnerType.JiQiRen) || _levelCtrl == null || castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.NORMAL)
		{
			return;
		}
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return;
		}
		List<SoldierActor> battleActors = _levelCtrl.GetBattleActors(mainControlActor, _actorBuffer);
		int num = 0;
		for (int i = 0; i < battleActors.Count; i++)
		{
			if (battleActors.get_Item(i) != null && !battleActors.get_Item(i).isDead)
			{
				num++;
			}
		}
		if (num > 0)
		{
			int num2 = TSRandom.Range(0, num);
			int num3 = 0;
			for (int j = 0; j < battleActors.Count; j++)
			{
				SoldierActor soldierActor = battleActors.get_Item(j);
				if (soldierActor == null || soldierActor.isDead)
				{
					continue;
				}
				if (num3 == num2)
				{
					if (soldierActor.buffComponent != null)
					{
						soldierActor.buffComponent.AddBuff(260110521, actor);
					}
					break;
				}
				num3++;
			}
		}
		if (actor.isSupport)
		{
			_supportCastCount++;
			if (_supportCastCount >= 3)
			{
				_supportCastCount = 0;
				TriggerMaintenance(mainControlActor, battleActors);
			}
		}
	}

	private void TriggerMaintenance(SoldierActor anchor, List<SoldierActor> battleActors)
	{
		for (int i = 0; i < battleActors.Count; i++)
		{
			SoldierActor soldierActor = battleActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && !(soldierActor.buffComponent == null))
			{
				soldierActor.buffComponent.AddBuff(260110522, anchor);
			}
		}
	}
}
