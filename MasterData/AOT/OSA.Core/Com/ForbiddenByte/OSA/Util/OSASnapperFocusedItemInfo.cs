using System;
using Com.ForbiddenByte.OSA.Core;
using UnityEngine;
using UnityEngine.Events;

namespace Com.ForbiddenByte.OSA.Util;

public class OSASnapperFocusedItemInfo : MonoBehaviour
{
	[Serializable]
	public class FocusedItemChangedUnityEvent : UnityEvent<AbstractViewsHolder>
	{
	}

	[Serializable]
	public class FocusedItemIndexChangedUnityEvent : UnityEvent<int>
	{
	}

	[SerializeField]
	private Snapper8 _Snapper;

	public FocusedItemChangedUnityEvent FocusedItemChanged;

	public FocusedItemIndexChangedUnityEvent FocusedItemIndexChanged;

	private int _FocusedIndex = -1;

	private IOSA _OSA;

	public int FocusedIndex => _FocusedIndex;

	private void Start()
	{
		_OSA = GetComponent(typeof(IOSA)) as IOSA;
		_OSA.ItemsRefreshed += OnItemsRefreshed;
	}

	private void Update()
	{
		AbstractViewsHolder middleVH = _Snapper.GetMiddleVH(out var _);
		int num = middleVH?.ItemIndex ?? (-1);
		if (_FocusedIndex != num)
		{
			ChangeFocusedItem(middleVH);
		}
	}

	private void OnItemsRefreshed(int _, int __)
	{
		if (_FocusedIndex != -1)
		{
			ChangeFocusedItem(null);
		}
	}

	private void ChangeFocusedItem(AbstractViewsHolder vh)
	{
		if (vh == null)
		{
			_FocusedIndex = -1;
		}
		else
		{
			_FocusedIndex = vh.ItemIndex;
		}
		if (FocusedItemChanged != null)
		{
			FocusedItemChanged.Invoke(vh);
		}
		if (FocusedItemIndexChanged != null)
		{
			FocusedItemIndexChanged.Invoke(_FocusedIndex);
		}
	}
}
