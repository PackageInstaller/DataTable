using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Com.ForbiddenByte.OSA.Core;
using Com.ForbiddenByte.OSA.DataHelpers;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class BookViewMultiplePrefabsOSA : OSA<BookViewParams, BookViewBaseVH>
{
	private Dictionary<int, Dictionary<int, SystemGuideData>> typedDataDict;

	[SerializeField]
	public ChapterItemPrefabsOSA chapterItemPrefabsOSA;

	private Action<int> _onSelectChapter;

	private SystemGuideTabView _view;

	[SerializeField]
	private float scrollToOffset = 0.5f;

	[SerializeField]
	private float scrollToDuration = 0.5f;

	[SerializeField]
	public BookRightPanel bookRightPanel;

	[SerializeField]
	public GameObject emptyClose;

	[SerializeField]
	private RectTransform decorator;

	[SerializeField]
	private RectTransform bookRightPanelRoot;

	[SerializeField]
	private LoopHorizontalScrollRect bgScrollRect;

	private int panelRootoffest;

	private int decoratorDefaultValue;

	private int m_LastSelectIndex = -1;

	private ImageAssetStation m_Station;

	private int m_CurrLockKey = -1;

	public SimpleDataHelper<BookViewBaseModel> Data { get; private set; }

	public bool IsScrollTo { get; set; }

	public bool canPlayAnimation { get; set; }

	protected override void Start()
	{
	}

	public void Unload()
	{
		_onSelectChapter = null;
		chapterItemPrefabsOSA?.Unload();
		BookViewParams bookViewParams = _Params;
		if (bookViewParams != null && (object)bookViewParams.Snapper != null)
		{
			_Params.Snapper.OnPassingCell -= OnPassCell;
		}
	}

	protected override BookViewBaseVH CreateViewsHolder(int itemIndex)
	{
		Type cachedType = Data[itemIndex].CachedType;
		if (cachedType == typeof(BookItemChapterModel))
		{
			BookItemChapterVH bookItemChapterVH = new BookItemChapterVH();
			bookItemChapterVH.Init(_Params.bookItemChapterPrefabs[Data[itemIndex].PrefabIndex], _Params.Content, itemIndex);
			return bookItemChapterVH;
		}
		if (cachedType == typeof(BookItemMissionModel))
		{
			BookItemMissionVH bookItemMissionVH = new BookItemMissionVH();
			bookItemMissionVH.Init(_Params.bookItemMissionPrefabs[Data[itemIndex].PrefabIndex], _Params.Content, itemIndex);
			bookItemMissionVH.BindClickAction(OnMissionClicked);
			return bookItemMissionVH;
		}
		if (cachedType == typeof(BookItemSystemModel))
		{
			BookItemSystemVH bookItemSystemVH = new BookItemSystemVH();
			bookItemSystemVH.Init(_Params.bookItemSystemPrefabs[Data[itemIndex].PrefabIndex], _Params.Content, itemIndex);
			bookItemSystemVH.BindClickAction(OnSystemClicked);
			return bookItemSystemVH;
		}
		if (cachedType == typeof(BookItemLevelModel))
		{
			BookItemLevelVH bookItemLevelVH = new BookItemLevelVH();
			bookItemLevelVH.Init(_Params.bookItemLevelPrefabs[Data[itemIndex].PrefabIndex], _Params.Content, itemIndex);
			bookItemLevelVH.BindClickAction(OnLevelClicked);
			return bookItemLevelVH;
		}
		if (cachedType == typeof(BookEndModel))
		{
			BookEndVH bookEndVH = new BookEndVH();
			bookEndVH.Init(_Params.bookEndPrefabs[Data[itemIndex].PrefabIndex], _Params.Content, itemIndex);
			return bookEndVH;
		}
		if (cachedType == typeof(BookEmptyModel))
		{
			BookEmptyVH bookEmptyVH = new BookEmptyVH();
			bookEmptyVH.Init(_Params.bookEmptyPrefabs[Data[itemIndex].PrefabIndex], _Params.Content, itemIndex);
			return bookEmptyVH;
		}
		throw new InvalidOperationException("Unrecognized model type: " + cachedType.Name);
	}

	protected override void UpdateViewsHolder(BookViewBaseVH newOrRecycled)
	{
		BookViewBaseModel model = Data[newOrRecycled.ItemIndex];
		newOrRecycled.UpdateViews(model, m_Station, canPlayAnimation);
		newOrRecycled.SetSelect(m_LastSelectIndex == newOrRecycled.ItemIndex);
		ScheduleComputeVisibilityTwinPass();
	}

	protected override float UpdateItemSizeOnTwinPass(BookViewBaseVH viewsHolder)
	{
		viewsHolder.UpdateSize();
		return viewsHolder.root.rect.width;
	}

	protected override void OnScrollPositionChanged(double normalizedPosition)
	{
		base.OnScrollPositionChanged(normalizedPosition);
		if (bgScrollRect != null)
		{
			bgScrollRect.horizontalNormalizedPosition = (float)normalizedPosition * 0.15f;
		}
	}

	public override void OnEndDrag(PointerEventData eventData)
	{
		base.OnEndDrag(eventData);
		TryRestoreSelection();
	}

	public override void OnScroll(PointerEventData eventData)
	{
		base.OnEndDrag(eventData);
		TryRestoreSelection();
	}

	private void TryRestoreSelection()
	{
		if (EventSystemHelper.Available && !(EventSystemHelper.CurrentSelected != null))
		{
			ACT.ViewControl.SelectableEx selectableEx = GetSelectableEx();
			if (!(selectableEx == null))
			{
				_view.JourneyTracesView.ViewControlLayers[JourneyTraceSubController.SystemGuide].SetDefaultSelect(selectableEx);
			}
		}
	}

	protected override bool IsRecyclable(BookViewBaseVH potentiallyRecyclable, int indexOfItemThatWillBecomeVisible, double sizeOfItemThatWillBecomeVisible)
	{
		BookViewBaseModel bookViewBaseModel = Data[indexOfItemThatWillBecomeVisible];
		int prefabIndex = Data[indexOfItemThatWillBecomeVisible].PrefabIndex;
		int prefabIndex2 = Data[potentiallyRecyclable.ItemIndex].PrefabIndex;
		if (prefabIndex == prefabIndex2)
		{
			return potentiallyRecyclable.CanPresentModelType(bookViewBaseModel.CachedType);
		}
		return false;
	}

	protected override void Awake()
	{
		base.Awake();
		decoratorDefaultValue = (int)decorator.rect.width;
		panelRootoffest = _Params.ContentPadding.right;
	}

	private void OnMissionClicked(BookViewBaseVH vh)
	{
		if (vh is BookItemMissionVH bookItemMissionVH && !bookItemMissionVH.bookItemMission.getUnlockStatus())
		{
			GameUtility.OpenToolTip(1025);
		}
		else
		{
			OpenRightPanel(vh);
		}
	}

	private void OnLevelClicked(BookItemLevelVH vh)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SYSTEMGUIDEREWARD);
	}

	private void OnSystemClicked(BookViewBaseVH vh)
	{
		OpenRightPanel(vh);
	}

	public bool RightPanelIsActive()
	{
		return bookRightPanel.gameObject.activeSelf;
	}

	private async void OpenRightPanel(BookViewBaseVH vh)
	{
		GetItemViewsHolderIfVisible(m_LastSelectIndex)?.SetSelect(isSelect: false);
		if (vh.itemIndexInView == m_LastSelectIndex)
		{
			OnCloseRightPanel();
			return;
		}
		vh.SetSelect(isSelect: true);
		emptyClose.SetActive(value: true);
		EventSystemHelper.SetSelectedGameObject(vh.GetCurrentSelectableEx().gameObject);
		m_LastSelectIndex = vh.itemIndexInView;
		bookRightPanel.Init(Data[vh.ItemIndex], m_Station);
		bookRightPanel.scrollSupport.SetForbidScroll(!GetRightScrollPromptActive());
		SmoothScrollTo(vh.ItemIndex, scrollToDuration, scrollToOffset);
		_view.JourneyTracesView.ChangeToGamePadInputState(JourneyTraceSubController.SystemGuideSideBar);
	}

	public bool GetRightScrollPromptActive()
	{
		Canvas.ForceUpdateCanvases();
		return bookRightPanel.scrollRect.content.rect.height > bookRightPanel.scrollRect.viewport.rect.height;
	}

	public async void OnCloseRightPanel()
	{
		GetItemViewsHolderIfVisible(m_LastSelectIndex)?.SetSelect(isSelect: false);
		bookRightPanel.Close();
		emptyClose.SetActive(value: false);
		m_LastSelectIndex = -1;
		_view.JourneyTracesView.ChangeToGamePadInputState(JourneyTraceSubController.SystemGuide, needReFocusLayer: true);
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

	public Dictionary<int, SystemGuideData> GetDataByType(int chapter)
	{
		if (typedDataDict.TryGetValue(chapter, out var value))
		{
			return value;
		}
		return new Dictionary<int, SystemGuideData>();
	}

	public SystemGuideData GetData(int chapter, int id)
	{
		if (typedDataDict.TryGetValue(chapter, out var value) && value.TryGetValue(id, out var value2))
		{
			return value2;
		}
		return null;
	}

	public List<SystemGuideData> GetDataListByType(int chapter)
	{
		if (typedDataDict.TryGetValue(chapter, out var value))
		{
			return value.Values.ToList();
		}
		return new List<SystemGuideData>();
	}

	public void InitOSA(SystemGuideTabView view)
	{
		InitializeChapterData();
		_view = view;
		m_Station = view.Station;
		bookRightPanel.SetHide();
		emptyClose.SetActive(value: false);
		Dictionary<int, SystemGuideData> systemGuideDatas = RuntimeConfigs.data.systemGuideDatas;
		BookViewBaseModel[] array = new BookViewBaseModel[systemGuideDatas.Count + 3];
		bgScrollRect.ClearCells();
		bgScrollRect.totalCount = systemGuideDatas.Count;
		bgScrollRect.RefillCells();
		m_CurrLockKey = -1;
		int num = 0;
		int num2 = 0;
		bool flag = false;
		array[num] = new BookEmptyModel(num, 0, unlock: true);
		num++;
		foreach (KeyValuePair<int, SystemGuideData> item in systemGuideDatas)
		{
			array[num] = CreateRandomModel(item.Key);
			if (!array[num].Unlock && num2 == 0)
			{
				num2 = num;
				flag = true;
			}
			num++;
		}
		array[num] = CreateRandomModel(num + 1, isEnd: true);
		if (!flag)
		{
			num2 = num - 1;
		}
		num++;
		array[num] = new BookEmptyModel(num + 1, 1, unlock: true);
		Data = new SimpleDataHelper<BookViewBaseModel>(this);
		m_LastSelectIndex = -1;
		if (!IsInitialized)
		{
			Init();
		}
		Data.ResetItems(array);
		ScrollTo(num2, 0.5f, 0.5f);
		_view.JourneyTracesView.ViewControlLayers[JourneyTraceSubController.SystemGuide].SetDefaultSelect(GetSelectableEx());
		SystemGuideData systemGuideData = RuntimeConfigs.data.systemGuideDatas[array[num2].Id];
		chapterItemPrefabsOSA.InitOSA(systemGuideData.chapter, this, ScrollToChapter);
		_onSelectChapter = (Action<int>)Delegate.Combine(_onSelectChapter, new Action<int>(chapterItemPrefabsOSA.ScrollToChapter));
		if (_Params.Snapper != null)
		{
			_Params.Snapper.OnPassingCell -= OnPassCell;
			_Params.Snapper.OnPassingCell += OnPassCell;
		}
	}

	public ACT.ViewControl.SelectableEx GetSelectableEx()
	{
		if (!IsInitialized || Data == null || Data.Count == 0)
		{
			return null;
		}
		for (int i = 0; i < VisibleItemsCount; i++)
		{
			BookViewBaseVH itemViewsHolder = GetItemViewsHolder(i);
			if (itemViewsHolder != null && itemViewsHolder.GetCurrentSelectableEx() != null)
			{
				return itemViewsHolder.GetCurrentSelectableEx();
			}
		}
		return null;
	}

	public ACT.ViewControl.SelectableEx GetChapterSelectableEx(int chapter)
	{
		if (!IsInitialized || Data == null || Data.Count == 0)
		{
			return null;
		}
		for (int i = 0; i < VisibleItemsCount; i++)
		{
			if (GetItemViewsHolder(i) is BookItemChapterVH bookItemChapterVH && bookItemChapterVH.GetCurrentSelectableEx() != null && bookItemChapterVH.bookItemChapter.CurrentChapter == chapter)
			{
				return bookItemChapterVH.GetCurrentSelectableEx();
			}
		}
		return GetSelectableEx();
	}

	public GameObject GetSelectableGo()
	{
		if (!IsInitialized || Data == null || Data.Count == 0)
		{
			return null;
		}
		for (int i = 0; i < VisibleItemsCount; i++)
		{
			BookViewBaseVH itemViewsHolder = GetItemViewsHolder(i);
			if (itemViewsHolder != null && itemViewsHolder.GetCurrentSelectableEx() != null)
			{
				return itemViewsHolder.root.gameObject;
			}
		}
		return null;
	}

	public GameObject GetChapterSelectableGo(int chapter)
	{
		if (!IsInitialized || Data == null || Data.Count == 0)
		{
			return null;
		}
		for (int i = 0; i < VisibleItemsCount; i++)
		{
			if (GetItemViewsHolder(i) is BookItemChapterVH bookItemChapterVH && bookItemChapterVH.GetCurrentSelectableEx() != null && bookItemChapterVH.bookItemChapter.CurrentChapter == chapter)
			{
				return bookItemChapterVH.root.gameObject;
			}
		}
		return null;
	}

	private void OnPassCell(int obj)
	{
		if (GetBaseItemViewsHolderIfVisible(obj) is BookViewBaseVH bookViewBaseVH && !(bookViewBaseVH is BookEmptyVH) && !(bookViewBaseVH is BookEndVH))
		{
			int chapter = RuntimeConfigs.data.systemGuideDatas[Data[bookViewBaseVH.ItemIndex].Id].chapter;
			_onSelectChapter?.Invoke(chapter);
		}
	}

	public void ScrollToChapter(int chapterIndex)
	{
		for (int i = 0; i < Data.Count; i++)
		{
			if (RuntimeConfigs.data.systemGuideDatas.ContainsKey(Data[i].Id) && RuntimeConfigs.data.systemGuideDatas[Data[i].Id].chapter == chapterIndex)
			{
				IsScrollTo = true;
				SmoothScrollTo(i, 0.5f, 0.5f, 0f, null, () =>
				{
					IsScrollTo = false;
					chapterItemPrefabsOSA.isScrollTo = false;
					_view.JourneyTracesView.ViewControlLayers[JourneyTraceSubController.SystemGuide].SetDefaultSelect(GetChapterSelectableEx(chapterIndex));
					EventSystemHelper.SetSelectedGameObject(GetChapterSelectableGo(chapterIndex));
				});
				break;
			}
		}
	}

	private BookViewBaseModel CreateRandomModel(int key, bool isEnd = false)
	{
		if (isEnd)
		{
			return new BookEndModel(key, 0, unlock: true);
		}
		SystemGuideData systemGuideData = RuntimeConfigs.data.systemGuideDatas[key];
		bool flag = true;
		if (systemGuideData.type == 0)
		{
			int chapter = systemGuideData.chapter;
			flag = false;
			bool flag2 = false;
			List<SystemGuideData> dataListByType = GetDataListByType(chapter);
			if (m_CurrLockKey == -1)
			{
				flag = true;
			}
			for (int i = 0; i < dataListByType.Count; i++)
			{
				if (checkTypeUnlock(dataListByType[i]))
				{
					flag2 = true;
					break;
				}
			}
			bool isLocked = flag || ((m_CurrLockKey != -1 && key < m_CurrLockKey) & flag2);
			return new BookItemChapterModel(key, 0, isLocked);
		}
		if (systemGuideData.type == 1)
		{
			bool inProgress = false;
			if (m_CurrLockKey == -1)
			{
				if (systemGuideData.condition.Length != 0)
				{
					MissionGroup data = CoreUtils.GetData(systemGuideData.condition[0], RuntimeConfigs.data.missionGroups);
					if (data != null && !Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(data.id))
					{
						flag = false;
						m_CurrLockKey = key;
					}
				}
			}
			else
			{
				flag = false;
			}
			return new BookItemMissionModel(key, 0, flag, inProgress);
		}
		if (systemGuideData.type == 2)
		{
			if (m_CurrLockKey == -1)
			{
				if (systemGuideData.condition.Length != 0)
				{
					MissionGroup data2 = CoreUtils.GetData(systemGuideData.condition[0], RuntimeConfigs.data.missionGroups);
					if (data2 != null && !Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(data2.id))
					{
						flag = false;
						m_CurrLockKey = key;
					}
				}
			}
			else
			{
				flag = false;
			}
			return new BookItemSystemModel(key, 0, flag);
		}
		if (m_CurrLockKey == -1)
		{
			if (systemGuideData.condition.Length != 0)
			{
				int chapter2 = systemGuideData.chapter;
				List<SystemGuideData> dataListByType2 = GetDataListByType(chapter2);
				for (int j = 0; j < dataListByType2.Count; j++)
				{
					if (!checkTypeUnlock(dataListByType2[j]))
					{
						flag = false;
						break;
					}
				}
				if (!flag)
				{
					m_CurrLockKey = key;
				}
			}
		}
		else
		{
			flag = false;
		}
		return new BookItemLevelModel(key, 0, flag);
	}

	private bool checkTypeUnlock(SystemGuideData data)
	{
		if (data.type == 1)
		{
			if (data.condition.Length != 0)
			{
				MissionGroup data2 = CoreUtils.GetData(data.condition[0], RuntimeConfigs.data.missionGroups);
				if (data2 != null && !Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(data2.id))
				{
					return false;
				}
			}
		}
		else if (data.type == 2 && data.condition.Length != 0)
		{
			MissionGroup data3 = CoreUtils.GetData(data.condition[0], RuntimeConfigs.data.missionGroups);
			if (data3 != null && !Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(data3.id))
			{
				return false;
			}
		}
		return true;
	}
}
