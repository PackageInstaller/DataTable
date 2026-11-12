using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using AK.Wwise;
using Google.Protobuf.Collections;
using LitJson;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.UI.Extensions;

[Serializable]
public class AdventureModuleLevelLoadParams
{
	public struct MapGroupStageCount
	{
		public int stage;

		public int group;

		public int count;

		public MapGroupStageCount(int stage, int group, int count)
		{
			this.stage = stage;
			this.group = group;
			this.count = count;
		}

		public MapGroupStageCount(JsonData jsonData)
		{
			stage = (int)jsonData.get_Item("Stage");
			group = (int)jsonData.get_Item("Group");
			count = (int)jsonData.get_Item("Count");
		}

		public JsonData ToJsonData()
		{
			JsonData jsonData = new JsonData();
			jsonData.SetJsonType(JsonType.Object);
			jsonData.set_Item("Stage", (JsonData)stage);
			jsonData.set_Item("Group", (JsonData)group);
			jsonData.set_Item("Count", (JsonData)count);
			return jsonData;
		}
	}

	public enum BootConfigLoadType
	{
		None = 0,
		Prologue = 1,
		PrologueBattleLevel = 2,
		Mainline = 10,
		RegionBoss = 23,
		WeeklyCopies = 25,
		BattleTestBedComboClip = 34,
		TravelerDuel = 40,
		TravelerDuelEditor = 41,
		DailyInstance_Formal = 51,
		DailyInstance_BootConfig = 52,
		InfinityTower_Fromal = 61,
		InfinityTower_BootConfig = 62,
		EquipmentInstance_Formal = 71,
		EquipmentInstance_BootConfig = 72,
		StarTower_Formal = 80,
		StarTower_ByRandom = 81,
		StarTower_ByFixedId = 82,
		StarTower_ByFixedId_ThroughBootConfig = 83,
		StarTower_Limitless = 85,
		VampireSurvivor_Fromal = 90,
		VampireSurvivor_BootConfig = 91,
		SceneView = 99,
		ScoreBoss_Fromal = 100,
		ScoreBoss_BootConfig = 101,
		SkillInstance_Formal = 111,
		SkillInstance_BootConfig = 112,
		DynamicLevel = 120,
		AutoBattleBalance_BootConfig = 130,
		ActivityLevelsInstance_Formal = 140,
		TowerDefense = 150,
		BreakOut_BootConfig = 160,
		ActivityStoryLevels = 170
	}

	public BootConfigLoadType loadType;

	public string id;

	protected int levelID;

	protected int battleLv;

	public int starTowerStageID;

	public string mapId;

	[ReadOnly]
	public const int DefaultTiledColorMapSize = 1024;

	[ReadOnly]
	public int tiledColorMapSize;

	public int floor;

	[HideInInspector]
	public bool isHalfVampireBattleMode;

	[HideInInspector]
	public List<int> vampireSpecialEnemySet = new List<int>();

	[HideInInspector]
	public List<int> vampireTreasureSet = new List<int>();

	[HideInInspector]
	public List<VampireDropData> vampireDropList = new List<VampireDropData>();

	public bool isVampireFirstHalf;

	public int monsterLevel = 1;

	[HideInInspector]
	public bool isBattleEnd;

	[HideInInspector]
	public bool isFinalLevelFloor;

	public int levelDifficultLv = 1;

	public Lua2CSharpInfo_RoguelikeChestInfo[] rogueTreasureBoxInfos;

	public Lua2CSharpInfo_FixedRoguelike fixedRoguelikeInfo;

	[UnityEngine.UI.Extensions.ReadOnly]
	[HideInInspector]
	public int[] mainlineOpenedTreasureBoxs;

	[HideInInspector]
	public List<FixedRoguelikeRoomData> fixedRoguelikeRoomData;

	[HideInInspector]
	public RandomMonsterSpawnWaveGizmo.RdmMonsterSpawnInfo rogRdmMonsterSpawnInfo;

	[SerializeField]
	[HideInInspector]
	public string strRdmMonsterSpawnInfo;

	[HideInInspector]
	public bool isThreePlayer;

	[HideInInspector]
	public Vector3 revivalPoint = Vector3.zero;

	[HideInInspector]
	public bool isStarTowerPrologue;

