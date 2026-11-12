using System.Collections.Generic;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_130 : SoldierPartnerBase
{
	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.MeiShiJianShangJia;

	private static readonly int[] buffId_LifeSteal_ByLevel = new int[3] { 1718906696, 1415346281, 1550868850 };

	private static readonly int[] shieldId_ByLevel = new int[3] { 2020173428, 1701336156, 1699767661 };

	private static readonly FP shieldDelay = 10;

	private const int buffId_DamageReduce_3 = 260113041;

	private const int DMG_REDUCE_MIN_LV = 3;

	private SoldierLevelController _levelCtrl;

	private readonly List<SoldierActor> _actorBuffer = new List<SoldierActor>();

	private bool _battleStarted;

	private bool _shieldApplied;

	private FP _shieldTriggerTime;

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
		_actorBuffer.Clear();
		_battleStarted = false;
		_shieldApplied = false;
		_levelCtrl = null;
	}

	protected override void OnPartnerBattleStart()
	{
		base.OnPartnerBattleStart();
		ApplyLifeSteal();
		if (GetShieldId() > 0)
		{
			_shieldTriggerTime = LockStepManager.time + shieldDelay;
			_battleStarted = true;
		}
	}

	private void ApplyLifeSteal()
	{
		int lifeStealId = GetLifeStealId();
		if (lifeStealId <= 0 || _levelCtrl == null)
		{
			return;
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
			if (IsValidPiece(soldierActor))
			{
				soldierActor.buffComponent.AddBuff(lifeStealId, soldierActor);
			}
		}
	}

	public void OnUpdate()
	{
		if (!(_levelCtrl == null))
		{
			if (_battleStarted && !_shieldApplied && LockStepManager.time >= _shieldTriggerTime)
			{
				_shieldApplied = true;
				ApplyShield();
			}
			if (partnerLv >= 3)
			{
				SyncDamageReduce();
			}
		}
	}

	private void ApplyShield()
	{
		int shieldId = GetShieldId();
		if (shieldId <= 0)
		{
			return;
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
			if (IsValidPiece(soldierActor) && !(soldierActor.actorShield == null))
			{
				soldierActor.actorShield.AddShield(shieldId, soldierActor);
			}
		}
	}

	private void SyncDamageReduce()
	{
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _actorBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (IsValidPiece(soldierActor))
			{
				bool flag = soldierActor.actorShield != null && soldierActor.actorShield.shiledValue > 0;
				bool flag2 = soldierActor.buffComponent.CheckBuffByBuffID(260113041);
				if (flag && !flag2)
				{
					soldierActor.buffComponent.AddBuff(260113041, soldierActor);
				}
				else if (!flag & flag2)
				{
					soldierActor.buffComponent.RemoveBuffByBuffId(260113041);
				}
			}
		}
	}

	private int GetLifeStealId()
	{
		int num = partnerLv - 1;
		if (num < 0 || num >= buffId_LifeSteal_ByLevel.Length)
		{
			return 0;
		}
		return buffId_LifeSteal_ByLevel[num];
	}

	private int GetShieldId()
	{
		int num = partnerLv - 1;
		if (num < 0 || num >= shieldId_ByLevel.Length)
		{
			return 0;
		}
		return shieldId_ByLevel[num];
	}

	private bool IsValidPiece(SoldierActor actor)
	{
		if (actor == null || actor.isDead || actor.buffComponent == null)
		{
			return false;
		}
		SoldierActor summoner;
		return !IsSummoned(actor, out summoner);
	}
}
