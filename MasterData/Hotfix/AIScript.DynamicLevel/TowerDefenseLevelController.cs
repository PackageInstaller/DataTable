using System;
using System.Collections.Generic;
using System.Linq;
using AIScript.Utils;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace AIScript.DynamicLevel;

public class TowerDefenseLevelController : AdventureLevelController
{
	private new AdventureModuleLevelLoadParams levelLoadParams;

	private TowerDefenseFloor floorData;

	private new GameObject configPrefab;

	private TowerDefensePrefabData prefabData;

	private TowerDefenseMapData mapData;

	private TowerDefenseGameplayBase gameplay;

	private bool enableMainCameraPhysicsRaycaster;

	private List<int> selRoles;

	private int itemID;

	private bool pinMainCamera;

	private Vector3 pinnedCameraPosition;

	private Quaternion pinnedCameraRotation;

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		AdventureGameContext.TeamConfig = null;
		base.Load(param, callback);
		levelLoadParams = ModuleController<AdventureModuleController>.Instance?.levelLoadParams;
		floorData = Singleton<HotfixDataController>.Instance.GetTowerDefenseFloor(CommonUtils.ParseStringParamToInt(levelLoadParams.id));
		if (floorData == null)
		{
			Debug.LogError("塔防FloorId出错：" + levelLoadParams.id);
			return;
		}
		levelLoadParams.dynamicBGM = floorData.BGM;
		levelLoadParams.dynamicSceneName = floorData.SceneName;
		levelLoadParams.dynamicLeaveMusicEvent = floorData.LeaveTriggerEvent;
		string[] enterDynamicLevelParams = levelLoadParams.enterDynamicLevelParams;
		if (enterDynamicLevelParams != null && enterDynamicLevelParams.Length >= 2)
		{
			CommonUtils.TryParseStringParamToInt(enterDynamicLevelParams[0], out itemID);
			string[] array = enterDynamicLevelParams[1].Split(',');
			if (array != null && array.Length != 0)
			{
				selRoles = new List<int>();
				for (int i = 0; i < array.Length; i++)
				{
					if (CommonUtils.TryParseStringParamToInt(array[i], out var intValue))
					{
						selRoles.Add(intValue);
					}
				}
			}
		}
		scenePath = "Assets/AssetBundles/" + floorData.SceneName;
		MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(scenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, (string levelSceneName, int process) =>
		{
			LevelLoadProcessUpdate(levelSceneName, process);
			return true;
		});
		MonoSingleton<GameCameraStackManager>.Instance.autoVerticalToHorizontalFieldOfView = true;
	}

	protected override void LevelLoadComplete(string sceneName)
	{
		base.LevelLoadComplete(sceneName);
		string[] array = scenePath.Split('/');
		Scene sceneByName = SceneManager.GetSceneByName(array[array.Length - 1]);
		string text = scenePath + "/" + floorData.ConfigPrefabName + ".prefab";
		GameObject gameObject = MonoSingleton<SceneLoaderController>.Instance.LoadAsset(scenePath, text, typeof(GameObject)) as GameObject;
		if (gameObject != null)
		{
			configPrefab = UnityEngine.Object.Instantiate(gameObject, Vector3.zero, Quaternion.identity);
			configPrefab.transform.localScale = Vector3.one;
			configPrefab.name = floorData.ConfigPrefabName;
			SceneManager.MoveGameObjectToScene(configPrefab, sceneByName);
		}
		if (null == configPrefab)
		{
			Debug.LogError("策划配置预制体加载失败：" + text);
			return;
		}
		TowerDefensePrefabData component = configPrefab.GetComponent<TowerDefensePrefabData>();
		if (null == component)
		{
			Debug.LogError("策划配置预制体没有塔防数据组件：" + floorData.ConfigPrefabName);
			return;
		}
		mapData = component.mapData;
		if (null == mapData)
		{
			Debug.LogError("策划配置预制体没有塔防数据：" + floorData.ConfigPrefabName);
			return;
		}
		gameplay = CreateGameplayInstance(floorData.LevelScript);
		if (gameplay == null)
		{
			Debug.LogError("塔防脚本加载错误:" + floorData.LevelScript);
			return;
		}
		List<int> list = new List<int>();
		List<int> list2 = new List<int>();
		if (floorData.MemberNum <= 0)
		{
			list.AddRange(floorData.TeamGroup.ToList());
			int initPlayerNum = floorData.InitPlayerNum;
			if (initPlayerNum > 0)
			{
				List<int> list3 = floorData.InitPlayers.ToList();
				if (list3.Count < initPlayerNum)
				{
					list2.AddRange(list3);
					for (int i = 0; i < list3.Count; i++)
					{
						list.Remove(list3.get_Item(i));
					}
					int num = initPlayerNum - list3.Count;
					for (int j = 0; j < num; j++)
					{
						int index = 0;
						list2.Add(list.get_Item(index));
						list.RemoveAt(index);
					}
				}
				else
				{
					for (int k = 0; k < initPlayerNum; k++)
					{
						int index2 = 0;
						int item = list3.get_Item(index2);
						list2.Add(item);
						list3.RemoveAt(index2);
						list.Remove(item);
					}
				}
			}
		}
		else if (selRoles != null && selRoles.Count > 0)
		{
			list = selRoles;
			for (int l = 0; l < floorData.InitPlayerNum; l++)
			{
				if (list.Count == 0)
				{
					break;
				}
				int index3 = 0;
				list2.Add(list.get_Item(index3));
				list.RemoveAt(index3);
			}
		}
		List<int> list4 = new List<int>();
		foreach (TowerDefenseTeamExp value in Singleton<HotfixDataController>.Instance.TowerDefenseTeamExpData.Values)
		{
			if (value.FloorId == floorData.Id)
			{
				list4.Add(value.Exp);
			}
		}
		gameplay.InitMapData(mapData);
		gameplay.InitLevelGamePlayType(floorData.TDLevelGamePlayType);
		gameplay.InitExpInfo(FP.FromMyriad(floorData.UpgradeSpeed), list4.ToArray());
		gameplay.InitLevelInfo(floorData.Durability, floorData.MonsterNum);
		gameplay.InitRoles(list, list2);
		gameplay.InitGameplay();
		TowerDefenseItem towerDefenseItem = Singleton<HotfixDataController>.Instance.GetTowerDefenseItem(floorData.ItemID);
		if (towerDefenseItem != null)
		{
			gameplay.InitItems(towerDefenseItem);
		}
	}

	private TowerDefenseGameplayBase CreateGameplayInstance(string path)
	{
		LocalTypeCache localTypeCache = MonoSingleton<HybridCLRManager>.Instance.LoadLocalTypes(path);
		if (localTypeCache == null)
		{
			return null;
		}
		return Activator.CreateInstance(localTypeCache.type) as TowerDefenseGameplayBase;
	}

	public override void LevelStart(Action callback = null)
	{
		base.LevelStart(callback);
		MonoSingleton<WwiseAudioManager>.Instance.SetAudioListenerPos(Vector3.zero, Vector3.zero);
		if (gameplay != null)
		{
			if (!MonoSingleton<GameCameraStackManager>.Instance.mainCameraPhysicsRaycasterEnabled)
			{
				enableMainCameraPhysicsRaycaster = true;
				MonoSingleton<GameCameraStackManager>.Instance.EnableMainCameraPhysicsRaycaster();
			}
			gameplay.OnLevelStart();
		}
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		base.UpdateLogic(logicDeltaTime);
		gameplay?.OnUpdateLogic();
	}

	public override bool HasTimelinePerformance()
	{
		int num;
		if (floorData != null)
		{
			num = ((!string.IsNullOrEmpty(floorData.IntroCutscene)) ? 1 : 0);
			if (num != 0)
			{
				timelineName = floorData.IntroCutscene;
			}
		}
		else
		{
			num = 0;
		}
		return (byte)num != 0;
	}

	public override void PlayTimelinePerformance(Action callback = null, bool needLimitPlayTimes = true)
	{
		base.PlayTimelinePerformance(() =>
		{
			SetMainCameraBrainEnabled(enabled: false);
			callback?.Invoke();
		}, needLimitPlayTimes: false);
	}

	private void SetMainCameraBrainEnabled(bool enabled)
	{
		Camera camera = MonoSingleton<GameCameraStackManager>.Instance?.mainCamera;
		if (!(null == camera))
		{
			Behaviour behaviour = camera.GetComponent("CinemachineBrain") as Behaviour;
			if (null != behaviour)
			{
				behaviour.enabled = enabled;
			}
			if (enabled)
			{
				pinMainCamera = false;
				return;
			}
			Transform transform = camera.transform;
			pinnedCameraPosition = transform.position;
			pinnedCameraRotation = transform.rotation;
			pinMainCamera = true;
		}
	}

	private void Update()
	{
		if (pinMainCamera)
		{
			Camera camera = MonoSingleton<GameCameraStackManager>.Instance?.mainCamera;
			if (!(null == camera))
			{
				camera.transform.SetPositionAndRotation(pinnedCameraPosition, pinnedCameraRotation);
			}
		}
	}

	public override bool IsLevelComplete()
	{
		if (gameplay == null)
		{
			return true;
		}
		return gameplay.IsLevelComplete();
	}

	public override void LevelEnd()
	{
		base.LevelEnd();
		gameplay?.OnLevelEnd();
		gameplay = null;
		if (enableMainCameraPhysicsRaycaster)
		{
			MonoSingleton<GameCameraStackManager>.Instance.DisableMainCameraPhysicsRaycaster();
		}
		enableMainCameraPhysicsRaycaster = false;
		SetMainCameraBrainEnabled(enabled: true);
		prefabData = null;
		mapData = null;
		if (null != configPrefab)
		{
			UnityEngine.Object.Destroy(configPrefab);
			configPrefab = null;
		}
		floorData = null;
		levelLoadParams = null;
		MonoSingleton<GameCameraStackManager>.Instance.autoVerticalToHorizontalFieldOfView = false;
		itemID = 0;
		selRoles?.Clear();
		selRoles = null;
	}
}
