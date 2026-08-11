using System.Collections.Generic;
using System.Linq;
using GameFramework.Runtime;

namespace Ase;

public class PlayerInfoAchiSelectViewModel : OptionBase
{
	private List<AchiItemData> achiItemDatas;

	private List<AchiItemData> copyAchiItemDatas;

	private List<int> initialSelectIds;

	private Dictionary<int, int> selectIds;

	private SimpleCommand<string> optCommand;

	private AchiItemData curSelectAchiItem;

	private bool isShowAchiInfoView;

	private PlayerInfoShowAchiInfoViewModel curShowAchiInfoVM;

	private string rankTxt;

	private bool isShowUpArrow;

	private bool isShowDownArrow;

	private bool isShowRank;

	private string filterTxt;

	private bool isShowFilter;

	private List<TabItemNormalData> filterList;

	private TabItemNormalData curFilterTab;

	private InteractionRequest updateAchiListRequest;

	public List<AchiItemData> AchiItemDatas
	{
		get
		{
			return achiItemDatas;
		}
		set
		{
			Set(ref achiItemDatas, value, "AchiItemDatas");
		}
	}

	public bool IsShowAchiInfoView
	{
		get
		{
			return isShowAchiInfoView;
		}
		set
		{
			Set(ref isShowAchiInfoView, value, "IsShowAchiInfoView");
		}
	}

	public string RankTxt
	{
		get
		{
			return rankTxt;
		}
		set
		{
			Set(ref rankTxt, value, "RankTxt");
		}
	}

	public bool IsShowUpArrow
	{
		get
		{
			return isShowUpArrow;
		}
		set
		{
			Set(ref isShowUpArrow, value, "IsShowUpArrow");
		}
	}

	public bool IsShowDownArrow
	{
		get
		{
			return isShowDownArrow;
		}
		set
		{
			Set(ref isShowDownArrow, value, "IsShowDownArrow");
		}
	}

	public bool IsShowRank
	{
		get
		{
			return isShowRank;
		}
		set
		{
			Set(ref isShowRank, value, "IsShowRank");
		}
	}

	public string FilterTxt
	{
		get
		{
			return filterTxt;
		}
		set
		{
			Set(ref filterTxt, value, "FilterTxt");
		}
	}

	public bool IsShowFilter
	{
		get
		{
			return isShowFilter;
		}
		set
		{
			Set(ref isShowFilter, value, "IsShowFilter");
		}
	}

	public ICommand OptCommand => optCommand;

	public PlayerInfoShowAchiInfoViewModel CurShowAchiInfoVM => curShowAchiInfoVM;

	public List<TabItemNormalData> FilterList => filterList;

	public InteractionRequest UpdateAchiListRequest => updateAchiListRequest;

	public PlayerInfoAchiSelectViewModel()
	{
	}

