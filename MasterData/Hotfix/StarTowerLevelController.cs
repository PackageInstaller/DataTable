using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DG.Tweening;
using LitJson;
using Nova.Hotfix;
using Pathfinding;
using TrueSync;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;
using XLua;

public class StarTowerLevelController : AdventureLevelController
{
	public class DropData
	{
		public int dropNum;

		public AdventureFXPlayer dropEffect;

		public Vector3 currentVelocity;

		public float duration;

		public bool aniComplete;

		public bool noNeedClose;

		private DropType dType;

		public bool flyToPlayer = true;

		public DropType dropType
		{
			get
			{
				return dType;
			}
			set
			{
				dType = value;
				if (dType != DropType.Coin)
				{
					flyToPlayer = false;
				}
			}
		}
	}

	public enum DropType
	{
		Coin,
		SmallEXP,
		BigExp,
		FateCard,
		YinFU
	}

	public class DropInfo
	{
		public DropType dropType;

		public int splitDropMin;

		public int splitDropMax;

		public int dropMax;

		public int[] dropRates;

		public string dropAssetPath;

		public string getAssetPath;

		public GameObject dropPrefab;

		public GameObject getPrefab;

		public int GetSplitNum()
		{
			if (splitDropMin < 0 || splitDropMax < 0)
			{
				return 1;
			}
			if (splitDropMax <= splitDropMin)
			{
				return splitDropMax;
			}
			return MonoSingleton<GameController>.Instance.Random_Roguelike(splitDropMin, splitDropMax);
		}

