using System.Collections.Generic;
using TrueSync;

namespace AIScript.Soldier.SoldierPlayerPassive;

public class SoldierPlayerPassive_8 : SoldierPlayerPassiveBase
{
	private static readonly FP FIRST_TRIGGER_DELAY = FP.One * 3;

	private static readonly FP TRIGGER_INTERVAL = FP.One * 10;

	private static readonly FP STUN_BASE_DURATION = FP.One;

	private static readonly FP STUN_PER_3STAR_BONUS = FP.One / 2;

	private const int STAR_LEVEL_THREE = 3;

	private const int BUFF_ID_STUN = 11;

	private SoldierLevelController _levelCtrl;

	private FP _nextTriggerTime;

	private bool _battleStarted;

	private readonly List<SoldierActor> _enemyBuffer = new List<SoldierActor>();

	private readonly List<SoldierActor> _allyBuffer = new List<SoldierActor>();

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
		_allyBuffer.Clear();
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
				FP fP = TriggerMassStun();
				_nextTriggerTime += fP + TRIGGER_INTERVAL;
			}
		}
	}

	private FP TriggerMassStun()
	{
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return STUN_BASE_DURATION;
		}
		int num = CountAllyThreeStar();
		FP fP = STUN_BASE_DURATION + STUN_PER_3STAR_BONUS * num;
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(_levelCtrl.enemyMainControlActor, _enemyBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && !(soldierActor.buffComponent == null) && soldierActor.actorHealthInfo != null && soldierActor.actorHealthInfo.isAlive)
			{
				soldierActor.buffComponent.AddBuff(11, mainControlActor)?.SetTime(fP);
			}
		}
		return fP;
	}

	private int CountAllyThreeStar()
	{
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return 0;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _allyBuffer);
		int num = 0;
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && soldierActor.GetPotentialLv() >= 3)
			{
				num++;
			}
		}
		return num;
	}

	private void ResetTimeline()
	{
		_battleStarted = false;
		_nextTriggerTime = FP.Zero;
	}
}
