#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine.Pool;

namespace Ase;

public class BattleEmoteSetViewModel : OptionBase
{
	private Dictionary<int, SetEmoteItemModel> setEmoteDic;

	private List<SetEmoteItemModel> battleStartList;

	private List<ToHaveEmoteItemModel> toHaveEmoteList;

	private List<ToHaveEmoteItemModel> showToHaveEmoteList;

	private List<BattleEmoteTabViewModel> tabList;

	private int curEmoteIndex;

	private BattleEmoteTabViewModel curSelectTab;

	private ToHaveEmoteItemModel curSelectEmote;

	private InteractionRequest updateToHaveListRequest;

	private bool isShowTimeLimitTxt;

	private string timeLimitTxt;

	private ToHaveEmoteItemModel dragVM;

	private InteractionRequest dragEndRequest;

	private List<RoleDecorateData> haveEmotePBData;

	public ToHaveEmoteItemModel DragtVM => dragVM;

	public InteractionRequest DragEndRequest => dragEndRequest;

	public InteractionRequest UpdateToHaveListRequest => updateToHaveListRequest;

	public ToHaveEmoteItemModel CurSelectEmote => curSelectEmote;

	public Dictionary<int, SetEmoteItemModel> SetEmoteDic => setEmoteDic;

	public List<SetEmoteItemModel> BattleStartList => battleStartList;

	public List<ToHaveEmoteItemModel> ToHaveEmoteList => toHaveEmoteList;

	public List<ToHaveEmoteItemModel> ShowToHaveEmoteList => showToHaveEmoteList;

	public List<BattleEmoteTabViewModel> TabList => tabList;

	public bool IsShowTimeLimitTxt
	{
		get
		{
			return isShowTimeLimitTxt;
		}
		set
		{
			Set(ref isShowTimeLimitTxt, value, "IsShowTimeLimitTxt");
		}
	}

	public string TimeLimitText
	{
		get
		{
			return timeLimitTxt;
		}
		set
		{
			Set(ref timeLimitTxt, value, "TimeLimitText");
		}
	}

	public BattleEmoteSetViewModel()
	{
	}

	public BattleEmoteSetViewModel(OptionBase parent)
	{
		base.parent = parent;
		setEmoteDic = new Dictionary<int, SetEmoteItemModel>();
		battleStartList = new List<SetEmoteItemModel>();
		toHaveEmoteList = new List<ToHaveEmoteItemModel>();
		showToHaveEmoteList = new List<ToHaveEmoteItemModel>();
		tabList = new List<BattleEmoteTabViewModel>();
		updateToHaveListRequest = new InteractionRequest();
		dragEndRequest = new InteractionRequest();
		InitToHaveEmote();
		InitBattleEmote();
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>().AddNormalSecondUpdateAction(InitTimeLimit);
		dragVM = new ToHaveEmoteItemModel(this);
	}

	private void InitToHaveEmote()
	{
		haveEmotePBData = new List<RoleDecorateData>();
		Dictionary<RoleDecorateEnum, List<RoleDecorateData>> itemList = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().ItemList;
		haveEmotePBData = itemList[RoleDecorateEnum.BattleEmote];
		haveEmotePBData.Add(new RoleDecorateData
		{
			id = 97002,
			DecorateType = RoleDecorateEnum.BattleEmote,
			expireTime = 0L,
			isNew = false
		});
		for (int i = 0; i < haveEmotePBData.Count; i++)
		{
			DRBattleEmoteGroup dataRow = GameEntry.DataTable.GetDataRow<DRBattleEmoteGroup>(haveEmotePBData[i].id);
			tabList.Add(new BattleEmoteTabViewModel(this, dataRow, haveEmotePBData[i].expireTime));
		}
		int j;
		for (j = 0; j < tabList.Count; j++)
		{
			DRBattleEmote[] dataRows = GameEntry.DataTable.GetDataRows((DRBattleEmote p) => p.GroupId == tabList[j].Id);
			if (dataRows.Length != 0)
			{
				for (int num = 0; num < dataRows.Length; num++)
				{
					DRBattleEmote dataRow2 = GameEntry.DataTable.GetDataRow<DRBattleEmote>(dataRows[num].Id);
					toHaveEmoteList.Add(new ToHaveEmoteItemModel(this, dataRow2.ResPath, dataRow2.Id, dataRow2.GroupId, dataRow2.Sort, tabList[j].TimeLimitGroupId));
				}
			}
		}
		foreach (ToHaveEmoteItemModel toHaveEmote in toHaveEmoteList)
		{
			if (toHaveEmote.TimeLimitGroupId == tabList[0].Id)
			{
				showToHaveEmoteList.Add(toHaveEmote);
			}
		}
		ShowTabListSort();
		if (tabList.Count > 0)
		{
			ByCurTabIndexInitShowEmoteList(tabList[0]);
		}
	}

