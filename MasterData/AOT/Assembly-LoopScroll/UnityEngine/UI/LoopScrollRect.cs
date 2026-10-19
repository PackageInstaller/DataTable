using System;
using System.Collections.Generic;
using UnityEngine.Events;
using UnityEngine.Pool;

namespace UnityEngine.UI;

public abstract class LoopScrollRect : LoopScrollRectBase
{
	private static ObjectPool<Stack<GameObject>> m_StackPool = new ObjectPool<Stack<GameObject>>(() => new Stack<GameObject>());

	public GameObject item;

	public bool refreshSelfOnAwake;

	private Dictionary<Type, Stack<GameObject>> _multiPool = new Dictionary<Type, Stack<GameObject>>();

	public UnityEvent onInitOver;

	public void ClearCellsPool()
	{
		ResetVisibleCellRange();
		ResetReachBoundItemCache();
		RecycleAllCachedCells(unload: true);
	}

	private Stack<GameObject> GetOrCreatePool(GameObject source)
	{
		Type key = typeof(GameObject);
		ILoopScrollDataSource loopScrollDataSource = (source ? source.GetComponentInChildren<ILoopScrollDataSource>() : null);
		if (loopScrollDataSource != null)
		{
			key = loopScrollDataSource.GetType();
		}
		if (!_multiPool.TryGetValue(key, out var value))
		{
			value = m_StackPool.Get();
			_multiPool.TryAdd(key, value);
		}
		return value;
	}

	private void RecycleCell(GameObject trans, bool unload)
	{
		if ((bool)trans && (bool)trans.transform && (bool)trans.gameObject)
		{
			ILoopScrollDataSource component = trans.GetComponent<ILoopScrollDataSource>();
			if (unload)
			{
				NotifyCellUnloaded(component);
			}
			else
			{
				NotifyCellHidden(component);
			}
			DetachCellFromContent(trans.transform);
			GetOrCreatePool(trans).Push(trans);
		}
	}

	public ILoopScrollDataSource GetItem(int id)
	{
		for (int i = 0; i < m_CachedAvailableRect.Count; i++)
		{
			RectTransform rectTransform = m_CachedAvailableRect[i];
			if ((bool)rectTransform && (bool)rectTransform.gameObject)
			{
				ILoopScrollDataSource component = rectTransform.GetComponent<ILoopScrollDataSource>();
				if (component != null && component.GetIndex() == id)
				{
					return component;
				}
			}
		}
		return null;
	}

	protected override void Awake()
	{
		base.Awake();
		if ((bool)item)
		{
			item.SetActive(value: false);
		}
		if (refreshSelfOnAwake)
		{
			RefillCells();
		}
	}

	protected override void Start()
	{
		base.Start();
		onInitOver.Invoke();
	}

	protected override void ProvideData(ILoopScrollDataSource transform, int index)
	{
		transform.ScrollCellIndex(index);
		transform.OnShow();
		OnItemShow?.Invoke(transform);
	}

	protected override void OnItemLoaded(ILoopScrollDataSource transform, int index)
	{
		transform.OnLoad(index);
		OnItemLoad?.Invoke(transform);
	}

	protected override void OnItemUnLoaded(ILoopScrollDataSource transform, int index)
	{
		NotifyCellUnloaded(transform);
	}

	protected override RectTransform GetFromTempPool(int itemIdx)
	{
		RectTransform rectTransform = null;
		if (deletedItemTypeStart > 0)
		{
			deletedItemTypeStart--;
			BeforeItemGet?.Invoke(itemIdx);
			int index = (IsStableTempPoolReuse ? GetStableTempPoolIndex(itemIdx, fromStart: true) : 0);
			rectTransform = m_CachedAvailableRect[index];
			SetSiblingIndexAndSync(rectTransform.transform, itemIdx - itemTypeStart + deletedItemTypeStart);
		}
		else if (deletedItemTypeEnd > 0)
		{
			deletedItemTypeEnd--;
			BeforeItemGet?.Invoke(itemIdx);
			int index2 = (IsStableTempPoolReuse ? GetStableTempPoolIndex(itemIdx, fromStart: false) : (m_CachedAvailableRect.Count - deletedItemTypeEnd - 1));
			rectTransform = m_CachedAvailableRect[index2];
			SetSiblingIndexAndSync(rectTransform.transform, itemIdx - itemTypeStart + deletedItemTypeStart);
		}
		else
		{
			BeforeItemGet?.Invoke(itemIdx);
			rectTransform = GetObject(itemIdx, m_Content).transform as RectTransform;
			OnItemLoaded(rectTransform.GetComponent<ILoopScrollDataSource>(), itemIdx);
		}
		ProvideData(rectTransform.GetComponent<ILoopScrollDataSource>(), itemIdx);
		return rectTransform;
	}

