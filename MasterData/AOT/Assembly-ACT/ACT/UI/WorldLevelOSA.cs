using System;
using ACT.Model;
using ACT.ViewControl;
using Com.ForbiddenByte.OSA.Core;
using Com.ForbiddenByte.OSA.DataHelpers;
using UnityEngine;

namespace ACT.UI;

public class WorldLevelOSA : OSA<WorldLevelBreakParam, WorldLevelBreakItemVH>
{
	private Action<int> _onSelectLevel;

	private SimpleDataHelper<WorldLevelItemData> _data;

	private int _minLevel;

	private int _maxLevel;

	private int _curLevel;

	private int _selectLevel;

	private float _offect = 92f;

	private bool isReset;

	private bool isScrollTo;

	private bool _isFirstLoad = true;

	private int _lastMiddleIndex = -1;

	private bool _isUpdatingScale;

	public object DataContext { get; set; }

	public object ItemSourceDataContext { get; set; }

	private int _halfContentWidth => (int)Content.rect.width / 2;

	private int _selectIndex => _selectLevel;

	private Vector2 midpos => new Vector2(_halfContentWidth, 0f);

	protected override void Start()
	{
		_offect = _Params.DefaultItemSize + _Params.ContentSpacing;
	}

	protected override void Update()
	{
		base.Update();
		if (IsInitialized)
		{
			if (IsDragging || isScrollTo)
			{
				UpdateItemScale();
			}
			else if (!_isUpdatingScale)
			{
				_isUpdatingScale = true;
				UpdateItemScale();
				_isUpdatingScale = false;
			}
		}
	}

	public void UpdateItemScale()
	{
		if (!IsInitialized || _data == null || _data.Count == 0)
		{
			return;
		}
		int currentMiddleIndex = GetCurrentMiddleIndex();
		if (currentMiddleIndex == _lastMiddleIndex && !_isFirstLoad)
		{
			return;
		}
		_lastMiddleIndex = currentMiddleIndex;
		for (int i = 0; i < VisibleItemsCount; i++)
		{
			WorldLevelBreakItemVH itemViewsHolder = GetItemViewsHolder(i);
			if (itemViewsHolder == null)
			{
				continue;
			}
			int itemIndex = itemViewsHolder.ItemIndex;
			if (itemIndex >= 0 && itemIndex < _data.Count && !_data[itemIndex].IsPlaceholder)
			{
				float num = Mathf.Clamp01(Vector2.Distance(itemViewsHolder.root.localPosition, midpos) / _offect);
				if (itemIndex == currentMiddleIndex)
				{
					itemViewsHolder.ChangeScale(1.56f - num * 0.56f);
				}
				else
				{
					itemViewsHolder.ChangeScale(1f + 0.56f * (1f - num));
				}
			}
		}
	}

	public ACT.ViewControl.SelectableEx GetMiddleSelectableEx()
	{
		if (!IsInitialized || _data == null || _data.Count == 0)
		{
			return null;
		}
		int currentMiddleIndex = GetCurrentMiddleIndex();
		for (int i = 0; i < VisibleItemsCount; i++)
		{
			WorldLevelBreakItemVH itemViewsHolder = GetItemViewsHolder(i);
			if (itemViewsHolder != null)
			{
				int itemIndex = itemViewsHolder.ItemIndex;
				if (itemIndex >= 0 && itemIndex < _data.Count && !_data[itemIndex].IsPlaceholder && itemIndex == currentMiddleIndex)
				{
					return itemViewsHolder.GetCurrentSelectableEx();
				}
			}
		}
		return null;
	}

	private int GetCurrentMiddleIndex()
	{
		if (!IsInitialized || _data == null || _data.Count == 0)
		{
			return -1;
		}
		int result = -1;
		float num = float.MaxValue;
		for (int i = 0; i < VisibleItemsCount; i++)
		{
			WorldLevelBreakItemVH itemViewsHolder = GetItemViewsHolder(i);
			if (itemViewsHolder != null)
			{
				float num2 = Vector2.Distance(itemViewsHolder.root.localPosition, midpos);
				if (num2 < num)
				{
					num = num2;
					result = itemViewsHolder.ItemIndex;
				}
			}
		}
		return result;
	}

	public void Reload(int minLevel, int maxLevel, int curLevel, Action<int> onSelectLevel)
	{
		_minLevel = minLevel;
		_maxLevel = maxLevel;
		_curLevel = curLevel;
		_selectLevel = curLevel;
		_onSelectLevel = onSelectLevel;
		_isFirstLoad = true;
		_lastMiddleIndex = -1;
		isScrollTo = false;
		WorldLevelItemData[] array = new WorldLevelItemData[Model<WorldLevelModel>.Interface.displayItems.Count];
		for (int i = 0; i < Model<WorldLevelModel>.Interface.displayItems.Count; i++)
		{
			LevelDisplayItem levelDisplayItem = Model<WorldLevelModel>.Interface.displayItems[i];
			array[i] = new WorldLevelItemData(levelDisplayItem.type, i, i == curLevel, levelDisplayItem.isPlaceholder);
		}
		_data = new SimpleDataHelper<WorldLevelItemData>(this);
		if (!IsInitialized)
		{
			Init();
		}
		if (_Params.Snapper != null)
		{
			_Params.Snapper.SnappingEndedOrCancelled += OnScrollToLevel;
			_Params.Snapper.OnPassingCell -= OnPassLevel;
			_Params.Snapper.OnPassingCell += OnPassLevel;
			_Params.Snapper.OnDrag -= OnDrag;
			_Params.Snapper.OnDrag += OnDrag;
		}
		_data.ResetItems(array);
		ScrollTo(_curLevel, 0.5f, 0.5f);
	}