	[HideInInspector]
	public List<string> btnNames = new List<string>();

	[HideInInspector]
	public int dropEntityGroupId;

	[HideInInspector]
	public FP dropEntityRate;

	[HideInInspector]
	public int dropMaxNum;

	public int dynamicLevelType;

	public string[] enterDynamicLevelParams;

	public HotfixEnum.elementType autoBattleBalanceEET = HotfixEnum.elementType.WE;

	public AutoBattleBalanceConfig autoBattleBalanceConfig;

	[HideInInspector]
	public FP balanceMainPlayHPPre;

	[HideInInspector]
	public int balanceTeamIndex;

	[ReadOnly]
	public int[] starTowerDropInfo;

	public StarTowerCombo starTowerCombo;

	public StarTowerFloorSet starTowerFloorSet;

	public StarTowerScenePrefab starTowerScenePrefab;

	[HideInInspector]
	public int nextRoomType;

	public string dmgRecordId;

	public string dynamicBGM;

	public string dynamicLeaveMusicEvent;

	public string dynamicSceneName;

	public float dynamicParam;

	[HideInInspector]
	public float levelRunningTime;

	public State[] bgmState;

	public MainlineFloor mainlineFloorData { get; protected set; }

	public RegionBossFloor regionBossFloor { get; protected set; }

	public StarTowerStage starTowerStage { get; protected set; }

	public StarTowerFloor starTowerFloor { get; protected set; }

	public StarTowerMap starTowerMap { get; protected set; }

	public RegionBossLevel regionBossLevel { get; protected set; }

	public bool isInfinityContinueBattle { get; set; }

	public HotfixEnum.worldLevelType levelType { get; set; }

	public bool viewSceneMode { get; private set; }

	public bool sendBattleEndMsg { get; private set; } = true;

	public bool gmOrderLevel { get; private set; }

	public string starTowerScenePath { get; protected set; }

	public string starTowerConfigPath { get; protected set; }

	public string starTowerConfigExtension { get; protected set; }

	public bool isRaceStarTower
	{
		get
		{
			if (!string.IsNullOrEmpty(dmgRecordId))
			{
				return levelType == HotfixEnum.worldLevelType.StarTower;
			}
			return false;
		}
	}

	public AdventureModuleLevelLoadParams()
	{
		tiledColorMapSize = 1024;
	}

	public AdventureModuleLevelLoadParams(string id)
	{
		this.id = id;
		isStarTowerPrologue = false;
		tiledColorMapSize = 1024;
	}

	public AdventureModuleLevelLoadParams(int levelID, int battleLv)
	{
		this.levelID = levelID;
		this.battleLv = battleLv;
	}

	public void GenerateViewSceneData(HotfixEnum.worldLevelType levelType, bool viewSceneMode = true, int starTowerFloorSetId = 0, int prefabID = 0, string prefabExtension = "", int playType = 0, bool sceneDoMir = false)
	{
		this.viewSceneMode = !viewSceneMode;
		this.levelType = levelType;
		gmOrderLevel = true;
		switch (levelType)
		{
		case HotfixEnum.worldLevelType.RegionBoss:
			RegionBoss_GenerateFloorData();
			break;
		case HotfixEnum.worldLevelType.Mainline:
		case HotfixEnum.worldLevelType.Prologue:
		case HotfixEnum.worldLevelType.PrologueBattleLevel:
			Mainline_GenerateFloorData();
			break;
		case HotfixEnum.worldLevelType.StarTower:
			StarTower_GenerateMapData_ViewSceneMode(CommonHelper.ParseStringParamToInt(id), starTowerFloorSetId, prefabID, prefabExtension, playType, sceneDoMir);
			break;
		case HotfixEnum.worldLevelType.TravelerDuel:
			floor = CommonHelper.ParseStringParamToInt(id);
			break;
		case HotfixEnum.worldLevelType.DailyInstance:
			floor = CommonHelper.ParseStringParamToInt(id);
			break;
		case HotfixEnum.worldLevelType.EquipmentInstance:
			floor = CommonHelper.ParseStringParamToInt(id);
			break;
		case HotfixEnum.worldLevelType.SkillInstance:
			floor = CommonHelper.ParseStringParamToInt(id);
			break;
		case HotfixEnum.worldLevelType.AutoBalance:
			mainlineFloorData = Singleton<HotfixDataController>.Instance.GetMainlineFloor(CommonHelper.ParseStringParamToInt(id));
			if (mainlineFloorData == null)
			{
				Debug.LogError("平衡性测试关卡 ID 错误，没有找到相应的数据 id = " + id);
			}
			break;
		default:
			throw new ArgumentOutOfRangeException("levelType", levelType, null);
		case HotfixEnum.worldLevelType.Branchline:
		case HotfixEnum.worldLevelType.InfinityTower:
		case HotfixEnum.worldLevelType.VampireInstance:
		case HotfixEnum.worldLevelType.ScoreBoss:
		case HotfixEnum.worldLevelType.WeeklyCopies:
		case HotfixEnum.worldLevelType.ActivityLevels:
		case HotfixEnum.worldLevelType.ActivityStory:
			break;
		}
	}

