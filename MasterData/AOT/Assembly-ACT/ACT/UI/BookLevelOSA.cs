using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Com.ForbiddenByte.OSA.Core;
using Com.ForbiddenByte.OSA.DataHelpers;
using Fundamental;
using Google.Protobuf.Collections;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class BookLevelOSA : OSA<BookLevelParams, BookLevelHolder>
{
	private SimpleDataHelper<BookLevelModel> _data;

	private Dictionary<int, Dictionary<int, SystemGuideData>> typedDataDict;

	public ActButton oneClickRewardButton;

	public GameObject btnPrompt_OneClick;

	public TextMeshProUGUI oneClickRewardText;

	private SystemGuideRewardView _systemGuideRewardView;

	private List<Item> items = new List<Item>();

	private List<BookLevelModel> tempModels = new List<BookLevelModel>();

	public int Reload(SystemGuideRewardView view)
	{
		_systemGuideRewardView = view;
		InitializeChapterData();
		Dictionary<int, ChapterIndex> chapterIndexs = RuntimeConfigs.data.chapterIndexs;
		List<BookLevelModel> list = new List<BookLevelModel>();
		foreach (ChapterIndex data in chapterIndexs.Values)
		{
			bool unlock = true;
			List<SystemGuideData> dataListByType = GetDataListByType(data.id);
			for (int i = 0; i < dataListByType.Count; i++)
			{
				if (!checkTypeUnlock(dataListByType[i]) || list.Find((BookLevelModel item) => item?.Id == data.id - 1 && item != null && !item.Unlock) != null)
				{
					unlock = false;
					break;
				}
			}
			foreach (SystemGuideData item in dataListByType)
			{
				if (item.type == 3)
				{
					list.Add(new BookLevelModel(data.id, unlock, item.condition[0]));
					break;
				}
			}
		}
		list.Sort((BookLevelModel a, BookLevelModel b) => a.Id.CompareTo(b.Id));
		int num = list.FindIndex((BookLevelModel m) => (m.Unlock && !G.localPlayer.TakeRewardLevels.Contains(m.Id)) || m.Id == 1);
		if (!IsInitialized)
		{
			Init();
		}
		_data = new SimpleDataHelper<BookLevelModel>(this);
		_data.ResetItems(list);
		RefreshButtonStatus();
		oneClickRewardButton.OnClick.AddListener(OnRewardClick);
		if (_Params.Scrollbar != null)
		{
			_Params.Scrollbar.value = 0f;
			_Params.Scrollbar.onValueChanged.RemoveAllListeners();
			_Params.Scrollbar.onValueChanged.AddListener(OnScrollbarValueChanged);
		}
		ForceUpdateVisibleItems();
		ScrollTo(num);
		_systemGuideRewardView.ViewControlLayers[JourneyTraceSubController.main].DefaultSelect = GetItemViewsHolder(num).levelRewardItem.GetComponent<ACT.ViewControl.SelectableEx>();
		return num;
	}

	public new void OnDestroy()
	{
		oneClickRewardButton.OnClick.RemoveAllListeners();
		if (_Params.Scrollbar != null)
		{
			_Params.Scrollbar.onValueChanged.RemoveAllListeners();
		}
	}

	private void OnScrollbarValueChanged(float value)
	{
		SetNormalizedPosition(1f - value);
	}

	protected override void OnScrollPositionChanged(double normalizedPosition)
	{
		base.OnScrollPositionChanged(normalizedPosition);
		if (_Params.Scrollbar != null)
		{
			_Params.Scrollbar.value = 1f - (float)normalizedPosition;
		}
	}

	protected override BookLevelHolder CreateViewsHolder(int itemIndex)
	{
		BookLevelHolder bookLevelHolder = new BookLevelHolder();
		bookLevelHolder.Init(_Params.ItemPrefab, _Params.Content, itemIndex);
		bookLevelHolder.BindClickAction(OnSelectChapter);
		bookLevelHolder.BindSelectionAction(OnSelectIndex);
		return bookLevelHolder;
	}

	protected override void UpdateViewsHolder(BookLevelHolder newOrRecycled)
	{
		BookLevelModel model = _data[newOrRecycled.ItemIndex];
		newOrRecycled.UpdateView(model);
		ScheduleComputeVisibilityTwinPass();
	}

	private void OnSelectChapter(BookLevelHolder vh)
	{
		G.service.SystemGuideChapterReward(_data[vh.ItemIndex].Id, (RepeatedField<UniversalItem> datas) =>
		{
			if (G.localPlayer.SystemGuideChapter.TryGetValue(_data[vh.ItemIndex].Id, out var value))
			{
				value = true;
			}
			else
			{
				G.localPlayer.SystemGuideChapter.Add(_data[vh.ItemIndex].Id, value: true);
			}
			items.Clear();
			foreach (UniversalItem data in datas)
			{
				Item item = new Item
				{
					Id = data.Index,
					Count = data.Count
				};
				items.Add(item);
			}
			GameUtility.OpenPopReward(GameUtility.ToUniversalItems(items));
			vh.UpdateView(_data[vh.ItemIndex]);
			RefreshButtonStatus();
			Model<PlayerModel>.Interface.RefreshChapterRewardRedDot();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_JourneyTracesTabRefresh, null);
		});
	}

	public void OnSelectIndex(BookLevelHolder vh)
	{
		GameObject gameObject = vh.levelRewardItem.gameObject;
		for (int i = 0; i < VisibleItemsCount; i++)
		{
			BookLevelHolder itemViewsHolder = GetItemViewsHolder(i);
			if (itemViewsHolder != null)
			{
				bool flag = gameObject != null && gameObject == itemViewsHolder.levelRewardItem.gameObject;
				itemViewsHolder.levelRewardItem.btnPromptCanvasGroup.alpha = (flag ? 1 : 0);
				itemViewsHolder.levelRewardItem.btnPrompt_confirm.SetActive(_systemGuideRewardView.GetCurSubControllerType() == JourneyTraceSubController.main && itemViewsHolder.levelRewardItem.unLockRoot.activeSelf);
				itemViewsHolder.levelRewardItem.btnPrompt_item.SetActive(_systemGuideRewardView.GetCurSubControllerType() == JourneyTraceSubController.main);
				if (flag)
				{
					_systemGuideRewardView.ViewControlLayers[JourneyTraceSubController.SelectItem] = itemViewsHolder.levelRewardItem.content.GetComponent<ViewControlLayer>();
					_systemGuideRewardView.ViewControlLayers[JourneyTraceSubController.SelectItem].SetTargetTransform(itemViewsHolder.levelRewardItem.content);
				}
			}
		}
	}

	private void RefreshButtonStatus()
	{
		oneClickRewardButton.interactable = IsHaveReward();
		btnPrompt_OneClick.SetActive(IsHaveReward());
		oneClickRewardText.color = (IsHaveReward() ? ColorParseUtility.HexToColor("#3A3A3A") : ColorParseUtility.HexToColor("#939393"));
	}

	private List<SystemGuideData> GetDataListByType(int chapter)
	{
		if (typedDataDict.TryGetValue(chapter, out var value))
		{
			return value.Values.ToList();
		}
		return new List<SystemGuideData>();
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
		else if (data.type == 2)
		{
			if (data.condition.Length != 0)
			{
				MissionGroup data3 = CoreUtils.GetData(data.condition[0], RuntimeConfigs.data.missionGroups);
				if (data3 != null && !Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(data3.id))
				{
					return false;
				}
			}
			return true;
		}
		return true;
	}

	private bool IsHaveReward()
	{
		bool flag = true;
		SimpleDataHelper<BookLevelModel> data = _data;
		tempModels.Clear();
		foreach (BookLevelModel data2 in (IEnumerable<BookLevelModel>)data)
		{
			bool flag2 = true;
			List<SystemGuideData> dataListByType = GetDataListByType(data2.Id);
			for (int i = 0; i < dataListByType.Count; i++)
			{
				if (!checkTypeUnlock(dataListByType[i]) || tempModels.Find((BookLevelModel item) => item?.Id == data2.Id - 1 && item != null && !item.Unlock) != null)
				{
					flag2 = false;
					break;
				}
			}
			foreach (SystemGuideData item in dataListByType)
			{
				if (item.type == 3)
				{
					tempModels.Add(new BookLevelModel(data2.Id, flag2, item.condition[0]));
					break;
				}
			}
			bool flag3 = true;
			if (G.localPlayer.SystemGuideChapter.TryGetValue(data2.Id, out var value))
			{
				flag3 = !value;
			}
			flag = flag2 & flag3;
			if (flag)
			{
				return true;
			}
		}
		return flag;
	}

	private void OnRewardClick()
	{
		G.service.SystemGuideChapterReward(-1, (RepeatedField<UniversalItem> datas) =>
		{
			items.Clear();
			foreach (UniversalItem data in datas)
			{
				Item item = new Item
				{
					Id = data.Index,
					Count = data.Count
				};
				items.Add(item);
			}
			GameUtility.OpenPopReward(GameUtility.ToUniversalItems(items));
			ForceUpdateVisibleItems();
			RefreshButtonStatus();
			Model<PlayerModel>.Interface.RefreshChapterRewardRedDot();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_JourneyTracesTabRefresh, null);
		});
	}
}