	private async void InitBattleEmote()
	{
		List<int> roundEmojis = new List<int>();
		List<int> fightEventEmojis = new List<int>();
		(roundEmojis, fightEventEmojis) = Singleton<ServiceSystem>.Instance.GetService<IBFBEService>().GetBattleSetEmojiSetting();
		setEmoteDic.Clear();
		for (int i = 0; i < 8; i++)
		{
			SetEmoteItemModel value = new SetEmoteItemModel(this, i + 1);
			setEmoteDic[i + 1] = value;
		}
		if (roundEmojis.Count > 0)
		{
			int j;
			for (j = 0; j < roundEmojis.Count; j++)
			{
				ToHaveEmoteItemModel toHaveEmoteItemModel = ToHaveEmoteList.Find((ToHaveEmoteItemModel emote) => emote.Id == roundEmojis[j]);
				if (toHaveEmoteItemModel != null)
				{
					setEmoteDic[j + 1].InitValue(toHaveEmoteItemModel);
				}
			}
		}
		battleStartList.Clear();
		string[] array = new string[3] { "开始战斗", "击倒Boss", "击杀Boss" };
		for (int num = 0; num < 3; num++)
		{
			SetEmoteItemModel item = new SetEmoteItemModel(this, num + 1, array[num]);
			battleStartList.Add(item);
		}
		if (fightEventEmojis.Count <= 0)
		{
			return;
		}
		int i2;
		for (i2 = 0; i2 < fightEventEmojis.Count; i2++)
		{
			ToHaveEmoteItemModel toHaveEmoteItemModel2 = ToHaveEmoteList.Find((ToHaveEmoteItemModel emote) => emote.Id == fightEventEmojis[i2]);
			if (toHaveEmoteItemModel2 != null)
			{
				battleStartList[i2].InitValue(toHaveEmoteItemModel2);
			}
		}
	}

