#define LOG_WARNING
using System.Collections.Generic;
using Nova.Hotfix;
using UnityEngine;
using UnityEngine.UI.Extensions;

public class AdventureModulePreloadAssetsMrg : MonoSingleton<AdventureModulePreloadAssetsMrg>
{
	protected const string PreloadMonsterConfigFolderPath = "preload_configs/monsterSpawnConfigs/";

	protected const string PreloadSceneObjConfigFolderPath = "preload_configs/sceneObjConfigs/";

	public Dictionary<string, Dictionary<string, List<AdventureLevelMonsterSpawnConfig.MonsterSpawnConfig>>> preloadMonsterConfigs;

	public List<AdventureLevelMonsterSpawnConfig.MonsterSpawnConfig> monsterSpawnConfigs;

	public bool isPreload;

	protected Dictionary<string, AdventureLevelObjectConfig> objConfigDic = new Dictionary<string, AdventureLevelObjectConfig>();

	public Dictionary<int, List<StarTowerMonsterBornGroup>> monsterBornGroupDic;

	public AdventureModuleLevelLoadParams preloadLevelParam { get; protected set; }

	public int PreloadMonsterCount
	{
		get
		{
			if (!MonoSingleton<ClientManager>.Instance.GetMemoryType())
			{
				return 3;
			}
			return 2;
		}
	}

	public AdventureLevelObjectConfig GetObjConfig(string sceneName)
	{
		if (objConfigDic.TryGetValue(sceneName, out var value))
		{
			Debug.LogError("get : " + sceneName + " is " + ((null == value) ? "null" : "not null"));
			if (null != value)
			{
				return Object.Instantiate(value);
			}
		}
		Debug.LogError("没有找到场景物体配置文件:" + sceneName + ".asset");
		return null;
	}

	public void PreloadMonsters(List<StarTowerLevelController.MonsterSpawnDataList> spawnMonsterDataList)
	{
		if (spawnMonsterDataList == null)
		{
			return;
		}
		for (int i = 0; i < spawnMonsterDataList.Count; i++)
		{
			List<StarTowerLevelController.MonsterSpawnData> monsterSpawnDatas = spawnMonsterDataList.get_Item(i).monsterSpawnDatas;
			if (monsterSpawnDatas != null && monsterSpawnDatas.Count != 0)
			{
				for (int j = 0; j < monsterSpawnDatas.Count; j++)
				{
					PreloadMonster(monsterSpawnDatas.get_Item(j).monsterId, isRoguelikeMonster: true);
				}
			}
		}
	}

	public void PreloadMonsters_IDList(List<int> monsterids, bool isRoguelikeMonster)
	{
		for (int i = 0; i < monsterids.Count; i++)
		{
			PreloadMonster(monsterids.get_Item(i), isRoguelikeMonster);
		}
	}