	public MainlineFloor Mainline_GenerateFloorData()
	{
		mainlineFloorData = Singleton<HotfixDataController>.Instance.GetMainlineFloor(CommonHelper.ParseStringParamToInt(id));
		if (mainlineFloorData == null)
		{
			Debug.LogError("主线ID 错误，没有找到相应的数据 id = " + id);
			return null;
		}
		monsterLevel = mainlineFloorData.MonsterLv;
		return mainlineFloorData;
	}

	public StarTowerFloor StarTower_GenerateFloorData()
	{
		starTowerFloor = Singleton<HotfixDataController>.Instance.GetStarTowerFloor(CommonHelper.ParseStringParamToInt(id));
		return starTowerFloor;
	}

	public void StarTower_GenerateMapData_ViewSceneMode(int mapID, int floorSetId, int prefabID = 0, string prefabExtension = "", int playType = 0, bool sceneDoMir = false)
	{
		sendBattleEndMsg = false;
		tiledColorMapSize = 1024;
		starTowerMap = StarTower_GenerateMapData(mapID);
		if (starTowerMap == null)
		{
			return;
		}
		starTowerConfigExtension = prefabExtension;
		GenerateScenePrefab(prefabID);
		GenerateMapConfig(reconnect: true);
		if (sceneDoMir)
		{
			if (!starTowerScenePath.EndsWith("_Mir"))
			{
				starTowerScenePath += "_Mir";
			}
			if (!starTowerConfigPath.EndsWith("_Mir"))
			{
				starTowerConfigPath += "_Mir";
			}
			if (!starTowerConfigExtension.EndsWith("_Mir"))
			{
				starTowerConfigExtension += "_Mir";
			}
		}
		if (viewSceneMode)
		{
			return;
		}
		if (floorSetId > 0)
		{
			starTowerFloorSet = Singleton<HotfixDataController>.Instance.GetStarTowerFloorSet(floorSetId);
			if (starTowerFloorSet == null)
			{
				Debug.LogError("战斗模式的星塔需要填入正确的StarTowerFloorSetID!");
				return;
			}
		}
		else
		{
			List<int> list = new List<int>();
			foreach (StarTowerFloorSet value in Singleton<HotfixDataController>.Instance.StarTowerFloorSetData.Values)
			{
				if (value.MapID.Contains(mapID))
				{
					list.Add(value.Id);
				}
			}
			if (list.Count == 0)
			{
				Debug.LogError("关卡战斗模式下没有随机到合适的【StarTowerFloorSet】数据，请检查填入的其余参数，或者手动填入FloorSetID!");
				return;
			}
			int index = MonoSingleton<GameController>.Instance.Random_Roguelike(0, list.Count);
			starTowerFloorSet = Singleton<HotfixDataController>.Instance.GetStarTowerFloorSet(list.get_Item(index));
		}
		monsterLevel = starTowerFloorSet.MonsterLv;
		GenerateStarTowerFloor(0, playType);
	}

	public StarTowerMap StarTower_GenerateMapData(int mapID)
	{
		starTowerMap = Singleton<HotfixDataController>.Instance.GetStarTowerMap(mapID);
		if (starTowerMap == null)
		{
			Debug.LogError($"固定rog关卡:从Roguelikemap表里没有找到ID为{mapID}的数据!");
			return null;
		}
		return starTowerMap;
	}

