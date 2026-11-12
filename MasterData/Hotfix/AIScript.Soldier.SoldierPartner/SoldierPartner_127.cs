using System.Collections.Generic;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_127 : SoldierPartnerBase
{
	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.QiLiMoFa;

	private readonly int[] _onceIdPerLevel = new int[3] { 1750359147, 1600482661, 1918986323 };

	private SoldierLevelController _levelCtrl;

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (_levelCtrl != null)
		{
			partnerLv = _levelCtrl.GetPartnerLv(partnerTypes);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnBeforeSettlement);
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnBeforeSettlement);
		_levelCtrl = null;
	}

	private void OnBeforeSettlement(IEvent evt)
	{
		int onceId = GetOnceId();
		if (onceId <= 0 || !(evt is AdventureActorReceiveDamageBeforeSettlementEvent { from: AdventureActor { isDead: false } adventureActor } adventureActorReceiveDamageBeforeSettlementEvent) || adventureActorReceiveDamageBeforeSettlementEvent.damageType != HotfixEnum.damageType.SKILL)
		{
			return;
		}
		if (TryResolveRootSummoner(adventureActor.Id, out var root))
		{
			if (IsMember(root))
			{
				AdventureActor.AddFromAttr(onceId, adventureActor);
			}
		}
		else if (adventureActor is SoldierActor actor && IsMember(actor))
		{
			AdventureActor.AddFromAttr(onceId, adventureActor);
		}
	}

	private bool IsMember(SoldierActor actor)
	{
		if (actor != null && !actor.isEnemyCamp)
		{
			return actor.HasPartnerType(partnerTypes);
		}
		return false;
	}

	private bool TryResolveRootSummoner(long entityId, out SoldierActor root)
	{
		root = null;
		List<SoldierLevelController.SoldierSummonData> list = _levelCtrl?.GetSoldierSummonInfos();
		if (list == null || list.Count <= 0)
		{
			return false;
		}
		bool result = false;
		int num = list.Count + 1;
		while (num-- > 0)
		{
			int num2 = -1;
			for (int i = 0; i < list.Count; i++)
			{
				if (list.get_Item(i).entityId == entityId)
				{
					num2 = i;
					break;
				}
			}
			if (num2 < 0)
			{
				break;
			}
			SoldierLevelController.SoldierSummonData soldierSummonData = list.get_Item(num2);
			result = true;
			root = ((soldierSummonData.summoner != null && soldierSummonData.summoner.Id == soldierSummonData.summonerId) ? soldierSummonData.summoner : null);
			entityId = soldierSummonData.summonerId;
		}
		return result;
	}

	private int GetOnceId()
	{
		if (partnerLv < 1 || _onceIdPerLevel.Length == 0)
		{
			return 0;
		}
		int num = partnerLv - 1;
		if (num >= _onceIdPerLevel.Length)
		{
			num = _onceIdPerLevel.Length - 1;
		}
		return _onceIdPerLevel[num];
	}
}
