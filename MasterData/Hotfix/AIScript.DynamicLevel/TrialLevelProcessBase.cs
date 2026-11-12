using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.DynamicLevel;

public class TrialLevelProcessBase
{
	protected int taskProcess;

	private FP drop_Cd = 5;

	private TSVector2 drop_pos = new TSVector2(12, 0);

	private readonly int dropId = 119;

	private long drop_energyId;

	protected UIGameSystemSetup.TimeLinePlayType timeLinePlayType;

	private readonly List<CoroutineNode> corList = new List<CoroutineNode>();

	protected int actorId;

	protected PlayerAdventureActor main_actor => SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;

	public virtual void OnLevelStart()
	{
		timeLinePlayType = Singleton<UIGameSystemSetup>.Instance.PlayType;
		Singleton<UIGameSystemSetup>.Instance.PlayType = UIGameSystemSetup.TimeLinePlayType.everyTime;
		taskProcess = 1;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_ROOM_WAVE_MONSTER_CLEARED", RoomWaveMonsterCleared);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("LEVEL_ON_TELEPORTER_TRIGGER_RUN", TriggerTeleportRun);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("DROP_EFFECT_FINISH", OnDropFinish);
	}

	public void InitCharId(int charId)
	{
		actorId = charId;
	}

	protected void ChangeEnegyDropPos(TSVector2 pos)
	{
		drop_pos = pos;
	}

	protected void ChangeEnegyDropCd(FP cd)
	{
		drop_Cd = cd;
	}

	public virtual void OnUpdateLogic(FP deltaTime)
	{
	}

	public virtual void OnTaskTargetSuccess(int taskId, int taskTargetId, bool isLasTaskTarget = false)
	{
	}

	public virtual void OnTaskFinish(int taskId, bool isLastTask = false)
	{
		taskProcess++;
	}

	protected virtual void OnRoomWaveMonsterCleared(AdventureLevelRoomWaveMonsterClearedEvent ievent)
	{
	}

	protected virtual void OnTriggerTeleportRun(AdventureTriggerTeleportRunEvent ievent)
	{
		AdventureModuleHelper.SetSemiAutoBattleMode(enable: false);
	}

	public virtual void OnLevelEnd()
	{
		Singleton<UIGameSystemSetup>.Instance.PlayType = timeLinePlayType;
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("BATTLE_ROOM_WAVE_MONSTER_CLEARED", RoomWaveMonsterCleared);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("LEVEL_ON_TELEPORTER_TRIGGER_RUN", TriggerTeleportRun);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("DROP_EFFECT_FINISH", OnDropFinish);
		List<CoroutineNode> list = corList;
		if (list != null && list.Count > 0)
		{
			for (int num = corList.Count - 1; num > -1; num--)
			{
				StopLogicCoroutine(corList.get_Item(num));
			}
			corList.Clear();
		}
	}