	public void StarTower_GenerateMapData(Lua2CSharpInfo_FixedRoguelike info)
	{
		fixedRoguelikeInfo = info;
		starTowerConfigExtension = info.extension;
		HotfixDataController instance = Singleton<HotfixDataController>.Instance;
		starTowerStage = instance.GetStarTowerStage(info.startowerStageId);
		if (starTowerStage == null)
		{
			Debug.LogError($"[StarTowerStage]表中没有找到ID为{info.startowerStageId}的数据!");
			return;
		}
		starTowerCombo = instance.GetStarTowerCombo(info.startowerId);
		if (starTowerCombo == null)
		{
			Debug.LogError($"星塔：【StarTowerCombo】数据为空:{info.startowerId}");
			return;
		}
		RepeatedField<int> battleLvs = starTowerCombo.BattleLvs;
		_ = battleLv;
		if (battleLvs.Count == 0)
		{
			Debug.LogError($"星塔：【StarTowerCombo】战斗等级数据为空:{starTowerCombo.Id}");
			return;
		}
		int stage = starTowerStage.Stage;
		battleLv = starTowerStage.Floor;
		HotfixEnum.starTowerRoomType dangerRoom = (HotfixEnum.starTowerRoomType)info.dangerRoom;
		bool flag = dangerRoom == HotfixEnum.starTowerRoomType.DangerRoom || dangerRoom == HotfixEnum.starTowerRoomType.HorrorRoom;
		for (int i = 0; i < battleLvs.Count; i++)
		{
			StarTowerFloorSet starTowerFloorSet = instance.GetStarTowerFloorSet(battleLvs.get_Item(i));
			if (starTowerFloorSet == null)
			{
				Debug.LogError($"星塔：获取【StarTowerFloorSet】数据为空:StarTowerCombo id:{starTowerCombo.Id}_battleLv:{battleLvs.get_Item(i)}");
				continue;
			}
			if (flag)
			{
				if (starTowerFloorSet.RoomType != info.dangerRoom)
				{
					continue;
				}
			}
			else
			{
				if (starTowerFloorSet.BattleLvs != battleLv)
				{
					continue;
				}
				dangerRoom = (HotfixEnum.starTowerRoomType)starTowerFloorSet.RoomType;
				if (dangerRoom == HotfixEnum.starTowerRoomType.DangerRoom || dangerRoom == HotfixEnum.starTowerRoomType.HorrorRoom)
				{
					continue;
				}
			}
			if (!starTowerFloorSet.Stage.ToList().Contains(stage))
			{
				continue;
			}
			this.starTowerFloorSet = starTowerFloorSet;
			break;
		}
		if (this.starTowerFloorSet == null)
		{
			Debug.LogError("星塔【StarTowerFloorSet】数据为空!");
			return;
		}
		monsterLevel = this.starTowerFloorSet.MonsterLv;
		Debug.Log($"怪物等级:{monsterLevel}");
		int nMapId = info.nMapId;
		int[] historyGroupMaps;
		if (nMapId != 0)
		{
			starTowerMap = instance.GetStarTowerMap(nMapId);
			GenerateScenePrefab(info.scenePrefabId);
		}
		else
		{
			historyGroupMaps = info.arrHistoryGroupIds;
			for (int j = 0; j < historyGroupMaps.Length; j++)
			{
				Debug.Log($"历史记录mapID[{j}] = {historyGroupMaps[j]}");
			}
			int[] array = this.starTowerFloorSet.MapID.ToArray();
			if (array.Length == 0)
			{
				Debug.LogError($"星塔【StarTowerFloorSet】中MapID为空：set id {this.starTowerFloorSet.Id}");
				return;
			}
			if (array.Length > 1)
			{
				List<int> list = new List<int>();
				foreach (int num in array)
				{
					if (!IsInHistory(num))
					{
						list.Add(num);
					}
				}
				if (list.Count > 0)
				{
					int index = MonoSingleton<GameController>.Instance.Random_Roguelike(0, list.Count);
					starTowerMap = instance.GetStarTowerMap(list.get_Item(index));
				}
				if (starTowerMap == null && historyGroupMaps.Length != 0)
				{
					starTowerMap = instance.GetStarTowerMap(historyGroupMaps[0]);
				}
			}
			else
			{
				starTowerMap = instance.GetStarTowerMap(array[0]);
			}
		}
		if (starTowerMap == null)
		{
			Debug.LogError("星塔【StarTowerMap】数据为空");
			return;
		}
		GenerateScenePrefab();
		GenerateMapConfig(nMapId != 0);
		GenerateStarTowerFloor(info.floorId);
		tiledColorMapSize = 1024;
		bool IsInHistory(int mapID)
		{
			if (historyGroupMaps == null || historyGroupMaps.Length == 0)
			{
				return false;
			}
			for (int l = 0; l < historyGroupMaps.Length; l++)
			{
				if (mapID == historyGroupMaps[l])
				{
					return true;
				}
			}
			return false;
		}
	}