	protected override void ReturnToTempPool(bool fromStart, int count)
	{
		if (fromStart)
		{
			deletedItemTypeStart += count;
		}
		else
		{
			deletedItemTypeEnd += count;
		}
	}

	protected override void ClearTempPool()
	{
		RecycleTempPoolRange(0, deletedItemTypeStart);
		deletedItemTypeStart = 0;
		if (deletedItemTypeEnd > 0)
		{
			int startInclusive = m_CachedAvailableRect.Count - deletedItemTypeEnd;
			RecycleTempPoolRange(startInclusive, m_CachedAvailableRect.Count);
			deletedItemTypeEnd = 0;
		}
		SyncCachedSiblingOrder();
	}

	private void RecycleTempPoolRange(int startInclusive, int endExclusive)
	{
		for (int num = endExclusive - 1; num >= startInclusive; num--)
		{
			RectTransform rectTransform = m_CachedAvailableRect[num];
			if ((bool)rectTransform && (bool)rectTransform.gameObject)
			{
				ILoopScrollDataSource component = rectTransform.GetComponent<ILoopScrollDataSource>();
				if (component != null)
				{
					OnItemUnLoaded(component, num);
				}
				ReturnObject(rectTransform.gameObject);
			}
		}
	}

	private void SyncCachedSiblingOrder()
	{
		if (m_CachedAvailableRect == null)
		{
			return;
		}
		for (int i = 0; i < m_CachedAvailableRect.Count; i++)
		{
			RectTransform rectTransform = m_CachedAvailableRect[i];
			if ((bool)rectTransform)
			{
				Transform transform = rectTransform.transform;
				if (transform.GetSiblingIndex() != i)
				{
					transform.SetSiblingIndex(i);
				}
			}
		}
	}

	protected GameObject GetObject(int index, Transform parent = null)
	{
		if (!item)
		{
			return null;
		}
		GameObject gameObject = null;
		Stack<GameObject> orCreatePool = GetOrCreatePool(item);
		if (orCreatePool.Count != 0)
		{
			gameObject = orCreatePool.Pop();
		}
		else
		{
			gameObject = ((!parent) ? Object.Instantiate(item) : Object.Instantiate(item, parent));
		}
		if ((bool)parent && (bool)gameObject)
		{
			gameObject.transform.SetParent(parent, worldPositionStays: false);
			m_CachedAvailableRect.Add(gameObject.GetComponent<RectTransform>());
			LayoutElement component = gameObject.GetComponent<LayoutElement>();
			if ((bool)component)
			{
				component.ignoreLayout = false;
			}
		}
		(gameObject?.GetComponent<ILoopScrollDataSource>())?.OnLoad(index);
		return gameObject;
	}

	protected override void ReturnObject(GameObject trans)
	{
		RecycleCell(trans, unload: false);
	}

	protected override void ReturnObject(GameObject trans, bool unload)
	{
		RecycleCell(trans, unload);
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		if (this == null)
		{
			return;
		}
		foreach (KeyValuePair<Type, Stack<GameObject>> item in _multiPool)
		{
			Stack<GameObject> value = item.Value;
			while (value.Count > 0)
			{
				GameObject gameObject = value.Pop();
				if ((bool)gameObject)
				{
					NotifyCellUnloaded(gameObject.GetComponent<ILoopScrollDataSource>());
					if (this.item != gameObject)
					{
						Object.Destroy(gameObject);
					}
				}
			}
			m_StackPool.Release(value);
		}
		_multiPool.Clear();
	}
}