		public void InitDropInfo()
		{
			UnityEngine.Object obj = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, dropAssetPath, typeof(GameObject));
			if (null != obj)
			{
				dropPrefab = obj as GameObject;
			}
			else
			{
				Debug.LogError("没有找到掉落物" + dropType.ToString() + "的掉落特效资源:" + dropAssetPath);
			}
			obj = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, getAssetPath, typeof(GameObject));
			if (null != obj)
			{
				getPrefab = obj as GameObject;
			}
			else
			{
				Debug.LogError("没有找到掉落物" + dropType.ToString() + "的获得特效资源:" + getAssetPath);
			}
			Debug.Log($"本层可掉落的{dropType}数量为:{dropMax}");
		}

		public void Drop(int num)
		{
			if (num > dropMax)
			{
				dropMax = 0;
			}
			dropMax -= num;
		}

		public bool IsDropByNum()
		{
			return dropMax > 0;
		}

		public bool IsDropByRate(HotfixEnum.monsterEpicType type)
		{
			if (dropRates == null || dropRates.Length != 4)
			{
				Debug.LogError($"本层{dropType}类型的掉落物，掉落概率数据为空或者长度不为4!");
				return false;
			}
			int num = 0;
			switch (type)
			{
			case HotfixEnum.monsterEpicType.LORD:
				num = dropRates[3];
				break;
			case HotfixEnum.monsterEpicType.LEADER:
				num = dropRates[2];
				break;
			case HotfixEnum.monsterEpicType.ELITE:
				num = dropRates[1];
				break;
			case HotfixEnum.monsterEpicType.NORMAL:
				num = dropRates[0];
				break;
			}
			return num switch
			{
				0 => false, 
				100 => true, 
				_ => MonoSingleton<GameController>.Instance.Random_Roguelike(0, 100) < num, 
			};
		}
	}

	public class EditorNeedData
	{
		public int floorID;

		public int battleFloorNum;

		public int stage;

		public bool isElit;

		public float levelTotalDiff;

		public ClampedIntParameter monsterWave;

		public float[] waveDiff;

		public ClampedIntParameter monsterKind;

		public StarTowerEnemySet monsterSetData;

		public List<int> schemeIDs;

		public List<float> waveKindWeights;

		public int monsterIntensityLimit;

		public int monsterNumLimit;
	}

	public class MonsterSpawnDataList : IComparable
	{
		public readonly int waveIndex;

		public List<MonsterSpawnData> monsterSpawnDatas;

		public int WaveRemaindNum
		{
			get
			{
				if (monsterSpawnDatas == null || monsterSpawnDatas.Count == 0)
				{
					return 0;
				}
				int num = 0;
				for (int i = 0; i < monsterSpawnDatas.Count; i++)
				{
					num += monsterSpawnDatas.get_Item(i).RemaindMonsterNum;
				}
				return num;
			}
		}

		public int WaveSurviveMonsterNum
		{
			get
			{
				if (monsterSpawnDatas == null || monsterSpawnDatas.Count == 0)
				{
					return 0;
				}
				int num = 0;
				for (int i = 0; i < monsterSpawnDatas.Count; i++)
				{
					num += monsterSpawnDatas.get_Item(i).curWaveRemaindNum;
				}
				return num;
			}
		}

		public bool IsInRefreshing
		{
			get
			{
				if (monsterSpawnDatas == null || monsterSpawnDatas.Count == 0)
				{
					return false;
				}
				for (int i = 0; i < monsterSpawnDatas.Count; i++)
				{
					if (monsterSpawnDatas.get_Item(i).curWaveMonsterNum > 0)
					{
						return true;
					}
				}
				return false;
			}
		}

		public MonsterSpawnDataList(int waveIndex)
		{
			this.waveIndex = waveIndex;
		}

		public void Add(MonsterSpawnData data)
		{
			if (monsterSpawnDatas == null)
			{
				monsterSpawnDatas = new List<MonsterSpawnData>();
			}
			monsterSpawnDatas.Add(data);
		}

		public int CompareTo(object obj)
		{
			MonsterSpawnDataList monsterSpawnDataList = (MonsterSpawnDataList)obj;
			if (waveIndex >= monsterSpawnDataList.waveIndex)
			{
				return 1;
			}
			return -1;
		}
	}

	public struct MonsterSpawnData
	{
		public int setId;

		public int maxNum;

		public int waveMaxNum;

		public int monsterId;

		public float refInterval;

		public int curWaveMonsterNum;

		public int curWaveRemaindNum;

		public static MonsterSpawnData Empty { get; } = new MonsterSpawnData
		{
			monsterId = 0
		};

		public bool IsEmpty => monsterId == 0;

		public int RemaindMonsterNum => waveMaxNum - curWaveMonsterNum + curWaveRemaindNum;

		public bool IsRefreshAll => waveMaxNum - curWaveMonsterNum <= 0;
	}

	private AdventureLevelGameplayRoom room;

	private string preBgScenePath;

	protected MonsterSpawnWaveGizmo firstMonsterSpawnWave;

	private bool hasDropPerformance;

	private bool sceneDoMir;

	private RandomMonsterSpawnWaveGizmo rdmMonsterSpawnWaveGizmo;

	public List<List<MonsterSpawnData>> spawnMonsterDatas;

	private RandomMonsterSpawnWaveGizmo.RdmMonsterSpawnInfo rdmMonsterSpawnInfo;

	public bool limitlessMode;

	private GameplayRoomData roomData;

	private readonly float DROP_GET_DISTANCE = 5f;

	private readonly float DROP_GET_DURATION = 0.2f;

	private readonly float DROP_DISAPPEAR_DISTANCE = 0.5f;

	private readonly float DROP_WAIT2GET_DURATION = 1.5f;

	private readonly float DROP_COIN_ANI_DURATION = 0.8f;

	private readonly float DROP_COIN_ANI_POWER = 3f;

	private readonly float DROP_RADIUS = 3f;

	private readonly float DROP_GET_DURATION_REDUCE = 0.01f;

	private Vector3 lastDropPosition;

	private Quaternion lastDropRotation;

	private HotfixEnum.monsterEpicType lastEpicType;

	private List<DropInfo> dropInfoList = new List<DropInfo>();

	private readonly List<DropData> dropEffectList = new List<DropData>();

	private readonly List<DropData> getEffectList = new List<DropData>();

	private readonly List<Sequence> seList = new List<Sequence>();

	protected Dictionary<int, Coroutine> dicUltarCor = new Dictionary<int, Coroutine>();

	public StarTowerPorts ports { get; protected set; }

	private StarTowerFloor starTowerFloor => levelLoadParams?.starTowerFloor;

	private StarTowerMap starTowerMap => levelLoadParams?.starTowerMap;

	public HotfixEnum.fixedRoguelikeGameplayType gameplayType
	{
		get
		{
			if (levelLoadParams == null)
			{
				return HotfixEnum.fixedRoguelikeGameplayType.Thorough;
			}
			return (HotfixEnum.fixedRoguelikeGameplayType)(levelLoadParams.starTowerFloor?.CommonGameplayType ?? 6);
		}
	}

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		base.Load(param, callback);
		if (param == null)
		{
			_logger.LogError("固定rog关卡:关卡加载参数为空!");
			callback?.Invoke();
			return;
		}
		StarTowerMap fixedRoguelikeMap = param.starTowerMap;
		if (fixedRoguelikeMap == null)
		{
			_logger.LogError("固定随机关卡:地图数据为空!FloorId:" + param.id);
			return;
		}
		levelScript = fixedRoguelikeMap.LevelScript;
		isBattleFinish = false;
		isReconnected = false;
		if (!isViewSceneMode && levelLoadParams.fixedRoguelikeInfo.nMapId != 0)
		{
			isReconnected = true;
			isBattleFinish = levelLoadParams.isBattleEnd;
		}
		rdmMonsterSpawnInfo = param.rogRdmMonsterSpawnInfo;
		if (param.loadType != AdventureModuleLevelLoadParams.BootConfigLoadType.StarTower_ByFixedId && !isBattleFinish)
		{
			rdmMonsterSpawnInfo.spawnMonsterDataList = GenerateLevelMonsterInfo(param.starTowerFloor, param.starTowerMap);
			rdmMonsterSpawnInfo.refNextWaveRemaindNum = ((param.starTowerFloor != null) ? param.starTowerFloor.MonsterSurplusNum : 0);
			param.rogRdmMonsterSpawnInfo = rdmMonsterSpawnInfo;
		}
		if (param.loadType == AdventureModuleLevelLoadParams.BootConfigLoadType.StarTower_Limitless)
		{
			limitlessMode = true;
		}
		if (string.IsNullOrEmpty(preBgScenePath))
		{
			preBgScenePath = fixedRoguelikeMap.BGSceneRes;
			if (!string.IsNullOrEmpty(preBgScenePath))
			{
				preBgScenePath = "Assets/AssetBundles/" + preBgScenePath;
				MonoSingleton<SceneLoaderController>.Instance.LoadScene(preBgScenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, BGSceneLoadComplete);
			}
			else
			{
				BGSceneLoadComplete(default);
			}
			return;
		}
		string curBgScenePath = fixedRoguelikeMap.BGSceneRes;
		if (string.IsNullOrEmpty(curBgScenePath))
		{
			MonoSingleton<SceneLoaderController>.Instance.UnloadAdditiveSceneAsync(preBgScenePath, UnloadSceneOptions.None, (string sceneN, int process) =>
			{
				if (process == 300)
				{
					preBgScenePath = null;
					BGSceneLoadComplete(default);
				}
				return true;
			});
			return;
		}
		curBgScenePath = "Assets/AssetBundles/" + curBgScenePath;
		if (!curBgScenePath.Equals(preBgScenePath))
		{
			MonoSingleton<SceneLoaderController>.Instance.UnloadAdditiveSceneAsync(preBgScenePath, UnloadSceneOptions.None, (string sceneN, int process) =>
			{
				if (process == 300)
				{
					preBgScenePath = curBgScenePath;
					MonoSingleton<SceneLoaderController>.Instance.LoadScene(curBgScenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, BGSceneLoadComplete);
				}
				return true;
			});
		}
		else
		{
			BGSceneLoadComplete(default);
		}
		void BGSceneLoadComplete(Scene scene)
		{
			scenePath = param.starTowerScenePath;
			if (string.IsNullOrEmpty(scenePath))
			{
				Debug.LogError($"固定随机关卡:场景资源路径为空!MapID:{fixedRoguelikeMap.Id}");
			}
			else
			{
				scenePath = "Assets/AssetBundles/" + scenePath;
				MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(scenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, (string sceneName, int process) =>
				{
					LevelLoadProcessUpdate(sceneName, process);
					return true;
				});
			}
		}
	}

	protected override void LevelLoadComplete(string sceneName)
	{
		base.LevelLoadComplete(sceneName);
		StarTowerMap starTowerMap = levelLoadParams.starTowerMap;
		string text = levelLoadParams.starTowerConfigPath;
		if (string.IsNullOrEmpty(text))
		{
			_logger.LogInfo($"没有对应的配置预制体：{starTowerMap.Id}");
			return;
		}
		sceneDoMir = text.EndsWith("_Mir");
		if (sceneDoMir)
		{
			text = text.Replace("_Mir", "");
		}
		text = "Assets/AssetBundles/" + text + ".prefab";
		GameObject gameObject = null;
		if (GameResourceLoader.ExistsAsset(text))
		{
			gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, text, typeof(GameObject)) as GameObject;
		}
		if (gameObject == null)
		{
			gameObject = MonoSingleton<SceneLoaderController>.Instance.LoadAsset(levelLoadParams.starTowerScenePath, text, typeof(GameObject)) as GameObject;
		}
		if (null == gameObject)
		{
			Debug.LogError($"固定Rog关卡:map{starTowerMap.Id}配置项没有找到对应的prefab!路径:prefab path:{text}___scene path:{levelLoadParams.starTowerScenePath}");
			return;
		}
		if (sceneDoMir)
		{
			Vector3 localScale = gameObject.transform.localScale;
			gameObject.transform.localScale = new Vector3(0f - localScale.x, localScale.y, localScale.z);
		}
		string[] array = sceneName.Split('/');
		sceneName = array[array.Length - 1];
		GameObject[] rootGameObjects = SceneManager.GetSceneByName(sceneName).GetRootGameObjects();
		GameObject gameObject2 = null;
		GameObject gameObject3 = null;
		foreach (GameObject gameObject4 in rootGameObjects)
		{
			switch (gameObject4.name)
			{
			case "==== LevelLogic ====":
				gameObject3 = gameObject4;
				break;
			case "==== Navigation ====":
				HandleNavigation(gameObject4, sceneName);
				break;
			case "==== Environment ====":
				gameObject2 = gameObject4;
				break;
			}
		}
		if (null == gameObject3)
		{
			configPrefab = UnityEngine.Object.Instantiate(gameObject);
		}
		else
		{
			configPrefab = UnityEngine.Object.Instantiate(gameObject, gameObject3.transform);
		}
		if (null == configPrefab)
		{
			Debug.LogError("实例化预制体失败!");
			return;
		}
		AdventurePlayerController instance = SceneSingleton<AdventurePlayerController>.Instance;
		if (null != instance)
		{
			instance.reversalCameraRotationAngle = ((!sceneDoMir) ? 1 : (-1));
		}
		Transform transform = configPrefab.transform.FindInChildren("==== Triggers ====");
		TriggerCom[] array2 = null;
		List<InteractiveSimple> simple = null;
		if (null == transform)
		{
			Debug.LogError("没有找到触发器节点==== Triggers ====");
		}
		else
		{
			if (!isReconnected || !isBattleFinish)
			{
				array2 = transform.GetComponentsInChildren<TriggerCom>();
				Singleton<TriggerManager>.Instance.AddTriggers(array2, -1, -1);
			}
			interactiveNpc = transform.transform.GetComponentsInChildren<InteractiveNpc>(includeInactive: true).ToList();
			simple = transform.transform.GetComponentsInChildren<InteractiveSimple>(includeInactive: true).ToList();
		}
		Transform transform2 = configPrefab.transform.FindInChildren("==== SpawnPoints ====");
		if (null == transform2)
		{
			Debug.LogError("没有找到出生节点==== SpawnPoints ====");
		}
		else
		{
			if (!isViewSceneMode)
			{
				Transform transform3 = transform2.transform.FindInChildren("---- MonsterSpawnPoints ----");
				if (null != transform3)
				{
					monsterSpawnWaves = transform2.transform.GetComponentsInChildren<MonsterSpawnWaveGizmo>().ToList();
					virtualMonsterSpawnWaves = transform2.transform.GetComponentsInChildren<VirtualMonsterSpawnWaveGizmo>().ToList();
				}
				Transform transform4 = transform2.transform.FindInChildren("---- RandomMonsterSpawnPoints ----");
				if (null == transform4)
				{
					_logger.LogInfo("新版随机怪物出生点为空!");
				}
				else
				{
					if (!transform4.gameObject.activeSelf)
					{
						transform4.gameObject.SetActive(value: true);
					}
					HotfixEnum.fixedRoguelikeGameplayType fixedRoguelikeGameplayType = gameplayType;
					RandomMonsterSpawnWaveGizmo[] componentsInChildren = transform2.GetComponentsInChildren<RandomMonsterSpawnWaveGizmo>();
					for (int j = 0; j < componentsInChildren.Length; j++)
					{
						if (componentsInChildren[j].groupIndex == fixedRoguelikeGameplayType)
						{
							rdmMonsterSpawnWaveGizmo = componentsInChildren[j];
							break;
						}
					}
					if (null != rdmMonsterSpawnWaveGizmo)
					{
						rdmMonsterSpawnWaveGizmo.InitSpawnMonsterDatas(rdmMonsterSpawnInfo, limitlessMode);
						rdmMonsterSpawnWaveGizmo.EnableSpawnLogic();
					}
					else
					{
						_logger.LogInfo("随机怪物出生点为空!");
					}
				}
			}
			Transform transform5 = transform2.transform.FindInChildren("---- TrapSpawnPoints ----");
			if (transform5 != null)
			{
				trapGroups = transform5.transform.GetComponentsInChildren<TrapSpawnGroupGizmo>().ToList();
			}
			PreloadAssets();
			Transform transform6 = transform2.transform.FindInChildren("---- TreasureBoxSpawnPoints ----");
			if (null != transform6)
			{
				treasureBoxSpawnPoints = transform6.transform.GetComponentsInChildren<TreasureBoxSpawnPoint>().ToList();
			}
		}
		ports = configPrefab.GetComponentInChildren<StarTowerPorts>();
		if (null == ports)
		{
			Debug.LogError("固定Rog:没有在配置预制体下找到出入口配置!");
		}
		else
		{
			teleporters = ports.GetTeleporters();
			StarTowerPort[] array3 = ports.Ports;
			if (null != gameObject2 && array3 != null)
			{
				foreach (StarTowerPort starTowerPort in array3)
				{
					if (!(null == starTowerPort))
					{
						Transform transform7 = gameObject2.transform.Find(starTowerPort.name);
						if (!(null == transform7))
						{
							starTowerPort.transform.position = transform7.transform.position;
							starTowerPort.transform.rotation = transform7.transform.rotation;
						}
					}
				}
			}
		}
		if (!isViewSceneMode)
		{
			roomData = new GameplayRoomData
			{
				worldLevelType = HotfixEnum.worldLevelType.StarTower,
				floorId = levelLoadParams.fixedRoguelikeInfo.floorId,
				eventId = levelLoadParams.fixedRoguelikeInfo.eventId,
				ports = ports,
				fixedRoguelikeFloor = levelLoadParams.starTowerFloor,
				monsterSpawnPointsGizmos = monsterSpawnWaves,
				virtualMonsterSpawnWaveGizmos = virtualMonsterSpawnWaves,
				trapSpawnPointsGizmos = trapGroups,
				treasureBoxSpawnPoints = treasureBoxSpawnPoints,
				starTowerStage = levelLoadParams.starTowerStage,
				starTowerMap = this.starTowerMap,
				isBattleFinish = isBattleFinish,
				isReconnected = isReconnected,
				triggerComs = array2,
				npc = interactiveNpc,
				simple = simple
			};
		}
	}

	public override void LevelStart(Action callback = null)
	{
		if (!isViewSceneMode)
		{
			InitRoom();
			if (room == null)
			{
				return;
			}
			InitDropInfo(levelLoadParams.starTowerDropInfo);
			room.EntryRoom();
		}
		if (levelLoadParams.isStarTowerPrologue)
		{
			addEventPrologue();
		}
		base.LevelStart(callback);
		if (!isViewSceneMode)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("FixedRogue_Room_Start");
			if (null == rdmMonsterSpawnWaveGizmo)
			{
				_logger.LogWarning("随机怪物波次节点为空!");
			}
			else if (!rdmMonsterSpawnWaveGizmo.isTriggerActived)
			{
				rdmMonsterSpawnWaveGizmo.ExecuteSpawnLogic();
			}
		}
		callback?.Invoke();
	}

	public override void LevelStart_CheckBattleStartMsgTrigger()
	{
		if (isReconnected)
		{
			if (!isBattleFinish)
			{
				CheckRoomType();
			}
		}
		else
		{
			CheckRoomType();
		}
		void CheckRoomType()
		{
			HotfixEnum.starTowerRoomType starTowerRoomType = HotfixEnum.starTowerRoomType.BattleRoom;
			if (roomData != null && roomData.starTowerStage != null)
			{
				starTowerRoomType = (HotfixEnum.starTowerRoomType)roomData.starTowerStage.RoomType;
			}
			if (starTowerRoomType != HotfixEnum.starTowerRoomType.ShopRoom && starTowerRoomType != HotfixEnum.starTowerRoomType.EventRoom)
			{
				base.LevelStart_CheckBattleStartMsgTrigger();
			}
		}
	}

	public override bool HasTimelinePerformance()
	{
		int num;
		if (levelLoadParams != null && levelLoadParams.starTowerMap != null)
		{
			num = ((!string.IsNullOrEmpty(levelLoadParams.starTowerMap.IntroCutscene)) ? 1 : 0);
			if (num != 0)
			{
				timelineName = levelLoadParams.starTowerMap.IntroCutscene;
			}
		}
		else
		{
			num = 0;
		}
		return (byte)num != 0;
	}

	public bool ExecuteExtrlSpawnLogic(MonsterSpawnData spawnData, int callSpawnSrc = 0, bool includeInStatistics = true)
	{
		if (null == rdmMonsterSpawnWaveGizmo)
		{
			_logger.LogWarning("随机怪物波次节点为空!");
			return false;
		}
		rdmMonsterSpawnWaveGizmo.ExecuteExtrlSpawnLogic(spawnData, callSpawnSrc, includeInStatistics);
		return true;
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		base.UpdateLogic(logicDeltaTime);
		if (!isViewSceneMode)
		{
			UpdateDropLogic();
			if (room != null)
			{
				room.UpdateLogic(logicDeltaTime);
			}
		}
	}

	public override void LevelEnd()
	{
		if (levelLoadParams.isStarTowerPrologue)
		{
			removeEventPrologue();
			levelLoadParams.isStarTowerPrologue = false;
		}
		base.LevelEnd();
		AdventurePlayerController instance = SceneSingleton<AdventurePlayerController>.Instance;
		if (null != instance)
		{
			instance.reversalCameraRotationAngle = 1;
		}
		ports = null;
		firstMonsterSpawnWave = null;
		if (null != configPrefab)
		{
			UnityEngine.Object.Destroy(configPrefab);
			configPrefab = null;
		}
		rdmMonsterSpawnWaveGizmo = null;
		room?.LeaveRoom();
		room = null;
		if (hasDropPerformance)
		{
			RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDied);
		}
		SeForceComplete();
		ClearDropEffect();
	}

	public override void LevelFinish()
	{
		base.LevelFinish();
		scenePath = null;
		preBgScenePath = null;
		SeForceComplete();
		ClearDropEffect();
	}

	public void ActiveLevelTeleporters(bool isActive)
	{
		if (!(null == ports))
		{
			ports.ActiveTeleporter(isActive);
		}
	}

	public void HandleSpecialMode(bool hasSpecialMode, bool playBornPerformance)
	{
		if (isLevelLogicComplete)
		{
			return;
		}
		bool flag = true;
		if (monsterSpawnWaves == null || monsterSpawnWaves.Count == 0)
		{
			Debug.Log("怪物波次为空!");
		}
		else
		{
			for (int i = 0; i < monsterSpawnWaves.Count; i++)
			{
				MonsterSpawnWaveGizmo monsterSpawnWaveGizmo = monsterSpawnWaves.get_Item(i);
				if (!monsterSpawnWaveGizmo.isTriggerActived && !(monsterSpawnWaveGizmo is RandomMonsterSpawnWaveGizmo))
				{
					flag = false;
					firstMonsterSpawnWave = monsterSpawnWaveGizmo;
					break;
				}
			}
		}
		Singleton<EventDispatchManager>.Instance.AddEventListener("LUA2CSHARP_UI_TIPS_COMPLETE", Lua2CSharp_UITipComplete);
		if (!flag)
		{
			if (hasSpecialMode)
			{
				Debug.Log("发送显示UI1");
				MonoSingleton<LuaManager>.Instance.FireEvent("CSHARP2LUA_SHOW_UI_TIPS", 1);
				return;
			}
			Debug.Log("固定rog的log1");
			if (null == firstMonsterSpawnWave)
			{
				Debug.LogError("固定rog:没有找到无指令激活的怪物波次!");
				return;
			}
			firstMonsterSpawnWave.Initialize(-1, -1);
			if (playBornPerformance)
			{
				firstMonsterSpawnWave.EnableSpawnLogic();
			}
			else if (!(firstMonsterSpawnWave is RandomMonsterSpawnWaveGizmo))
			{
				firstMonsterSpawnWave.JumpOverBornPerformance();
			}
			firstMonsterSpawnWave = null;
		}
		else
		{
			Debug.Log("固定rog的log2");
			if (hasSpecialMode)
			{
				Debug.Log("发送显示UI0");
				MonoSingleton<LuaManager>.Instance.FireEvent("CSHARP2LUA_SHOW_UI_TIPS", 0);
			}
			firstMonsterSpawnWave = null;
		}
	}

	protected void Lua2CSharp_UITipComplete(IEvent ievent)
	{
		Debug.Log("UI提示结束，开始刷第一波怪");
		Singleton<EventDispatchManager>.Instance.RemoveEventListener("LUA2CSHARP_UI_TIPS_COMPLETE", Lua2CSharp_UITipComplete);
		if (null == firstMonsterSpawnWave)
		{
			Debug.LogError("固定rog:第一波非指令激活的怪物波次为空!");
			return;
		}
		firstMonsterSpawnWave.Initialize(-1, -1);
		firstMonsterSpawnWave.EnableSpawnLogic();
		firstMonsterSpawnWave = null;
	}

	protected void InitRoom()
	{
		if (roomData != null)
		{
			room = new AdventureLevelGameplayRoom();
			room.Init(roomData, LevelStateChangedCallback);
		}
	}

	public override void InitSpawnPoints()
	{
		base.InitSpawnPoints();
		if (null == ports)
		{
			Debug.LogError("固定rog关卡:关卡" + levelLoadParams.id + "中没有找到出入口节点！");
			return;
		}
		HotfixEnum.fixedRoguelikePortDir enterExitPortDirection = nextLevelData.enterExitPortDirection;
		bool isFinalLevelFloor = levelLoadParams.isFinalLevelFloor;
		ports.InitOutPorts(levelLoadParams.nextRoomType, isFinalLevelFloor, sceneDoMir);
		StarTowerPort starTowerPort = ports.InitSpawnPorts(enterExitPortDirection);
		if (null == starTowerPort)
		{
			Debug.LogError("固定rog关卡:关卡" + levelLoadParams.id + "中没有找到合适的入口(出生点)!");
			return;
		}
		Transform parent = ports.transform.parent.parent;
		if (null == parent)
		{
			Debug.LogError("固定rog关卡:数据预制体结构配置出错!");
			return;
		}
		Transform transform = parent.transform.Find("==== SpawnPoints ====");
		if (null == transform)
		{
			Debug.LogError("固定rog关卡:数据预制体结构配置出错!");
			return;
		}
		Transform transform2 = transform.transform.Find("---- PlayerSpawnPoints ----");
		if (null == transform2)
		{
			Debug.LogError("固定rog关卡:数据预制体结构配置出错!");
			return;
		}
		Transform transform3 = transform.transform.Find("---- NPCSpawnPoints ----");
		if (null != transform3)
		{
			npcSpawnPoints = transform3.GetComponentsInChildren<NPCSpawnPointGizmo>().ToList();
			npcSpawnPoints.Sort();
		}
		if (isReconnected)
		{
			if (isBattleFinish)
			{
				playerSpawnPointGizmo = transform2.GetComponentInChildren<PlayerSpawnPointGizmo>();
				if (null == playerSpawnPointGizmo)
				{
					Debug.LogError("固定rog关卡:数据预制体结构配置出错!");
					return;
				}
				playerSpawnPointGizmo.Initialize(0, 0);
				playerSpawnPointGizmo.EnableSpawnLogic();
				playerSpawnPointGizmo.ExecuteSpawnLogic();
			}
			else
			{
				transform2.gameObject.SetActive(value: false);
				playerSpawnPointGizmo = starTowerPort.SetActive_SpawnPoint();
			}
		}
		else
		{
			transform2.gameObject.SetActive(value: false);
			if (!levelLoadParams.isStarTowerPrologue || levelLoadParams.starTowerFloorSet.BattleLvs != 1)
			{
				playerSpawnPointGizmo = starTowerPort.SetActive_SpawnPoint();
			}
		}
		if (!isBattleFinish)
		{
			HandleSpawnGizmos();
		}
		else
		{
			HandleTraps();
		}
	}

	protected void LevelStateChangedCallback(HotfixEnum.levelState levelState, int levelTime)
	{
		_logger.LogInfo($"fixed rog level state changed:{levelState}");
		if (levelState != HotfixEnum.levelState.Failed)
		{
			_ = 2;
		}
		MonoSingleton<LuaManager>.Instance.FireEvent("LevelUseTotalTime", levelTime);
		LevelStateChanged(levelState);
	}

	protected override void MonsterCleared()
	{
	}

	public override bool IsLevelComplete()
	{
		if (room == null)
		{
			return base.IsLevelComplete();
		}
		if (base.IsLevelComplete())
		{
			return room.isComplete;
		}
		return false;
	}

	protected override bool IsEmptyLevel()
	{
		if (base.IsEmptyLevel())
		{
			return rdmMonsterSpawnWaveGizmo == null;
		}
		return false;
	}

	public override void CheckLevelEntitiesStatus()
	{
		if (!isLevelLogicComplete && (!(null != rdmMonsterSpawnWaveGizmo) || rdmMonsterSpawnWaveGizmo.IsAllActivedAndDied()))
		{
			base.CheckLevelEntitiesStatus();
		}
	}

	protected override void ClearMonsterGizmos()
	{
		base.ClearMonsterGizmos();
		rdmMonsterSpawnWaveGizmo?.FinishSpawnLogic();
	}

	public void HandleTraps()
	{
		for (int i = 0; i < trapGroups.Count; i++)
		{
			TrapSpawnGroupGizmo trapSpawnGroupGizmo = trapGroups.get_Item(i);
			trapSpawnGroupGizmo.Initialize(-1, -1);
			trapSpawnGroupGizmo.SetTrapActive(active: false);
		}
		for (int j = 0; j < trapGroups.Count; j++)
		{
			trapGroups.get_Item(j).EnableSpawnLogic();
		}
	}

	public override void HandleSpawnGizmos()
	{
		for (int i = 0; i < monsterSpawnWaves.Count; i++)
		{
			monsterSpawnWaves.get_Item(i).Initialize(-1, -1);
		}
		for (int j = 0; j < trapGroups.Count; j++)
		{
			trapGroups.get_Item(j).Initialize(-1, -1);
		}
		if (isReconnected && isBattleFinish)
		{
			for (int k = 0; k < monsterSpawnWaves.Count; k++)
			{
				MonsterSpawnWaveGizmo monsterSpawnWaveGizmo = monsterSpawnWaves.get_Item(k);
				if (!monsterSpawnWaveGizmo.isTriggerActived && monsterSpawnWaveGizmo.waveType != MonsterSpawnWaveGizmo.WaveType.Goblin && (!(null != firstMonsterSpawnWave) || !monsterSpawnWaveGizmo.name.Equals(firstMonsterSpawnWave.name)) && !(monsterSpawnWaveGizmo is RandomMonsterSpawnWaveGizmo))
				{
					monsterSpawnWaveGizmo.SetAllActiveAndDied();
				}
			}
		}
		else
		{
			for (int l = 0; l < monsterSpawnWaves.Count; l++)
			{
				MonsterSpawnWaveGizmo monsterSpawnWaveGizmo2 = monsterSpawnWaves.get_Item(l);
				if (!monsterSpawnWaveGizmo2.isTriggerActived && monsterSpawnWaveGizmo2.waveType != MonsterSpawnWaveGizmo.WaveType.Goblin && (!(null != firstMonsterSpawnWave) || !monsterSpawnWaveGizmo2.name.Equals(firstMonsterSpawnWave.name)) && !(monsterSpawnWaveGizmo2 is RandomMonsterSpawnWaveGizmo))
				{
					monsterSpawnWaveGizmo2.EnableSpawnLogic();
				}
			}
		}
		for (int m = 0; m < trapGroups.Count; m++)
		{
			trapGroups.get_Item(m).EnableSpawnLogic();
		}
		for (int n = 0; n < npcSpawnPoints.Count; n++)
		{
			NPCSpawnPointGizmo nPCSpawnPointGizmo = npcSpawnPoints.get_Item(n);
			if (nPCSpawnPointGizmo.npcType == NPCSpawnPointGizmo.SpawnNPCType.IDNpc)
			{
				nPCSpawnPointGizmo.EnableSpawnLogic();
				nPCSpawnPointGizmo.ExecuteSpawnLogic();
			}
		}
		HandleTreasureBoxSpawnPoints();
	}

	protected override void HandleTreasureBoxSpawnPoints()
	{
		for (int i = 0; i < treasureBoxSpawnPoints.Count; i++)
		{
			TreasureBoxSpawnPoint treasureBoxSpawnPoint = treasureBoxSpawnPoints.get_Item(i);
			treasureBoxSpawnPoint.Initialize(-1, -1);
			if (treasureBoxSpawnPoint.isActiveAndEnabled && !treasureBoxSpawnPoint.isTriggerActived)
			{
				treasureBoxSpawnPoint.EnableSpawnLogic();
			}
		}
	}

	public void CloseDoorObstacle()
	{
		NavmeshCut[] componentsInChildren = configPrefab.GetComponentsInChildren<NavmeshCut>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].enabled = false;
		}
	}

	public override void PreloadAssets()
	{
		base.PreloadAssets();
		MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance.PreloadMonsters(rdmMonsterSpawnInfo.spawnMonsterDataList);
		MonoSingleton<SoundBankManager>.Instance.LoadBankByEventName("amb_roguelike_elevator_out");
		MonoSingleton<SoundBankManager>.Instance.LoadBankByEventName("amb_roguelike_elevator_in");
	}

	private void AddDropInfo(DropType dropType, int key, int maxNum)
	{
		StarTowerDropItem starTowerDropItem = Singleton<HotfixDataController>.Instance.GetStarTowerDropItem(key);
		if (starTowerDropItem == null)
		{
			Debug.LogError($"掉落物数据为空{key}");
			return;
		}
		int[] array = starTowerDropItem.DropSplitRange.ToArray();
		DropInfo dropInfo = new DropInfo();
		dropInfo.dropType = dropType;
		if (array.Length == 0)
		{
			Debug.LogError($"掉落物{key}的掉落数量区间出错!");
			dropInfo.splitDropMin = 1;
			dropInfo.splitDropMax = 1;
		}
		else
		{
			dropInfo.splitDropMin = array[0];
			dropInfo.splitDropMax = array[1];
		}
		dropInfo.dropRates = starTowerDropItem.Rate.ToArray();
		dropInfo.dropAssetPath = "Assets/AssetBundles/" + starTowerDropItem.Model + ".prefab";
		dropInfo.getAssetPath = "Assets/AssetBundles/" + starTowerDropItem.Model + "_get.prefab";
		dropInfo.dropMax = maxNum;
		dropInfo.InitDropInfo();
		dropInfoList.Add(dropInfo);
	}

	private void InitDropInfo(int[] dropInfos)
	{
		if (isLevelLogicComplete)
		{
			return;
		}
		if (dropInfos == null || dropInfos.Length == 0)
		{
			Debug.LogWarning("没有获取到掉落信息");
			return;
		}
		dropInfoList?.Clear();
		if (dropInfos.Length != 0)
		{
			int num = dropInfos[0];
			if (num > 0)
			{
				AddDropInfo(DropType.Coin, 1, num);
			}
		}
		if (dropInfos.Length > 1)
		{
			int num2 = dropInfos[1];
			if (num2 > 0)
			{
				AddDropInfo(DropType.SmallEXP, 2, num2);
				AddDropInfo(DropType.BigExp, 3, num2);
			}
		}
		if (dropInfos.Length > 2)
		{
			int num3 = dropInfos[2];
			if (num3 > 0)
			{
				AddDropInfo(DropType.FateCard, 4, num3);
			}
		}
		if (dropInfos.Length > 3)
		{
			int num4 = dropInfos[3];
			if (num4 > 0)
			{
				AddDropInfo(DropType.YinFU, 5, num4);
			}
		}
		hasDropPerformance = true;
		if (hasDropPerformance)
		{
			AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDied);
		}
	}

	private void MonsterDied(IEvent ievent)
	{
		if (ievent == null)
		{
			return;
		}
		object sender = ievent.sender;
		if (sender == null)
		{
			_logger.LogError("怪物死亡消息的发送者为空!");
			return;
		}
		if (!(sender is MonsterAdventureActor monsterAdventureActor))
		{
			_logger.LogError("怪物死亡消息的发送者类型错误!");
			return;
		}
		if (monsterAdventureActor.monsterSummonInfo != null && monsterAdventureActor.monsterSummonInfo.SummonActor != null)
		{
			_logger.LogInfo("召唤物不参与掉落计算!");
			return;
		}
		Vector3 position = monsterAdventureActor.transform.position;
		float terrainHeight = CommonHelper.GetTerrainHeight(new Vector2(position.x, position.z), 0f, out var _);
		lastDropPosition = new Vector3(position.x, terrainHeight, position.z);
		lastDropRotation = monsterAdventureActor.transform.rotation;
		if (!monsterAdventureActor.TryGetParentLogicComponent<MonsterInfo>(out var comp))
		{
			_logger.LogError("没有从怪物身上获取到组件MonsterInfo!");
		}
		else
		{
			if (comp.subType != HotfixEnum.monsterSubType.Monster)
			{
				return;
			}
			lastEpicType = comp.epicType;
			int dataID = monsterAdventureActor.dataID;
			StarTowerMonsterSpAttr starTowerMonsterSpAttr = Singleton<HotfixDataController>.Instance.GetStarTowerMonsterSpAttr(dataID);
			if (starTowerMonsterSpAttr == null)
			{
				_logger.LogError($"[StarTowerMonsterSpAttr]表数据为空!怪物ID={dataID}");
				return;
			}
			for (int i = 0; i < dropInfoList.Count; i++)
			{
				DropInfo dropInfo = dropInfoList.get_Item(i);
				if (!dropInfo.IsDropByRate(lastEpicType) || !dropInfo.IsDropByNum())
				{
					continue;
				}
				int[] dropRng = starTowerMonsterSpAttr.RougeMoneyDropRange.ToArray();
				int a = GetNumByRng(dropRng);
				a = Mathf.Min(a, dropInfo.dropMax);
				if (a == 0)
				{
					continue;
				}
				DropItem(dropInfo, lastDropPosition, lastDropRotation, a);
				dropInfo.Drop(a);
				switch (dropInfo.dropType)
				{
				case DropType.SmallEXP:
				{
					for (int k = 0; k < dropInfoList.Count; k++)
					{
						DropInfo dropInfo3 = dropInfoList.get_Item(k);
						if (dropInfo3.dropType == DropType.BigExp)
						{
							dropInfo3.Drop(a);
							break;
						}
					}
					break;
				}
				case DropType.BigExp:
				{
					for (int j = 0; j < dropInfoList.Count; j++)
					{
						DropInfo dropInfo2 = dropInfoList.get_Item(j);
						if (dropInfo2.dropType == DropType.SmallEXP)
						{
							dropInfo2.Drop(a);
							break;
						}
					}
					break;
				}
				}
			}
		}
		int GetNumByRng(int[] array)
		{
			if (array == null || array.Length != 2)
			{
				_logger.LogError("掉落范围数值配置错误!");
				return 0;
			}
			int num = array[0];
			int num2 = array[1];
			if (num < 0 || num2 < 0)
			{
				_logger.LogError($"掉落范围值配置错误:min={num} max={num2}");
				return 0;
			}
			int num3 = 0;
			if (num > num2)
			{
				_logger.LogError("掉落范围值配置错误:min值比max值大");
				return num;
			}
			if (num == num2)
			{
				return num;
			}
			return MonoSingleton<GameController>.Instance.Random_Roguelike(num, num2 + 1);
		}
	}

	protected void DropItem(DropInfo dropInfo, Vector3 position, Quaternion rotation, int dropNum)
	{
		PlayerAdventureActor player = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor;
		int splitNum = dropInfo.GetSplitNum();
		int num = dropNum / splitNum;
		int num2 = dropNum - num * splitNum;
		for (int i = 0; i < num; i++)
		{
			DropEffect(splitNum);
		}
		if (num2 > 0)
		{
			DropEffect(num2);
		}
		void DropEffect(int num3)
		{
			GameObject dropPrefab = dropInfo.dropPrefab;
			if (null != dropPrefab)
			{
				AdventureFXPlayer adventureFXPlayer = AdventureFXPlayer.PlayFX(dropPrefab, 1f, position, rotation);
				if (null == adventureFXPlayer)
				{
					_logger.LogError("掉落特效为空!");
				}
				else
				{
					adventureFXPlayer.name = $"{dropPrefab.name}_{adventureFXPlayer.GetInstanceID()}_{num3}";
					TSVector2 tSVector = player.RandomActorReachablePointInsideRing(new TSVector2(position.x, position.z), 0, DROP_RADIUS, useSelfPos: false, 10);
					Vector3 endValue = new Vector3((float)tSVector.x, position.y, (float)tSVector.y);
					DropData dropData = new DropData();
					dropData.dropNum = num3;
					dropData.dropEffect = adventureFXPlayer;
					dropData.duration = DROP_GET_DURATION;
					dropData.noNeedClose = false;
					dropData.aniComplete = false;
					dropData.dropType = dropInfo.dropType;
					dropEffectList.Add(dropData);
					Sequence item = adventureFXPlayer.transform.DOJump(endValue, DROP_COIN_ANI_POWER, 1, DROP_COIN_ANI_DURATION).OnComplete(() =>
					{
						dropData.aniComplete = true;
					});
					seList.Add(item);
				}
			}
		}
	}

	private IEnumerator Wait(Action callback, float duration)
	{
		yield return new WaitForSeconds(duration);
		callback?.Invoke();
	}

	private void GetDrop(DropData dropData, Vector3 position, Quaternion rotation)
	{
		GameObject gameObject = null;
		for (int i = 0; i < dropInfoList.Count; i++)
		{
			DropInfo dropInfo = dropInfoList.get_Item(i);
			if (dropInfo.dropType == dropData.dropType)
			{
				gameObject = dropInfo.getPrefab;
				break;
			}
		}
		if (null != gameObject)
		{
			AdventureFXPlayer.PlayFX(gameObject, 1f, position, rotation);
		}
		AdventureFXPlayer dropEffect = dropData.dropEffect;
		if (null != dropEffect)
		{
			dropEffect.Stop();
		}
		if (dropData.dropType == DropType.Coin)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("CSHARP2LUA_BATTLE_DROP_COIN", dropData.dropNum);
		}
	}

	private void UpdateDropLogic()
	{
		PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor;
		if (!(null != playerAdventureActor))
		{
			return;
		}
		Vector3 position = playerAdventureActor.transform.position;
		Quaternion rotation = playerAdventureActor.transform.rotation;
		if (null != playerAdventureActor.slotConfig)
		{
			Transform slotNode = playerAdventureActor.slotConfig.GetSlotNode(AnimationSlotConfigComponent.SlotType.Body);
			if (null != slotNode)
			{
				position = slotNode.position;
				rotation = slotNode.rotation;
			}
		}
		Vector3 vector = position;
		vector.y = 0f;
		for (int num = dropEffectList.Count - 1; num >= 0; num--)
		{
			DropData dropData = dropEffectList.get_Item(num);
			if (dropData.flyToPlayer && dropData.aniComplete)
			{
				Vector3 position2 = dropData.dropEffect.transform.position;
				position2.y = 0f;
				if (dropData.noNeedClose || Vector3.Distance(vector, position2) <= DROP_GET_DISTANCE)
				{
					dropEffectList.RemoveAt(num);
					getEffectList.Add(dropData);
				}
			}
		}
		for (int num2 = getEffectList.Count - 1; num2 >= 0; num2--)
		{
			DropData dropData2 = getEffectList.get_Item(num2);
			AdventureFXPlayer dropEffect = dropData2.dropEffect;
			Vector3 position3 = dropEffect.transform.position;
			position3.y = 0f;
			if (Vector3.Distance(position3, vector) <= DROP_DISAPPEAR_DISTANCE)
			{
				GetDrop(dropData2, position, rotation);
				getEffectList.RemoveAt(num2);
			}
			else
			{
				Vector3 currentVelocity = dropData2.currentVelocity;
				float duration = dropData2.duration;
				dropEffect.transform.position = Vector3.SmoothDamp(dropEffect.transform.position, position, ref currentVelocity, duration);
				dropData2.currentVelocity = currentVelocity;
				dropData2.duration -= DROP_GET_DURATION_REDUCE;
				getEffectList.set_Item(num2, dropData2);
			}
		}
	}

	private void ClearDropEffect()
	{
		for (int i = 0; i < dropEffectList.Count; i++)
		{
			DropData dropData = dropEffectList.get_Item(i);
			dropData.dropEffect?.Stop();
			dropData.dropEffect = null;
		}
		dropEffectList.Clear();
		for (int j = 0; j < getEffectList.Count; j++)
		{
			DropData dropData2 = getEffectList.get_Item(j);
			dropData2.dropEffect?.Stop();
			dropData2.dropEffect = null;
		}
		getEffectList.Clear();
	}

	private void SeForceComplete()
	{
		if (seList != null)
		{
			for (int i = 0; i < seList.Count; i++)
			{
				seList.get_Item(i)?.Complete(withCallbacks: true);
			}
			seList.Clear();
		}
		for (int j = 0; j < dropEffectList.Count; j++)
		{
			DropData dropData = dropEffectList.get_Item(j);
			dropData.aniComplete = true;
			dropData.noNeedClose = true;
			dropEffectList.set_Item(j, dropData);
		}
	}

	public void FinalDrop()
	{
		for (int i = 0; i < dropInfoList.Count; i++)
		{
			DropInfo dropInfo = dropInfoList.get_Item(i);
			int dropMax = dropInfo.dropMax;
			if (dropMax <= 0)
			{
				continue;
			}
			if (dropInfo.dropType == DropType.SmallEXP)
			{
				HotfixEnum.monsterEpicType monsterEpicType = lastEpicType;
				if (monsterEpicType == HotfixEnum.monsterEpicType.LORD || monsterEpicType == HotfixEnum.monsterEpicType.LEADER)
				{
					continue;
				}
				DropItem(dropInfo, lastDropPosition, lastDropRotation, dropMax);
				dropInfo.Drop(dropMax);
				for (int j = 0; j < dropInfoList.Count; j++)
				{
					DropInfo dropInfo2 = dropInfoList.get_Item(j);
					if (dropInfo2.dropType == DropType.BigExp)
					{
						dropInfo2.Drop(dropMax);
					}
				}
			}
			else if (dropInfo.dropType == DropType.BigExp)
			{
				HotfixEnum.monsterEpicType monsterEpicType = lastEpicType;
				if (monsterEpicType != HotfixEnum.monsterEpicType.LORD && monsterEpicType != HotfixEnum.monsterEpicType.LEADER)
				{
					continue;
				}
				DropItem(dropInfo, lastDropPosition, lastDropRotation, dropMax);
				dropInfo.Drop(dropMax);
				for (int k = 0; k < dropInfoList.Count; k++)
				{
					DropInfo dropInfo3 = dropInfoList.get_Item(k);
					if (dropInfo3.dropType == DropType.SmallEXP)
					{
						dropInfo3.Drop(dropMax);
					}
				}
			}
			else
			{
				DropItem(dropInfo, lastDropPosition, lastDropRotation, dropMax);
				dropInfo.Drop(dropMax);
			}
		}
		for (int l = 0; l < dropEffectList.Count; l++)
		{
			dropEffectList.get_Item(l).flyToPlayer = true;
		}
		StartCoroutine(Wait(() =>
		{
			SeForceComplete();
		}, DROP_WAIT2GET_DURATION));
	}

	protected int Random(int min, int max)
	{
		int result = min;
		if (Application.isPlaying && null != MonoSingleton<GameController>.Instance)
		{
			result = MonoSingleton<GameController>.Instance.Random_Roguelike(min, max);
		}
		return result;
	}

	public MonsterSpawnData ParseMonsterGroupSet(StarTowerEnemySet enemySet)
	{
		return new MonsterSpawnData
		{
			maxNum = enemySet.MaxNum,
			waveMaxNum = enemySet.MaxNumPerWave,
			monsterId = enemySet.MonsterId,
			setId = enemySet.SetId,
			refInterval = enemySet.RefInterval
		};
	}

	public List<MonsterSpawnDataList> GenerateLevelMonsterInfo(StarTowerFloor floorData, StarTowerMap mapData)
	{
		if (floorData == null)
		{
			return null;
		}
		string commonMonsterSet = floorData.CommonMonsterSet;
		if (string.IsNullOrEmpty(commonMonsterSet))
		{
			return null;
		}
		int num = 0;
		try
		{
			JsonData jsonData = JsonMapper.ToObject(commonMonsterSet);
			int num2 = 0;
			foreach (JsonData item in (IEnumerable)jsonData)
			{
				int num3 = (int)item.get_Item("Weight");
				num2 += num3;
			}
			int num4 = Random(0, num2);
			num2 = 0;
			foreach (JsonData item2 in (IEnumerable)jsonData)
			{
				int num5 = (int)item2.get_Item("Id");
				int num6 = (int)item2.get_Item("Weight");
				num2 += num6;
				if (num4 <= num2)
				{
					num = num5;
					break;
				}
			}
		}
		catch (Exception)
		{
			_logger.LogError("JSON解析出错:EnemySet:" + commonMonsterSet);
			return null;
		}
		if (num == 0)
		{
			_logger.LogError("没有找到合适的怪物SetId!");
			return null;
		}
		List<StarTowerEnemySet> starTowerEnemySetData = Singleton<HotfixDataController>.Instance.StarTowerEnemySetData;
		List<StarTowerEnemySet> list = new List<StarTowerEnemySet>();
		for (int i = 0; i < starTowerEnemySetData.Count; i++)
		{
			StarTowerEnemySet starTowerEnemySet = starTowerEnemySetData.get_Item(i);
			if (starTowerEnemySet.SetId == num)
			{
				list.Add(starTowerEnemySet);
			}
		}
		if (list.Count == 0)
		{
			_logger.LogError($"找不到合适的怪物Set数据,SetId = {num}");
			return null;
		}
		List<MonsterSpawnDataList> monsterSpawnDataLists = new List<MonsterSpawnDataList>();
		for (int j = 0; j < list.Count; j++)
		{
			StarTowerEnemySet starTowerEnemySet2 = list.get_Item(j);
			int waveNum = starTowerEnemySet2.WaveNum;
			MonsterSpawnData data = ParseMonsterGroupSet(starTowerEnemySet2);
			if (!TryGetValue(waveNum, out var dataList))
			{
				dataList = new MonsterSpawnDataList(waveNum);
				monsterSpawnDataLists.Add(dataList);
			}
			dataList.Add(data);
		}
		monsterSpawnDataLists.Sort((MonsterSpawnDataList x, MonsterSpawnDataList y) => x.CompareTo(y));
		return monsterSpawnDataLists;
		bool TryGetValue(int waveIndex, out MonsterSpawnDataList reference)
		{
			for (int k = 0; k < monsterSpawnDataLists.Count; k++)
			{
				MonsterSpawnDataList monsterSpawnDataList = monsterSpawnDataLists.get_Item(k);
				if (monsterSpawnDataList.waveIndex == waveIndex)
				{
					reference = monsterSpawnDataList;
					return true;
				}
			}
			reference = null;
			return false;
		}
	}

	private void addEventPrologue()
	{
		dicUltarCor.Clear();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("INTERACTIVEID", OnPrologueNextFloor);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_SPAWN_COMPLRTR", ActorSpawnComplete);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("INPUT_ENABLE", OnInputEnable);
	}

	private void removeEventPrologue()
	{
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("INTERACTIVEID", OnPrologueNextFloor);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_SPAWN_COMPLRTR", ActorSpawnComplete);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("INPUT_ENABLE", OnInputEnable);
		foreach (KeyValuePair<int, Coroutine> item in dicUltarCor)
		{
			StopCoroutine(item.Value);
		}
		dicUltarCor.Clear();
	}

	private void OnPrologueNextFloor(IEvent evt)
	{
		if (evt is AdventureInteractiveIDTrigger adventureInteractiveIDTrigger && string.Equals(adventureInteractiveIDTrigger.interactiveID, "PrologueNextFloor"))
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("LevelStateChanged", 3, 0);
		}
	}

	private void ActorSpawnComplete(IEvent ievent)
	{
		List<string> btnNames = levelLoadParams.btnNames;
		if (btnNames == null || btnNames.Count <= 0)
		{
			return;
		}
		StringBuilder stringBuilder = new StringBuilder();
		foreach (string item in btnNames)
		{
			stringBuilder.Append("+");
			stringBuilder.Append(item);
		}
		MonoSingleton<LuaManager>.Instance.FireEvent("EnableBtnControl", stringBuilder.ToString(), a2: false);
	}

	private void CharUltraCanUse(IEvent ievent)
	{
		if (!(ievent is GeneralEvent generalEvent))
		{
			return;
		}
		LuaTable obj = generalEvent.data as LuaTable;
		CommonHelper.TryParseStringParamToInt(obj.get_Item((object)1).ToString(), out var intValue);
		bool.TryParse(obj.get_Item((object)2).ToString(), out var result);
		if (result)
		{
			if (dicUltarCor.ContainsKey(intValue))
			{
				StopCoroutine(dicUltarCor.get_Item(intValue));
			}
			Coroutine value = StartCoroutine(CorWaitShowUltarBtnFX(8f, intValue));
			dicUltarCor.set_Item(intValue, value);
		}
		else if (dicUltarCor.ContainsKey(intValue))
		{
			StopCoroutine(dicUltarCor.get_Item(intValue));
			dicUltarCor.Remove(intValue);
		}
	}

	private IEnumerator CorWaitShowUltarBtnFX(float delayTime, int tmpActionPosId)
	{
		yield return new WaitForSeconds(delayTime);
		MonoSingleton<LuaManager>.Instance.FireEvent("Open_Ultra_Special_FX", tmpActionPosId);
	}

	private void OnInputEnable(IEvent evt)
	{
		if (evt is AdventureInputEnable adventureInputEnable && (!levelLoadParams.isStarTowerPrologue || levelLoadParams.starTowerFloorSet.BattleLvs != 1))
		{
			SceneSingleton<AdventurePlayerController>.Instance.showVisionAttackRange = adventureInputEnable.enbale;
		}
	}
}
