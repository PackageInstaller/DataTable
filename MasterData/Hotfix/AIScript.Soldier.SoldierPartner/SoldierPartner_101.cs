using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_101 : SoldierPartnerBase
{
	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.KongBaiLvTuan;

	private const int BUFF_ID_SWORD_INTENT = 260110111;

	private const int BUFF_ID_TRISTAR_RADIANCE = 260110121;

	private const int SWORD_INTENT_THRESHOLD = 30;

	private static readonly FP ENERGY_RATE_BONUS = 0.2;

	private static readonly int[] _buffLayerPerLevel = new int[3] { 1802659152, 1701336156, 1113548141 };

	private const string FX_TRISTAR = "fx_soldier_loop_starshine";

	private static readonly TSVector2 FX_POSITION = new TSVector2(0, 0);

	private static readonly FP FX_POSITION_Y = FP.FromFloat(0f);

	private SoldierLevelController _levelCtrl;

	private bool _isTristarActive;

	private List<SoldierActor> _actorBuffer = new List<SoldierActor>();

	private List<(SoldierActor ally, FP delta)> _energyRateBoosted = new List<(SoldierActor, FP)>();

	private PlayFX _tristartFx;

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
		_isTristarActive = false;
		_energyRateBoosted.Clear();
		_actorBuffer.Clear();
		_levelCtrl = null;
		_tristartFx?.Stop();
		_tristartFx = null;
	}

	protected override void OnOurSoldierCastSkill(SoldierActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
		if (partnerLv < 1 || actor == null || !actor.HasPartnerType(partnerTypes) || _levelCtrl == null || castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.NORMAL)
		{
			return;
		}
		int num = partnerLv - 1;
		if (num < 0 || num >= _buffLayerPerLevel.Length)
		{
			return;
		}
		int num2 = _buffLayerPerLevel[num];
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _actorBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && !(soldierActor.buffComponent == null) && soldierActor.HasPartnerType(partnerTypes))
			{
				soldierActor.buffComponent.AddBuffNum(260110111, num2, actor);
			}
		}
		if (!_isTristarActive && GetCurrentSwordIntentLayers(allActors) >= 30)
		{
			ActivateTristarRadiance(mainControlActor, allActors);
		}
	}

	private int GetCurrentSwordIntentLayers(List<SoldierActor> allActors)
	{
		int num = 0;
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && !(soldierActor.buffComponent == null) && soldierActor.HasPartnerType(partnerTypes))
			{
				num += soldierActor.buffComponent.GetBuffNumByID(260110111);
			}
		}
		return num;
	}

	private void ActivateTristarRadiance(SoldierActor mainActor, List<SoldierActor> allActors)
	{
		_isTristarActive = true;
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && !(soldierActor.buffComponent == null))
			{
				soldierActor.buffComponent.AddBuffNum(260110121, 1, mainActor);
				soldierActor.ModifyEnergyRecoverRatePercent(ENERGY_RATE_BONUS);
				_energyRateBoosted.Add((soldierActor, ENERGY_RATE_BONUS));
			}
		}
		_tristartFx?.Stop();
		_tristartFx = new PlayFX();
		_tristartFx.Play(mainActor, null, "fx_soldier_loop_starshine", FX_POSITION_Y, FX_POSITION, TSVector2.zero);
	}

	protected override void OnRemoveBuff(IEvent evt)
	{
		if (_isTristarActive && evt is AdventureActorRemoveBuff adventureActorRemoveBuff && adventureActorRemoveBuff.eventInfo.buffId == 260110121)
		{
			ClearAllSwordIntent();
		}
	}

	private void ClearAllSwordIntent()
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
		_isTristarActive = false;
		_tristartFx?.Stop();
		_tristartFx = null;
		for (int i = 0; i < _energyRateBoosted.Count; i++)
		{
			var (soldierActor, fP) = _energyRateBoosted.get_Item(i);
			if (soldierActor != null && !soldierActor.isDead)
			{
				soldierActor.ModifyEnergyRecoverRatePercent(-fP);
			}
		}
		_energyRateBoosted.Clear();
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _actorBuffer);
		for (int j = 0; j < allActors.Count; j++)
		{
			SoldierActor soldierActor2 = allActors.get_Item(j);
			if (!(soldierActor2 == null) && !soldierActor2.isDead && !(soldierActor2.buffComponent == null) && soldierActor2.HasPartnerType(partnerTypes))
			{
				soldierActor2.buffComponent.RemoveBuffByBuffId(260110111);
			}
		}
	}
}
