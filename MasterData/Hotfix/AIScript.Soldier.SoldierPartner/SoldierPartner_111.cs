using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_111 : SoldierPartnerBase
{
	private const HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.SenLinPengYou;

	private const int BUFF_ID_NATURAL_BLESSING = 260111111;

	private const int BUFF_ID_NATURAL_BLESSING_2 = 260111112;

	private static readonly FP TICK_INTERVAL_LV1 = 10;

	private static readonly FP TICK_INTERVAL_LV2 = 8;

	private static readonly FP TICK_INTERVAL_LV3 = 5;

	private static readonly FP CHARGE_BONUS_PER_DEATH = 1.0;

	private const string FX_NATURAL_BLESSING = "fx_soldier_base_forest";

	private static readonly TSVector2 FX_POSITION = new TSVector2(0, 0);

	private static readonly FP FX_POSITION_Y = 0;

	private SoldierLevelController _levelCtrl;

	private FP _interval;

	private FP _lastTickTime;

	private bool _battleStarted;

	private List<SoldierActor> _targetBuffer = new List<SoldierActor>();

	private HashSet<long> _memberIds = new HashSet<long>();

	private Dictionary<long, FP> _energyBonusApplied = new Dictionary<long, FP>();

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (_levelCtrl != null)
		{
			partnerLv = _levelCtrl.GetPartnerLv(HotfixEnum.ChessPartnerType.SenLinPengYou);
		}
		if (partnerLv >= 3)
		{
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnActorDied_ChargeBonus);
		}
	}

	protected override void OnPartnerDisable()
	{
		_battleStarted = false;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnActorDied_ChargeBonus);
		SoldierActor soldierActor = _levelCtrl?.mainControlActor;
		if (soldierActor != null)
		{
			List<SoldierActor> allActors = _levelCtrl.GetAllActors(soldierActor, _targetBuffer);
			for (int i = 0; i < allActors.Count; i++)
			{
				SoldierActor soldierActor2 = allActors.get_Item(i);
				if (soldierActor2 != null && _energyBonusApplied.TryGetValue(soldierActor2.Id, out var value))
				{
					soldierActor2.ModifyEnergyRecoverRatePercent(-value);
				}
			}
		}
		_targetBuffer.Clear();
		_memberIds.Clear();
		_energyBonusApplied.Clear();
		_levelCtrl = null;
		base.OnPartnerDisable();
	}

	protected override void OnPartnerBattleStart()
	{
		base.OnPartnerBattleStart();
		if (partnerLv < 1 || _levelCtrl == null)
		{
			return;
		}
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _targetBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && soldierActor.HasPartnerType(HotfixEnum.ChessPartnerType.SenLinPengYou))
			{
				_memberIds.Add(soldierActor.Id);
			}
		}
		ref FP interval = ref _interval;
		FP fP;
		if (partnerLv == 1)
		{
			fP = TICK_INTERVAL_LV1;
		}
		else
		{
			fP = ((partnerLv == 2) ? TICK_INTERVAL_LV2 : TICK_INTERVAL_LV3);
		}
		interval = fP;
		_lastTickTime = LockStepManager.time;
		_battleStarted = true;
	}

	public void OnUpdate()
	{
		if (_battleStarted && !(_levelCtrl == null))
		{
			FP time = LockStepManager.time;
			if (time - _lastTickTime >= _interval)
			{
				_lastTickTime = time;
				ApplyNaturalBlessing();
			}
		}
	}

	private void ApplyNaturalBlessing()
	{
		SoldierActor soldierActor = _levelCtrl?.mainControlActor;
		if (soldierActor == null)
		{
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(soldierActor, _targetBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor2 = allActors.get_Item(i);
			if (!(soldierActor2 == null) && !soldierActor2.isDead && !(soldierActor2.buffComponent == null))
			{
				if (soldierActor2.HasPartnerType(HotfixEnum.ChessPartnerType.SenLinPengYou))
				{
					soldierActor2.buffComponent.AddBuff(260111112, soldierActor2);
				}
				else
				{
					soldierActor2.buffComponent.AddBuff(260111111, soldierActor2);
				}
			}
		}
		new PlayFX().Play(soldierActor, null, "fx_soldier_base_forest", FX_POSITION_Y, FX_POSITION, TSVector2.zero);
	}

	private void OnActorDied_ChargeBonus(IEvent evt)
	{
		if (_levelCtrl == null || !(evt is AdventureMonsterDiedEvent adventureMonsterDiedEvent))
		{
			return;
		}
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null || !_memberIds.Contains(adventureMonsterDiedEvent.id))
		{
			return;
		}
		_memberIds.Remove(adventureMonsterDiedEvent.id);
		_energyBonusApplied.Remove(adventureMonsterDiedEvent.id);
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _targetBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && soldierActor.HasPartnerType(HotfixEnum.ChessPartnerType.SenLinPengYou) && _memberIds.Contains(soldierActor.Id))
			{
				soldierActor.ModifyEnergyRecoverRatePercent(CHARGE_BONUS_PER_DEATH);
				_energyBonusApplied.set_Item(soldierActor.Id, _energyBonusApplied.TryGetValue(soldierActor.Id, out var value) ? (value + CHARGE_BONUS_PER_DEATH) : CHARGE_BONUS_PER_DEATH);
			}
		}
	}
}
