using System;
using ACT.ViewControl;
using Bamboo.NumberString;
using Com.ForbiddenByte.OSA.Core;
using Com.ForbiddenByte.OSA.CustomParams;
using Com.ForbiddenByte.OSA.DataHelpers;
using Fundamental;
using Runtime.UI.CommonComponent.UIComponentEx;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class LevelUpOSA : OSA<LevelUpOSA.LevelUpParams, LevelUpOSA.LevelUpViewsHolder>
{
	[Serializable]
	public class LevelUpParams : BaseParamsWithPrefab
	{
		public bool needLimitMin = true;

		public string canNotSelectColorStr { get; set; }

		public string canSelectColorStr { get; set; }

		public string isSelectColorStr { get; set; }

		public string unEnoughColorStr { get; set; }

		public string selectIsUnEnoughColorStr { get; set; }

		public string currentLevelColorStr { get; set; }
	}

	public class LevelUpModel
	{
		public int Level { get; }

		public bool IsSelect { get; private set; }

		public LevelUpModel(int level, bool isSelect)
		{
			Level = level;
			IsSelect = isSelect;
		}

		public void SetIsSelect(bool isSelect)
		{
			IsSelect = isSelect;
		}
	}

	public class LevelUpViewsHolder : BaseItemViewsHolder
	{
		private ActButton btn;

		private TextMeshProUGUI _numText;

		private LevelNumItem item;

		private IOSAUnit _binder;

		private object _dataContext;

		private int _level;

		private int _finallyMaxLevel;

		private float NormalFontSize = 40f;

		private float SelectFontSize = 48f;

		private LevelUpParams _params;

		public override void CollectViews()
		{
			btn = root.GetComponent<ActButton>();
			item = root.GetComponent<LevelNumItem>();
			_numText = root.GetComponentInChildren<TextMeshProUGUI>();
			_binder = root.GetComponent<IOSAUnit>();
			_binder?.OnInstantiate();
		}

		public void UpdateView(LevelUpModel model, int curLevel, int selectLevel, int maxlevel, int itemEnoughLevel, int finallyMaxLevel, LevelUpParams param)
		{
			root.gameObject.SetActive(value: true);
			_numText.text = model.Level.FastToString();
			_level = model.Level;
			_finallyMaxLevel = finallyMaxLevel;
			_params = param;
			RefreshSelect(model.Level == selectLevel, itemEnoughLevel, curLevel, maxlevel);
			if (item?.imageCurrentLevel != null)
			{
				item?.imageCurrentLevel.SetActive(curLevel == model.Level && model.Level != maxlevel);
			}
			if (item?.imageCurrentLevelMax != null)
			{
				item?.imageCurrentLevelMax.SetActive(curLevel == model.Level && model.Level == maxlevel && model.Level != finallyMaxLevel);
			}
			_binder?.OnShow(model.Level, _dataContext);
		}

		public void BindDataContext(object dataContext)
		{
			_dataContext = dataContext;
		}

		public void ChangeScale(float normalizedProgress)
		{
			float a = 1f - normalizedProgress * 0.1f;
			_numText.color = new Color(_numText.color.r, _numText.color.g, _numText.color.b, a);
			_numText.fontSize = ((normalizedProgress < 0.05f) ? 34 : 24);
		}

		public ACT.ViewControl.SelectableEx GetCurrentSelectableEx()
		{
			return root.GetComponent<ACT.ViewControl.SelectableEx>();
		}

		public void SetCantSelect()
		{
			if (_binder == null)
			{
				ColorUtility.TryParseHtmlString((_params != null && !string.IsNullOrEmpty(_params.canNotSelectColorStr)) ? _params.canNotSelectColorStr : "#7c888a", out var color);
				_numText.color = color;
			}
		}

		public void SetCanSelect()
		{
			if (_binder == null)
			{
				ColorUtility.TryParseHtmlString((_params != null && !string.IsNullOrEmpty(_params.canSelectColorStr)) ? _params.canSelectColorStr : "#e4e8d7", out var color);
				_numText.color = new Color(color.r, color.g, color.b, 0.9f);
			}
		}

		public void SetIsSelect()
		{
			if (_binder == null)
			{
				ColorUtility.TryParseHtmlString((_params != null && !string.IsNullOrEmpty(_params.isSelectColorStr)) ? _params.isSelectColorStr : "#e4e8d7", out var color);
				_numText.color = new Color(color.r, color.g, color.b, 1f);
			}
		}

		public void SetIsUnEnough()
		{
			if (_binder == null)
			{
				ColorUtility.TryParseHtmlString((_params != null && !string.IsNullOrEmpty(_params.unEnoughColorStr)) ? _params.unEnoughColorStr : "#f27474", out var color);
				_numText.color = new Color(color.r, color.g, color.b, 0.9f);
			}
		}

		private void SetSelectIsUnEnough()
		{
			if (_binder == null)
			{
				ColorUtility.TryParseHtmlString((_params != null && !string.IsNullOrEmpty(_params.selectIsUnEnoughColorStr)) ? _params.selectIsUnEnoughColorStr : "#f27474", out var color);
				_numText.color = new Color(color.r, color.g, color.b, 1f);
			}
		}

		private void SetCurrentLevel()
		{
			if (_binder == null)
			{
				ColorUtility.TryParseHtmlString((_params != null && !string.IsNullOrEmpty(_params.currentLevelColorStr)) ? _params.currentLevelColorStr : "#e4e8d7", out var color);
				_numText.color = color;
			}
		}

		public void BindClickAction(Action<LevelUpViewsHolder> action)
		{
			if (!(btn == null))
			{
				btn.OnClick.RemoveAllListeners();
				btn.OnClick.AddListener(() =>
				{
					action(this);
				});
			}
		}

		public void RefreshSelect(bool isSelect, int itemEnoughLevel, int curLevel, int maxLevel)
		{
			if (isSelect)
			{
				if (itemEnoughLevel != -1)
				{
					if (itemEnoughLevel >= _level)
					{
						if (_level == maxLevel && curLevel == _level && _finallyMaxLevel != maxLevel)
						{
							SetCurrentLevel();
						}
						else
						{
							SetIsSelect();
						}
					}
					else
					{
						SetSelectIsUnEnough();
					}
				}
				else
				{
					SetIsSelect();
				}
			}
			else if (itemEnoughLevel != -1)
			{
				if (_level <= curLevel)
				{
					SetCantSelect();
				}
				else if (itemEnoughLevel >= _level)
				{
					SetCanSelect();
				}
				else if (maxLevel < _level)
				{
					SetCantSelect();
				}
				else
				{
					SetIsUnEnough();
				}
			}
			else if (_level <= curLevel || _level > maxLevel)
			{
				if (_level == curLevel)
				{
					SetCurrentLevel();
				}
				else
				{
					SetCantSelect();
				}
			}
			else
			{
				SetCanSelect();
			}
		}
	}

	private Action<int> _onSelectLevel;

	private SimpleDataHelper<LevelUpModel> _data;

	private int _minLevel;

	private int _maxLevel;

	private int _curLevel;

	private int _itemEnoughLevel;

	private int _selectLevel;

	private int _finallyMaxLevel;

	private float _offect = 92f;

	private bool isReset;

	private bool isScrollTo;

	public string PassingAudioEventName { get; set; }

	public object DataContext { get; set; }

	public object ItemSourceDataContext { get; set; }

	private int _halfContentWidth => (int)Content.rect.width / 2;

	private int _selectIndex => _selectLevel - _minLevel;

	private Vector2 midpos => new Vector2(_halfContentWidth, 0f);

	protected override void Start()
	{
		_offect = _Params.DefaultItemSize + _Params.ContentSpacing;
	}

	private void OnValidate()
	{
		_InternalState?.CacheScrollViewInfo();
	}

	protected override void Update()
	{
		base.Update();
		if (IsInitialized && (IsDragging || isScrollTo))
		{
			UpdateItemScale();
		}
	}

	private void UpdateItemScale()
	{
		for (int i = 0; i < VisibleItemsCount; i++)
		{
			LevelUpViewsHolder itemViewsHolder = GetItemViewsHolder(i);
			float num = Vector2.Distance(itemViewsHolder.root.localPosition, midpos);
			if (itemViewsHolder != null)
			{
				float num2 = num / _offect;
				if (!(num2 > 1f))
				{
					itemViewsHolder.ChangeScale(num2);
				}
			}
		}
	}

	public void SetLevelStringColor(string cantSelect, string canSelect, string isSelect, string unEnough, string selectUnEnough, string currentLevel)
	{
		_Params.canNotSelectColorStr = cantSelect;
		_Params.canSelectColorStr = canSelect;
		_Params.isSelectColorStr = isSelect;
		_Params.unEnoughColorStr = unEnough;
		_Params.selectIsUnEnoughColorStr = selectUnEnough;
		_Params.currentLevelColorStr = currentLevel;
	}

	private void ReSetLevelStringColorEmpty()
	{
		if (!string.IsNullOrEmpty(_Params.canNotSelectColorStr))
		{
			_Params.canNotSelectColorStr = null;
		}
		if (!string.IsNullOrEmpty(_Params.canSelectColorStr))
		{
			_Params.canSelectColorStr = null;
		}
		if (!string.IsNullOrEmpty(_Params.isSelectColorStr))
		{
			_Params.isSelectColorStr = null;
		}
		if (!string.IsNullOrEmpty(_Params.unEnoughColorStr))
		{
			_Params.unEnoughColorStr = null;
		}
		if (!string.IsNullOrEmpty(_Params.selectIsUnEnoughColorStr))
		{
			_Params.selectIsUnEnoughColorStr = null;
		}
		if (!string.IsNullOrEmpty(_Params.currentLevelColorStr))
		{
			_Params.currentLevelColorStr = null;
		}
	}

	public void Reload(int minLevel, int maxLevel, int curLevel, int addLevel, Action<int> onSelectLevel, int finallyMaxLevel = 0, int itemEnoughLevel = 0, int normalSelectLevel = 0)
	{
		_minLevel = minLevel;
		_maxLevel = maxLevel;
		_curLevel = curLevel;
		_selectLevel = ((curLevel == maxLevel) ? curLevel : (curLevel + addLevel));
		_onSelectLevel = onSelectLevel;
		_itemEnoughLevel = itemEnoughLevel;
		_finallyMaxLevel = ((finallyMaxLevel == 0) ? maxLevel : finallyMaxLevel);
		isScrollTo = false;
		if (finallyMaxLevel > maxLevel)
		{
			maxLevel += 2;
		}
		LevelUpModel[] array = new LevelUpModel[maxLevel - minLevel + 1];
		for (int i = minLevel; i <= maxLevel; i++)
		{
			array[i - minLevel] = new LevelUpModel(i, i == curLevel);
		}
		_data = new SimpleDataHelper<LevelUpModel>(this);
		if (_Params.needLimitMin)
		{
			_Params.ContentPadding.left = -(int)((_Params.ItemPrefabSize + _Params.ContentSpacing) * (float)_selectIndex - (float)_halfContentWidth + 0.5f);
			_Params.ContentPadding.right = (int)((float)_halfContentWidth - (_Params.ItemPrefabSize + _Params.ContentSpacing) * (float)(maxLevel - _maxLevel) + 0.5f);
		}
		if (!IsInitialized)
		{
			Init();
		}
		else if (_Params.needLimitMin)
		{
			_InternalState.CacheScrollViewInfo();
		}
		if (_Params.Snapper != null)
		{
			_Params.Snapper.SnappingEndedOrCancelled -= OnScrollToLevel;
			_Params.Snapper.SnappingEndedOrCancelled += OnScrollToLevel;
			_Params.Snapper.OnPassingCell -= OnPassLevel;
			_Params.Snapper.OnPassingCell += OnPassLevel;
			_Params.Snapper.OnDrag -= OnDrag;
			_Params.Snapper.OnDrag += OnDrag;
		}
		isReset = true;
		_data.ResetItems(array);
		if (normalSelectLevel != 0)
		{
			ScrollTo(normalSelectLevel - 1, 0.5f, 0.5f);
		}
		else
		{
			ScrollTo(_selectLevel - _minLevel, 0.5f, 0.5f);
		}
		isReset = false;
	}

	public ACT.ViewControl.SelectableEx GetMiddleSelectableEx(bool isVertical)
	{
		if (!IsInitialized || _data == null || _data.Count == 0)
		{
			return null;
		}
		int currentMiddleIndex = GetCurrentMiddleIndex(isVertical);
		for (int i = 0; i < VisibleItemsCount; i++)
		{
			LevelUpViewsHolder itemViewsHolder = GetItemViewsHolder(i);
			if (itemViewsHolder != null)
			{
				int itemIndex = itemViewsHolder.ItemIndex;
				if (itemIndex >= 0 && itemIndex < _data.Count && itemIndex == currentMiddleIndex)
				{
					return itemViewsHolder.GetCurrentSelectableEx();
				}
			}
		}
		return null;
	}

	public LevelUpModel GetItemViewsData(int itemIndex)
	{
		LevelUpModel levelUpModel = _data[itemIndex];
		if (levelUpModel != null)
		{
			return levelUpModel;
		}
		return null;
	}

	private int GetCurrentMiddleIndex(bool isVertical)
	{
		if (!IsInitialized || _data == null || _data.Count == 0)
		{
			return -1;
		}
		int result = -1;
		float num = float.MaxValue;
		for (int i = 0; i < VisibleItemsCount; i++)
		{
			LevelUpViewsHolder itemViewsHolder = GetItemViewsHolder(i);
			if (itemViewsHolder != null)
			{
				float num2 = ((!isVertical) ? Vector2.Distance(itemViewsHolder.root.localPosition, new Vector2(Content.rect.width / 2f, 0f)) : Vector2.Distance(itemViewsHolder.root.localPosition, new Vector2(0f, Content.rect.height / 2f)));
				if (num2 < num)
				{
					num = num2;
					result = itemViewsHolder.ItemIndex;
				}
			}
		}
		return result;
	}

	private void OnDrag(int targetIndex)
	{
	}

	public void OnUpgradeSuccess(int curLevel, int addLevel, int preLevel)
	{
		_data[_selectIndex].SetIsSelect(isSelect: false);
		_curLevel = curLevel;
		_selectLevel = curLevel + addLevel;
		_data[_selectIndex].SetIsSelect(isSelect: true);
		ScrollTo(_selectIndex, 0.5f, 0.5f);
		if (_Params.needLimitMin)
		{
			_Params.ContentPadding.left = -(int)((_Params.ItemPrefabSize + _Params.ContentSpacing) * (float)_selectIndex - (float)_halfContentWidth + 0.5f);
			_InternalState.CacheScrollViewInfo();
		}
		for (int i = preLevel - _minLevel; i <= curLevel - _minLevel; i++)
		{
			GetItemViewsHolderIfVisible(i)?.SetCantSelect();
		}
		GetItemViewsHolderIfVisible(_selectIndex)?.RefreshSelect(isSelect: true, _itemEnoughLevel, curLevel, _maxLevel);
	}

	public void Unload()
	{
		if (IsInitialized)
		{
			LevelUpParams levelUpParams = _Params;
			if (levelUpParams != null && (object)levelUpParams.Snapper != null)
			{
				_Params.Snapper.SnappingEndedOrCancelled -= OnScrollToLevel;
				_Params.Snapper.OnPassingCell -= OnPassLevel;
				_Params.Snapper.OnDrag -= OnDrag;
			}
			isScrollTo = false;
			isReset = false;
			ReSetLevelStringColorEmpty();
			Clear();
		}
	}

	public void OnReset(int minLevel, int maxLevel, int curLevel, int addLevel, int finallyMaxLevel, int itemEnoughLevel, int normalSelectLevel = 0)
	{
		isReset = true;
		_minLevel = minLevel;
		_maxLevel = maxLevel;
		_curLevel = curLevel;
		_selectLevel = ((normalSelectLevel > curLevel) ? Mathf.Clamp(normalSelectLevel, minLevel, maxLevel) : Mathf.Min(maxLevel, curLevel + addLevel));
		_itemEnoughLevel = itemEnoughLevel;
		if (finallyMaxLevel > maxLevel)
		{
			maxLevel += 2;
		}
		LevelUpModel[] array = new LevelUpModel[maxLevel - minLevel + 1];
		for (int i = minLevel; i <= maxLevel; i++)
		{
			array[i - minLevel] = new LevelUpModel(i, i == curLevel);
		}
		if (_Params.needLimitMin)
		{
			_Params.ContentPadding.left = -(int)((_Params.ItemPrefabSize + _Params.ContentSpacing) * (float)_selectIndex - (float)_halfContentWidth + 0.5f);
			_Params.ContentPadding.right = (int)((float)_halfContentWidth - (_Params.ItemPrefabSize + _Params.ContentSpacing) * (float)(maxLevel - _maxLevel) + 0.5f);
			_InternalState.CacheScrollViewInfo();
		}
		_data.ResetItems(array);
		ScrollTo(_selectLevel - _minLevel, 0.5f, 0.5f);
		isReset = false;
	}

	private void OnPassLevel(int obj)
	{
		LevelUpViewsHolder levelUpViewsHolder = GetBaseItemViewsHolderIfVisible(_selectIndex) as LevelUpViewsHolder;
		if (!isReset)
		{
			if (!string.IsNullOrEmpty(PassingAudioEventName))
			{
				Singleton<GameManager>.instance.audioManager.PlaySound(PassingAudioEventName);
			}
			LevelUpViewsHolder levelUpViewsHolder2 = GetBaseItemViewsHolderIfVisible(obj) as LevelUpViewsHolder;
			levelUpViewsHolder?.RefreshSelect(isSelect: false, _itemEnoughLevel, _curLevel, _maxLevel);
			levelUpViewsHolder2.RefreshSelect(isSelect: true, _itemEnoughLevel, _curLevel, _maxLevel);
			_selectLevel = _data[levelUpViewsHolder2.ItemIndex].Level;
			_onSelectLevel(_selectLevel);
		}
	}

	private void OnScrollToLevel()
	{
		if (!(_Params.Snapper.GetMiddleVH(out var _) is LevelUpViewsHolder levelUpViewsHolder))
		{
			isScrollTo = false;
			return;
		}
		int level = _data[levelUpViewsHolder.ItemIndex].Level;
		int itemIndex = levelUpViewsHolder.ItemIndex;
		if (level == _selectLevel)
		{
			isScrollTo = false;
			return;
		}
		if (level > _maxLevel)
		{
			isScrollTo = false;
			return;
		}
		_data[_selectIndex].SetIsSelect(isSelect: false);
		_data[itemIndex].SetIsSelect(isSelect: true);
		(GetBaseItemViewsHolderIfVisible(_selectIndex) as LevelUpViewsHolder)?.RefreshSelect(isSelect: false, _itemEnoughLevel, _curLevel, _maxLevel);
		levelUpViewsHolder.RefreshSelect(isSelect: true, _itemEnoughLevel, _curLevel, _maxLevel);
		_selectLevel = level;
		_onSelectLevel(_selectLevel);
		isScrollTo = false;
	}

	public void ScrollToMaxLevel()
	{
		int level = ((_itemEnoughLevel == 0) ? _maxLevel : _itemEnoughLevel);
		ScrollToLevel(level);
	}

	public void RefreshItemEnoughLevel(int itemEnoughLevel)
	{
		_itemEnoughLevel = itemEnoughLevel;
		if (!IsInitialized || _data == null)
		{
			return;
		}
		for (int i = 0; i < VisibleItemsCount; i++)
		{
			LevelUpViewsHolder itemViewsHolder = GetItemViewsHolder(i);
			if (itemViewsHolder != null)
			{
				bool isSelect = _data[itemViewsHolder.ItemIndex].Level == _selectLevel;
				itemViewsHolder.RefreshSelect(isSelect, _itemEnoughLevel, _curLevel, _maxLevel);
			}
		}
	}

	public void ScrollToLevel(int level)
	{
		if (IsInitialized && _data != null)
		{
			level = Mathf.Clamp(level, _minLevel, _maxLevel);
			isScrollTo = true;
			SmoothScrollTo(level - _minLevel, 0.5f, 0.5f, 0.5f, null, OnScrollToLevel);
		}
	}

	public void ScrollToLevelByVh(LevelUpViewsHolder vh)
	{
		ScrollToLevel(_data[vh.ItemIndex].Level);
	}

	protected override LevelUpViewsHolder CreateViewsHolder(int itemIndex)
	{
		LevelUpViewsHolder levelUpViewsHolder = new LevelUpViewsHolder();
		levelUpViewsHolder.Init(_Params.ItemPrefab, _Params.Content, itemIndex);
		levelUpViewsHolder.BindClickAction(ScrollToLevelByVh);
		return levelUpViewsHolder;
	}

	protected override void UpdateViewsHolder(LevelUpViewsHolder newOrRecycled)
	{
		LevelUpModel levelUpModel = _data[newOrRecycled.ItemIndex];
		newOrRecycled.BindDataContext(ItemSourceDataContext);
		newOrRecycled.UpdateView(levelUpModel, _curLevel, _selectLevel, _maxLevel, _itemEnoughLevel, _finallyMaxLevel, _Params);
		bool flag = levelUpModel.Level == _selectLevel;
		newOrRecycled.ChangeScale(flag ? 0f : 1f);
	}
}
