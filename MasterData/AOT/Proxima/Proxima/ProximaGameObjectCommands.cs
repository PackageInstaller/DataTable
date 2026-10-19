using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Proxima;

internal class ProximaGameObjectCommands
{
	[Serializable]
	internal class GameObjectInfo
	{
		public int Id;

		public string Name;

		public bool ActiveSelf;

		public int Parent;

		public int Depth;

		public int SiblingIndex;

		public int ChildCount;

		public int Order;

		public int Layer;

		public string Tag;

		public string Scene;
	}

	[Serializable]
	internal class GameObjectList
	{
		public List<GameObjectInfo> GameObjects = new List<GameObjectInfo>();

		public string[] Layers;

		public List<int> Destroyed = new List<int>();
	}

	private static Dictionary<int, GameObject> _idToGameObject;

	private static List<GameObject> _rootGameObjects;

	private static GameObjectList _gameObjects;

	private static GameObjectList _changeList;

	private static Dictionary<int, GameObjectInfo> _gameObjectToInfo;

	private static int _lastUpdate;

	private static int _order;

	private static GameObject _lastUpdatedGameObject;

	private static int _lastDeleteCheckedGameObjectInfo = -1;

	private static Scene _dontDestroyOnLoadScene;

	private static HashSet<string> _pendingStreamIds;

	private static bool _showHidden;

	public static Dictionary<int, GameObject> IdToGameObject => _idToGameObject;

	public static bool ShowHidden => _showHidden;

	[ProximaInitialize]
	public static void Init()
	{
		_idToGameObject = new Dictionary<int, GameObject>();
		_rootGameObjects = new List<GameObject>();
		_gameObjects = new GameObjectList();
		_gameObjects.Layers = (from index in Enumerable.Range(0, 31)
			select LayerMask.LayerToName(index)).ToArray();
		_changeList = new GameObjectList();
		_gameObjectToInfo = new Dictionary<int, GameObjectInfo>();
		_lastUpdate = -1;
		_pendingStreamIds = new HashSet<string>();
		GameObject gameObject = new GameObject("Proxima DDOL");
		UnityEngine.Object.DontDestroyOnLoad(gameObject);
		_dontDestroyOnLoadScene = gameObject.scene;
		UnityEngine.Object.Destroy(gameObject);
	}

