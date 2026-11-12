using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_108 : SoldierPartnerBase
{
	private readonly struct CharShieldCfg(int characterDataId, int shieldId, int shieldId_Outsider)
	{
		public readonly int characterDataId = characterDataId;

		public readonly int shieldId = shieldId;

		public readonly int shieldId_Outsider = shieldId_Outsider;
	}

	private readonly struct CharOnceCfg(int characterDataId, int onceId, int onceId_Outsider)
	{
		public readonly int characterDataId = characterDataId;

		public readonly int onceId = onceId;

		public readonly int onceId_Outsider = onceId_Outsider;
	}

	private readonly struct CharExecuteCfg(int characterDataId, FP executeThreshold, FP executeThreshold_Outsider)
	{
		public readonly int characterDataId = characterDataId;

		public readonly FP executeThreshold = executeThreshold;

		public readonly FP executeThreshold_Outsider = executeThreshold_Outsider;
	}

	private static readonly CharShieldCfg _keluonisiCfg = new CharShieldCfg(2501046, 250104602, 250104601);

	private static readonly CharOnceCfg _ziJinCfg = new CharOnceCfg(2501047, 250104705, 250104704);

	private static readonly CharExecuteCfg _yiYeCfg = new CharExecuteCfg(2501053, 0.1, 0.05);

	private const string Fx_YiYeSlay = "FX/Soldier/fx_soldier_base_yiye_slay";

	private static readonly FP Fx_YiYeSlay_Scale = 1.5;

	private const HotfixEnum.ChessPartnerType partnerType = HotfixEnum.ChessPartnerType.ZiYouLvRen;

	private SoldierLevelController _levelCtrl;

	private readonly List<SoldierActor> _actorBuffer = new List<SoldierActor>();

	private bool _keluonisiOnField;

	private bool _ziJinOnField;

	private bool _yiYeOnField;

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (_levelCtrl != null)
		{
			partnerLv = _levelCtrl.GetPartnerLv(HotfixEnum.ChessPartnerType.ZiYouLvRen);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnBeforeSettlement);
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnBeforeSettlement);
		_actorBuffer.Clear();
		_levelCtrl = null;
		_keluonisiOnField = false;
		_ziJinOnField = false;
		_yiYeOnField = false;
	}

	protected override void OnPartnerBattleStart()
	{
		base.OnPartnerBattleStart();
		if (partnerLv < 1 || _levelCtrl == null)
		{
			return;
		}
		_actorBuffer.Clear();
		_levelCtrl.GetAllActors(_levelCtrl.mainControlActor, _actorBuffer);
		for (int i = 0; i < _actorBuffer.Count; i++)
		{
			SoldierActor soldierActor = _actorBuffer.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead)
			{
				if (soldierActor.dataID == _keluonisiCfg.characterDataId)
				{
					_keluonisiOnField = true;
				}
				else if (soldierActor.dataID == _ziJinCfg.characterDataId)
				{
					_ziJinOnField = true;
				}
				else if (soldierActor.dataID == _yiYeCfg.characterDataId)
				{
					_yiYeOnField = true;
				}
			}
		}
		if (!_keluonisiOnField)
		{
			return;
		}
		_actorBuffer.Clear();
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(_levelCtrl.mainControlActor, _actorBuffer);
		for (int j = 0; j < allActors.Count; j++)
		{
			SoldierActor soldierActor2 = allActors.get_Item(j);
			if (!(soldierActor2 == null) && !soldierActor2.isDead)
			{
				int num = (soldierActor2.HasPartnerType(HotfixEnum.ChessPartnerType.ZiYouLvRen) ? _keluonisiCfg.shieldId : _keluonisiCfg.shieldId_Outsider);
				if (num > 0)
				{
					soldierActor2.actorShield?.AddShield(num, soldierActor2);
				}
			}
		}
	}

	private void OnBeforeSettlement(IEvent evt)
	{
		if (partnerLv >= 1 && evt is AdventureActorReceiveDamageBeforeSettlementEvent adventureActorReceiveDamageBeforeSettlementEvent)
		{
			SoldierActor soldierActor = adventureActorReceiveDamageBeforeSettlementEvent.from as SoldierActor;
			if (!(soldierActor == null) && !soldierActor.isEnemyCamp && !soldierActor.isDead)
			{
				OnBeforeZiJinHit(adventureActorReceiveDamageBeforeSettlementEvent, soldierActor);
			}
		}
	}

	private void OnBeforeZiJinHit(AdventureActorReceiveDamageBeforeSettlementEvent e, SoldierActor from)
	{
		if (_ziJinOnField && e.skillSlotType != HotfixEnum.skillSlotType.NORMAL)
		{
			int num = (from.HasPartnerType(HotfixEnum.ChessPartnerType.ZiYouLvRen) ? _ziJinCfg.onceId : _ziJinCfg.onceId_Outsider);
			if (num > 0)
			{
				AdventureActor.AddFromAttr(num, from);
			}
		}
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent e)
	{
		if (partnerLv >= 1)
		{
			SoldierActor soldierActor = e.from as SoldierActor;
			if (!(soldierActor == null) && !soldierActor.isDead && !soldierActor.isEnemyCamp)
			{
				OnYiYeHit(e, soldierActor);
			}
		}
	}

	private void OnYiYeHit(AdventureActorReceiveDamageEvent e, SoldierActor from)
	{
		if (!_yiYeOnField)
		{
			return;
		}
		FP fP = (from.HasPartnerType(HotfixEnum.ChessPartnerType.ZiYouLvRen) ? _yiYeCfg.executeThreshold : _yiYeCfg.executeThreshold_Outsider);
		if (!(fP <= 0))
		{
			SoldierActor soldierActor = e.to as SoldierActor;
			if (!(soldierActor == null) && !soldierActor.isDead && soldierActor.isEnemyCamp && !e.isKill && !((FP)soldierActor.actorHealthInfo.hpPercentage > fP))
			{
				new PlayFX().Play(soldierActor, null, "FX/Soldier/fx_soldier_base_yiye_slay", FP.Zero, soldierActor.tsTransform.Position, TSVector2.zero, null, 1f, Fx_YiYeSlay_Scale.AsFloat());
				soldierActor.Kill(from);
			}
		}
	}
}
