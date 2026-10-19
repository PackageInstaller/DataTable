using System;
using System.Collections.Generic;
using ACT.UI.ItemDetail.Interface;
using Fundamental;
using UnityEngine;

namespace ACT.UI.ItemDetail.Styles;

[Serializable]
public abstract class UniqStyleBase : IStyle
{
	protected static ObjectPool<Stack<ItemSource>> _objectPool = new ObjectPool<Stack<ItemSource>>(null, null);

	public GameObject topPartRoot;

	public GameObject middlePartRoot;

	public GameObject bottomPartRoot;

	public GameObject obtainWayTipRoot;

	public Transform generateRoot;

	public ItemSource itemSourceTemplate;

	protected Stack<ItemSource> _itemSourcePool;

	public Action OnJumpSuccess { get; set; }

	public virtual void Reset()
	{
		if (!obtainWayTipRoot)
		{
			return;
		}
		obtainWayTipRoot.SetActive(value: true);
		if (_itemSourcePool == null)
		{
			_itemSourcePool = _objectPool.Get();
		}
		for (int num = generateRoot.childCount - 1; num >= 0; num--)
		{
			ItemSource component = generateRoot.GetChild(num).GetComponent<ItemSource>();
			if ((bool)component)
			{
				component.gameObject.SetActive(value: false);
				component.transform.SetParent(generateRoot.parent);
				component.ReleaseJumpResult();
				component.OnJump = null;
			}
		}
	}

	public virtual void Release()
	{
		if (_itemSourcePool != null)
		{
			_objectPool.Release(_itemSourcePool);
			_itemSourcePool.Clear();
		}
	}

	public ItemSource GetGo()
	{
		ItemSource itemSource = ((_itemSourcePool.Count > 0) ? _itemSourcePool.Pop() : UnityEngine.Object.Instantiate(itemSourceTemplate));
		itemSource.transform.SetParent(generateRoot, worldPositionStays: false);
		itemSource.gameObject.SetActive(value: true);
		itemSource.OnJump = OnJumpSuccess;
		return itemSource;
	}
}
