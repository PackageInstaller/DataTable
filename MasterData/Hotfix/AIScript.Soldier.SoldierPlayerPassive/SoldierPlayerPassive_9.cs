using System.Collections.Generic;
using TrueSync;

namespace AIScript.Soldier.SoldierPlayerPassive;

public class SoldierPlayerPassive_9 : SoldierPlayerPassiveBase
{
	private static readonly FP FIRST_TRIGGER_DELAY = FP.One * 3;

	private static readonly FP TRIGGER_INTERVAL = FP.One * 8;

	private const int BUFF_ID_CONTROL = 11;

	private SoldierLevelController _levelCtrl;

	private FP _nextTriggerTime;

	private bool _battleStarted;

	private readonly List<SoldierActor> _enemyBuffer = new List<SoldierActor>();

	protected override void OnPlayerPassiveEnable()
	{
		base.OnPlayerPassiveEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		ResetTimeline();
	}

	protected override void OnPlayerPassiveDisable()
	{
		base.OnPlayerPassiveDisable();
		_levelCtrl = null;
		_enemyBuffer.Clear();
		ResetTimeline();
	}

	protected override void OnPlayerPassiveBattleStart()
	{
		_battleStarted = true;
		_nextTriggerTime = LockStepManager.time + FIRST_TRIGGER_DELAY;
	}

	public void OnUpdate()
	{
		if (_levelCtrl == null || !_battleStarted)
		{
			return;
		}
		FP time = LockStepManager.time;
		if (!(time < _nextTriggerTime))
		{
			while (time >= _nextTriggerTime)
			{
				TriggerMassControl();
				_nextTriggerTime += TRIGGER_INTERVAL;
			}
		}
	}

	private void TriggerMassControl()
	{
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(_levelCtrl.enemyMainControlActor, _enemyBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && !(soldierActor.buffComponent == null) && soldierActor.actorHealthInfo != null && soldierActor.actorHealthInfo.isAlive)
			{
				soldierActor.buffComponent.AddBuff(11, mainControlActor);
			}
		}
	}

	private void ResetTimeline()
	{
		_battleStarted = false;
		_nextTriggerTime = FP.Zero;
	}
}
