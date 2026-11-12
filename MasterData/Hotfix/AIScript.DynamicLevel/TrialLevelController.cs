#define LOG_ERROR
using System;
using System.Collections.Generic;
using System.Linq;
using AdventureBehaviour;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace AIScript.DynamicLevel;

public class TrialLevelController : TaskTypeLevelController
{
	protected TrialFloor _floorData;

	private List<PlayerSpawnPointGizmo> _playerSpawnPoints = new List<PlayerSpawnPointGizmo>();

	private PlayerSpawnPointGizmo _playerSpawnPointGizmo;

	private TrialLevelProcessBase _process;

	protected bool isStartTime;

	protected FP timing;

	protected FP levelTime;

	protected bool isSettlement;

	protected const string ZoomFreezeKey = "ZoomFreeze";

	protected const string ZoomDurationTimeKey = "ZoomInDurationTime";

	protected float _zoomFreeze;

	protected float _zoomDurationTime;

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		base.Load(param, callback);
		if (levelLoadParams != null)
		{
			_floorData = Singleton<HotfixDataController>.Instance.GetTrialFloor(CommonHelper.ParseStringParamToInt(levelLoadParams.id));
		}
		if (_floorData != null)
		{
			InitTask(_floorData.QuestFlow, triggerFirstTask: true);
			InitProcess((HotfixEnum.TrialSectType)_floorData.TrialSectType, _floorData.TrialChar);
			scenePath = "Assets/AssetBundles/" + _floorData.SceneName;
			MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(scenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, (string levelSceneName, int process) =>
			{
				LevelLoadProcessUpdate(levelSceneName, process);
				return true;
			});
			musicName = _floorData.BGM;
			leaveMusicEvent = _floorData.LeaveTriggerEvent;
		}
	}

	protected override void LevelLoadComplete(string sceneName)
	{
		ILRuntimeAPI.LoadConfigPrefab(scenePath, _floorData.ConfigPrefabName);
		base.LevelLoadComplete(sceneName);
	}

	public override void LevelStart(Action callback = null)
	{
		timing = 0;
		levelTime = 0;
		isStartTime = true;
		isSettlement = false;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_LEVEL_ON_TELEPORTER_TRIGGERED", TaskSettlement);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		_process?.OnLevelStart();
		_playerSpawnPointGizmo?.LevelStart();
		base.LevelStart(callback);
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		base.UpdateLogic(logicDeltaTime);
		_process?.OnUpdateLogic(logicDeltaTime);
		if (isStartTime)
		{
			levelTime += logicDeltaTime;
			timing += logicDeltaTime;
			if (timing >= 1)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("Trial_Time", (int)(long)levelTime);
				timing -= (FP)1;
			}
		}
	}

	public override void InitSpawnPoints()
	{
		base.InitSpawnPoints();
		_playerSpawnPoints = UnityEngine.Object.FindObjectsOfType<PlayerSpawnPointGizmo>().ToList();
		if (_playerSpawnPoints == null || _playerSpawnPoints.Count == 0)
		{
			NovaLogger.Error("关卡中没有配置玩家出生点!");
			return;
		}
		if (null == _playerSpawnPointGizmo)
		{
			for (int i = 0; i < _playerSpawnPoints.Count; i++)
			{
				PlayerSpawnPointGizmo playerSpawnPointGizmo = _playerSpawnPoints.get_Item(i);
				if (string.IsNullOrEmpty(playerSpawnPointGizmo.spawnPointID))
				{
					_playerSpawnPointGizmo = playerSpawnPointGizmo;
					break;
				}
			}
		}
		if (null == _playerSpawnPointGizmo)
		{
			NovaLogger.Error("试玩关没有找到合适的角色出生点!");
			return;
		}
		_playerSpawnPointGizmo.Initialize(0, 0);
		_playerSpawnPointGizmo.EnableSpawnLogic();
		_playerSpawnPointGizmo.ExecuteSpawnLogic();
		if (!isViewSceneMode)
		{
			ILRuntimeAPI.HandleSpawnGizmos();
		}
	}

	protected override void OnTaskTargetSuccess(int taskId, int taskTargetId, bool isLasTaskTarget = false)
	{
		base.OnTaskTargetSuccess(taskId, taskTargetId, isLasTaskTarget);
		_process?.OnTaskTargetSuccess(taskId, taskTargetId, isLasTaskTarget);
	}

	protected override void OnTaskFinish(int taskId, bool isLastTask = false)
	{
		base.OnTaskFinish(taskId, isLastTask);
		_process?.OnTaskFinish(taskId, isLastTask);
		if (!isLastTask)
		{
			TriggerNextTask();
		}
	}

	public override void LevelEnd()
	{
		base.LevelEnd();
		_process?.OnLevelEnd();
		_process = null;
		isStartTime = false;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_LEVEL_ON_TELEPORTER_TRIGGERED", TaskSettlement);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		_playerSpawnPoints.Clear();
		_playerSpawnPointGizmo?.LevelEnd();
		_playerSpawnPointGizmo = null;
	}

	protected void TaskSettlement(IEvent evt)
	{
		object data = ((GeneralEvent)evt).data;
		if (data != null)
		{
			AdventureLevelTeleporter.NextLevelData nextLevelData = (AdventureLevelTeleporter.NextLevelData)data;
			isStartTime = false;
			if (nextLevelData.levelSuccess)
			{
				LevelStateChangedCall(HotfixEnum.levelState.Success);
			}
		}
	}

	private void OnPlayerDied(IEvent ievent)
	{
		LevelStateChangedCall(HotfixEnum.levelState.Failed);
	}

	protected void LevelStateChangedCall(HotfixEnum.levelState levelState)
	{
		if (!isSettlement)
		{
			isStartTime = false;
			isSettlement = true;
			MonoSingleton<LuaManager>.Instance.FireEvent("TrialGameEnd", levelTime.AsFloat());
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomFreeze").Value, out _zoomFreeze);
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomInDurationTime").Value, out _zoomDurationTime);
			ModuleController<AdventureModuleController>.Instance.FreezeFrame(_zoomFreeze, _zoomDurationTime, Action);
		}
		void Action()
		{
			LevelStateChanged(levelState);
		}
	}

	private void InitProcess(HotfixEnum.TrialSectType processType, int id)
	{
		string typeStr = "";
		switch (processType)
		{
		case HotfixEnum.TrialSectType.MainSect1:
			typeStr = $"AIScript.DynamicLevel.TrialLevelProcess_{id}_Main1";
			break;
		case HotfixEnum.TrialSectType.MainSect2:
			typeStr = $"AIScript.DynamicLevel.TrialLevelProcess_{id}_Main2";
			break;
		case HotfixEnum.TrialSectType.SupSect1:
			typeStr = $"AIScript.DynamicLevel.TrialLevelProcess_{id}_Sup1";
			break;
		case HotfixEnum.TrialSectType.SupSect2:
			typeStr = $"AIScript.DynamicLevel.TrialLevelProcess_{id}_Sup2";
			break;
		case HotfixEnum.TrialSectType.SkinMainSect:
			typeStr = $"AIScript.DynamicLevel.SkinTrialLevelProcess_{id}_Main";
			break;
		case HotfixEnum.TrialSectType.SkinSupSect:
			typeStr = $"AIScript.DynamicLevel.SkinTrialLevelProcess_{id}_Sup";
			break;
		}
		LocalTypeCache localTypeCache = MonoSingleton<HybridCLRManager>.Instance.LoadLocalTypes(typeStr);
		if (localTypeCache != null)
		{
			_process = Activator.CreateInstance(localTypeCache.type) as TrialLevelProcessBase;
		}
		if (_process == null)
		{
			NovaLogger.Error("未实例化试玩关卡流程");
		}
		else
		{
			_process.InitCharId(id);
		}
	}
}
