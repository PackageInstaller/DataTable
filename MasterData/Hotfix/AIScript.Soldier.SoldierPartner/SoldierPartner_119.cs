using System.Collections.Generic;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_119 : SoldierPartnerBase
{
	private const int BUFF_ID_MO_YU = 260111911;

	private static readonly FP TICK_INTERVAL = 12;

	private const int BUFF_ID_BOSS_COMING = 260111921;

	private static readonly FP BOSS_COMING_ENERGY_BONUS = 1;

	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.MoYu;

	private SoldierLevelController _levelCtrl;

	private FP _lastTickTime;

	private bool _battleStarted;

	private readonly List<SoldierActor> _targetBuffer = new List<SoldierActor>();

	private readonly HashSet<long> _memberIds = new HashSet<long>();

	private bool _bossComingActive;

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (!(_levelCtrl == null))
		{
			partnerLv = _levelCtrl.GetPartnerLv(partnerTypes);
		}
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		_battleStarted = false;
		if (_bossComingActive && _levelCtrl != null)
		{
			SoldierActor mainControlActor = _levelCtrl.mainControlActor;
			if (mainControlActor != null)
			{
				List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _targetBuffer);
				for (int i = 0; i < allActors.Count; i++)
				{
					SoldierActor soldierActor = allActors.get_Item(i);
					if (!(soldierActor == null) && _memberIds.Contains(soldierActor.Id))
					{
						soldierActor.ModifyEnergyRecoverRatePercent(-BOSS_COMING_ENERGY_BONUS);
					}
				}
			}
		}
		_memberIds.Clear();
		_bossComingActive = false;
		_targetBuffer.Clear();
		_levelCtrl = null;
		_actor = null;
	}

	protected override void OnPartnerBattleStart()
	{
		base.OnPartnerBattleStart();
		if (partnerLv < 1 || _levelCtrl == null)
		{
			return;
		}
		_lastTickTime = LockStepManager.time;
		_battleStarted = true;
		if (partnerLv < 2)
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
			if (!(soldierActor == null) && soldierActor.HasPartnerType(partnerTypes))
			{
				_memberIds.Add(soldierActor.Id);
			}
		}
	}

	public void OnUpdate()
	{
		if (_battleStarted && !(_levelCtrl == null))
		{
			FP time = LockStepManager.time;
			if (time - _lastTickTime >= TICK_INTERVAL)
			{
				_lastTickTime = time;
				ApplyBuffToMembers();
			}
		}
	}

	private void ApplyBuffToMembers()
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
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _targetBuffer);
		if (partnerLv >= 2 && _bossComingActive)
		{
			RemoveBossComing(allActors);
		}
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && !(soldierActor.buffComponent == null) && soldierActor.HasPartnerType(partnerTypes))
			{
				soldierActor.buffComponent.AddBuff(260111911, soldierActor);
			}
		}
	}

	protected override void OnRemoveBuff(IEvent evt)
	{
		if (partnerLv >= 2 && evt is AdventureActorRemoveBuff adventureActorRemoveBuff && adventureActorRemoveBuff.eventInfo.buffId == 260111911)
		{
			SoldierActor soldierActor = adventureActorRemoveBuff.sender as SoldierActor;
			if (!(soldierActor == null) && !soldierActor.isDead && soldierActor.HasPartnerType(partnerTypes))
			{
				ApplyBossComing(soldierActor);
			}
		}
	}

	private void ApplyBossComing(SoldierActor owner)
	{
		if (owner.buffComponent != null)
		{
			owner.buffComponent.AddBuff(260111921, owner);
		}
		if (_memberIds.Contains(owner.Id))
		{
			owner.ModifyEnergyRecoverRatePercent(BOSS_COMING_ENERGY_BONUS);
		}
		_bossComingActive = true;
	}

	private void RemoveBossComing(List<SoldierActor> actors)
	{
		for (int i = 0; i < actors.Count; i++)
		{
			SoldierActor soldierActor = actors.get_Item(i);
			if (!(soldierActor == null))
			{
				if (soldierActor.buffComponent != null)
				{
					soldierActor.buffComponent.RemoveBuffByBuffId(260111921);
				}
				if (_memberIds.Contains(soldierActor.Id))
				{
					soldierActor.ModifyEnergyRecoverRatePercent(-BOSS_COMING_ENERGY_BONUS);
				}
			}
		}
		_bossComingActive = false;
	}
}
