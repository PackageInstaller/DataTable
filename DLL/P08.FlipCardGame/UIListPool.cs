using System.Collections.Generic;
using UnityEngine;

public class UIListPool
{
	private UIList _uiList;

	private Queue<GameObject> _pool;

	private GameObject ItemPrefab;

	private Dictionary<int, GameObject> _objectDic;

	public UIListPool(UIList uiList, GameObject itemPrefab)
	{
		_uiList = uiList;
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
			_uiList.SetItemActive(gameObject, value: true);
			return gameObject;
		}
		GameObject gameObject2 = Object.Instantiate(ItemPrefab, null);
		gameObject2.SetActive(value: true);
		_uiList.SetItemActive(gameObject2, value: true);
		RectTransform obj = gameObject2.transform as RectTransform;
		obj.anchorMin = Vector2.up;
		obj.anchorMax = Vector3.up;
		obj.pivot = Vector3.up;
		obj.localPosition = Vector3.zero;
		Rect itemRect = UIListCalculator.GetItemRect(_uiList);
		obj.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, itemRect.width);
		obj.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, itemRect.height);
		return gameObject2;
	}

	public bool ReturnToPool(GameObject go, bool isActive = true)
	{
		_uiList.SetItemActive(go, value: false);
		_objectDic[go.GetInstanceID()] = go;
		_pool.Enqueue(go);
		return true;
	}

	public void SetPoolItemsInActive()
	{
		foreach (GameObject value in _objectDic.Values)
		{
			_uiList.SetItemActive(value, value: false);
		}
	}
}
