using System;
using System.Linq;
using Nova.Hotfix;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PrologueLevelControler : AdventureLevelController
{
	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		base.Load(param, callback);
		if (param == null)
		{
			callback?.Invoke();
			return;
		}
		MainlineFloor mainlineFloorData = (isViewSceneMode ? param.mainlineFloorData : param.Mainline_GenerateFloorData());
		if (mainlineFloorData == null)
		{
			return;
		}
		string scenePath = "Assets/AssetBundles/" + mainlineFloorData.SceneName;
		MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(scenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, (string sceneName, int process) =>
		{
			MonoSingleton<ClientManager>.Instance.UpdateLoadingView((float)process / 100f);
			if (process == 200)
			{
				string[] array = sceneName.Split('/');
				string sceneName2 = array[array.Length - 1];
				Scene sceneByName = SceneManager.GetSceneByName(sceneName2);
				string assetName = scenePath + "/" + mainlineFloorData.ConfigPrefabName + ".prefab";
				GameObject gameObject = MonoSingleton<SceneLoaderController>.Instance.LoadAsset(scenePath, assetName, typeof(GameObject)) as GameObject;
				if (gameObject != null)
				{
					configPrefab = UnityEngine.Object.Instantiate(gameObject, Vector3.zero, Quaternion.identity);
					configPrefab.transform.localScale = Vector3.one;
					configPrefab.name = mainlineFloorData.ConfigPrefabName;
					SceneManager.MoveGameObjectToScene(configPrefab, sceneByName);
				}
				else
				{
					Debug.LogError("策划配置预制体加载失败：" + mainlineFloorData.ConfigPrefabName);
				}
				GameObject[] rootGameObjects = sceneByName.GetRootGameObjects();
				foreach (GameObject gameObject2 in rootGameObjects)
				{
					if (gameObject2.name.Equals(mainlineFloorData.ConfigPrefabName))
					{
						Transform transform = gameObject2.transform.Find("==== Triggers ====");
						if (transform != null)
						{
							TriggerCom[] componentsInChildren = transform.GetComponentsInChildren<TriggerCom>();
							Singleton<TriggerManager>.Instance.AddTriggers(componentsInChildren, -1, -1);
							teleporters = transform.GetComponentsInChildren<AdventureLevelTeleporter>().ToList();
							if (teleporters != null)
							{
								for (int j = 0; j < teleporters.Count; j++)
								{
									teleporters.get_Item(j).SetPosition(-1, -1);
								}
							}
						}
					}
					if (gameObject2.name.Equals("==== Navigation ===="))
					{
						HandleNavigation(gameObject2, sceneName2);
					}
				}
				callback?.Invoke();
			}
			return true;
		});
	}

	public override void Unload(Action callback = null)
	{
		string text = "Assets/AssetBundles/" + levelLoadParams.mainlineFloorData.SceneName;
		MonoSingleton<SceneLoaderController>.Instance.UnloadAdditiveSceneAsync(text, UnloadSceneOptions.None, (string sceneN, int process) =>
		{
			if (process == 300)
			{
				callback?.Invoke();
			}
			return true;
		});
	}

	public override void PreloadAssets()
	{
		base.PreloadAssets();
	}
}
