using ACT.Battle;
using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;
using UnityEngine.Pool;

namespace ACT.World.Modules;

internal class SceneTriggerEntry : MonoBehaviour
{
	internal interface ITriggerCallback
	{
		void OnEnterTrigger(Collider other);

		void OnExitTrigger(Collider other);

		void OnUpdate()
		{
		}

		static bool IsMainEntity(Collider other)
		{
			GameObject root = MonoECS.instance.mainEntity.GetRoot();
			if (root != null)
			{
				return root == other.gameObject;
			}
			return false;
		}
	}

	private static Transform _activeContainer;

	private static Transform _inactiveContainer;

	private static ObjectPool<SceneTriggerEntry> _pool;

	private ITriggerCallback _callbackProcessor;

	private Vector3 _colliderSize;

	private Vector3 _colliderCenter;

	private BoxCollider _collider;

	public static ObjectPool<SceneTriggerEntry> Pool => _pool ?? (_pool = new ObjectPool<SceneTriggerEntry>(OnCreateEntry, OnGetEntry, OnReleaseEntry, OnDestroyEntry, collectionCheck: true, 5, 20));

	public BoxCollider Collider
	{
		get
		{
			return _collider;
		}
		private set
		{
			_collider = value;
			_collider.size = _colliderSize;
			_collider.center = _colliderCenter;
		}
	}

	static SceneTriggerEntry()
	{
		InitContainer();
	}

	private static void InitContainer()
	{
		Transform parent = MonoECS.instance.GetRoot(SceneRootType.Triggers).transform;
		_activeContainer = new GameObject(" - Active").transform;
		_inactiveContainer = new GameObject(" = Inactive").transform;
		_activeContainer.SetParent(parent, worldPositionStays: false);
		_inactiveContainer.SetParent(parent, worldPositionStays: false);
		Transform inactiveContainer = _inactiveContainer;
		Vector3 position = (_activeContainer.position = Vector3.zero);
		inactiveContainer.position = position;
		_inactiveContainer.gameObject.SetActive(value: false);
	}

	private static SceneTriggerEntry OnCreateEntry()
	{
		GameObject gameObject = new GameObject("Undefined Entry", typeof(SceneTriggerEntry), typeof(BoxCollider));
		gameObject.GetComponent<BoxCollider>().isTrigger = true;
		return gameObject.GetComponent<SceneTriggerEntry>();
	}

	private static void OnGetEntry(SceneTriggerEntry entry)
	{
		entry.transform.SetParent(_activeContainer);
	}

	private static void OnReleaseEntry(SceneTriggerEntry entry)
	{
		entry.transform.SetParent(_inactiveContainer);
		entry._callbackProcessor = null;
	}

	private static void OnDestroyEntry(SceneTriggerEntry entry)
	{
		Object.Destroy(entry.gameObject);
	}

	private void Start()
	{
		InitCollider();
	}

	private void InitCollider()
	{
		if (Collider == null)
		{
			if (!TryGetComponent<BoxCollider>(out var component))
			{
				component = gameObject.AddComponent<BoxCollider>();
			}
			Collider = component;
		}
	}

	internal void Setup(ITriggerCallback callback, Vector3 position, Vector3 center, Vector3 size, string debugName)
	{
		_callbackProcessor = callback;
		_colliderCenter = center;
		_colliderSize = size;
		transform.position = position;
		gameObject.name = debugName;
		if (!(Collider == null))
		{
			Collider.center = _colliderCenter;
			Collider.size = _colliderSize;
		}
	}

	private void OnTriggerEnter(Collider other)
	{
		_callbackProcessor?.OnEnterTrigger(other);
	}

	private void Update()
	{
		_callbackProcessor?.OnUpdate();
	}

	private void OnTriggerExit(Collider other)
	{
		_callbackProcessor?.OnExitTrigger(other);
	}
}
