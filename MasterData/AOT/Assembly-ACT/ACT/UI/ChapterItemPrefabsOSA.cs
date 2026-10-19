using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using Com.ForbiddenByte.OSA.Core;
using Com.ForbiddenByte.OSA.DataHelpers;
using UnityEngine;

namespace ACT.UI;

public class ChapterItemPrefabsOSA : OSA<ChapterViewParams, ChapterItemVH>
{
	private Dictionary<int, Dictionary<int, SystemGuideData>> typedDataDict;

	public bool isScrollTo;

	private BookViewMultiplePrefabsOSA parentOsa;

	private Action<int> _onSelectChapter;

	[SerializeField]
	private float scrollToOffset = 0.5f;

	[SerializeField]
	private float scrollToDuration = 0.5f;

	[SerializeField]
	public ActButton nextChapter;

	[SerializeField]
	public ActButton lastChapter;

	private int m_LastSelectIndex = -1;

	private int m_CurSelectIndex = -1;

	private int _selectChapter = -1;

	public SimpleDataHelper<ChapterViewBaseModel> Data { get; private set; }

	private int _selectIndex => _selectChapter - 1;

	protected override void Start()
	{
	}

	protected override ChapterItemVH CreateViewsHolder(int itemIndex)
	{
		ChapterItemVH chapterItemVH = new ChapterItemVH();
		chapterItemVH.Init(_Params.ItemPrefab, _Params.Content, itemIndex);
		chapterItemVH.BindClickAction(ScrollToLevelByVh);
		return chapterItemVH;
	}

	protected override void UpdateViewsHolder(ChapterItemVH newOrRecycled)
	{
		ChapterViewBaseModel model = Data[newOrRecycled.ItemIndex];
		newOrRecycled.UpdateViews(model);
		ScheduleComputeVisibilityTwinPass();
	}

	public void ScrollToLevelByVh(ChapterItemVH vh)
	{
		if (!isScrollTo && Data[vh.ItemIndex].ChapterIndex != _selectChapter && !parentOsa.IsScrollTo)
		{
			isScrollTo = true;
			SmoothScrollTo(vh.ItemIndex, 0.3f, 0.5f, 0.5f, null, () =>
			{
				OnScrollToChapter(vh);
			});
		}
	}

	private void OnScrollToChapter(ChapterItemVH vh)
	{
		int chapterIndex = Data[vh.ItemIndex].ChapterIndex;
		int itemIndex = vh.ItemIndex;
		if (chapterIndex != _selectChapter)
		{
			Data[_selectIndex].SetIsSelect(isSelect: false);
			Data[itemIndex].SetIsSelect(isSelect: true);
			m_CurSelectIndex = itemIndex;
			(GetBaseItemViewsHolderIfVisible(_selectIndex) as ChapterItemVH)?.SetSelect(select: false);
			vh?.SetSelect(select: true);
			_selectChapter = chapterIndex;
			_onSelectChapter?.Invoke(_selectChapter);
			isScrollTo = false;
		}
	}

	private void OnSnapToChapter()
	{
		int itemIndex = (_Params.Snapper.GetMiddleVH(out var _) as ChapterItemVH).ItemIndex;
		m_LastSelectIndex = itemIndex;
	}

	public void InitializeChapterData()
	{
		typedDataDict = new Dictionary<int, Dictionary<int, SystemGuideData>>();
		foreach (KeyValuePair<int, SystemGuideData> systemGuideData in RuntimeConfigs.data.systemGuideDatas)
		{
			if (!typedDataDict.TryGetValue(systemGuideData.Value.chapter, out var value))
			{
				value = new Dictionary<int, SystemGuideData>();
				typedDataDict[systemGuideData.Value.chapter] = value;
			}
			else
			{
				value[systemGuideData.Value.id] = systemGuideData.Value;
			}
		}
	}

	public List<SystemGuideData> GetDataListByType(int chapter)
	{
		if (typedDataDict.TryGetValue(chapter, out var value))
		{
			return value.Values.ToList();
		}
		return new List<SystemGuideData>();
	}