	private void InitTimeLimit(long curServerTime)
	{
		if (curSelectTab == null)
		{
			return;
		}
		IsShowTimeLimitTxt = curSelectTab.TimeLimited != 1;
		if (!IsShowTimeLimitTxt)
		{
			return;
		}
		long num = curSelectTab.ExpireTime - curServerTime;
		try
		{
			if ((curSelectTab.TimeLimited == 2 || curSelectTab.TimeLimited == 3) && num >= 0)
			{
				TimeLimitText = "有效时间：" + Utility.DateTime.GetLeftDateHourExact(num, "dd\\天hh\\时");
			}
		}
		catch (Exception ex)
		{
			Log.Error("获取有效时间异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	private void ByCurTabIndexInitShowEmoteList(BattleEmoteTabViewModel battleEmoteTabViewModel)
	{
		bool flag = false;
		if (curSelectTab != null)
		{
			flag = true;
			curSelectTab.IsSelected = false;
		}
		curSelectTab = battleEmoteTabViewModel;
		curSelectTab.IsSelected = true;
		showToHaveEmoteList.Clear();
		foreach (ToHaveEmoteItemModel toHaveEmote in toHaveEmoteList)
		{
			if (toHaveEmote.TimeLimitGroupId == battleEmoteTabViewModel.Id)
			{
				showToHaveEmoteList.Add(toHaveEmote);
			}
		}
		ShowTabListSort();
		UpdateToHaveListRequest.Raise();
		SetSelectedEmote(curSelectEmote);
		if (flag)
		{
			RoleDecorateData roleDecorateData = (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetItemList(RoleDecorateEnum.BattleEmote) ?? new List<RoleDecorateData>()).Find((RoleDecorateData p) => p.id == curSelectTab.Id);
			if (roleDecorateData != null && roleDecorateData.isNew)
			{
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.SetDecorateItemRead(roleDecorateData.DecorateType, roleDecorateData.id);
			}
		}
	}

	private void ShowTabListSort()
	{
		tabList.Sort((BattleEmoteTabViewModel x, BattleEmoteTabViewModel y) => x.SortValue.CompareTo(y.SortValue));
	}

	public void SetSelectedEmote(ToHaveEmoteItemModel toHaveEmoteItemModel)
	{
		if (curSelectEmote != null)
		{
			curSelectEmote.IsSelected = false;
		}
		if (curSelectEmote != null && curSelectEmote.Id == toHaveEmoteItemModel.Id)
		{
			curSelectEmote.IsSelected = false;
			curSelectEmote = null;
			HideEmote();
			return;
		}
		curSelectEmote = toHaveEmoteItemModel;
		if (curSelectEmote != null)
		{
			curSelectEmote.IsSelected = true;
			ShowEmoteState();
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (curSelectEmote != null && curSelectEmote.EmoteDrag == EmoteDragState.Dragging)
		{
			InterruptDrag();
		}
		else if (obj is BattleEmoteTabViewModel battleEmoteTabViewModel)
		{
			ByCurTabIndexInitShowEmoteList(battleEmoteTabViewModel);
		}
		else if (obj is ToHaveEmoteItemModel selectedEmote)
		{
			SetSelectedEmote(selectedEmote);
		}
		else if (obj is OptionArg optionArg)
		{
			if (optionArg.OptionName.Equals("AddEmote"))
			{
				ReplaceAndAddCurEmoteInFightEmote(optionArg.Obj as SetEmoteItemModel);
			}
			else if (optionArg.OptionName.Equals("ReplaceEmote"))
			{
				ReplaceAndAddCurEmoteInFightEmote(optionArg.Obj as SetEmoteItemModel);
			}
			else if (optionArg.OptionName.Equals("BattleEmoteItemOnClick"))
			{
				HideEmote();
				HideRemoveEmoteBtn();
			}
		}
		else if (obj is JumpWindowParams jumpWindowParams)
		{
			parent?.ItemOnClick(jumpWindowParams);
		}
	}

	public void HideEmoteState()
	{
		HideEmote();
		HideRemoveEmoteBtn();
		SetSelectedEmote(curSelectEmote);
	}

	private void ReplaceAndAddCurEmoteInFightEmote(SetEmoteItemModel setEmoteItemModel)
	{
		if (curSelectEmote != null)
		{
			setEmoteItemModel.ReplaceOrAddEmoteValue(curSelectEmote);
			HideEmote();
			SetSelectedEmote(curSelectEmote);
			SendSaveBattleEmote();
		}
	}

	public void MousePointerUpSaveInitialEmote()
	{
		foreach (SetEmoteItemModel item in setEmoteDic.Values)
		{
			if (item.Id != 0)
			{
				ToHaveEmoteItemModel emoteData = toHaveEmoteList.Find((ToHaveEmoteItemModel x) => x.Id == item.Id);
				item.InitValue(emoteData);
			}
		}
		foreach (SetEmoteItemModel item2 in battleStartList)
		{
			if (item2.Id != 0)
			{
				ToHaveEmoteItemModel emoteData2 = toHaveEmoteList.Find((ToHaveEmoteItemModel x) => x.Id == item2.Id);
				item2.InitValue(emoteData2);
			}
		}
	}

	public async void SendSaveBattleEmote()
	{
		List<int> list = new List<int>();
		List<int> list2 = new List<int>();
		foreach (SetEmoteItemModel value in setEmoteDic.Values)
		{
			list.Add(value.Id);
		}
		foreach (SetEmoteItemModel battleStart in battleStartList)
		{
			list2.Add(battleStart.Id);
		}
		if (await Singleton<ServiceSystem>.Instance.GetService<IBFBEService>().SetBattleSetEmojiSetting(list, list2))
		{
			RoleService.AddPlayerInfoChangeTDA();
		}
	}

	private void AddBattleEmoteSetTDA()
	{
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		List<Dictionary<string, object>> list = CollectionPool<List<Dictionary<string, object>>, Dictionary<string, object>>.Get();
		dictionary.Add("edit_detail", list);
		for (int i = 0; i < 3; i++)
		{
			if (i < battleStartList.Count && battleStartList[i].IsHaveEmote)
			{
				Dictionary<string, object> dictionary2 = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
				dictionary2.Clear();
				dictionary2.Add("index", $"{i + 1}");
				dictionary2.Add("name", battleStartList[i].EmoteIcon ?? "");
				dictionary2.Add("id", $"{battleStartList[i].Id}");
				dictionary2.Add("type", "battle_expression");
				list.Add(dictionary2);
			}
		}
		TDAHandler.Instance.SendUserEvent("profile_edit", dictionary);
		dictionary.Clear();
		list.Clear();
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
		CollectionPool<List<Dictionary<string, object>>, Dictionary<string, object>>.Release(list);
	}

	public override void OnOpen()
	{
		if (CurSelectEmote != null)
		{
			SetSelectedEmote(CurSelectEmote);
		}
		HideEmote();
		HideRemoveEmoteBtn();
	}

	public void HideEmote()
	{
		foreach (SetEmoteItemModel battleStart in battleStartList)
		{
			battleStart.HideEmoteState();
		}
		foreach (SetEmoteItemModel value in setEmoteDic.Values)
		{
			value.HideEmoteState();
		}
	}

	public void ShowEmoteState()
	{
		foreach (SetEmoteItemModel battleStart in battleStartList)
		{
			battleStart.ShowEmoteState();
		}
		foreach (SetEmoteItemModel value in setEmoteDic.Values)
		{
			value.ShowEmoteState();
		}
	}

	public void HideRemoveEmoteBtn()
	{
		foreach (SetEmoteItemModel battleStart in battleStartList)
		{
			battleStart.HideRemoveBtn();
		}
		foreach (SetEmoteItemModel value in setEmoteDic.Values)
		{
			value.HideRemoveBtn();
		}
	}

	public void CheckDragEndEmoteState()
	{
		foreach (SetEmoteItemModel battleStart in battleStartList)
		{
			if (battleStart.EmoteIcon != null)
			{
				battleStart.SetHaveEmote(isHaveEmote: true);
			}
		}
		foreach (SetEmoteItemModel value in setEmoteDic.Values)
		{
			if (value.EmoteIcon != null)
			{
				value.SetHaveEmote(isHaveEmote: true);
			}
		}
	}

	public override void Close()
	{
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>().RemoveNormalSecondUpdateAction(InitTimeLimit);
		base.Close();
	}

	public void InterruptDrag()
	{
		if (curSelectEmote != null && curSelectEmote.EmoteDrag == EmoteDragState.Dragging)
		{
			dragEndRequest.Raise();
		}
	}
}
