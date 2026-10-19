using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle;

public sealed class BattleGameObjectPoolService
{
	private static BattleGameObjectPoolService _instance;

	private readonly Dictionary<string, BattlePoolEntry> _entries = new Dictionary<string, BattlePoolEntry>(16);

	private readonly List<BattlePoolStats> _statsCache = new List<BattlePoolStats>(16);

	private static readonly List<MonoBehaviour> RuntimeAttachmentBuffer = new List<MonoBehaviour>(4);

	private Transform _poolRoot;

	private readonly Dictionary<string, Transform> _poolKeyRoots = new Dictionary<string, Transform>(16);

	private readonly Dictionary<string, BattlePoolPolicy> _defaultPolicies = new Dictionary<string, BattlePoolPolicy>(8);

	public static BattleGameObjectPoolService Instance => _instance ?? (_instance = new BattleGameObjectPoolService());

	private BattleGameObjectPoolService()
	{
		RegisterDefaultPolicies();
	}

	public GameObject Acquire(string key, Func<GameObject> factory, Transform parent = null)
	{
		if (string.IsNullOrEmpty(key))
		{
			throw new ArgumentException("Pool key cannot be null or empty.", "key");
		}
		if (factory == null)
		{
			throw new ArgumentNullException("factory");
		}
		BattlePoolEntry orCreateEntry = GetOrCreateEntry(key);
		GameObject gameObject = null;
		while (orCreateEntry.InactiveInstances.Count > 0 && gameObject == null)
		{
			gameObject = orCreateEntry.InactiveInstances.Pop();
		}
		if (gameObject != null)
		{
			orCreateEntry.AcquireReuseCount++;
		}
		else
		{
			gameObject = factory();
			orCreateEntry.AcquireCreateCount++;
			orCreateEntry.TotalCreatedCount++;
		}
		gameObject.transform.SetParent(parent, worldPositionStays: false);
		gameObject.SetActive(value: true);
		orCreateEntry.ActiveInstanceCount++;
		orCreateEntry.LastAcquireTime = Time.realtimeSinceStartup;
		return gameObject;
	}

	public bool Release(string key, GameObject instance)
	{
		if (string.IsNullOrEmpty(key) || instance == null)
		{
			return false;
		}
		if (!_entries.TryGetValue(key, out var value))
		{
			return false;
		}
		if (key == "Battle.BulletRoot")
		{
			ReleaseBulletRuntimeAttachments(instance.transform);
		}
		instance.SetActive(value: false);
		value.LastReleaseTime = Time.realtimeSinceStartup;
		value.ReleaseCount++;
		if (value.ActiveInstanceCount > 0)
		{
			value.ActiveInstanceCount--;
		}
		if (value.InactiveInstances.Count >= value.PoolPolicy.MaxInactiveCount)
		{
			UnityEngine.Object.Destroy(instance);
			value.TotalDestroyedCount++;
			value.ReleaseOverflowDestroyCount++;
			return true;
		}
		instance.transform.SetParent(GetOrCreatePoolKeyRoot(key), worldPositionStays: false);
		value.InactiveInstances.Push(instance);
		return true;
	}

	private static void ReleaseBulletRuntimeAttachments(Transform root)
	{
		if (root == null)
		{
			return;
		}
		MonoEntity component = root.GetComponent<MonoEntity>();
		if (component != null)
		{
			component.RemoveEntityRef();
		}
		for (int num = root.childCount - 1; num >= 0; num--)
		{
			Transform child = root.GetChild(num);
			child.GetComponents(RuntimeAttachmentBuffer);
			bool flag = false;
			for (int i = 0; i < RuntimeAttachmentBuffer.Count; i++)
			{
				if (RuntimeAttachmentBuffer[i] is IBattleRuntimeAttachment battleRuntimeAttachment)
				{
					battleRuntimeAttachment.ReleaseRuntimeAttachment();
					flag = true;
				}
			}
			RuntimeAttachmentBuffer.Clear();
			if (flag)
			{
				child.gameObject.SetActive(value: false);
				child.SetParent(null, worldPositionStays: false);
				UnityEngine.Object.Destroy(child.gameObject);
			}
		}
	}

	public void Prewarm(string key, int count, Func<GameObject> factory, Action<GameObject> onCreate = null)
	{
		if (count <= 0)
		{
			return;
		}
		if (string.IsNullOrEmpty(key))
		{
			throw new ArgumentException("Pool key cannot be null or empty.", "key");
		}
		if (factory == null)
		{
			throw new ArgumentNullException("factory");
		}
		BattlePoolEntry orCreateEntry = GetOrCreateEntry(key);
		for (int i = 0; i < count; i++)
		{
			if (orCreateEntry.InactiveInstances.Count >= orCreateEntry.PoolPolicy.MaxInactiveCount)
			{
				break;
			}
			GameObject gameObject = factory();
			orCreateEntry.TotalCreatedCount++;
			orCreateEntry.PrewarmCreatedCount++;
			onCreate?.Invoke(gameObject);
			gameObject.SetActive(value: false);
			gameObject.transform.SetParent(GetOrCreatePoolKeyRoot(key), worldPositionStays: false);
			orCreateEntry.InactiveInstances.Push(gameObject);
			orCreateEntry.LastReleaseTime = Time.realtimeSinceStartup;
		}
	}

