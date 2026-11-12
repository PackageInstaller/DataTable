using System.Diagnostics;
using UnityEngine;

public class DynamicSimpleEntity : MonoBehaviour
{
	protected LogManager.Logger _logger;

	public int entityType
	{
		get
		{
			return gameObject.layer;
		}
		protected set
		{
			gameObject.layer = value;
		}
	}

	public long id { get; internal set; } = -1L;

	public bool isInvalid => id == -1;

	public string poolName { get; private set; }

	public bool isSpawnFromPool => !string.IsNullOrEmpty(poolName);

	protected virtual void Awake()
	{
		_logger = Singleton<LogManager>.Instance.get_Item("Entity");
	}

	protected virtual void OnEnable()
	{
		InitializeComponents();
		ModuleController<DormModuleController>.Instance?.RegisterEntity(this);
	}

	protected virtual void OnDisable()
	{
		ModuleController<DormModuleController>.Instance?.UnRegisterEntity(this);
		ReleaseComponents();
	}

	public virtual void DoLogicUpdate(float dt)
	{
	}

	public virtual void DoLateLogicUpdate(float dt)
	{
	}

	public virtual void DoVisualUpdate(float dt)
	{
	}

	public static T SpawnInstance<T>(string poolName, GameObject prefab) where T : DynamicSimpleEntity
	{
		T component = null;
		if (!string.IsNullOrEmpty(poolName) && prefab != null)
		{
			GameObject gameObject = ObjectPoolUtils.SpawnGameObjectFromPool(prefab, poolName, autoDespawn: false);
			Transform poolRootNode = ObjectPoolUtils.GetPoolRootNode(poolName);
			gameObject.transform.SetParent(poolRootNode);
			if (!gameObject.TryGetComponent<T>(out component))
			{
				component = gameObject.AddComponent<T>();
			}
			component.poolName = poolName;
		}
		return component;
	}

	public virtual void DespawnInstance()
	{
		if (!isInvalid)
		{
			gameObject.SetActive(value: false);
		}
	}

	internal void OnDelayDespawnInstance()
	{
		if (isSpawnFromPool)
		{
			ObjectPoolUtils.DespawnToPool(transform, poolName);
		}
	}

	protected virtual void OnSpawned()
	{
	}

	protected virtual void OnDespawned()
	{
	}

	protected virtual void InitializeComponents()
	{
	}

	protected virtual void ReleaseComponents()
	{
	}

	[DebuggerHidden]
	protected void Log(string message)
	{
		_logger.LogInfo("[" + gameObject.name + "] " + message);
	}

	[DebuggerHidden]
	protected void LogWarning(string message)
	{
		_logger.LogWarning("[" + gameObject.name + "] " + message);
	}

	[DebuggerHidden]
	protected void LogError(string message)
	{
		_logger.LogError("[" + gameObject.name + "] " + message);
	}
}