	public PlayerInfoAchiSelectViewModel(OptionBase parent)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		achiItemDatas = new List<AchiItemData>();
		copyAchiItemDatas = new List<AchiItemData>();
		filterList = new List<TabItemNormalData>();
		selectIds = new Dictionary<int, int>();
		curShowAchiInfoVM = new PlayerInfoShowAchiInfoViewModel();
		updateAchiListRequest = new InteractionRequest();
		IsShowAchiInfoView = false;
		isShowUpArrow = false;
		isShowDownArrow = false;
		RankTxt = "默认";
		LoadAddAchi();
		LoadFilterTab();
	}

	private void LoadFilterTab()
	{
		FilterTxt = "全部徽章";
		IsShowFilter = false;
		FilterList.Add(new TabItemNormalData(this, "empty", 0, isSelected: false, "全部徽章"));
		DRAchievementType[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRAchievementType>();
		for (int i = 0; i < allDataRow.Length; i++)
		{
			FilterList.Add(new TabItemNormalData(this, "empty", allDataRow[i].Id, isSelected: false, allDataRow[i].Name));
		}
	}

	private void LoadAddAchi()
	{
		foreach (AchievementMedal allAchievementMedals in Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetAllAchievementMedalsList())
		{
			if (allAchievementMedals.MedalRank > 0 && allAchievementMedals.MedalNum > 0)
			{
				AchiItemData item = new AchiItemData(this, allAchievementMedals);
				achiItemDatas.Add(item);
				copyAchiItemDatas.Add(item);
			}
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is AchiItemData achiItemData)
		{
			CheckSelectAchiItem(achiItemData);
		}
		else if (obj is TabItemNormalData tabData)
		{
			FilterAchi(tabData);
		}
	}

	private void CheckSelectAchiItem(AchiItemData achiItemData)
	{
		curSelectAchiItem = null;
		curSelectAchiItem = achiItemData;
		IsShowAchiInfoView = true;
		CurShowAchiInfoVM.SetCurAchiInfo(achiItemData);
		if (achiItemData.IsSelected)
		{
			achiItemData.SetSelected(value: false);
			for (int i = 0; i < selectIds.Count; i++)
			{
				if (selectIds[i + 1] == achiItemData.AchiId)
				{
					selectIds[i + 1] = 0;
				}
			}
			curSelectAchiItem = null;
			IsShowAchiInfoView = false;
		}
		else if (!achiItemData.IsSelected && CheckDictionaryInfo())
		{
			int selectAchiIndex = 0;
			for (int j = 0; j < selectIds.Count; j++)
			{
				if (selectIds[j + 1] == 0)
				{
					selectIds[j + 1] = achiItemData.AchiId;
					selectAchiIndex = j + 1;
					break;
				}
			}
			achiItemData.SetSelected(value: true);
			achiItemData.SetSelectAchiIndex(selectAchiIndex);
		}
		else if (selectIds.Count >= 4)
		{
			Toast.ShowInfo("展示徽章已达上限!");
		}
	}

	private bool CheckDictionaryInfo()
	{
		if (selectIds.Count < 4)
		{
			int num = ((selectIds.Count > 0) ? selectIds.Keys.Max() : 0);
			while (selectIds.Count < 4)
			{
				num++;
				selectIds[num] = 0;
			}
		}
		for (int i = 0; i < selectIds.Count; i++)
		{
			if (selectIds[i + 1] == 0)
			{
				return true;
			}
		}
		return false;
	}

	public void OnOpt(string optName)
	{
		if ("OnSave".Equals(optName))
		{
			OnSave();
		}
		else if ("MRSort".Equals(optName))
		{
			MRSort();
		}
		else if ("TopSort".Equals(optName))
		{
			TopSort();
		}
		else if ("DownSort".Equals(optName))
		{
			DownSort();
		}
		else if ("ShowRank".Equals(optName))
		{
			ShowRank();
		}
		else if ("ShowFilter".Equals(optName))
		{
			ShowFilter();
		}
		else if ("RankBg".Equals(optName))
		{
			RankBgBtnClick();
		}
		else if ("FilterBg".Equals(optName))
		{
			FilterBgBtnClick();
		}
	}

	private void FilterBgBtnClick()
	{
		IsShowFilter = false;
	}

	private void RankBgBtnClick()
	{
		IsShowRank = false;
	}

	private void ShowFilter()
	{
		IsShowFilter = !IsShowFilter;
		if (IsShowRank)
		{
			IsShowRank = !IsShowRank;
		}
	}

	private void ShowRank()
	{
		IsShowRank = !IsShowRank;
	}

	private void OnSave()
	{
		foreach (AchiItemData achiItemData in achiItemDatas)
		{
			achiItemData.SetChecked(achiItemData.IsSelected);
		}
		ReorderAchiList();
		curSelectAchiItem = null;
		IsShowAchiInfoView = false;
		parent.ItemOnClick(new OptionArg(this, "OnShowAchis"));
		Close();
	}

	public void CloseOrSave()
	{
		if (CheckSelectIds())
		{
			IAsyncResult<int> result = AlertDialog.Show("", "有未保存的徽章展示修改，是否保存?", "保存", "不保存");
			result.Callbackable().OnCallback(async delegate
			{
				if (result.Result == -1)
				{
					OnSave();
				}
				else if (result.Result == -2)
				{
					Close();
				}
			});
		}
		else
		{
			curSelectAchiItem = null;
			IsShowAchiInfoView = false;
			Close();
		}
	}

	private bool CheckSelectIds()
	{
		List<int> list = new List<int>();
		foreach (int value in selectIds.Values)
		{
			if (value != 0)
			{
				list.Add(value);
			}
		}
		if (list.Count != initialSelectIds.Count)
		{
			return true;
		}
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i] != initialSelectIds[i])
			{
				return true;
			}
		}
		return false;
	}

	public void OnOpen(List<int> selectAchiIds, int selectId)
	{
		selectIds.Clear();
		IsShowAchiInfoView = false;
		initialSelectIds = new List<int>(selectAchiIds);
		for (int i = 0; i < selectAchiIds.Count; i++)
		{
			selectIds[i + 1] = selectAchiIds[i];
		}
		foreach (AchiItemData achiItemData in achiItemDatas)
		{
			bool flag = false;
			for (int j = 0; j < selectAchiIds.Count; j++)
			{
				if (achiItemData.AchiId != selectAchiIds[j])
				{
					continue;
				}
				achiItemData.SetChecked(value: true);
				achiItemData.SetSelected(value: true);
				int num = -1;
				foreach (KeyValuePair<int, int> selectId2 in selectIds)
				{
					if (selectId2.Value == achiItemData.AchiId)
					{
						num = selectId2.Key;
						break;
					}
				}
				if (num != -1)
				{
					achiItemData.SetSelectAchiIndex(num);
				}
				flag = true;
			}
			if (!flag)
			{
				achiItemData.SetChecked(value: false);
				achiItemData.SetSelected(value: false);
			}
		}
		ReorderAchiList();
	}

	public void Refresh()
	{
		if (selectIds.Count > 0)
		{
			RefreshSelectAchiDic();
			ReorderAchiList();
			{
				foreach (int item in selectIds.Keys)
				{
					achiItemDatas.Find((AchiItemData x) => x.AchiId == selectIds[item])?.SetSelectAchiIndex(item);
				}
				return;
			}
		}
		foreach (AchiItemData achiItemData in achiItemDatas)
		{
			achiItemData.SetSelected(achiItemData.IsChecked);
			if (achiItemData.IsChecked)
			{
				int key = selectIds.Count + 1;
				selectIds[key] = achiItemData.AchiId;
			}
		}
	}

	public void RefreshSelectAchiDic()
	{
		List<int> list = new List<int>();
		initialSelectIds.Clear();
		foreach (int value in selectIds.Values)
		{
			if (value != 0)
			{
				list.Add(value);
			}
		}
		for (int i = 0; i < 4; i++)
		{
			if (i < list.Count)
			{
				selectIds[i + 1] = list[i];
				initialSelectIds.Add(selectIds[i + 1]);
			}
			else
			{
				selectIds[i + 1] = 0;
			}
		}
	}

	public override void Close()
	{
		selectIds.Clear();
		foreach (AchiItemData achiItemData in achiItemDatas)
		{
			if (achiItemData.IsChecked)
			{
				int key = selectIds.Count + 1;
				selectIds[key] = achiItemData.AchiId;
			}
			achiItemData.SetSelected(achiItemData.IsChecked);
		}
		curSelectAchiItem = null;
		IsShowAchiInfoView = false;
		base.IsVisible = false;
	}

	private void ReorderAchiList()
	{
		List<AchiItemData> list = new List<AchiItemData>();
		foreach (int item in selectIds.Keys.OrderBy((int k) => k).ToList())
		{
			int achiId = selectIds[item];
			if (achiId != 0)
			{
				AchiItemData achiItemData = achiItemDatas.FirstOrDefault((AchiItemData h) => h.AchiId == achiId);
				if (achiItemData != null)
				{
					list.Add(achiItemData);
				}
			}
		}
		foreach (AchiItemData achiItem in achiItemDatas)
		{
			if ((!selectIds.ContainsValue(achiItem.AchiId) || (selectIds.ContainsValue(achiItem.AchiId) && selectIds.First((KeyValuePair<int, int> kvp) => kvp.Value == achiItem.AchiId).Value == 0)) && !list.Contains(achiItem))
			{
				list.Add(achiItem);
			}
		}
		achiItemDatas.Clear();
		achiItemDatas.AddRange(list);
	}

	private void MRSort()
	{
		RankTxt = "默认";
		IsShowUpArrow = false;
		IsShowDownArrow = false;
		achiItemDatas.Clear();
		for (int i = 0; i < copyAchiItemDatas.Count; i++)
		{
			achiItemDatas.Add(copyAchiItemDatas[i]);
		}
		UpdateAchiListRequest.Raise();
		RankBgBtnClick();
	}

	private void TopSort()
	{
		RankTxt = "稀有度";
		IsShowUpArrow = true;
		IsShowDownArrow = false;
		achiItemDatas.Sort(delegate(AchiItemData x, AchiItemData y)
		{
			if (x.IsSelected && !y.IsSelected)
			{
				return -1;
			}
			return (!x.IsSelected && y.IsSelected) ? 1 : x.AchiRarity.CompareTo(y.AchiRarity);
		});
		UpdateAchiListRequest.Raise();
		RankBgBtnClick();
	}

	private void DownSort()
	{
		RankTxt = "稀有度";
		IsShowUpArrow = false;
		IsShowDownArrow = true;
		achiItemDatas.Sort(delegate(AchiItemData x, AchiItemData y)
		{
			if (x.IsSelected && !y.IsSelected)
			{
				return -1;
			}
			return (!x.IsSelected && y.IsSelected) ? 1 : y.AchiRarity.CompareTo(x.AchiRarity);
		});
		UpdateAchiListRequest.Raise();
		RankBgBtnClick();
	}

	private void FilterAchi(TabItemNormalData tabData)
	{
		curFilterTab?.SetSelected(value: false);
		curFilterTab = tabData;
		curFilterTab.SetSelected(value: true);
		achiItemDatas.Clear();
		FilterTxt = tabData.Text;
		if (tabData.ID == 0)
		{
			foreach (AchiItemData copyAchiItemData in copyAchiItemDatas)
			{
				achiItemDatas.Add(copyAchiItemData);
			}
		}
		else
		{
			AddSelectAchiToList();
			for (int i = 0; i < copyAchiItemDatas.Count; i++)
			{
				if (copyAchiItemDatas[i].AchiType == tabData.ID && !achiItemDatas.Contains(copyAchiItemDatas[i]))
				{
					achiItemDatas.Add(copyAchiItemDatas[i]);
				}
			}
		}
		achiItemDatas.Sort(delegate(AchiItemData x, AchiItemData y)
		{
			if (x.IsSelected && !y.IsSelected)
			{
				return -1;
			}
			return (!x.IsSelected && y.IsSelected) ? 1 : x.AchiRarity.CompareTo(y.AchiRarity);
		});
		UpdateAchiListRequest.Raise();
		FilterBgBtnClick();
	}

	public void AddSelectAchiToList()
	{
		foreach (int item in selectIds.Values)
		{
			if (item != 0)
			{
				achiItemDatas.Add(copyAchiItemDatas.Find((AchiItemData x) => x.AchiId == item));
			}
		}
	}
}