	private void OnDrag(int targetIndex)
	{
	}

	protected override WorldLevelBreakItemVH CreateViewsHolder(int itemIndex)
	{
		WorldLevelBreakItemVH worldLevelBreakItemVH = new WorldLevelBreakItemVH();
		worldLevelBreakItemVH.Init(_Params.ItemPrefab, _Params.Content, itemIndex);
		worldLevelBreakItemVH.BindClickAction(ScrollToLevelByVh);
		return worldLevelBreakItemVH;
	}

	protected override void UpdateViewsHolder(WorldLevelBreakItemVH newOrRecycled)
	{
		WorldLevelItemData worldLevelItemData = _data[newOrRecycled.ItemIndex];
		newOrRecycled.BindDataContext(ItemSourceDataContext);
		newOrRecycled.UpdateViews(worldLevelItemData);
		bool flag = worldLevelItemData.WorldLevelItemIndex == _selectLevel;
		newOrRecycled.ChangeScale(flag ? 0f : 1f);
	}

	public void ScrollToLevelByVh(WorldLevelBreakItemVH vh)
	{
		if (!_data[vh.ItemIndex].IsPlaceholder)
		{
			isScrollTo = true;
			SmoothScrollTo(_data[vh.ItemIndex].WorldLevelItemIndex, 0.5f, 0.5f, 0.5f, null, OnScrollToLevel, overrideCurrentScrollingAnimation: true);
		}
	}

	private void OnScrollToLevel()
	{
		if (!(_Params.Snapper.GetMiddleVH(out var _) is WorldLevelBreakItemVH worldLevelBreakItemVH))
		{
			return;
		}
		int worldLevelItemIndex = _data[worldLevelBreakItemVH.ItemIndex].WorldLevelItemIndex;
		int itemIndex = worldLevelBreakItemVH.ItemIndex;
		if (_data[worldLevelBreakItemVH.ItemIndex].IsPlaceholder || worldLevelItemIndex == _selectLevel || worldLevelItemIndex > _maxLevel)
		{
			return;
		}
		for (int i = 0; i < _data.Count; i++)
		{
			if (_data[i].IsSelect && i != itemIndex)
			{
				_data[i].SetIsSelect(isSelect: false);
				(GetBaseItemViewsHolderIfVisible(i) as WorldLevelBreakItemVH)?.RefreshSelect(isSelect: false, _curLevel, _maxLevel);
			}
		}
		_data[itemIndex].SetIsSelect(isSelect: true);
		Debug.Log($"OnScrollToWorldLevel 当前_selectIndex: {_selectIndex}, 新值: {itemIndex}");
		worldLevelBreakItemVH.RefreshSelect(isSelect: true, _curLevel, _maxLevel);
		_selectLevel = worldLevelItemIndex;
		_onSelectLevel(_selectLevel);
		isScrollTo = false;
		_isFirstLoad = true;
		UpdateItemScale();
	}

	private void OnPassLevel(int obj)
	{
		if (!_data[obj].IsPlaceholder)
		{
			WorldLevelBreakItemVH worldLevelBreakItemVH = GetBaseItemViewsHolderIfVisible(_selectIndex) as WorldLevelBreakItemVH;
			if (!isReset)
			{
				WorldLevelBreakItemVH worldLevelBreakItemVH2 = GetBaseItemViewsHolderIfVisible(obj) as WorldLevelBreakItemVH;
				worldLevelBreakItemVH?.RefreshSelect(isSelect: false, _curLevel, _maxLevel);
				worldLevelBreakItemVH2?.RefreshSelect(isSelect: true, _curLevel, _maxLevel);
				_selectLevel = _data[worldLevelBreakItemVH2.ItemIndex].WorldLevelItemIndex;
				_onSelectLevel(_selectLevel);
			}
			UpdateItemScale();
		}
	}

	public void Unload()
	{
		if (IsInitialized)
		{
			WorldLevelBreakParam worldLevelBreakParam = _Params;
			if (worldLevelBreakParam != null && (object)worldLevelBreakParam.Snapper != null)
			{
				_Params.Snapper.SnappingEndedOrCancelled -= OnScrollToLevel;
				_Params.Snapper.OnPassingCell -= OnPassLevel;
				_Params.Snapper.OnDrag -= OnDrag;
			}
			Clear();
		}
	}

	public void ForceRefreshScales()
	{
		UpdateItemScale();
	}
}
