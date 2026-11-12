using System.Collections.Generic;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_132 : SoldierPartnerBase
{
	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.WuQiDaShi;

	private static readonly int[] buffId_JiaShi_ByLevel = new int[2] { 260113211, 260113212 };

	private const int buffId_YuWei = 260113221;

	private static readonly FP jiaShiInterval = 0;

	private readonly Dictionary<long, FP> _lastJiaShiTime = new Dictionary<long, FP>();

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		SoldierLevelController soldierLevelController = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (soldierLevelController != null)
		{
			partnerLv = soldierLevelController.GetPartnerLv(partnerTypes);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		_lastJiaShiTime.Clear();
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (partnerLv < 1 || !(damageEvent.from is SoldierActor { isEnemyCamp: false } soldierActor) || !soldierActor.HasPartnerType(partnerTypes) || damageEvent.skillSlotType != HotfixEnum.skillSlotType.NORMAL || soldierActor.isDead || soldierActor.buffComponent == null)
		{
			return;
		}
		soldierActor.buffComponent.RemoveBuffByBuffId(260113221, 1);
		int jiaShiBuffId = GetJiaShiBuffId();
		if (jiaShiBuffId > 0)
		{
			FP time = LockStepManager.time;
			if (!_lastJiaShiTime.TryGetValue(soldierActor.Id, out var value) || time - value >= jiaShiInterval)
			{
				soldierActor.buffComponent.AddBuffNum(jiaShiBuffId, 1, soldierActor);
				_lastJiaShiTime.set_Item(soldierActor.Id, time);
			}
		}
	}

	private void OnCastSkillEnd(IEvent evt)
	{
		if (partnerLv < 1 || !(evt is AdventureActorCastSkillEndEvent { sender: SoldierActor { isEnemyCamp: false } sender } adventureActorCastSkillEndEvent) || !sender.HasPartnerType(partnerTypes) || adventureActorCastSkillEndEvent.skillEventInfo == null || adventureActorCastSkillEndEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.NORMAL || sender.isDead || sender.buffComponent == null)
		{
			return;
		}
		int jiaShiBuffId = GetJiaShiBuffId();
		if (jiaShiBuffId > 0)
		{
			int buffNumByID = sender.buffComponent.GetBuffNumByID(jiaShiBuffId);
			if (buffNumByID > 0)
			{
				sender.buffComponent.RemoveBuffByBuffId(jiaShiBuffId);
				sender.buffComponent.AddBuffNum(260113221, buffNumByID, sender);
			}
		}
	}

	private int GetJiaShiBuffId()
	{
		int num = partnerLv - 1;
		if (num < 0)
		{
			return 0;
		}
		if (num >= buffId_JiaShi_ByLevel.Length)
		{
			num = buffId_JiaShi_ByLevel.Length - 1;
		}
		return buffId_JiaShi_ByLevel[num];
	}
}
