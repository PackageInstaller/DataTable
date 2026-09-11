using System.Collections.Generic;
using UnityEngine;

public class UIScrollerPool
{
	private UIScroller _uiScroller;

	private Queue<GameObject> _pool;

	private GameObject ItemPrefab;

	private Dictionary<int, GameObject> _objectDic;

	public UIScrollerPool(UIScroller uiScroller, GameObject itemPrefab)
	{
		_uiScroller = uiScroller;
		ItemPrefab = itemPrefab;
		_objectDic = new Dictionary<int, GameObject>();
		_pool = new Queue<GameObject>();
	}

	public GameObject GetFromPool()
	{
		if (_pool.Count > 0)
		{
			GameObject gameObject = _pool.Dequeue();
			_objectDic.Remove(gameObject.GetInstanceID());
			_uiScroller.SetItemActive(gameObject, value: true);
			return gameObject;
		}
		GameObject gameObject2 = Object.Instantiate(ItemPrefab, null);
		gameObject2.SetActive(value: true);
		_uiScroller.SetItemActive(gameObject2, value: true);
		RectTransform obj = gameObject2.transform as RectTransform;
		obj.anchorMin = Vector2.up;
		obj.anchorMax = Vector3.up;
		obj.pivot = Vector3.up;
		obj.localPosition = Vector3.zero;
		return gameObject2;
	}

	public bool ReturnToPool(GameObject go, bool isActive = true)
	{
		_uiScroller.SetItemActive(go, value: false);
		_objectDic[go.GetInstanceID()] = go;
		_pool.Enqueue(go);
		return true;
	}

	public void SetPoolItemsInActive()
	{
		foreach (GameObject value in _objectDic.Values)
		{
			_uiScroller.SetItemActive(value, value: false);
		}
	}
}
