using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

internal sealed class EliteElementEffectPool
{
	private readonly struct PoolEntry(EliteElementEffectView prefab, EliteElementEffectView instance)
	{
		public readonly EliteElementEffectView Prefab = prefab;

		public readonly EliteElementEffectView Instance = instance;
	}

	private readonly Transform _poolRoot;

	private readonly int _maxIdlePerPrefab;

	private readonly int _maxIdleTotal;

	private readonly List<PoolEntry> _idleEntries;

	private readonly Dictionary<EliteElementEffectView, int> _idleCountByPrefab = new Dictionary<EliteElementEffectView, int>(5);

	public EliteElementEffectPool(Transform owner, int maxIdlePerPrefab, int maxIdleTotal)
	{
		_maxIdlePerPrefab = Mathf.Max(1, maxIdlePerPrefab);
		_maxIdleTotal = Mathf.Max(_maxIdlePerPrefab, maxIdleTotal);
		_idleEntries = new List<PoolEntry>(_maxIdleTotal);
		GameObject gameObject = new GameObject("EliteElementEffectPool", typeof(RectTransform));
		_poolRoot = gameObject.transform;
		_poolRoot.SetParent(owner, worldPositionStays: false);
		gameObject.SetActive(value: false);
	}

	public EliteElementEffectView Rent(EliteElementEffectView prefab, Transform parent)
	{
		for (int num = _idleEntries.Count - 1; num >= 0; num--)
		{
			PoolEntry poolEntry = _idleEntries[num];
			if (poolEntry.Prefab == prefab)
			{
				EliteElementEffectView instance = poolEntry.Instance;
				RemoveIdleEntry(num, poolEntry.Prefab);
				if (instance != null)
				{
					instance.transform.SetParent(parent, worldPositionStays: false);
					ResetRootTransform(prefab.transform, instance.transform);
					instance.PrepareForPoolReuse(prefab.gameObject.activeSelf);
					return instance;
				}
			}
		}
		return Object.Instantiate(prefab, parent, worldPositionStays: false);
	}

	public void Recycle(EliteElementEffectView prefab, EliteElementEffectView instance)
	{
		if (!(prefab == null) && !(instance == null))
		{
			instance.PrepareForPoolRecycle();
			instance.transform.SetParent(_poolRoot, worldPositionStays: false);
			_idleEntries.Add(new PoolEntry(prefab, instance));
			_idleCountByPrefab.TryGetValue(prefab, out var value);
			_idleCountByPrefab[prefab] = value + 1;
			TrimPrefab(prefab);
			TrimTotal();
		}
	}

	private void TrimPrefab(EliteElementEffectView prefab)
	{
		if (!_idleCountByPrefab.TryGetValue(prefab, out var value) || value <= _maxIdlePerPrefab)
		{
			return;
		}
		int num = 0;
		while (num < _idleEntries.Count && value > _maxIdlePerPrefab)
		{
			if (_idleEntries[num].Prefab == prefab)
			{
				RemoveAndDestroy(num);
				value--;
			}
			else
			{
				num++;
			}
		}
	}

	private void TrimTotal()
	{
		while (_idleEntries.Count > _maxIdleTotal)
		{
			RemoveAndDestroy(0);
		}
	}

	private void RemoveAndDestroy(int index)
	{
		PoolEntry poolEntry = _idleEntries[index];
		EliteElementEffectView instance = poolEntry.Instance;
		RemoveIdleEntry(index, poolEntry.Prefab);
		if (instance != null)
		{
			Object.Destroy(instance.gameObject);
		}
	}

	private void RemoveIdleEntry(int index, EliteElementEffectView prefab)
	{
		_idleEntries.RemoveAt(index);
		if (_idleCountByPrefab.TryGetValue(prefab, out var value))
		{
			if (value <= 1)
			{
				_idleCountByPrefab.Remove(prefab);
			}
			else
			{
				_idleCountByPrefab[prefab] = value - 1;
			}
		}
	}

	private static void ResetRootTransform(Transform prefabTransform, Transform instanceTransform)
	{
		instanceTransform.localPosition = prefabTransform.localPosition;
		instanceTransform.localRotation = prefabTransform.localRotation;
		instanceTransform.localScale = prefabTransform.localScale;
		if (prefabTransform is RectTransform rectTransform && instanceTransform is RectTransform rectTransform2)
		{
			rectTransform2.anchorMin = rectTransform.anchorMin;
			rectTransform2.anchorMax = rectTransform.anchorMax;
			rectTransform2.anchoredPosition3D = rectTransform.anchoredPosition3D;
			rectTransform2.sizeDelta = rectTransform.sizeDelta;
			rectTransform2.pivot = rectTransform.pivot;
		}
		instanceTransform.SetAsLastSibling();
	}
}