	public void PreloadMonster(int monsterID, bool isRoguelikeMonster)
	{
		if (monsterID == 0)
		{
			Debug.Log($"ID={monsterID}的怪物数据不存在");
			return;
		}
		Monster monster = Singleton<HotfixDataController>.Instance.GetMonster(monsterID);
		if (monster == null)
		{
			Debug.Log($"ID={monsterID}的怪物数据不存在");
			return;
		}
		MonsterSkin monsterSkin = Singleton<HotfixDataController>.Instance.GetMonsterSkin(monster.FAId);
		if (monsterSkin == null)
		{
			Debug.LogError($"怪物{monsterID}skin为空");
			return;
		}
		string model = monsterSkin.Model;
		if (string.IsNullOrEmpty(model))
		{
			Debug.LogError("ID = " + model + " 的怪物模型资源 配置项为空");
			return;
		}
		string assetName = "Assets/AssetBundles/" + model + ".prefab";
		GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Actor, assetName, typeof(GameObject));
		int fCId = monster.FCId;
		string empty = string.Empty;
		MonsterAI monsterAI = Singleton<HotfixDataController>.Instance.GetMonsterAI(fCId);
		if (monsterAI == null)
		{
			AI aI = Singleton<HotfixDataController>.Instance.GetAI(fCId);
			if (aI == null)
			{
				return;
			}
			empty = aI.FCComboGroup;
		}
		else
		{
			empty = monsterAI.ComboGroupPath;
		}
		if (string.IsNullOrEmpty(empty))
		{
			return;
		}
		assetName = "Assets/AssetBundles/Actor/" + empty + ".asset";
		ComboGroup comboGroup = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Actor, assetName, typeof(ComboGroup)) as ComboGroup;
		if (!(null == comboGroup))
		{
			ActorRelatedResourceConfig relatedResourceConfig = comboGroup.relatedResourceConfig;
			if (!(null == relatedResourceConfig))
			{
				PreloadAssets_RelatedRes(relatedResourceConfig);
			}
		}
	}

	public void PreloadAssets_RelatedRes()
	{
	}

	public void PreHandleRelateRes(ActorRelatedResourceConfig config)
	{
	}

	public void PreloadAssets_RelatedRes(ActorRelatedResourceConfig config, bool doPreload = false)
	{
		if (null == config)
		{
			return;
		}
		CommonResourceConfig[] fxs = config.fxs;
		if (fxs != null)
		{
			foreach (CommonResourceConfig commonResourceConfig in fxs)
			{
				GameObject gameObject = commonResourceConfig.prefab;
				if (null == gameObject)
				{
					string text = "Assets/AssetBundles/" + commonResourceConfig.path;
					if (!text.EndsWith(".prefab"))
					{
						text += ".prefab";
					}
					gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.FX, text, typeof(GameObject)) as GameObject;
				}
				if (!(null == gameObject) && doPreload && null != gameObject.GetComponent<AdventureFXPlayer>())
				{
					AdventureFXManager.PreloadFX(null, gameObject);
				}
			}
		}
		CommonResourceConfig[] bullets = config.bullets;
		if (bullets != null)
		{
			foreach (CommonResourceConfig commonResourceConfig2 in bullets)
			{
				if (!(null == commonResourceConfig2.prefab))
				{
					string assetName = "Assets/AssetBundles/" + commonResourceConfig2.path;
					GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Actor, assetName, typeof(GameObject));
				}
			}
		}
		CommonResourceConfig[] timelines = config.timelines;
		if (timelines != null)
		{
			foreach (CommonResourceConfig commonResourceConfig3 in timelines)
			{
				if (commonResourceConfig3.prefab != null)
				{
					commonResourceConfig3.overridePrefab = commonResourceConfig3.prefab;
					return;
				}
				string assetName2 = "Assets/AssetBundles/" + commonResourceConfig3.path;
				GameObject overridePrefab = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Actor, assetName2, typeof(GameObject)) as GameObject;
				commonResourceConfig3.overridePrefab = overridePrefab;
			}
		}
		CommonResourceConfig[] monsterTimelines = config.monsterTimelines;
		if (monsterTimelines != null)
		{
			foreach (CommonResourceConfig commonResourceConfig4 in monsterTimelines)
			{
				if (commonResourceConfig4.prefab != null)
				{
					commonResourceConfig4.overridePrefab = commonResourceConfig4.prefab;
					return;
				}
				string assetName3 = "Assets/AssetBundles/" + commonResourceConfig4.path;
				GameObject overridePrefab2 = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Actor, assetName3, typeof(GameObject)) as GameObject;
				commonResourceConfig4.overridePrefab = overridePrefab2;
			}
		}
		SummonConfig[] summons = config.summons;
		if (summons != null)
		{
			foreach (SummonConfig summonConfig in summons)
			{
				PreloadMonster(summonConfig.monsterID, isRoguelikeMonster: true);
			}
		}
	}

	public void PreloadPlayers(int[] actors)
	{
		if (!isPreload && actors != null)
		{
			for (int i = 0; i < actors.Length; i++)
			{
				PreloadPlayer(actors[i]);
			}
			isPreload = true;
		}
	}

	public void PreloadPlayer(int actorID)
	{
		string text = string.Empty;
		Character character = Singleton<HotfixDataController>.Instance.GetCharacter(actorID);
		if (character == null)
		{
			Debug.LogError($"没有找到ID为{actorID}的角色数据");
			return;
		}
		int num = character.DefaultSkinId;
		if (ModuleController<AdventureModuleController>.Instance.GetActorAttribute(character.Id, out var attribute))
		{
			num = attribute.skinId;
		}
		CharacterSkin characterSkin = Singleton<HotfixDataController>.Instance.GetCharacterSkin(num);
		if (characterSkin != null)
		{
			text = characterSkin.Model;
		}
		string text2 = "Assets/AssetBundles/" + text + ".prefab";
		GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Actor, text2, typeof(GameObject));
		AdventureLevelObjPoolMgr.PoolBase poolBase = SceneSingleton<AdventureLevelObjPoolMgr>.Instance.De_Player(text2);
		if (poolBase == null)
		{
			Debug.LogError("没有找到角色资源" + text2);
			return;
		}
		AdventureLevelObjPoolMgr.PoolObj poolObj = poolBase as AdventureLevelObjPoolMgr.PoolObj;
		GameObject gameObject = poolObj.gameObject;
		if (null == gameObject)
		{
			Debug.LogError("没有找到角色资源" + text2);
			return;
		}
		PlayerAdventureActor orAddComponent = gameObject.GetOrAddComponent<PlayerAdventureActor>();
		orAddComponent.LoadData(character, characterSkin);
		SpawnSkillInstance(orAddComponent);
		ComboGroup comboGroup = orAddComponent.comboGroup;
		if (null == comboGroup)
		{
			Debug.LogError("没有找到角色comboGroup" + text2);
			return;
		}
		ActorRelatedResourceConfig relatedResourceConfig = comboGroup.relatedResourceConfig;
		if (null != relatedResourceConfig)
		{
			PreloadAssets_RelatedRes(relatedResourceConfig, doPreload: true);
		}
		if (orAddComponent.isSkin)
		{
			string text3 = $"Actor/Character/{num}/Combos/{comboGroup.name}";
			string text4 = "Assets/AssetBundles/" + text3 + ".asset";
			ComboGroup comboGroup2 = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, text4, typeof(ComboGroup)) as ComboGroup;
			if (comboGroup2 != null)
			{
				orAddComponent.comboGroupForSkin = comboGroup2;
				if (comboGroup2.relatedResourceConfig != null)
				{
					PreloadAssets_RelatedRes(comboGroup2.relatedResourceConfig, doPreload: true);
				}
			}
			else
			{
				NovaLogger.Warning($"角色皮肤 {num} 中的comboGroup配置没找到，路径：{text4}");
			}
		}
		orAddComponent.spawnPoolObj = poolObj;
		gameObject.SetActive(value: false);
	}

	private void SpawnSkillInstance(PlayerAdventureActor actor)
	{
		PlayerAIInfo playerAIInfo = actor.playerAIInfo;
		SpawnSkill(actor, playerAIInfo.NormalAtkId, SkillPhaseFeatureFlag.Normal);
		SpawnSkill(actor, playerAIInfo.DodgeId, SkillPhaseFeatureFlag.Dodge);
		SpawnSkill(actor, playerAIInfo.SkillId, SkillPhaseFeatureFlag.Skill1);
		SpawnSkill(actor, playerAIInfo.SpecialSkillId, SkillPhaseFeatureFlag.Skill2);
		SpawnSkill(actor, playerAIInfo.UltimateId, SkillPhaseFeatureFlag.Ultimate);
	}

	private void SpawnSkill(PlayerAdventureActor actor, int id, SkillPhaseFeatureFlag flag)
	{
		ModuleController<AdventureModuleController>.Instance.SpawnSkill(id)?.Recycle();
	}

	protected void InitMonsterBornGroupDic()
	{
		Debug.Log("加载怪物组信息");
		if (monsterBornGroupDic == null)
		{
			monsterBornGroupDic = new Dictionary<int, List<StarTowerMonsterBornGroup>>();
		}
		monsterBornGroupDic.Clear();
		List<StarTowerMonsterBornGroup> starTowerMonsterBornGroupData = Singleton<HotfixDataController>.Instance.StarTowerMonsterBornGroupData;
		for (int i = 0; i < starTowerMonsterBornGroupData.Count; i++)
		{
			StarTowerMonsterBornGroup starTowerMonsterBornGroup = starTowerMonsterBornGroupData.get_Item(i);
			int groupId = starTowerMonsterBornGroup.GroupId;
			if (!monsterBornGroupDic.TryGetValue(groupId, out var value))
			{
				value = new List<StarTowerMonsterBornGroup>();
				monsterBornGroupDic.Add(groupId, value);
			}
			value.Add(starTowerMonsterBornGroup);
		}
	}

	public List<StarTowerMonsterBornGroup> GetMonsterBornGroups(int groupID)
	{
		if (monsterBornGroupDic == null || monsterBornGroupDic.Count == 0)
		{
			InitMonsterBornGroupDic();
		}
		monsterBornGroupDic.TryGetValue(groupID, out var value);
		return value;
	}

	public void ExitSelectTeamPanel()
	{
	}

	public void LevelEnd()
	{
	}

	public void LevelFinish()
	{
		Debug.Log("清除预加载数据");
		isPreload = false;
		MonoSingleton<GameController>.Instance.ClearSeed();
		if (preloadMonsterConfigs != null)
		{
			preloadMonsterConfigs.Clear();
			preloadMonsterConfigs = null;
		}
		SceneSingleton<AdventureLevelObjPoolMgr>.Instance.Clear();
		SceneSingleton<AdventureLevelObjPoolMgr>.Instance.Unload();
	}

	public void ClearPlayerPool()
	{
		isPreload = false;
		SceneSingleton<AdventureLevelObjPoolMgr>.Instance.ClearPlayer();
	}

	public void ClearMonsters()
	{
		SceneSingleton<AdventureLevelObjPoolMgr>.Instance.ClearMonster();
	}

	public void ClearSkill()
	{
		SceneSingleton<AdventureLevelObjPoolMgr>.Instance.ClearSkillTemplete();
	}

	public void UnloadAssets()
	{
		if (MonoSingleton<ClientManager>.Instance.GetMemoryType())
		{
			SceneSingleton<AdventureLevelObjPoolMgr>.Instance.ClearMonster();
			SceneSingleton<AdventureLevelObjPoolMgr>.Instance.UnloadMonsterAssets();
		}
	}
}
