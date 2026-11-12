using PathologicalGames;
using UnityEngine;

public class AdventureFXHandler : MonoBehaviour
{
	public enum DestroyMode
	{
		Destroy,
		DespawnToPool,
		Disable
	}

	public string fxTag;

	[Tooltip("例如: 连线轨迹在播放时间缩放变慢的情况下(由于粒子喷射速度变慢等原因)拖尾出来的轨迹不太美观时使用")]
	public bool disableTimeScale;

	protected float _timeScale = 1f;

	protected int _hidenRC;

	public long token { get; internal set; }

	public DestroyMode destroyMode { get; internal set; }

	public bool isIndependentUpdate { get; private set; }

	public float timeScale
	{
		get
		{
			return _timeScale;
		}
		set
		{
			_timeScale = value;
			OnTimeScaleChanged();
		}
	}

	public bool ignoreTimeScale { get; set; }

	internal float finalTimeScale
	{
		get
		{
			if (!ignoreTimeScale && !disableTimeScale)
			{
				return Mathf.Max(0f, AdventureFXManager.globalTimeScale * _timeScale);
			}
			return 1f;
		}
	}

	public float deltaTime
	{
		get
		{
			if (isIndependentUpdate)
			{
				return Time.unscaledDeltaTime;
			}
			return Time.deltaTime * finalTimeScale;
		}
	}

	public bool isHidden => _hidenRC > 0;

	protected static Transform SpawnInstance(GameObject prefab, Vector3 spawnPosition, Quaternion spawnRotation, Vector3 spawnScale, bool isPreloadSpawn, out DestroyMode destroyMode)
	{
		Transform transform;
		if (PoolManager.Pools.TryGetValue("FX", out var spawnPool))
		{
			transform = spawnPool.Spawn(prefab.transform, spawnPosition, spawnRotation);
			destroyMode = DestroyMode.DespawnToPool;
			transform.localScale = spawnScale;
			transform.SetParent(ObjectPoolUtils.GetPoolRootNode("FX"));
		}
		else
		{
			transform = Object.Instantiate(prefab, spawnPosition, spawnRotation).transform;
			destroyMode = DestroyMode.Destroy;
			transform.localScale = spawnScale;
		}
		transform.gameObject.SetActive(value: true);
		return transform;
	}

	protected static void DestroyInstance(AdventureFXHandler instance)
	{
		switch (instance.destroyMode)
		{
		case DestroyMode.Destroy:
			Object.Destroy(instance.gameObject);
			break;
		case DestroyMode.DespawnToPool:
		{
			SpawnPool spawnPool = null;
			if (PoolManager.Pools.TryGetValue("FX", out spawnPool))
			{
				spawnPool.Despawn(instance.transform, spawnPool.group);
			}
			else
			{
				instance.gameObject.SetActive(value: false);
			}
			break;
		}
		case DestroyMode.Disable:
			instance.gameObject.SetActive(value: false);
			break;
		}
	}

	protected virtual void OnEnable()
	{
		if (isHidden)
		{
			OnVisible();
			_hidenRC = 0;
		}
		ResetRenderLayer();
		AdventureFXManager instance = SceneSingleton<AdventureFXManager>.Instance;
		if (instance != null)
		{
			instance.RegisterFXHandler(this);
		}
	}

	protected virtual void OnDisable()
	{
		AdventureFXManager instance = SceneSingleton<AdventureFXManager>.Instance;
		if (instance != null)
		{
			instance.UnRegisterFXHandler(this);
		}
		isIndependentUpdate = false;
		_timeScale = 1f;
		ignoreTimeScale = false;
	}

	public virtual void DoUpdate()
	{
	}

	public virtual void DoLateUpdate()
	{
	}

	public virtual void SetIndependentUpdate(bool value)
	{
		isIndependentUpdate = value;
	}

	public virtual void OnTimeScaleChanged()
	{
	}

	public void Hide()
	{
		_hidenRC++;
		if (_hidenRC == 1)
		{
			OnHide();
		}
	}

	protected virtual void OnHide()
	{
	}

	public void Visible()
	{
		_hidenRC--;
		if (_hidenRC == 0)
		{
			OnVisible();
		}
		if (_hidenRC < 0)
		{
			_hidenRC = 0;
		}
	}

	protected virtual void OnVisible()
	{
	}

	public virtual void SetRenderLayer(int layer)
	{
	}

	public virtual void ResetRenderLayer()
	{
	}

	public static bool ActiveValidate(AdventureFXHandler instance, long compareToken = 0L)
	{
		if (instance == null)
		{
			return false;
		}
		if (instance.token == 0L)
		{
			return false;
		}
		if (compareToken != 0L && instance.token != compareToken)
		{
			return false;
		}
		return true;
	}
}
