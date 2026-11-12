using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_134 : SoldierPartnerBase
{
	private const int xlKDataId = 2501034;

	private const int xHeDataId = 2501008;

	private const string selfFxAlias = "fx_m50801_loop_QiEBaoXiang_Call";

	private static readonly FP selfFxPositionY = FP.FromFloat(0f);

	private static readonly FP selfFxDuration = 1;

	private static readonly FP tickInterval = 6;

	private static readonly FP energyChargePercent = 50;

	private const int xlkSummonDataId = 100011;

	private static readonly TSVector2 xlkSummonPosition = new TSVector2(0, 0);

	private SoldierLevelController _levelCtrl;

	private FP _lastTickTime;

	private bool _battleStarted;

	private readonly List<SoldierActor> _actorBuffer = new List<SoldierActor>();

	private readonly List<SoldierActor> _heBuffer = new List<SoldierActor>();

	private PlayFX _selfFx;

	private FP _selfFxStopTime;

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		_battleStarted = false;
		StopSelfFx();
		_actorBuffer.Clear();
		_heBuffer.Clear();
		_levelCtrl = null;
		_actor = null;
	}

	protected override void OnPartnerBattleStart()
	{
		base.OnPartnerBattleStart();
		if (!(_levelCtrl == null))
		{
			_levelCtrl.SpawnSoldierSummon(_actor as SoldierActor, 100011, xlkSummonPosition, _levelCtrl.mainControlActor.tsTransform.Rotation);
			_lastTickTime = LockStepManager.time;
			_battleStarted = true;
		}
	}

	public void OnUpdate()
	{
		if (_battleStarted && !(_levelCtrl == null))
		{
			FP time = LockStepManager.time;
			TickSelfFx(time);
			if (!(time - _lastTickTime < tickInterval))
			{
				_lastTickTime = time;
				DoTick();
			}
		}
	}

	private void DoTick()
	{
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _actorBuffer);
		if (allActors == null || allActors.Count <= 0)
		{
			return;
		}
		SoldierActor soldierActor = null;
		_heBuffer.Clear();
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor2 = allActors.get_Item(i);
			if (soldierActor2 == null || soldierActor2.isDead)
			{
				continue;
			}
			if (soldierActor2.dataID == 2501034)
			{
				if (soldierActor == null && !soldierActor2.isSupport)
				{
					soldierActor = soldierActor2;
				}
			}
			else if (soldierActor2.dataID == 2501008)
			{
				_heBuffer.Add(soldierActor2);
			}
		}
		if (soldierActor == null)
		{
			_heBuffer.Clear();
			return;
		}
		PlaySelfFx(soldierActor);
		for (int j = 0; j < _heBuffer.Count; j++)
		{
			AddEnergyByPercent(_heBuffer.get_Item(j));
		}
		_heBuffer.Clear();
	}

	private void PlaySelfFx(SoldierActor sherlock)
	{
		if (!string.IsNullOrEmpty("fx_m50801_loop_QiEBaoXiang_Call"))
		{
			StopSelfFx();
			_selfFx = new PlayFX();
			_selfFx.Play(sherlock, null, "fx_m50801_loop_QiEBaoXiang_Call", selfFxPositionY, sherlock.tsTransform.Position, TSVector2.zero);
			if (selfFxDuration > 0)
			{
				_selfFxStopTime = LockStepManager.time + selfFxDuration;
			}
		}
	}

	private void TickSelfFx(FP now)
	{
		if (!(_selfFxStopTime <= 0) && !(now < _selfFxStopTime))
		{
			StopSelfFx();
		}
	}

	private void StopSelfFx()
	{
		_selfFx?.Stop();
		_selfFx = null;
		_selfFxStopTime = 0;
	}

	private void AddEnergyByPercent(SoldierActor target)
	{
		if (!target.isEnergyFull)
		{
			int num = (int)(long)(target.maxEnergy * energyChargePercent / 100);
			if (num > 0)
			{
				target.SetEnergy(target.energy + num);
			}
		}
	}
}
