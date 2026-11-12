using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_112 : SoldierPartnerBase
{
	private const HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.XiaLuoKe;

	private const int SHERLOCK_DATA_ID = 2501034;

	private static readonly FP[] AtkInheritPercent = new FP[3]
	{
		new FP(60) / 100,
		new FP(120) / 100,
		new FP(500) / 100
	};

	private static readonly FP[] HpInheritPercent = new FP[3]
	{
		new FP(10) / 100,
		new FP(50) / 100,
		FP.One
	};

	private const int buffId = 260111211;

	private const string Fx_withered = "fx_soldier_base_withered";

	private static readonly TSVector2 FX_POSITION = new TSVector2(0, 0);

	private static readonly FP FX_POSITION_Y = FP.FromFloat(0f);

	private const string Fx_sacrifice = "fx_soldier_base_sacrifice";

	private SoldierLevelController _levelCtrl;

	private List<SoldierActor> _actorBuffer = new List<SoldierActor>();

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (_levelCtrl != null)
		{
			partnerLv = _levelCtrl.GetPartnerLv(HotfixEnum.ChessPartnerType.XiaLuoKe);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_SOLDIER_SUPPORT_PROMOTED", OnSupportPromoted);
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_SOLDIER_SUPPORT_PROMOTED", OnSupportPromoted);
		_actorBuffer.Clear();
		_levelCtrl = null;
	}

	private void OnSupportPromoted(IEvent evt)
	{
		if (partnerLv < 1 || _levelCtrl == null || !(evt is AdventureSoldierSupportPromotedEvent { dataID: 2501034 } adventureSoldierSupportPromotedEvent))
		{
			return;
		}
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _actorBuffer);
		SoldierActor soldierActor = null;
		for (int i = 0; i < allActors.Count; i++)
		{
			if (allActors.get_Item(i) != null && allActors.get_Item(i).Id == adventureSoldierSupportPromotedEvent.actorId)
			{
				soldierActor = allActors.get_Item(i);
				break;
			}
		}
		if (!(soldierActor == null) && !soldierActor.isDead)
		{
			DoSacrifice(soldierActor);
		}
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
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _actorBuffer);
		SoldierActor soldierActor = null;
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor2 = allActors.get_Item(i);
			if (soldierActor2 != null && !soldierActor2.isDead && !soldierActor2.isSupport && soldierActor2.dataID == 2501034)
			{
				soldierActor = soldierActor2;
				break;
			}
		}
		if (!(soldierActor == null))
		{
			DoSacrifice(soldierActor);
		}
	}

	private void DoSacrifice(SoldierActor self)
	{
		if (_levelCtrl == null)
		{
			return;
		}
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return;
		}
		new PlayFX().Play(mainControlActor, null, "fx_soldier_base_withered", FX_POSITION_Y, FX_POSITION, TSVector2.zero);
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _actorBuffer);
		int num = self.GetPotentialLv() - 1;
		if (num < 0)
		{
			num = 0;
		}
		if (num >= AtkInheritPercent.Length)
		{
			num = AtkInheritPercent.Length - 1;
		}
		FP zero = FP.Zero;
		FP zero2 = FP.Zero;
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && !(soldierActor == self) && soldierActor.HasPartnerType(HotfixEnum.ChessPartnerType.SenLinPengYou))
			{
				zero += (FP)soldierActor.actorInfo.atk;
				zero2 += (FP)soldierActor.actorHealthInfo.hpMax;
				if (!soldierActor.isSupport)
				{
					new PlayFX().Play(soldierActor, null, "fx_soldier_base_sacrifice", FX_POSITION_Y, soldierActor.tsTransform.Position, TSVector2.zero);
				}
				soldierActor.DestroySelf();
			}
		}
		if (!(zero <= 0) || !(zero2 <= 0))
		{
			self.buffComponent?.AddBuff(260111211, self);
			long num2 = (long)(zero * AtkInheritPercent[num]);
			long num3 = (long)(zero2 * HpInheritPercent[num]);
			if (num2 > 0)
			{
				self.attributeList.ChangeValue(1, 3, num2);
			}
			if (num3 > 0)
			{
				self.attributeList.ChangeValue(3, 3, num3);
				self.DirectHeal((int)num3, showHud: true);
			}
		}
	}
}
