using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Fundamental;

public sealed class CGameObjectPool : Singleton<CGameObjectPool>
{
	private class stDelayRecycle
	{
		public GameObject recycleObj;

		public int recycleTime;

		public OnDelayRecycleDelegate callback;
	}

	public delegate void OnDelayRecycleDelegate(GameObject recycleObj);

	private Dictionary<string, Queue<CPooledGameObjectScript>> _pooledGameObjectMap = new Dictionary<string, Queue<CPooledGameObjectScript>>();

	private LinkedList<stDelayRecycle> m_delayRecycle = new LinkedList<stDelayRecycle>();

	private GameObject m_poolRoot;

	private const string RootStr = "CGameObjectPool";

	private bool m_clearPooledObjects;

	private int m_clearPooledObjectsExecuteFrame;

	private static int s_frameCounter;

	public override ContextType ContextType => ContextType.GLOBAL;

	public override void Init()
	{
		OnSceneLoaded(default, LoadSceneMode.Single);
		SceneManager.sceneLoaded += OnSceneLoaded;
	}

	private void OnSceneLoaded(Scene arg0, LoadSceneMode arg1)
	{
		m_poolRoot = GameObject.Find("CGameObjectPool");
		if (m_poolRoot == null)
		{
			m_poolRoot = new GameObject("CGameObjectPool");
		}
		m_delayRecycle.Clear();
		_pooledGameObjectMap.Clear();
	}

	public override void UnInit()
	{
	}

	public void Update()
	{
		s_frameCounter++;
		UpdateDelayRecycle();
		if (m_clearPooledObjects && m_clearPooledObjectsExecuteFrame == s_frameCounter)
		{
			ExecuteClearPooledObjects();
			m_clearPooledObjects = false;
		}
	}

	public void ClearPooledObjects()
	{
		m_clearPooledObjects = true;
		m_clearPooledObjectsExecuteFrame = s_frameCounter + 1;
	}

	public void ExecuteClearPooledObjects()
	{
		for (LinkedListNode<stDelayRecycle> linkedListNode = m_delayRecycle.First; linkedListNode != null; linkedListNode = linkedListNode.Next)
		{
			if (null != linkedListNode.Value.recycleObj)
			{
				RecycleGameObject(linkedListNode.Value.recycleObj);
			}
		}
		m_delayRecycle.Clear();
		Dictionary<string, Queue<CPooledGameObjectScript>>.Enumerator enumerator = _pooledGameObjectMap.GetEnumerator();
		while (enumerator.MoveNext())
		{
			Queue<CPooledGameObjectScript> value = enumerator.Current.Value;
			while (value.Count > 0)
			{
				CPooledGameObjectScript cPooledGameObjectScript = value.Dequeue();
				if (cPooledGameObjectScript != null && cPooledGameObjectScript.gameObject != null)
				{
					Object.Destroy(cPooledGameObjectScript.gameObject);
				}
			}
		}
		_pooledGameObjectMap.Clear();
	}

	private void UpdateDelayRecycle()
	{
		LinkedListNode<stDelayRecycle> linkedListNode = m_delayRecycle.First;
		int num = (int)(Time.time * 1000f);
		while (linkedListNode != null)
		{
			LinkedListNode<stDelayRecycle> linkedListNode2 = linkedListNode;
			linkedListNode = linkedListNode.Next;
			if (null == linkedListNode2.Value.recycleObj)
			{
				m_delayRecycle.Remove(linkedListNode2);
				continue;
			}
			if (linkedListNode2.Value.recycleTime <= num)
			{
				if (linkedListNode2.Value.callback != null)
				{
					linkedListNode2.Value.callback(linkedListNode2.Value.recycleObj);
				}
				RecycleGameObject(linkedListNode2.Value.recycleObj);
				m_delayRecycle.Remove(linkedListNode2);
				continue;
			}
			break;
		}
	}

	public GameObject GetGameObject(string prefabFullPath, Vector3 pos, Quaternion rot)
	{
		bool isInit = false;
		return GetGameObject(prefabFullPath, pos, rot, useRotation: true, out isInit);
	}

	public GameObject GetGameObject(string prefabFullPath, Vector3 pos, Quaternion rot, out bool isInit)
	{
		return GetGameObject(prefabFullPath, pos, rot, useRotation: true, out isInit);
	}

	public GameObject GetGameObject(string prefabFullPath, Vector3 pos)
	{
		bool isInit = false;
		return GetGameObject(prefabFullPath, pos, Quaternion.identity, useRotation: false, out isInit);
	}

	public GameObject GetGameObject(string prefabFullPath, Vector3 pos, out bool isInit)
	{
		return GetGameObject(prefabFullPath, pos, Quaternion.identity, useRotation: false, out isInit);
	}

	public GameObject GetGameObject(string prefabFullPath)
	{
		bool isInit = false;
		return GetGameObject(prefabFullPath, Vector3.zero, Quaternion.identity, useRotation: false, out isInit);
	}

