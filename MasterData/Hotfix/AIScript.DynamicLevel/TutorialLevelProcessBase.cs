using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;
using XLua;

namespace AIScript.DynamicLevel;

public class TutorialLevelProcessBase
{
	protected Action _triggerNextTask;

	protected PlayerAdventureActor _actor;

	protected int _subProcessIndex;

	private List<CoroutineNode> _waitTimeCorList;

	private bool _triggerNextTaskWithTutorialCard;

	private int _currentTutorialCardId;

	private const int buffId_ImmunityDead = 911210100;

	public void Init(Action triggerNextTask)
	{
		_triggerNextTask = triggerNextTask;
	}

	public virtual void OnLevelStart()
	{
		_actor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor;
		_actor?.buffComponent.AddBuff(911210100, _actor);
		_subProcessIndex = 0;
		_triggerNextTaskWithTutorialCard = false;
		_currentTutorialCardId = 0;
		Singleton<EventDispatchManager>.Instance.AddEventListener("Tutorial_CloseCard", OnTutorialCardClose);
		Singleton<EventDispatchManager>.Instance.AddEventListener("Tutorial_GuideEnd", OnGuideEnd);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_ROOM_WAVE_MONSTER_CLEARED", RoomWaveMonsterCleared);
	}

	protected void TriggerNextTask(int tutorialCardId = 0, bool isLevelStart = false)
	{
		if (tutorialCardId > 0)
		{
			_triggerNextTaskWithTutorialCard = true;
			OpenTutorialCard(tutorialCardId, isLevelStart);
		}
		else
		{
			_triggerNextTask?.Invoke();
		}
	}

	protected void StartWaitTime(FP time, Action onFinish = null)
	{
		if (_waitTimeCorList == null)
		{
			_waitTimeCorList = new List<CoroutineNode>(3);
		}
		_waitTimeCorList.Add(StartLogicCoroutine(WaitTime(time, onFinish)));
	}

	protected void StopWaitTime(CoroutineNode waitTimeCor)
	{
		if (waitTimeCor != null)
		{
			List<CoroutineNode> waitTimeCorList = _waitTimeCorList;
			if (waitTimeCorList != null && waitTimeCorList.Count > 0 && _waitTimeCorList.Remove(waitTimeCor))
			{
				StopLogicCoroutine(waitTimeCor);
			}
		}
	}

	protected void EnableButtonControl(string buttonName, bool isEnable)
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("EnableBtnControl", buttonName, isEnable);
	}

	protected void AddRoomBuff(int buffId)
	{
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			actorL.buffComponent.AddBuff(buffId, actorL);
		}
	}

	protected void UpdateOperationTips(string tipsKey)
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("UpdateOperationTips", tipsKey);
	}

	protected void OpenTutorialCard(int tutorialCardId, bool isLevelStart = false)
	{
		_currentTutorialCardId = tutorialCardId;
		MonoSingleton<LuaManager>.Instance?.FireEvent("OpenTutorialCard", tutorialCardId, isLevelStart);
	}

	protected void ShowTutorialButtonHint(string buttonName, bool isShow)
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("ShowTutorialButtonHint", buttonName, isShow);
	}

	protected void TriggerGuide(int guideId)
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("Trigger_Guide_Index", guideId);
	}

	protected bool TriggerPerkSelect(List<int> perkIdList)
	{
		if (perkIdList != null && perkIdList.Count > 0)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("TutorialPotentialSelect", perkIdList);
			return true;
		}
		return false;
	}

	public virtual void OnUpdateLogic(FP deltaTime)
	{
	}

	private void OnTutorialCardClose(IEvent _)
	{
		if (_currentTutorialCardId > 0)
		{
			if (_triggerNextTaskWithTutorialCard)
			{
				_triggerNextTask?.Invoke();
			}
			OnTutorialCardClose(_currentTutorialCardId);
			_currentTutorialCardId = 0;
		}
	}

	protected virtual void OnTutorialCardClose(int tutorialCardId)
	{
	}

	private void OnGuideEnd(IEvent evt)
	{
		if (evt is GeneralEvent generalEvent)
		{
			CommonHelper.TryParseStringParamToInt((generalEvent.data as LuaTable).get_Item((object)1).ToString(), out var intValue);
			if (intValue > 0)
			{
				OnGuideEnd(intValue);
			}
		}
	}

	protected virtual void OnGuideEnd(int guideId)
	{
	}

	private void RoomWaveMonsterCleared(IEvent evt)
	{
		if (evt is AdventureLevelRoomWaveMonsterClearedEvent waveClearEvent)
		{
			OnRoomWaveMonsterCleared(waveClearEvent);
		}
	}

	protected virtual void OnRoomWaveMonsterCleared(AdventureLevelRoomWaveMonsterClearedEvent waveClearEvent)
	{
	}

	public virtual void OnTriggerNextTask(int taskId)
	{
		_subProcessIndex++;
		_triggerNextTaskWithTutorialCard = false;
	}

	public virtual void OnTaskTargetSuccess(int taskId, int taskTargetId, bool isLasTaskTarget = false)
	{
	}

	public virtual void OnTaskFinish(int taskId, bool isLastTask = false)
	{
	}

	public virtual void OnLevelEnd()
	{
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("BATTLE_ROOM_WAVE_MONSTER_CLEARED", RoomWaveMonsterCleared);
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("Tutorial_CloseCard", OnTutorialCardClose);
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("Tutorial_GuideEnd", OnGuideEnd);
		List<CoroutineNode> waitTimeCorList = _waitTimeCorList;
		if (waitTimeCorList != null && waitTimeCorList.Count > 0)
		{
			foreach (CoroutineNode waitTimeCor in _waitTimeCorList)
			{
				StopLogicCoroutine(waitTimeCor);
			}
			_waitTimeCorList.Clear();
		}
		_triggerNextTask = null;
		_actor = null;
	}

	protected void ActiveMonsterSpawnWave(string waveName)
	{
		List<BaseSpawnPointGizmo> waves = ModuleController<AdventureModuleController>.Instance.GetWaves(waveName);
		if (waves.Count <= 0)
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

	protected CoroutineNode StartLogicCoroutine(IEnumerator routine, bool runImmediately = false)
	{
		return SceneSingleton<AdventurePlayerController>.Instance.StartLogicCoroutine(routine, runImmediately);
	}

	protected void StopLogicCoroutine(CoroutineNode coroutine)
	{
		SceneSingleton<AdventurePlayerController>.Instance.StopLogicCoroutine(coroutine);
	}

	protected IEnumerator WaitTime(FP time, Action onFinish = null)
	{
		FP waitTime = time;
		while (waitTime > 0)
		{
			waitTime -= LockStepManager.deltaTime;
			yield return null;
		}
		onFinish?.Invoke();
	}
}