	public void InitOSA(int initChapter, BookViewMultiplePrefabsOSA parentOsa, Action<int> onSelectChapter = null)
	{
		this.parentOsa = parentOsa;
		InitializeChapterData();
		if (initChapter < 1)
		{
			return;
		}
		if (_Params.Snapper != null)
		{
			_Params.Snapper.SnappingEndedOrCancelled += OnSnapToChapter;
		}
		ChapterViewBaseModel[] newModels = new ChapterViewBaseModel[typedDataDict.Keys.Count + 1];
		int num = 0;
		_Params.ScrollEnabled = newModels.Length >= 5;
		_Params.DragEnabled = newModels.Length >= 5;
		foreach (int key in typedDataDict.Keys)
		{
			ChapterViewBaseModel chapterViewBaseModel = new ChapterViewBaseModel(key, key == initChapter);
			newModels[num] = chapterViewBaseModel;
			num++;
		}
		ChapterViewBaseModel chapterViewBaseModel2 = new ChapterViewBaseModel(-1, isSelect: false, isDisabled: true);
		newModels[num] = chapterViewBaseModel2;
		Data = new SimpleDataHelper<ChapterViewBaseModel>(this);
		_selectChapter = initChapter;
		if (!IsInitialized)
		{
			Init();
		}
		Data.ResetItems(newModels);
		ScrollTo(_selectIndex, 0.5f, 0.5f);
		_onSelectChapter = onSelectChapter;
		nextChapter?.OnClick.RemoveAllListeners();
		nextChapter?.OnClick.AddListener(() =>
		{
			if (_selectIndex + 1 < newModels.Length - 1 && !isScrollTo && !parentOsa.IsScrollTo)
			{
				isScrollTo = true;
				if (GetItemViewsHolderIfVisible(_selectIndex + 1) != null)
				{
					SmoothScrollTo(_selectIndex + 1, 0.5f, 0.5f, 0.5f);
					OnScrollToChapter(GetItemViewsHolderIfVisible(_selectIndex + 1));
				}
				else
				{
					SmoothScrollTo(_selectIndex + 1, 0.3f, 0.5f, 0.5f, null, () =>
					{
						OnScrollToChapter(GetItemViewsHolderIfVisible(_selectIndex + 1));
					});
				}
			}
		});
		lastChapter?.OnClick.RemoveAllListeners();
		lastChapter?.OnClick.AddListener(() =>
		{
			if (_selectIndex - 1 >= 0 && !isScrollTo && !parentOsa.IsScrollTo)
			{
				isScrollTo = true;
				if (GetItemViewsHolderIfVisible(_selectIndex - 1) != null)
				{
					SmoothScrollTo(_selectIndex - 1, 0.5f, 0.5f, 0.5f);
					OnScrollToChapter(GetItemViewsHolderIfVisible(_selectIndex - 1));
				}
				else
				{
					SmoothScrollTo(_selectIndex - 1, 0.3f, 0.5f, 0.5f, null, () =>
					{
						OnScrollToChapter(GetItemViewsHolderIfVisible(_selectIndex - 1));
					});
				}
			}
		});
	}

	public void ScrollToChapter(int chapter)
	{
		if (_selectChapter != chapter && !isScrollTo && !parentOsa.IsScrollTo)
		{
			Data[_selectIndex].SetIsSelect(isSelect: false);
			Data[chapter - 1].SetIsSelect(isSelect: true);
			ChapterItemVH chapterItemVH = GetBaseItemViewsHolderIfVisible(_selectIndex) as ChapterItemVH;
			ChapterItemVH obj = GetBaseItemViewsHolderIfVisible(chapter - 1) as ChapterItemVH;
			chapterItemVH?.SetSelect(select: false);
			obj?.SetSelect(select: true);
			_selectChapter = chapter;
			SmoothScrollTo(_selectIndex, 0.1f, 0.5f, 0.5f);
		}
	}

	public void Unload()
	{
		if (IsInitialized)
		{
			ChapterViewParams chapterViewParams = _Params;
			if (chapterViewParams != null && (object)chapterViewParams.Snapper != null)
			{
				_Params.Snapper.SnappingEndedOrCancelled -= OnSnapToChapter;
			}
			lastChapter?.OnClick.RemoveAllListeners();
			nextChapter?.OnClick.RemoveAllListeners();
			Clear();
		}
	}
}