	public void ConfigurePolicy(string key, BattlePoolPolicy policy)
	{
		BattlePoolEntry orCreateEntry = GetOrCreateEntry(key);
		orCreateEntry.PoolPolicy = policy;
		TrimToKeepCount(orCreateEntry, orCreateEntry.PoolPolicy.MaxInactiveCount, isAutoTrim: false);
	}

	public int Trim(string key, int keepInactiveCount = 0)
	{
		if (!_entries.TryGetValue(key, out var value))
		{
			return 0;
		}
		return TrimToKeepCount(value, keepInactiveCount, isAutoTrim: false);
	}

	public int TrimAll(int keepInactiveCount = 0)
	{
		int num = 0;
		foreach (BattlePoolEntry value in _entries.Values)
		{
			num += TrimToKeepCount(value, keepInactiveCount, isAutoTrim: false);
		}
		return num;
	}

	public int Clear(string key)
	{
		return Trim(key);
	}

	public int ClearAll()
	{
		return TrimAll();
	}

	public BattlePoolStats GetStats(string key)
	{
		if (!_entries.TryGetValue(key, out var value))
		{
			BattlePoolPolicy poolPolicy = (_defaultPolicies.TryGetValue(key, out var value2) ? value2 : BattlePoolPolicy.Default);
			return new BattlePoolStats(key, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0f, 0f, 0f, poolPolicy);
		}
		return value.ToStats();
	}

	public IReadOnlyList<BattlePoolStats> GetAllStats()
	{
		_statsCache.Clear();
		foreach (KeyValuePair<string, BattlePoolEntry> entry in _entries)
		{
			_statsCache.Add(entry.Value.ToStats());
		}
		return _statsCache;
	}

	private BattlePoolEntry GetOrCreateEntry(string key)
	{
		if (_entries.TryGetValue(key, out var value))
		{
			return value;
		}
		value = new BattlePoolEntry(key);
		if (_defaultPolicies.TryGetValue(key, out var value2))
		{
			value.PoolPolicy = value2;
		}
		_entries.Add(key, value);
		return value;
	}

	private void RegisterDefaultPolicies()
	{
		_defaultPolicies["Battle.BulletRoot"] = new BattlePoolPolicy(16, 0, 20f, 5f, BattlePoolAutoRecycleMode.Update);
		_defaultPolicies["Battle.DummyRoot"] = new BattlePoolPolicy(8, 0, 30f, 5f, BattlePoolAutoRecycleMode.Update);
	}

	internal void UpdateAutoRecycle(float now)
	{
		foreach (BattlePoolEntry value in _entries.Values)
		{
			if (value.PoolPolicy.AutoRecycleMode != BattlePoolAutoRecycleMode.None)
			{
				TryAutoTrimEntry(value, now);
			}
		}
	}

	private void TryAutoTrimEntry(BattlePoolEntry entry, float now)
	{
		if (entry.InactiveInstances.Count > entry.PoolPolicy.AutoTrimInactiveCount && entry.PoolPolicy.AutoRecycleMode != BattlePoolAutoRecycleMode.None && !(now - entry.LastReleaseTime < entry.PoolPolicy.AutoTrimDelaySeconds) && !(now - entry.LastTrimTime < entry.PoolPolicy.SweepIntervalSeconds))
		{
			TrimToKeepCount(entry, entry.PoolPolicy.AutoTrimInactiveCount, isAutoTrim: true);
			entry.LastTrimTime = now;
		}
	}

	private int TrimToKeepCount(BattlePoolEntry entry, int keepInactiveCount, bool isAutoTrim)
	{
		int num = Mathf.Max(0, keepInactiveCount);
		int num2 = 0;
		while (entry.InactiveInstances.Count > num)
		{
			GameObject gameObject = entry.InactiveInstances.Pop();
			if (!(gameObject == null))
			{
				UnityEngine.Object.Destroy(gameObject);
				entry.TotalDestroyedCount++;
				if (isAutoTrim)
				{
					entry.AutoTrimDestroyCount++;
				}
				else
				{
					entry.ManualTrimDestroyCount++;
				}
				num2++;
			}
		}
		if (num2 > 0)
		{
			entry.LastTrimTime = Time.realtimeSinceStartup;
		}
		return num2;
	}

	private Transform GetOrCreatePoolKeyRoot(string key)
	{
		if (_poolKeyRoots.TryGetValue(key, out var value) && value != null)
		{
			return value;
		}
		value = new GameObject("[" + key + "]Pool").transform;
		value.SetParent(GetOrCreatePoolRoot(), worldPositionStays: false);
		_poolKeyRoots[key] = value;
		return value;
	}

	private Transform GetOrCreatePoolRoot()
	{
		if (_poolRoot != null)
		{
			return _poolRoot;
		}
		GameObject gameObject = new GameObject("[Battle]GameObjectPool");
		UnityEngine.Object.DontDestroyOnLoad(gameObject);
		if (gameObject.GetComponent<BattlePoolAutoRecycleDriver>() == null)
		{
			gameObject.AddComponent<BattlePoolAutoRecycleDriver>();
		}
		_poolRoot = gameObject.transform;
		return _poolRoot;
	}
}