	public GameObject GetGameObject(string prefabFullPath, out bool isInit)
	{
		return GetGameObject(prefabFullPath, Vector3.zero, Quaternion.identity, useRotation: false, out isInit);
	}

	private GameObject GetGameObject(string path, Vector3 pos, Quaternion rot, bool useRotation, out bool isInit)
	{
		Queue<CPooledGameObjectScript> value = null;
		if (!_pooledGameObjectMap.TryGetValue(path, out value))
		{
			value = new Queue<CPooledGameObjectScript>();
			_pooledGameObjectMap.Add(path, value);
		}
		CPooledGameObjectScript cPooledGameObjectScript = null;
		while (value.Count > 0)
		{
			cPooledGameObjectScript = value.Dequeue();
			if (cPooledGameObjectScript != null && cPooledGameObjectScript.gameObject != null)
			{
				cPooledGameObjectScript.gameObject.transform.SetParent(null, worldPositionStays: true);
				cPooledGameObjectScript.gameObject.transform.position = pos;
				cPooledGameObjectScript.gameObject.transform.rotation = rot;
				cPooledGameObjectScript.gameObject.transform.localScale = cPooledGameObjectScript.DefaultScale;
				break;
			}
			cPooledGameObjectScript = null;
		}
		if (cPooledGameObjectScript == null)
		{
			cPooledGameObjectScript = CreateGameObject(path, pos, rot, useRotation);
		}
		if (cPooledGameObjectScript == null)
		{
			isInit = false;
			return null;
		}
		isInit = cPooledGameObjectScript.IsInit;
		cPooledGameObjectScript.OnGet();
		return cPooledGameObjectScript.gameObject;
	}

	public void RecycleGameObjectDelay(GameObject pooledGameObject, int delayMillSeconds, OnDelayRecycleDelegate callback = null)
	{
		stDelayRecycle stDelayRecycle2 = new stDelayRecycle();
		stDelayRecycle2.recycleObj = pooledGameObject;
		stDelayRecycle2.recycleTime = (int)(Time.time * 1000f) + delayMillSeconds;
		stDelayRecycle2.callback = callback;
		if (m_delayRecycle.Count == 0)
		{
			m_delayRecycle.AddLast(stDelayRecycle2);
			return;
		}
		for (LinkedListNode<stDelayRecycle> linkedListNode = m_delayRecycle.Last; linkedListNode != null; linkedListNode = linkedListNode.Previous)
		{
			if (linkedListNode.Value.recycleTime < stDelayRecycle2.recycleTime)
			{
				m_delayRecycle.AddAfter(linkedListNode, stDelayRecycle2);
				return;
			}
		}
		m_delayRecycle.AddFirst(stDelayRecycle2);
	}

	public void RecycleGameObject(GameObject pooledGameObject)
	{
		_RecycleGameObject(pooledGameObject, setIsInit: false);
	}

	public void RecyclePreparedGameObject(GameObject pooledGameObject)
	{
		_RecycleGameObject(pooledGameObject, setIsInit: true);
	}

	private void _RecycleGameObject(GameObject pooledGameObject, bool setIsInit)
	{
		if (pooledGameObject == null || m_poolRoot == null)
		{
			return;
		}
		CPooledGameObjectScript component = pooledGameObject.GetComponent<CPooledGameObjectScript>();
		if (component != null)
		{
			Queue<CPooledGameObjectScript> value = null;
			if (_pooledGameObjectMap.TryGetValue(component.PrefabKey, out value))
			{
				value.Enqueue(component);
				component.OnRecycle();
				component.transform.SetParent(m_poolRoot.transform, worldPositionStays: true);
				component.IsInit = setIsInit;
				return;
			}
		}
		Object.Destroy(pooledGameObject);
	}

	private CPooledGameObjectScript CreateGameObject(string prefabFullPath, Vector3 pos, Quaternion rot, bool useRotation)
	{
		GameObject gameObject = Resources.Load<GameObject>(prefabFullPath);
		if (gameObject == null)
		{
			Debug.LogError("prefabObj Can Not Be Null " + prefabFullPath);
			return null;
		}
		GameObject gameObject2;
		if (useRotation)
		{
			gameObject2 = Object.Instantiate(gameObject, pos, rot);
		}
		else
		{
			gameObject2 = Object.Instantiate(gameObject);
			gameObject2.transform.position = pos;
		}
		CPooledGameObjectScript cPooledGameObjectScript = gameObject2.GetComponent<CPooledGameObjectScript>();
		if (cPooledGameObjectScript == null)
		{
			cPooledGameObjectScript = gameObject2.AddComponent<CPooledGameObjectScript>();
		}
		cPooledGameObjectScript.Initialize(prefabFullPath);
		cPooledGameObjectScript.OnCreate();
		return cPooledGameObjectScript;
	}
}
