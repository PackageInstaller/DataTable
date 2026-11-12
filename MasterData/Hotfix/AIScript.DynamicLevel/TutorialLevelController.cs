#define LOG_ERROR
using System;
using System.Collections.Generic;
using System.Linq;
using AIScript.Utils;
using AdventureBehaviour;
using Nova.Client;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace AIScript.DynamicLevel;

public class TutorialLevelController : TaskTypeLevelController
{
	public const string TutorialSettlementDelayTimeKey = "TutorialSettlementDelayTime";

	private TutorialLevelFloor _floorData;

	private List<PlayerSpawnPointGizmo> _playerSpawnPoints = new List<PlayerSpawnPointGizmo>();

	private PlayerSpawnPointGizmo _playerSpawnPointGizmo;

	private TutorialLevelProcessBase _process;

	private bool _isLevelFinish;

	private FP _delaySettlementTime;

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		base.Load(param, callback);
		if (levelLoadParams != null)
		{
			_floorData = Singleton<HotfixDataController>.Instance.GetTutorialLevelFloor(CommonHelper.ParseStringParamToInt(levelLoadParams.id));
		}
		if (_floorData != null)
		{
			InitTask(_floorData.QuestFlow);
			InitProcess((HotfixEnum.TutorialLevelProcessType)_floorData.ScriptType);
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

	private void InitProcess(HotfixEnum.TutorialLevelProcessType processType)
	{
		switch (processType)
		{
		case HotfixEnum.TutorialLevelProcessType.Test:
			_process = new TutorialLevelProcess_Test();
			break;
		case HotfixEnum.TutorialLevelProcessType.BasicOperation:
			_process = new TutorialLevelProcess_BasicOperation();
			break;
		case HotfixEnum.TutorialLevelProcessType.MoveOperation:
			_process = new TutorialLevelProcess_MoveOperation();
			break;
		case HotfixEnum.TutorialLevelProcessType.SupportOperation:
			_process = new TutorialLevelProcess_SupportOperation();
			break;
		case HotfixEnum.TutorialLevelProcessType.MarkMechanism:
			_process = new TutorialLevelProcess_MarkMechanism();
			break;
		case HotfixEnum.TutorialLevelProcessType.ElementMechanism:
			_process = new TutorialLevelProcess_ElementMechanism();
			break;
		case HotfixEnum.TutorialLevelProcessType.StarTowerCardMechanism:
			_process = new TutorialLevelProcess_StarTowerCardMechanism();
			break;
		case HotfixEnum.TutorialLevelProcessType.StarTowerNoteMechanism:
			_process = new TutorialLevelProcess_StarTowerNoteMechanism();
			break;
		case HotfixEnum.TutorialLevelProcessType.MonsterToughnessMechanism:
			_process = new TutorialLevelProcess_MonsterToughnessMechanism();
			break;
		}
		if (_process != null)
		{
			_process.Init(TriggerNextTask);
		}
		else
		{
			NovaLogger.Error("未实例化教学关卡流程");
		}
	}

	protected override void LevelLoadComplete(string sceneName)
	{
		ILRuntimeAPI.LoadConfigPrefab(scenePath, _floorData.ConfigPrefabName);
		base.LevelLoadComplete(sceneName);
	}

	public override void LevelStart(Action callback = null)
	{
		_process?.OnLevelStart();
		_playerSpawnPointGizmo?.LevelStart();
		_delaySettlementTime = 0;
		Config config = Singleton<GameDataController>.Instance.GetConfig("TutorialSettlementDelayTime");
		if (config != null)
		{
			_delaySettlementTime = CommonUtils.ParseStringParamToFP(config.Value);
		}
		_isLevelFinish = false;
		base.LevelStart(callback);
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		base.UpdateLogic(logicDeltaTime);
		_process?.OnUpdateLogic(logicDeltaTime);
		if (_isLevelFinish)
		{
			if (_delaySettlementTime >= 0)
			{
				_delaySettlementTime -= logicDeltaTime;
			}
			else
			{
				Settlement();
			}
		}
	}

	public override void InitSpawnPoints()
	{
		base.InitSpawnPoints();
		_playerSpawnPoints = UnityEngine.Object.FindObjectsOfType<PlayerSpawnPointGizmo>().ToList();
		if (_playerSpawnPoints == null || _playerSpawnPoints.Count == 0)
		{
			Debug.LogError("关卡中没有配置玩家出生点!");
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
			Debug.LogError("教学关没有找到合适的角色出生点!");
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
		if (isLastTask)
		{
			_isLevelFinish = true;
		}
	}

	protected override void OnTriggerNextTask(int taskId)
	{
		base.OnTriggerNextTask(taskId);
		_process?.OnTriggerNextTask(taskId);
	}

	private void Settlement()
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("TutorialLevelSuccess");
	}

	public override void LevelEnd()
	{
		base.LevelEnd();
		_process?.OnLevelEnd();
		_process = null;
		_playerSpawnPoints.Clear();
		_playerSpawnPointGizmo?.LevelEnd();
		_playerSpawnPointGizmo = null;
	}
}
