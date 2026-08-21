using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.SceneManagement;

public class QWorldMap : IResetWorldState
{
	private QWorldMapManager mapManager;

	private QWorldMapData mapData;

	public SceneSetting sceneSetting;

	public List<GameObject> RootGameObject;

	public Dictionary<LODGroup, List<LOD>> OriginLOD;

	public static string MapPath = "QWWorld/Map/QworldMap";

	public static int HeroId = 9070;

	private string _lastSceneName;

	private GameObject _collisionRoot;

	private string _lastCollisionPath;

	public Action<List<QWorldMiniMapUnit>> MiniMapUpdateAction;

	private List<QWorldMiniMapUnit> miniMapUnits;

	private List<int> trackEntityIds;

	public string lastSceneName => _lastSceneName;

	public List<QWorldMiniMapUnit> miniMapUnitsList => miniMapUnits;

	public QWorldMap(QWorldMapManager manager)
	{
		mapManager = manager;
		miniMapUnits = new List<QWorldMiniMapUnit>();
	}

	public IEnumerator Load(string sceneName)
	{
		mapData = Asset.Load<QWorldMapData>(MapPath);
		if (sceneName == null)
		{
			object[] array = LuaHelper.CallFunction("GetQWorldSceneName", mapData.mapdataName);
			if (array != null && array.Length != 0)
			{
				sceneName = array[0] as string;
			}
		}
		QWorldMapEntityData qWorldMapEntityData = mapData.mapEntityDatas[0];
		if (sceneName != null)
		{
			qWorldMapEntityData = mapData.mapEntityDatas.FirstOrDefault((QWorldMapEntityData d) => d.path_level.Contains(sceneName)) ?? qWorldMapEntityData;
		}
		string selectRoleScenePath = qWorldMapEntityData.path_level;
		AssetBundleLoadOperation ops = Asset.LoadLevelAsync(selectRoleScenePath, isAddtive: true);
		LoadCollision(qWorldMapEntityData);
		while (!ops.IsDone())
		{
			yield return null;
		}
		Scene sceneByPath = SceneManager.GetSceneByPath("Assets/ComScene/ABResources/" + selectRoleScenePath + ".unity");
		List<GameObject> list = new List<GameObject>();
		sceneByPath.GetRootGameObjects(list);
		RootGameObject = list;
		OriginLOD = new Dictionary<LODGroup, List<LOD>>();
		for (int num = 0; num < list.Count; num++)
		{
			sceneSetting = list[num].GetComponentInChildren<SceneSetting>();
			LODGroup[] componentsInChildren = list[num].GetComponentsInChildren<LODGroup>();
			foreach (LODGroup lODGroup in componentsInChildren)
			{
				OriginLOD.Add(lODGroup, new List<LOD>(lODGroup.GetLODs()));
			}
			if (sceneSetting != null)
			{
				break;
			}
		}
		mapManager.Init(mapData);
		QWorldMapCull.Init();
		_lastSceneName = sceneByPath.name;
	}

	public IEnumerator Restart(string sceneName)
	{
		if (_lastSceneName == sceneName)
		{
			yield break;
		}
		Scene sceneByName = SceneManager.GetSceneByName(_lastSceneName);
		if (sceneByName.IsValid())
		{
			AsyncOperation unloadOp = SceneManager.UnloadSceneAsync(sceneByName);
			while (!unloadOp.isDone)
			{
				yield return null;
			}
		}
		else
		{
			Debug.LogError("can't find scene: " + _lastSceneName);
		}
		QWorldMapEntityData qWorldMapEntityData = mapData.mapEntityDatas[0];
		if (sceneName != null)
		{
			qWorldMapEntityData = mapData.mapEntityDatas.FirstOrDefault((QWorldMapEntityData d) => d.path_level.Contains(sceneName)) ?? qWorldMapEntityData;
		}
		string selectRoleScenePath = qWorldMapEntityData.path_level;
		AssetBundleLoadOperation loadOp = Asset.LoadLevelAsync(selectRoleScenePath, isAddtive: true);
		LoadCollision(qWorldMapEntityData);
		while (!loadOp.IsDone())
		{
			yield return null;
		}
		Scene sceneByPath = SceneManager.GetSceneByPath("Assets/ABResources/" + selectRoleScenePath + ".unity");
		List<GameObject> list = new List<GameObject>();
		sceneByPath.GetRootGameObjects(list);
		for (int num = 0; num < list.Count; num++)
		{
			sceneSetting = list[num].GetComponentInChildren<SceneSetting>();
			if (sceneSetting != null)
			{
				break;
			}
		}
		_lastSceneName = sceneByPath.name;
	}

	public void Tick(QWCharacterAgent agent)
	{
	}

	public void CullingAll(bool hideAll, int[] hiddenIds = null, QWAgentLayer cullingLayer = (QWAgentLayer)4095)
	{
		if (!hideAll)
		{
			QWorldScene.Scene.ResetWorldStateWithPos(QWorldCameraManager.Instance.mcCamera.FreeLook.transform.position);
		}
		QwLodMgr.SetStoryCulling(hideAll);
		QwLodMgr.SetCullingAgentLayer(cullingLayer);
		QwLodMgr.SetHiddenIds(hiddenIds);
	}

	public void Dispose()
	{
		UnloadCollision();
		DisposeMiniMap();
	}

	public QWorldMiniMapUnit AddMiniMap(QWorldMapEntity entity)
	{
		QWorldMiniMapUnit qWorldMiniMapUnit = new QWorldMiniMapUnit(this, entity.entityId, entity.transform);
		miniMapUnits.Add(qWorldMiniMapUnit);
		MiniMapUpdateAction?.Invoke(miniMapUnits);
		return qWorldMiniMapUnit;
	}

	public void RemoveMiniMap(QWorldMiniMapUnit unit)
	{
		unit.Dispose();
		miniMapUnits.Remove(unit);
		MiniMapUpdateAction?.Invoke(miniMapUnits);
	}

	public void DisposeMiniMap()
	{
		foreach (QWorldMiniMapUnit miniMapUnit in miniMapUnits)
		{
			miniMapUnit.Dispose();
		}
		miniMapUnits.Clear();
		trackEntityIds.Clear();
	}

	public void ActiveMiniMap(bool active)
	{
	}

	public bool IsTrack(int entityId)
	{
		if (entityId == 0 || trackEntityIds == null)
		{
			return false;
		}
		return trackEntityIds.IndexOf(entityId) >= 0;
	}

	public void Track(int[] tracks)
	{
		trackEntityIds = new List<int>(tracks);
	}

	private void LoadCollision(QWorldMapEntityData mapEntityData)
	{
		if (_lastCollisionPath != mapEntityData.path_base_collision)
		{
			UnloadCollision();
			if (!string.IsNullOrEmpty(mapEntityData.path_base_collision))
			{
				_collisionRoot = Asset.Instantiate(mapEntityData.path_base_collision);
			}
			_lastCollisionPath = mapEntityData.path_base_collision;
		}
	}

	private void UnloadCollision()
	{
		if (_collisionRoot != null)
		{
			UnityEngine.Object.Destroy(_collisionRoot);
			Asset.Unload(_lastCollisionPath);
			_collisionRoot = null;
			_lastCollisionPath = null;
		}
	}

	public void ResetWorldState(Vector3 pos)
	{
	}
}