	private void GenerateStarTowerFloor(int floorID = 0, int appointedGameplayType = 0)
	{
		if (floorID > 0)
		{
			this.starTowerFloor = Singleton<HotfixDataController>.Instance.GetStarTowerFloor(floorID);
		}
		else if (appointedGameplayType > 0 || starTowerScenePrefab.GameplayTypes.Count > 0)
		{
			int[] array = starTowerFloorSet.FloorID.ToArray();
			if (array.Length == 0)
			{
				Debug.LogError($"星塔【引用Floor】数据为空：FloorSet ID : {starTowerFloorSet.Id}");
				return;
			}
			List<int> list = new List<int>();
			foreach (int num in array)
			{
				StarTowerFloor starTowerFloor = Singleton<HotfixDataController>.Instance.GetStarTowerFloor(num);
				if (appointedGameplayType > 0)
				{
					if (appointedGameplayType != starTowerFloor.CommonGameplayType)
					{
						continue;
					}
				}
				else if (!starTowerScenePrefab.GameplayTypes.Contains(starTowerFloor.CommonGameplayType))
				{
					continue;
				}
				list.Add(num);
			}
			if (list.Count == 0)
			{
				Debug.LogError("星塔 没有找到合适的floor数据");
				return;
			}
			int index = MonoSingleton<GameController>.Instance.Random_Roguelike(0, list.Count);
			this.starTowerFloor = Singleton<HotfixDataController>.Instance.GetStarTowerFloor(list.get_Item(index));
		}
		if (this.starTowerFloor != null)
		{
			Debug.Log($"固定随机关卡:选取Floor数据ID={this.starTowerFloor.Id}");
			dropEntityGroupId = this.starTowerFloor.DropObjectGroupId;
			dropEntityRate = FP.FromMyriad(this.starTowerFloor.DropObjectRate);
			dropMaxNum = this.starTowerFloor.DropMaxNum;
			id = this.starTowerFloor.Id.ToString();
		}
	}

	private void GenerateScenePrefab(int prefabId = 0)
	{
		if (prefabId > 0)
		{
			starTowerScenePrefab = Singleton<HotfixDataController>.Instance.GetStarTowerScenePrefab(prefabId);
			return;
		}
		int[] array = starTowerMap.PrefabNum.ToArray();
		if (array.Length == 0)
		{
			Debug.LogError($"星塔【StarTowerMap】中PrefabNum为空：map id {starTowerMap.Id}");
			return;
		}
		int num = 0;
		if (array.Length > 1)
		{
			num = MonoSingleton<GameController>.Instance.Random_Roguelike(0, array.Length);
		}
		starTowerScenePrefab = Singleton<HotfixDataController>.Instance.GetStarTowerScenePrefab(array[num]);
	}

