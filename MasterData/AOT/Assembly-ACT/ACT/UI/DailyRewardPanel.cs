using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.UI.DataProxy;
using UnityEngine;

namespace ACT.UI;

public class DailyRewardPanel : MonoBehaviour
{
	public ItemUIComponentBase rewardTemplate;

	public RectTransform contentRoot;

	private int _collectionID;

	private bool _isComplete;

	private Stack<ItemUIComponentBase> _rewards = new Stack<ItemUIComponentBase>();

	public int CollectionID
	{
		get
		{
			return _collectionID;
		}
		set
		{
			_collectionID = value;
			OpenPanel();
		}
	}

	public Vector3 Position
	{
		get
		{
			return contentRoot.position;
		}
		set
		{
			contentRoot.position = value;
		}
	}

	public bool IsComplete
	{
		set
		{
			_isComplete = value;
			ItemUIComponentBase[] componentsInChildren = contentRoot.GetComponentsInChildren<ItemUIComponentBase>();
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				componentsInChildren[i].IsComplete = value;
			}
		}
	}

	public event Action OnClose;

	private void OpenPanel()
	{
		ItemUIComponentBase[] componentsInChildren = contentRoot.GetComponentsInChildren<ItemUIComponentBase>();
		foreach (ItemUIComponentBase itemUIComponentBase in componentsInChildren)
		{
			itemUIComponentBase.transform.SetParent(contentRoot.parent);
			itemUIComponentBase.gameObject.SetActive(value: false);
			_rewards.Push(itemUIComponentBase);
		}
		Collection data = CoreUtils.GetData(_collectionID, RuntimeConfigs.data.collections);
		if (data != null)
		{
			for (int j = 0; j < data.certain.Count; j++)
			{
				ItemUIComponentBase itemUIComponentBase2 = ((_rewards.Count > 0) ? _rewards.Pop() : UnityEngine.Object.Instantiate(rewardTemplate, contentRoot));
				itemUIComponentBase2.transform.SetParent(contentRoot, worldPositionStays: false);
				ItemKv itemKv = data.certain[j];
				itemUIComponentBase2.SetData(ItemUnifierProxy.ItemUnifierPool.Get<Item>(itemKv.id, itemKv.count), long.MinValue, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide, autoReleaseData: true);
				itemUIComponentBase2.IsComplete = _isComplete;
				itemUIComponentBase2.UpdatePerformance();
				itemUIComponentBase2.gameObject.SetActive(value: true);
			}
			gameObject.SetActive(value: true);
		}
	}

	public void ClosePanel()
	{
		gameObject.SetActive(value: false);
		OnClose?.Invoke();
	}
}
