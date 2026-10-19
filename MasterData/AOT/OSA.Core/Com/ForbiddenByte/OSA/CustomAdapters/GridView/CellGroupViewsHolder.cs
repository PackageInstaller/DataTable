using Com.ForbiddenByte.OSA.Core;
using UnityEngine;
using UnityEngine.UI;

namespace Com.ForbiddenByte.OSA.CustomAdapters.GridView;

public class CellGroupViewsHolder<TCellVH> : BaseItemViewsHolder where TCellVH : CellViewsHolder, new()
{
	protected int _Capacity = -1;

	protected int _NumActiveCells;

	private RectTransform[] _ContainingCellInstances;

	public override int ItemIndex
	{
		get
		{
			return base.ItemIndex;
		}
		set
		{
			base.ItemIndex = value;
			if (_Capacity > 0)
			{
				OnGroupIndexChanged();
			}
		}
	}

	public int NumActiveCells
	{
		get
		{
			return _NumActiveCells;
		}
		set
		{
			if (_NumActiveCells == value)
			{
				return;
			}
			_NumActiveCells = value;
			for (int i = 0; i < _Capacity; i++)
			{
				TCellVH val = ContainingCellViewsHolders[i];
				GameObject gameObject = val.views.gameObject;
				bool flag = i < _NumActiveCells;
				if (gameObject.activeSelf != flag)
				{
					gameObject.SetActive(flag);
				}
				if (val.rootLayoutElement.ignoreLayout == flag)
				{
					val.rootLayoutElement.ignoreLayout = !flag;
				}
			}
		}
	}

	public TCellVH[] ContainingCellViewsHolders { get; private set; }

	public override void CollectViews()
	{
		base.CollectViews();
		ContainingCellViewsHolders = new TCellVH[_Capacity];
		for (int i = 0; i < _Capacity; i++)
		{
			ContainingCellViewsHolders[i] = new TCellVH();
			RectTransform existingRoot = _ContainingCellInstances[i];
			ContainingCellViewsHolders[i].InitWithExistingRoot(existingRoot, root, -1);
			ContainingCellViewsHolders[i].views.gameObject.SetActive(value: false);
		}
		if (ItemIndex != -1 && _Capacity > 0)
		{
			UpdateIndicesOfContainingCells();
		}
	}

	public void Init(GameObject groupPrefab, RectTransform parent, int itemIndex, RectTransform cellPrefab, int numCellsPerGroup)
	{
		Init(groupPrefab, parent, itemIndex, activateRootGameObject: true, callCollectViews: false);
		_Capacity = numCellsPerGroup;
		_ContainingCellInstances = new RectTransform[_Capacity];
		for (int i = 0; i < _Capacity; i++)
		{
			RectTransform rectTransform = Object.Instantiate(cellPrefab.gameObject, root, worldPositionStays: false).transform as RectTransform;
			rectTransform.gameObject.SetActive(value: true);
			_ContainingCellInstances[i] = rectTransform;
		}
		CollectViews();
		LayoutRebuilder.ForceRebuildLayoutImmediate(root);
	}

	public override void OnBeforeDestroy()
	{
		if (ContainingCellViewsHolders != null)
		{
			for (int i = 0; i < ContainingCellViewsHolders.Length; i++)
			{
				ContainingCellViewsHolders[i]?.OnBeforeDestroy();
			}
		}
		base.OnBeforeDestroy();
	}

	protected virtual void OnGroupIndexChanged()
	{
		if (_Capacity > 0)
		{
			UpdateIndicesOfContainingCells();
		}
	}

	protected virtual void UpdateIndicesOfContainingCells()
	{
		for (int i = 0; i < _Capacity; i++)
		{
			ContainingCellViewsHolders[i].ItemIndex = ItemIndex * _Capacity + i;
		}
	}
}