	private void GenerateMapConfig(bool reconnect = false)
	{
		if (starTowerMap == null)
		{
			return;
		}
		if (reconnect)
		{
			if (string.IsNullOrEmpty(starTowerConfigExtension))
			{
				DoRdmConfig();
			}
			else
			{
				if (starTowerConfigExtension.EndsWith("Mir"))
				{
					starTowerScenePath = starTowerMap.SceneRes + "_Mir";
				}
				else
				{
					starTowerScenePath = starTowerMap.SceneRes;
				}
				starTowerConfigPath = starTowerScenePrefab.ConfigRes + "_" + starTowerConfigExtension;
			}
		}
		else
		{
			DoRdmConfig();
		}
		Debug.Log("场景路径:" + starTowerScenePath);
		Debug.Log("预制体路径:" + starTowerConfigPath);
		Debug.Log("预制体后缀:" + starTowerConfigExtension);
		void DoRdmConfig()
		{
			string bianQuan = starTowerScenePrefab.BianQuan;
			if (string.IsNullOrEmpty(bianQuan))
			{
				bool flag = starTowerMap.Mir;
				if (flag)
				{
					flag = MonoSingleton<GameController>.Instance.Random_Roguelike(0, 2) == 0;
				}
				if (flag)
				{
					starTowerScenePath = starTowerMap.SceneRes + "_Mir";
					starTowerConfigPath = starTowerScenePrefab.ConfigRes ?? "";
					starTowerConfigExtension = "Mir";
				}
				else
				{
					starTowerScenePath = starTowerMap.SceneRes;
					starTowerConfigPath = starTowerScenePrefab.ConfigRes;
					starTowerConfigExtension = string.Empty;
				}
				return;
			}
			try
			{
				JsonData jsonData = JsonMapper.ToObject(bianQuan);
				int num = 0;
				foreach (JsonData item in (IEnumerable)jsonData)
				{
					int num2 = (int)item.get_Item("Weight");
					num += num2;
				}
				int num3 = MonoSingleton<GameController>.Instance.Random_Roguelike(0, num);
				num = 0;
				string text = string.Empty;
				foreach (JsonData item2 in (IEnumerable)jsonData)
				{
					int num4 = (int)item2.get_Item("Weight");
					num += num4;
					if (num >= num3)
					{
						text = (string)item2.get_Item("Id");
						break;
					}
				}
				if (!string.IsNullOrEmpty(text))
				{
					bool flag2 = starTowerMap.Mir;
					if (flag2)
					{
						flag2 = MonoSingleton<GameController>.Instance.Random_Roguelike(0, 2) == 0;
					}
					if (flag2)
					{
						starTowerConfigExtension = text + "_Mir";
						starTowerScenePath = starTowerMap.SceneRes + "_Mir";
					}
					else
					{
						starTowerConfigExtension = text ?? "";
						starTowerScenePath = starTowerMap.SceneRes;
					}
					starTowerConfigPath = starTowerScenePrefab.ConfigRes + "_" + starTowerConfigExtension;
				}
			}
			catch (Exception)
			{
				Debug.LogError($"解析json出错,ScenePrefabID:{starTowerScenePrefab.Id},字段[BianQuan]");
			}
		}
	}

	public RegionBossFloor RegionBoss_GenerateFloorData()
	{
		regionBossFloor = Singleton<HotfixDataController>.Instance.GetRegionBossFloor(CommonHelper.ParseStringParamToInt(id));
		if (regionBossFloor != null)
		{
			monsterLevel = regionBossFloor.MonsterLv;
		}
		return regionBossFloor;
	}

	public RegionBossLevel RegionBoss_GenerateLvData(int regionBosslvId)
	{
		regionBossLevel = Singleton<HotfixDataController>.Instance.GetRegionBossLevel(regionBosslvId);
		return regionBossLevel;
	}

	private void playBgm()
	{
		if (bgmState.Length != 0)
		{
			for (int i = 0; i < bgmState.Length; i++)
			{
				MonoSingleton<WwiseAudioManager>.Instance.SetState(bgmState[i]);
			}
		}
	}

	private void SetFullEnergy()
	{
		foreach (long currentGroupPlayer in AdventureModuleHelper.GetCurrentGroupPlayers())
		{
			PlayerSkillCd playerSkillCd = AdventureModuleHelper.GetPlayerSkillCd(currentGroupPlayer);
			if (playerSkillCd != null)
			{
				FDP energy = playerSkillCd.GetTotalEnergy();
				playerSkillCd.SetEnergy(energy);
			}
		}
	}

	private void BalanceNextLv()
	{
		if (ModuleController<AdventureModuleController>.Instance.levelInstance is AutoBattleBalanceLevelController autoBattleBalanceLevelController)
		{
			autoBattleBalanceLevelController.LevelStateChangedCall(HotfixEnum.levelState.Success);
		}
	}
}
