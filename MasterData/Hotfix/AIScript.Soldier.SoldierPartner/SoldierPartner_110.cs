using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_110 : SoldierPartnerBase
{
	private const int BuffId = 260111011;

	private static readonly FP ExtraRate = 0.5;

	private static readonly FP EnergyBoostedRate = 0.015;

	private const int MaxCastCount = 3;

	private const string Fx_Coin = "FX/Soldier/fx_soldier_base_coin_get";

	private static readonly FP Fx_Coin_Scale = 1.5;

	private const HotfixEnum.ChessPartnerType partnerType = HotfixEnum.ChessPartnerType.LianHeZhongYe;

	private SoldierLevelController _levelCtrl;

	private List<SoldierActor> _actorBuffer = new List<SoldierActor>();

	private List<(SoldierActor actor, FP delta)> _ratePatched = new List<(SoldierActor, FP)>();

	public int harvestCount;

	private int _castCount;

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (!(_levelCtrl == null))
		{
			partnerLv = _levelCtrl.GetPartnerLv(HotfixEnum.ChessPartnerType.LianHeZhongYe);
			harvestCount = _levelCtrl.GetHarvestCount();
		}
	}

	protected override void OnPartnerDisable()
	{
		for (int i = 0; i < _ratePatched.Count; i++)
		{
			var (soldierActor, fP) = _ratePatched.get_Item(i);
			if (soldierActor != null)
			{
				soldierActor.ModifyEnergyRecoverRatePercent(-fP);
			}
		}
		_ratePatched.Clear();
		_castCount = 0;
		_actorBuffer.Clear();
		_levelCtrl = null;
		base.OnPartnerDisable();
	}

	protected override void OnPartnerBattleStart()
	{
		base.OnPartnerBattleStart();
		if (partnerLv < 1 || _levelCtrl == null || harvestCount <= 0)
		{
			return;
		}
		int num = harvestCount;
		if (partnerLv >= 3)
		{
			num += TSMath.FloorToInt(harvestCount * ExtraRate);
		}
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _actorBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && soldierActor.HasPartnerType(HotfixEnum.ChessPartnerType.LianHeZhongYe))
			{
				if (soldierActor.buffComponent != null)
				{
					soldierActor.buffComponent.AddBuffNum(260111011, num, mainControlActor);
				}
				if (partnerLv >= 4)
				{
					FP fP = EnergyBoostedRate * num;
					soldierActor.ModifyEnergyRecoverRatePercent(fP);
					_ratePatched.Add((soldierActor, fP));
				}
			}
		}
	}

	protected override void OnOurSoldierCastSkill(SoldierActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
		if (partnerLv >= 5 && !(actor == null) && !actor.isDead && actor.HasPartnerType(HotfixEnum.ChessPartnerType.LianHeZhongYe) && castSkillEvent.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.NORMAL)
		{
			if (_castCount < 3)
			{
				_castCount++;
				new PlayFX().Play(actor, null, "FX/Soldier/fx_soldier_base_coin_get", FP.Zero, actor.tsTransform.Position, TSVector2.zero, null, 1f, Fx_Coin_Scale.AsFloat());
			}
			MonoSingleton<LuaManager>.Instance?.FireEvent("SoldierHarvestSkill");
		}
	}
}
