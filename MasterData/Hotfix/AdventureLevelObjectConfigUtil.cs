using System.Collections.Generic;
using Pathfinding;
using UnityEngine;

public class AdventureLevelObjectConfigUtil : MonoBehaviour
{
	[SerializeField]
	public AdventureLevelObjectConfig levelObjectConfig;

	protected float dynamicLoad_SceneObjLoadDistance = 50f;

	protected float dynamicLoad_MonsterLoadDistance = 50f;

	public NavmeshAdd[] navmeshAdds;

	public NavmeshCut[] navmeshCuts;

	protected AdventureLevelObjPoolMgr poolMgr;

	protected Texture2D[] lightingmaps;

	public bool isEnableLogic { get; protected set; }

	private void OnEnable()
	{
		poolMgr = SceneSingleton<AdventureLevelObjPoolMgr>.Instance;
	}

	private void OnDisable()
	{
		poolMgr = SceneSingleton<AdventureLevelObjPoolMgr>.Instance;
	}

	public void InitConfigs(string sceneName)
	{
		levelObjectConfig = MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance.GetObjConfig(sceneName);
	}

	public void PreloadConfigs(Vector2 entityPosition)
	{
		if (null == levelObjectConfig)
		{
			Debug.LogError("Configs is Null!");
			return;
		}
		for (int i = 0; i < levelObjectConfig.Count; i++)
		{
			AdventureLevelObjectConfig.SceneObjDataConfig sceneObjDataConfig = levelObjectConfig[i];
			if (sceneObjDataConfig != null && sceneObjDataConfig.SanCheck(entityPosition))
			{
				Config2GameObject(sceneObjDataConfig, transform);
			}
		}
	}

	public void Config2GameObject()
	{
		if (null == levelObjectConfig || levelObjectConfig.Count == 0)
		{
			Debug.LogError(name + " 的数据为空！");
			return;
		}
		for (int i = 0; i < levelObjectConfig.Count; i++)
		{
			AdventureLevelObjectConfig.SceneObjDataConfig config = levelObjectConfig[i];
			Config2GameObject(config, transform);
		}
	}

	protected void Config2GameObject(AdventureLevelObjectConfig.SceneObjDataConfig config, Transform parent)
	{
		if (config == null)
		{
			Debug.LogError("SceneObjDataConfig is Null!");
		}
		else
		{
			if (config.isInitializing)
			{
				return;
			}
			if (string.IsNullOrEmpty(config.parent))
			{
				string assetPath = config.assetPath;
				if (Application.isPlaying)
				{
					config.isInitializing = true;
					AdventureLevelObjPoolMgr.PoolBase poolBase = poolMgr.De_SceneObject(assetPath);
					if (poolBase != null)
					{
						AdventureLevelObjPoolMgr.PoolObj poolObj = poolBase as AdventureLevelObjPoolMgr.PoolObj;
						HandleConfigGameObject(poolObj.gameObject, config, parent);
						config.poolObj = poolObj;
						config.isInitializing = false;
						poolObj.Enabled(enable: true);
					}
				}
				return;
			}
			config.isInitializing = true;
			Transform transform = parent.transform.Find(config.name);
			if (null == transform)
			{
				Debug.Log("场景物体：" + gameObject.scene.name + "/" + config.parent + "/" + config.name + " 为空！");
				config.isInitializing = false;
			}
			else
			{
				GameObject go = transform.gameObject;
				HandleConfigGameObject(go, config, parent);
				config.isInitializing = false;
			}
		}
	}

	protected void HandleConfigGameObject(GameObject go, AdventureLevelObjectConfig.SceneObjDataConfig config, Transform parent)
	{
		if (null == go || config == null)
		{
			return;
		}
		go.name = config.name;
		Transform transform = go.transform;
		if (null != parent)
		{
			transform.SetParent(parent);
		}
		transform.localScale = config.scale;
		transform.localPosition = config.position;
		transform.localEulerAngles = config.eulerAngles;
		UpdateLightingmapSetting(lightingmaps);
		AdventureLevelObjectConfig.SceneObjDataConfig[] childs = config.childs;
		if (childs != null)
		{
			AdventureLevelObjectConfig.SceneObjDataConfig sceneObjDataConfig = null;
			for (int i = 0; i < childs.Length; i++)
			{
				sceneObjDataConfig = childs[i];
				Config2GameObject(sceneObjDataConfig, transform);
			}
		}
		config.gameObject = go;
	}