	[ProximaTeardown]
	public static void Teardown()
	{
		_idToGameObject = null;
		_rootGameObjects = null;
		_gameObjects = null;
		_changeList = null;
		_gameObjectToInfo = null;
		_lastUpdate = -1;
		_pendingStreamIds = null;
		_order = 0;
		_lastUpdatedGameObject = null;
		_lastDeleteCheckedGameObjectInfo = -1;
		_dontDestroyOnLoadScene = default;
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static void SetParent(int id, int parentId, int index)
	{
		if (_idToGameObject.TryGetValue(id, out var value))
		{
			_idToGameObject.TryGetValue(parentId, out var value2);
			value.transform.SetParent(value2?.transform, worldPositionStays: true);
			value.transform.SetSiblingIndex(index);
		}
		else
		{
			Log.Warning($"SetParent: GameObject with id {id} not found");
		}
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static void SetScene(int id, int sceneIndex, int index)
	{
		if (_idToGameObject.TryGetValue(id, out var value))
		{
			if (sceneIndex < SceneManager.sceneCount)
			{
				value.transform.SetParent(null, worldPositionStays: true);
				SceneManager.MoveGameObjectToScene(value, SceneManager.GetSceneAt(sceneIndex));
				value.transform.SetSiblingIndex(index);
			}
		}
		else
		{
			Log.Warning($"SetScene: GameObject with id {id} not found");
		}
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static void SetActive(int id, bool active)
	{
		if (_idToGameObject.TryGetValue(id, out var value))
		{
			value.SetActive(active);
		}
		else
		{
			Log.Warning($"SetActive: GameObject with id {id} not found");
		}
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static void SetName(int id, string name)
	{
		if (_idToGameObject.TryGetValue(id, out var value))
		{
			value.name = name;
		}
		else
		{
			Log.Warning($"SetName: GameObject with id {id} not found");
		}
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static void SetLayer(int id, int layer)
	{
		if (_idToGameObject.TryGetValue(id, out var value))
		{
			value.layer = layer;
		}
		else
		{
			Log.Warning($"SetLayer: GameObject with id {id} not found");
		}
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static void SetTag(int id, string tag)
	{
		if (_idToGameObject.TryGetValue(id, out var value))
		{
			value.tag = tag;
		}
		else
		{
			Log.Warning($"SetTag: GameObject with id {id} not found");
		}
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static void CreateGameObject(int parentId)
	{
		GameObject gameObject = new GameObject();
		if (_idToGameObject.TryGetValue(parentId, out var value))
		{
			gameObject.transform.SetParent(value.transform, worldPositionStays: true);
		}
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static void DuplicateGameObject(int id)
	{
		if (!_idToGameObject.TryGetValue(id, out var value))
		{
			Log.Warning($"DuplicateGameObject: GameObject with id {id} not found");
		}
		UnityEngine.Object.Instantiate(value, value.transform.parent);
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static void DestroyGameObject(int id)
	{
		if (_idToGameObject.TryGetValue(id, out var value) && (bool)value)
		{
			UnityEngine.Object.Destroy(value);
		}
		else
		{
			Log.Warning($"DestroyGameObject: GameObject with id {id} not found");
		}
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static void AddGameObjectComponent(int id, string component)
	{
		if (!_idToGameObject.TryGetValue(id, out var value))
		{
			Log.Warning($"AddComponent: GameObject with id {id} not found");
			return;
		}
		Type type = ProximaCommandHelpers.FindFirstComponentType(component);
		if (type == null)
		{
			throw new Exception("Component type " + component + " not found.");
		}
		value.AddComponent(type);
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static void SetShowHidden(bool showHidden)
	{
		_showHidden = showHidden;
	}

	[ProximaStreamStart("GameObjects", false)]
	public static void StartStream(string id)
	{
		_pendingStreamIds.Add(id);
	}

	[ProximaStreamUpdate("GameObjects", false)]
	public static GameObjectList UpdateStream(string id)
	{
		UpdateInfoLists();
		if (_pendingStreamIds.Contains(id))
		{
			_pendingStreamIds.Remove(id);
			return _gameObjects;
		}
		if (_changeList.Destroyed.Count <= 0 && _changeList.GameObjects.Count <= 0)
		{
			return null;
		}
		return _changeList;
	}

	[ProximaStreamStop("GameObjects", false)]
	public static void StopStream(string id)
	{
		_pendingStreamIds.Remove(id);
	}

	public static void UpdateInfoLists()
	{
		if (_lastUpdate == Time.frameCount)
		{
			return;
		}
		_lastUpdate = Time.frameCount;
		_changeList.GameObjects.Clear();
		_changeList.Destroyed.Clear();
		if (!_lastUpdatedGameObject)
		{
			_lastUpdatedGameObject = null;
		}
		for (int i = 0; i <= ProximaInspector.MaxGameObjectUpdatesPerFrame; i++)
		{
			if (!UpdateNextGameObjectInfo())
			{
				break;
			}
		}
		for (int j = 0; j <= ProximaInspector.MaxGameObjectUpdatesPerFrame; j++)
		{
			if (!UpdateNextDeletedGameObjectInfo())
			{
				break;
			}
		}
	}

	private static bool UpdateNextGameObjectInfo()
	{
		_lastUpdatedGameObject = GetNextGameObject(_lastUpdatedGameObject);
		if (_lastUpdatedGameObject != null)
		{
			UpdateGameObjectInfo(_lastUpdatedGameObject);
			return true;
		}
		return false;
	}

	private static bool ShouldHide(GameObject go)
	{
		if (!_showHidden)
		{
			return go.hideFlags.HasFlag(HideFlags.HideInHierarchy);
		}
		return false;
	}

	private static GameObject GetNextChildGameObject(Transform t)
	{
		for (int i = 0; i < t.childCount; i++)
		{
			Transform child = t.GetChild(i);
			if (!ShouldHide(child.gameObject))
			{
				return child.gameObject;
			}
		}
		return null;
	}

	private static GameObject GetNextSiblingGameObject(Transform parent, Transform t)
	{
		for (int i = t.GetSiblingIndex() + 1; i < parent.childCount; i++)
		{
			GameObject gameObject = parent.GetChild(i).gameObject;
			if (!ShouldHide(gameObject))
			{
				return gameObject;
			}
		}
		return null;
	}

	private static GameObject GetNextRootGameObject(GameObject go)
	{
		int num = _rootGameObjects.IndexOf(go);
		if (num >= 0)
		{
			return GetNextRootGameObject(num + 1);
		}
		return null;
	}

	private static GameObject GetNextRootGameObject(int rootIndex)
	{
		while (rootIndex < _rootGameObjects.Count)
		{
			GameObject gameObject = _rootGameObjects[rootIndex];
			if ((bool)gameObject && !ShouldHide(gameObject))
			{
				return gameObject;
			}
			rootIndex++;
		}
		return null;
	}

	private static GameObject GetNextSceneGameObject(Scene? currentScene)
	{
		int i = 0;
		for (int j = 0; j < SceneManager.sceneCount; j++)
		{
			if (SceneManager.GetSceneAt(j) == currentScene)
			{
				i = j + 1;
			}
		}
		if (i == 0)
		{
			_order = 0;
		}
		for (; i < SceneManager.sceneCount; i++)
		{
			Scene sceneAt = SceneManager.GetSceneAt(i);
			if (sceneAt.isLoaded)
			{
				sceneAt.GetRootGameObjects(_rootGameObjects);
				GameObject nextRootGameObject = GetNextRootGameObject(0);
				if (nextRootGameObject != null)
				{
					return nextRootGameObject;
				}
			}
		}
		_ = _dontDestroyOnLoadScene;
		if (currentScene != _dontDestroyOnLoadScene)
		{
			_dontDestroyOnLoadScene.GetRootGameObjects(_rootGameObjects);
			GameObject nextRootGameObject2 = GetNextRootGameObject(0);
			if (nextRootGameObject2 != null)
			{
				return nextRootGameObject2;
			}
		}
		return null;
	}

	private static GameObject GetNextGameObject(GameObject go)
	{
		if (go == null)
		{
			return GetNextSceneGameObject(null);
		}
		_order++;
		Transform transform = go.transform;
		GameObject nextChildGameObject = GetNextChildGameObject(transform);
		if (nextChildGameObject != null)
		{
			return nextChildGameObject;
		}
		Transform parent = transform.parent;
		while (parent != null)
		{
			GameObject nextSiblingGameObject = GetNextSiblingGameObject(parent, transform);
			if (nextSiblingGameObject != null)
			{
				return nextSiblingGameObject;
			}
			transform = parent;
			parent = transform.parent;
		}
		go = transform.gameObject;
		go.scene.GetRootGameObjects(_rootGameObjects);
		GameObject nextRootGameObject = GetNextRootGameObject(go);
		if (nextRootGameObject != null)
		{
			return nextRootGameObject;
		}
		return GetNextSceneGameObject(go.scene);
	}

	private static bool FastStringEqual(string lhs, string rhs)
	{
		if (lhs.Length == rhs.Length && lhs[0] == rhs[0])
		{
			return lhs[lhs.Length - 1] == rhs[rhs.Length - 1];
		}
		return false;
	}

	private static void UpdateGameObjectInfo(GameObject go)
	{
		int instanceID = go.GetInstanceID();
		int num = (go.transform.parent ? go.transform.parent.gameObject.GetInstanceID() : 0);
		int siblingIndex = go.transform.GetSiblingIndex();
		int num2 = 0;
		if ((bool)go.transform.parent && _gameObjectToInfo.TryGetValue(num, out var value))
		{
			num2 = value.Depth + 1;
		}
		if (!_gameObjectToInfo.TryGetValue(instanceID, out var value2))
		{
			value2 = new GameObjectInfo
			{
				Id = instanceID,
				Name = go.name,
				ActiveSelf = go.activeSelf,
				Parent = num,
				Depth = num2,
				SiblingIndex = siblingIndex,
				ChildCount = go.transform.childCount,
				Order = _order,
				Tag = go.tag,
				Layer = go.layer,
				Scene = ((num2 == 0) ? (go.scene.name + "#" + go.scene.handle) : null)
			};
			_gameObjects.GameObjects.Add(value2);
			_gameObjectToInfo.Add(instanceID, value2);
			_idToGameObject.Add(instanceID, go);
			_changeList.GameObjects.Add(value2);
		}
		else if (!FastStringEqual(value2.Name, go.name) || value2.ActiveSelf != go.activeSelf || value2.Parent != num || value2.Depth != num2 || value2.SiblingIndex != siblingIndex || value2.ChildCount != go.transform.childCount || value2.Order != _order || !FastStringEqual(value2.Tag, go.tag) || value2.Layer != go.layer)
		{
			value2.Name = go.name;
			value2.ActiveSelf = go.activeSelf;
			value2.Parent = num;
			value2.Depth = num2;
			value2.SiblingIndex = siblingIndex;
			value2.ChildCount = go.transform.childCount;
			value2.Order = _order;
			value2.Tag = go.tag;
			value2.Layer = go.layer;
			value2.Scene = ((num2 == 0) ? (go.scene.name + "#" + go.scene.handle) : null);
			_changeList.GameObjects.Add(value2);
		}
	}

	private static bool UpdateNextDeletedGameObjectInfo()
	{
		if (_gameObjects.GameObjects.Count == 0)
		{
			return false;
		}
		_lastDeleteCheckedGameObjectInfo = (_lastDeleteCheckedGameObjectInfo + 1) % _gameObjects.GameObjects.Count;
		GameObjectInfo gameObjectInfo = _gameObjects.GameObjects[_lastDeleteCheckedGameObjectInfo];
		GameObject gameObject = _idToGameObject[gameObjectInfo.Id];
		if (!gameObject || ShouldHide(gameObject))
		{
			_gameObjectToInfo.Remove(gameObjectInfo.Id);
			_gameObjects.GameObjects.RemoveAt(_lastDeleteCheckedGameObjectInfo);
			_changeList.Destroyed.Add(gameObjectInfo.Id);
			_idToGameObject.Remove(gameObjectInfo.Id);
		}
		return true;
	}
}
