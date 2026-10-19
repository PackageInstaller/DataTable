using UnityEngine;

namespace Fundamental;

public class CPooledGameObjectScript : MonoBehaviour
{
	private IPooledMonoBehaviour[] _cachedIPooledMonos;

	public string PrefabKey { get; set; }

	public bool IsInit { get; set; }

	public Vector3 DefaultScale { get; set; }

	private bool IsInUse { get; set; }

	public void Initialize(string prefabKey)
	{
		_cachedIPooledMonos = GetComponentsInChildren<IPooledMonoBehaviour>(includeInactive: true);
		PrefabKey = prefabKey;
		DefaultScale = gameObject.transform.localScale;
		IsInit = true;
		IsInUse = false;
		gameObject.name = PrefabKey + "_" + GetInstanceID();
	}

	public void AddCachedMono(MonoBehaviour mono, bool defaultEnabled)
	{
		if (!(mono == null) && mono is IPooledMonoBehaviour)
		{
			IPooledMonoBehaviour[] array = new IPooledMonoBehaviour[_cachedIPooledMonos.Length + 1];
			for (int i = 0; i < _cachedIPooledMonos.Length; i++)
			{
				array[i] = _cachedIPooledMonos[i];
			}
			array[_cachedIPooledMonos.Length] = mono as IPooledMonoBehaviour;
			_cachedIPooledMonos = array;
		}
	}

	public void OnCreate()
	{
		if (_cachedIPooledMonos == null)
		{
			return;
		}
		for (int i = 0; i < _cachedIPooledMonos.Length; i++)
		{
			if (_cachedIPooledMonos[i] != null)
			{
				_cachedIPooledMonos[i].OnCreate();
			}
		}
	}

	public void OnGet()
	{
		if (!gameObject.activeSelf)
		{
			gameObject.SetActive(value: true);
		}
		if (_cachedIPooledMonos != null)
		{
			for (int i = 0; i < _cachedIPooledMonos.Length; i++)
			{
				if (_cachedIPooledMonos[i] != null)
				{
					_cachedIPooledMonos[i].OnGet();
				}
			}
		}
		IsInUse = true;
	}

	public void OnRecycle()
	{
		if (_cachedIPooledMonos != null)
		{
			for (int i = 0; i < _cachedIPooledMonos.Length; i++)
			{
				if (_cachedIPooledMonos[i] != null)
				{
					_cachedIPooledMonos[i].OnRecycle();
				}
			}
		}
		gameObject.SetActive(value: false);
		IsInUse = false;
	}

	public void OnPrepare()
	{
		gameObject.SetActive(value: false);
	}
}
