using System.Collections.Generic;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_106 : SoldierPartnerBase
{
	private const HotfixEnum.ChessPartnerType partnerType = HotfixEnum.ChessPartnerType.DiGuoWeiDui;

	private static readonly int[] InitialEnergyBonus = new int[2] { 20, 60 };

	private static readonly FP[] EnergyRateMultiplier = new FP[4] { 0.2, 0.6, 0.9, 1.2 };

	private const int EnergyMinBonusLv3 = 60;

	private static readonly FP Lv3EnergyFillRatio = 0.5;

	private static readonly FP Lv4EnergyFillRatio = 1.0;

	private SoldierLevelController _levelCtrl;

	private List<SoldierActor> _actorBuffer = new List<SoldierActor>();

	private List<(SoldierActor actor, FP delta)> _ratePatched = new List<(SoldierActor, FP)>();

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (!(_levelCtrl == null))
		{
			partnerLv = _levelCtrl.GetPartnerLv(HotfixEnum.ChessPartnerType.DiGuoWeiDui);
			_ = partnerLv;
			_ = 1;
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
		_actorBuffer.Clear();
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
		FP fP = EnergyRateMultiplier[partnerLv - 1];
		FP fP2 = fP * 0.5;
		FP fP3 = ((partnerLv >= 4) ? Lv4EnergyFillRatio : Lv3EnergyFillRatio) * 0.5;
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _actorBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (soldierActor == null || soldierActor.isDead)
			{
				continue;
			}
			bool flag = soldierActor.HasPartnerType(HotfixEnum.ChessPartnerType.DiGuoWeiDui);
			if (!flag && partnerLv < 3)
			{
				continue;
			}
			if (flag)
			{
				soldierActor.SetEnergy(CalcInitialEnergy(soldierActor));
				soldierActor.ModifyEnergyRecoverRatePercent(fP);
				_ratePatched.Add((soldierActor, fP));
				continue;
			}
			if (partnerLv >= 4)
			{
				soldierActor.SetEnergy(TSMath.Max(soldierActor.energy, soldierActor.maxEnergy * fP3).AsInt());
			}
			else
			{
				FP val = TSMath.Max(soldierActor.maxEnergy * fP3, 30.0);
				soldierActor.SetEnergy(TSMath.Max(soldierActor.energy, val).AsInt());
			}
			soldierActor.ModifyEnergyRecoverRatePercent(fP2);
			_ratePatched.Add((soldierActor, fP2));
		}
	}

	private int CalcInitialEnergy(SoldierActor actor)
	{
		if (partnerLv >= 4)
		{
			return TSMath.Max(actor.energy, actor.maxEnergy * Lv4EnergyFillRatio).AsInt();
		}
		if (partnerLv >= 3)
		{
			FP fP = TSMath.Max(actor.maxEnergy * Lv3EnergyFillRatio, 60);
			return (fP + actor.energy).AsInt();
		}
		return actor.energy + InitialEnergyBonus[partnerLv - 1];
	}
}
