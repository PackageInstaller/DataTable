using System;
using Com.ForbiddenByte.OSA.Core;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace Com.ForbiddenByte.OSA.CustomParams;

[Serializable]
public class BaseParamsWithPrefab : BaseParams
{
	[SerializeField]
	[FormerlySerializedAs("itemPrefab")]
	private RectTransform _ItemPrefab;

	[SerializeField]
	[Tooltip("Whether to set the BaseParam's DefaultItemSize to the size of the prefab.\nSetting it to false, leaves DefaultItemSize unchanged.\n")]
	private bool _PrefabControlsDefaultItemSize = true;

	[SerializeField]
	[Tooltip("Whether to set the BaseParam's ItemTransversalSize to the transversal size of the prefab, like it's done with DefaultItemSize.\nSetting this to true naturally overrides any value you set to ItemTransversalSize.\nSetting it to false, leaves ItemTransversalSize unchanged.\n")]
	private bool _AlsoControlItemTransversalSize;

	private float _ItemPrefabSize = -1f;

	[Obsolete("Use ItemPrefab instead", true)]
	public RectTransform itemPrefab
	{
		get
		{
			return ItemPrefab;
		}
		set
		{
			ItemPrefab = value;
		}
	}

	public RectTransform ItemPrefab
	{
		get
		{
			return _ItemPrefab;
		}
		set
		{
			_ItemPrefab = value;
		}
	}

	public bool PrefabControlsDefaultItemSize
	{
		get
		{
			return _PrefabControlsDefaultItemSize;
		}
		set
		{
			_PrefabControlsDefaultItemSize = value;
		}
	}

	public bool AlsoControlItemTransversalSize
	{
		get
		{
			return _AlsoControlItemTransversalSize;
		}
		set
		{
			_AlsoControlItemTransversalSize = value;
		}
	}

	public float ItemPrefabSize
	{
		get
		{
			if (!ItemPrefab)
			{
				throw new OSAException(typeof(BaseParamsWithPrefab).Name + ": the prefab was not set. Please set it through inspector or in code");
			}
			if (_ItemPrefabSize == -1f)
			{
				Rect rect = ItemPrefab.rect;
				if (IsHorizontal)
				{
					_ItemPrefabSize = rect.width;
					if (_AlsoControlItemTransversalSize)
					{
						ItemTransversalSize = rect.height;
						RectOffset contentPadding = ContentPadding;
						int top = (ContentPadding.bottom = -1);
						contentPadding.top = top;
					}
				}
				else
				{
					_ItemPrefabSize = ItemPrefab.rect.height;
					if (_AlsoControlItemTransversalSize)
					{
						ItemTransversalSize = rect.width;
						RectOffset contentPadding2 = ContentPadding;
						int top = (ContentPadding.right = -1);
						contentPadding2.left = top;
					}
				}
			}
			return _ItemPrefabSize;
		}
	}

	public override void InitIfNeeded(IOSA iAdapter)
	{
		base.InitIfNeeded(iAdapter);
		InitItemPrefab();
	}

	protected void InitItemPrefab()
	{
		if (!(ItemPrefab.parent == null))
		{
			if (ItemPrefab.parent != ScrollViewRT)
			{
				RectTransform obj = ItemPrefab.parent as RectTransform;
				if (!obj)
				{
					throw new OSAException("ItemPrefab " + ItemPrefab.name + " should only be parented to an object that has a RectTransform");
				}
				LayoutRebuilder.ForceRebuildLayoutImmediate(obj);
			}
			else
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(ItemPrefab);
			}
		}
		if (PrefabControlsDefaultItemSize)
		{
			AssertValidWidthHeight(ItemPrefab);
			_ItemPrefabSize = -1f;
			DefaultItemSize = ItemPrefabSize;
		}
	}
}
