using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class TeachingManualViewModel : OptionBase
{
	private List<TeachingPoint> datas = new List<TeachingPoint>();

	private List<TeachingPoint> filterDatas = new List<TeachingPoint>();

	private bool showSearch;

	private bool showClearcSearch;

	private string searchContent;

	private bool showNoContent;

	private string pageIcon = string.Empty;

	private string pageTitle;

	private string pageContent;

	private int curPage;

	private int totalPage;

	private bool isInBattle;

	private TeachingPoint curData;

	private TabItemData curPointTab;

	private InteractionRequest clearSearchRst = new InteractionRequest();

	private InteractionRequest onFilterDataChanged = new InteractionRequest();

	private List<PropDataBase> rewards = new List<PropDataBase>();

	private List<int> requestingIndexes = new List<int>();

	public bool ShowSearch
	{
		get
		{
			return showSearch;
		}
		set
		{
			Set(ref showSearch, value, "ShowSearch");
		}
	}

	public bool ShowClearcSearch
	{
		get
		{
			return showClearcSearch;
		}
		set
		{
			Set(ref showClearcSearch, value, "ShowClearcSearch");
		}
	}

	public string SearchContent
	{
		get
		{
			return searchContent;
		}
		set
		{
			Set(ref searchContent, value, "SearchContent");
		}
	}

	public bool ShowNoContent
	{
		get
		{
			return showNoContent;
		}
		set
		{
			Set(ref showNoContent, value, "ShowNoContent");
		}
	}

	public string PageIcon
	{
		get
		{
			return pageIcon;
		}
		set
		{
			Set(ref pageIcon, value, "PageIcon");
		}
	}

	public string PageTitle
	{
		get
		{
			return pageTitle;
		}
		set
		{
			Set(ref pageTitle, value, "PageTitle");
		}
	}

	public string PageContent
	{
		get
		{
			return pageContent;
		}
		set
		{
			Set(ref pageContent, value, "PageContent");
		}
	}

	public int CurPage
	{
		get
		{
			return curPage;
		}
		set
		{
			Set(ref curPage, value, "CurPage");
		}
	}

	public int TotalPage
	{
		get
		{
			return totalPage;
		}
		set
		{
			Set(ref totalPage, value, "TotalPage");
		}
	}

	public bool IsInBattle
	{
		get
		{
			return isInBattle;
		}
		set
		{
			Set(ref isInBattle, value, "IsInBattle");
		}
	}

	public TeachingPoint CurData => curData;

	public List<TeachingPoint> FilterDatas => filterDatas;

	public InteractionRequest ClearSearchRst => clearSearchRst;

	public InteractionRequest OnFilterDataChanged => onFilterDataChanged;

	public List<PropDataBase> Rewards => rewards;

	public TeachingManualViewModel()
	{
	}

	public TeachingManualViewModel(OptionBase parent, bool showSearch)
	{
		base.parent = parent;
		isInBattle = Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().GetGameProcess() != GameProcessType.Outer;
		ShowSearch = showSearch;
	}

	public void RefreshData(List<TeachingPoint> newDatas, int selectPointId = 0)
	{
		datas = newDatas;
		CancelSearch();
		SetPointData(selectPointId);
		onFilterDataChanged.Raise();
	}

	public override async void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemData tabSelected)
		{
			SetTabSelected(tabSelected);
		}
	}

	private void SetTabSelected(TabItemData tabItemData)
	{
		if (curPointTab != null)
		{
			curPointTab.IsSelected = false;
		}
		curPointTab = tabItemData;
		curPointTab.IsSelected = true;
		SetPointData(tabItemData.TabIndex);
	}

	private void CancelSearch()
	{
		RefreshFilterData(string.Empty);
		clearSearchRst.Raise();
	}

	public void OnInputFieldEndEdit(string content)
	{
		RefreshFilterData(content);
		ClearCurData();
		onFilterDataChanged.Raise();
	}

	private void RefreshFilterData(string content)
	{
		if (string.IsNullOrEmpty(content))
		{
			ShowClearcSearch = false;
			filterDatas = datas;
		}
		else
		{
			ShowClearcSearch = true;
			filterDatas = datas.FindAll((TeachingPoint p) => p.PointName.Contains(content));
		}
		ShowNoContent = filterDatas == null || filterDatas.Count <= 0;
		SortFilterDatas();
	}

	private void SortFilterDatas()
	{
		filterDatas?.Sort(delegate(TeachingPoint a, TeachingPoint b)
		{
			int num = 0;
			int value = 0;
			if (!IsInBattle)
			{
				num = ((!a.UnRead) ? 1 : (-1));
				value = ((!b.UnRead) ? 1 : (-1));
			}
			int num2 = 0;
			int value2 = 0;
			if (IsInBattle)
			{
				num2 = a.Type;
				value2 = b.Type;
			}
			return num.CompareTo(value) * 100 - num2.CompareTo(value2) * 10 + a.Id.CompareTo(b.Id);
		});
	}

	public void OnLastBtnClick()
	{
		if (CurPage - 1 > 0 && curData != null)
		{
			SetPageData(curData.Pages[CurPage - 1 - 1]);
		}
	}

	public void OnNextBtnClick()
	{
		if (CurPage < TotalPage && curData != null)
		{
			SetPageData(curData.Pages[CurPage - 1 + 1]);
		}
	}

	private void ClearCurData()
	{
		curData = null;
	}

	private async void SetPointData(int pointId)
	{
		curData = filterDatas.Find((TeachingPoint p) => p.Id == pointId);
		if (curData != null && curData.Pages != null && curData.Pages.Count > 0)
		{
			if (!IsInBattle && !TeachingDefinition.GetManualRewardState(curData.Index) && !requestingIndexes.Contains(curData.Index))
			{
				requestingIndexes.Add(CurData.Index);
				await TryGetManualReward(curData.Index);
				requestingIndexes.Remove(CurData.Index);
			}
			SetPageData(curData.Pages[0]);
		}
	}

	private void SetPageData(TeachingPointPage page)
	{
		CurPage = page.PageIndex;
		TotalPage = page.TotalPage;
		PageIcon = "Copy/CopyGuide/" + page.PageIcon;
		PageTitle = page.PageTitle;
		PageContent = page.PageContent;
	}

	private async Task TryGetManualReward(int index)
	{
		Loading loading = await Loading.Show();
		KeyValuePair<bool, RewardGetData> keyValuePair = await Singleton<ServiceSystem>.Instance.GetService<IRoleService>().RequestGetManualReward(index);
		loading?.Dispose();
		if (!keyValuePair.Key || keyValuePair.Value == null)
		{
			return;
		}
		foreach (PropDataBase prop in keyValuePair.Value.PropList)
		{
			PropExtension.Attach(rewards, prop);
		}
	}
}