	public void EnableLogic()
	{
		isEnableLogic = true;
	}

	public void DisableLogic()
	{
		isEnableLogic = false;
	}

	public void UpdateLogic(Vector2 entityPosition)
	{
		if (isEnableLogic)
		{
			if (null == levelObjectConfig)
			{
				Debug.LogError("Configs is Null!");
				return;
			}
			List<AdventureLevelObjectConfig.SceneObjDataConfig> configs = levelObjectConfig.configs;
			int count = configs.Count;
			for (int i = 0; i < count; i++)
			{
				AdventureLevelObjectConfig.SceneObjDataConfig sceneObjDataConfig = configs.get_Item(i);
				if (sceneObjDataConfig == null)
				{
					continue;
				}
				if (sceneObjDataConfig.SanCheck(entityPosition))
				{
					if (null == sceneObjDataConfig.gameObject && sceneObjDataConfig.poolObj == null)
					{
						Config2GameObject(sceneObjDataConfig, transform);
					}
					continue;
				}
				sceneObjDataConfig.gameObject = null;
				if (sceneObjDataConfig.poolObj != null)
				{
					poolMgr.En_SceneObject(sceneObjDataConfig.poolObj);
					sceneObjDataConfig.poolObj = null;
				}
				sceneObjDataConfig.isInitializing = false;
			}
		}
		else
		{
			ClearChild();
		}
	}

	public void RevertData2GameObject()
	{
		Config2GameObject();
	}

	public void ClearChild()
	{
		if (null == levelObjectConfig || !Application.isPlaying)
		{
			return;
		}
		List<AdventureLevelObjectConfig.SceneObjDataConfig> configs = levelObjectConfig.configs;
		int count = configs.Count;
		for (int i = 0; i < count; i++)
		{
			AdventureLevelObjectConfig.SceneObjDataConfig sceneObjDataConfig = configs.get_Item(i);
			AdventureLevelObjPoolMgr.PoolObj poolObj = sceneObjDataConfig.poolObj;
			if (poolObj != null)
			{
				poolMgr.En_SceneObject(poolObj);
				sceneObjDataConfig.poolObj = null;
			}
			sceneObjDataConfig.gameObject = null;
			sceneObjDataConfig.isInitializing = false;
		}
	}

	public void UpdateTransform(Matrix4x4 transMatrix, Vector3 relativeRotation)
	{
		AdventureModuleConfigureData adventureModuleConfigureData = ModuleController<AdventureModuleController>.Instance?.sharedConfigureData;
		dynamicLoad_SceneObjLoadDistance = ((adventureModuleConfigureData != null) ? adventureModuleConfigureData.DynamicLoad_SceneObjLoadDistance : 50f);
		dynamicLoad_MonsterLoadDistance = ((adventureModuleConfigureData != null) ? adventureModuleConfigureData.DynamicLoad_MonsterLoadDistance : 50f);
		if (!(null == levelObjectConfig))
		{
			for (int i = 0; i < levelObjectConfig.Count; i++)
			{
				levelObjectConfig[i].UpdateTransform(transMatrix, relativeRotation, dynamicLoad_SceneObjLoadDistance);
			}
		}
	}

	public void UpdateLightingmapSetting(Texture2D[] maps)
	{
		if (maps == null || maps.Length == 0 || null == levelObjectConfig)
		{
			return;
		}
		lightingmaps = maps;
		for (int i = 0; i < levelObjectConfig.Count; i++)
		{
			AdventureLevelObjectConfig.SceneObjDataConfig sceneObjDataConfig = levelObjectConfig[i];
			if (sceneObjDataConfig.lightmapIndex >= 0)
			{
				sceneObjDataConfig.UpdateLightingmaps();
				continue;
			}
			for (int j = 0; j < maps.Length; j++)
			{
				sceneObjDataConfig.UpdateLightingmaps(maps[j], j);
			}
		}
	}
}