	protected void SendTaskProcessToServer()
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("Trial_QuestComplete");
	}

	protected void OpenTeleporters(string teleporterName)
	{
		List<AdventureLevelTeleporter> teleporters = ModuleController<AdventureModuleController>.Instance.GetTeleporters(teleporterName, -1, -1);
		for (int i = 0; i < teleporters.Count; i++)
		{
			teleporters.get_Item(i).Active(active: true);
		}
	}

	protected void RoomWaveMonsterCleared(IEvent ievent)
	{
		if (ievent != null)
		{
			AdventureLevelRoomWaveMonsterClearedEvent adventureLevelRoomWaveMonsterClearedEvent = (AdventureLevelRoomWaveMonsterClearedEvent)ievent;
			if (adventureLevelRoomWaveMonsterClearedEvent != null)
			{
				OnRoomWaveMonsterCleared(adventureLevelRoomWaveMonsterClearedEvent);
			}
		}
	}

	protected void TriggerTeleportRun(IEvent ievent)
	{
		if (ievent != null)
		{
			AdventureTriggerTeleportRunEvent adventureTriggerTeleportRunEvent = (AdventureTriggerTeleportRunEvent)ievent;
			if (adventureTriggerTeleportRunEvent != null)
			{
				OnTriggerTeleportRun(adventureTriggerTeleportRunEvent);
			}
		}
	}

	protected void DropItemEnegy()
	{
		if (dropId > 0)
		{
			drop_energyId = SceneSingleton<DropsManager>.Instance.PlayDropsByDropId(main_actor, dropId, drop_pos);
		}
	}

	private void OnDropFinish(IEvent evt)
	{
		AdventureDropFinishEvent obj = evt as AdventureDropFinishEvent;
		long entityID = obj.entityID;
		if (obj.isPickUp && entityID == drop_energyId)
		{
			StartLogicCoroutine(DropEnumerator());
			OnGetDrop();
		}
	}

	protected virtual void OnGetDrop()
	{
	}

	private IEnumerator DropEnumerator()
	{
		FP waitTime = drop_Cd;
		while (waitTime > 0)
		{
			waitTime -= LockStepManager.deltaTime;
			yield return null;
		}
		DropItemEnegy();
	}

	protected void ActiveMonsterSpawnWave(string waveName)
	{
		List<BaseSpawnPointGizmo> waves = ModuleController<AdventureModuleController>.Instance.GetWaves(waveName);
		if (waves == null || waves.Count <= 0)
		{
			return;
		}
		foreach (BaseSpawnPointGizmo item in waves)
		{
			if (item.isSpawnEnabled)
			{
				item.ReEnableSpawnLogic();
			}
			else
			{
				item.EnableSpawnLogic();
			}
		}
	}

	protected void KillMonsterSpawnWave(string waveName)
	{
		List<BaseSpawnPointGizmo> waves = ModuleController<AdventureModuleController>.Instance.GetWaves(waveName);
		if (waves != null && waves.Count > 0)
		{
			StartLogicCoroutine(KillMonsterEnumerator(waves));
		}
	}

	private bool IsSpwanState(List<BaseSpawnPointGizmo> monsterWaves)
	{
		if (monsterWaves != null && monsterWaves.Count <= 0)
		{
			return false;
		}
		for (int i = 0; i < monsterWaves.Count; i++)
		{
			if (monsterWaves.get_Item(i).IsSpwanState())
			{
				return true;
			}
		}
		return false;
	}

	private IEnumerator KillMonsterEnumerator(List<BaseSpawnPointGizmo> monsterWaves)
	{
		while (IsSpwanState(monsterWaves))
		{
			yield return null;
		}
		foreach (BaseSpawnPointGizmo monsterWave in monsterWaves)
		{
			monsterWave.KillAllSummoners();
		}
	}

	protected int GetMonsterCountSpawnWave(string waveName)
	{
		List<BaseSpawnPointGizmo> waves = ModuleController<AdventureModuleController>.Instance.GetWaves(waveName);
		int num = 0;
		if (waves != null && waves.Count > 0)
		{
			foreach (BaseSpawnPointGizmo item in waves)
			{
				num += item.RemindMonsterCount();
			}
		}
		return num;
	}

	protected CoroutineNode StartLogicCoroutine(IEnumerator routine, bool runImmediately = false)
	{
		CoroutineNode coroutineNode = SceneSingleton<AdventurePlayerController>.Instance.StartLogicCoroutine(routine, runImmediately);
		corList.Add(coroutineNode);
		return coroutineNode;
	}

	protected void StopLogicCoroutine(CoroutineNode coroutine)
	{
		if (coroutine != null)
		{
			if (corList.Contains(coroutine))
			{
				corList.Remove(coroutine);
			}
			SceneSingleton<AdventurePlayerController>.Instance.StopLogicCoroutine(coroutine);
		}
	}

	protected IEnumerator WaitTime(FP time)
	{
		FP waitTime = time;
		while (waitTime > 0)
		{
			waitTime -= LockStepManager.deltaTime;
			yield return null;
		}
	}

	protected void AddBuffNumByActor(int _actorId, int buffId, int buffnum)
	{
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.dataID == _actorId)
			{
				playerAdventureActor.buffComponent?.AddBuffNum(buffId, buffnum, playerAdventureActor);
			}
		}
	}
}
