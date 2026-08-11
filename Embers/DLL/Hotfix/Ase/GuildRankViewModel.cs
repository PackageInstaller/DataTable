using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class GuildRankViewModel : OptionBase
{
	private GuildRankItemData myGuildRankData;

	private List<KeyValuePair<int, GuildData>> rankDatas = new List<KeyValuePair<int, GuildData>>();

	private int curTabIndex = 1;

	private TabItemData curSelectTab;

	private InteractionRequest onTabClickRst = new InteractionRequest();

	private bool openReportEnable = true;

	public GuildRankItemData MyGuildRankData => myGuildRankData;

	public List<KeyValuePair<int, GuildData>> RankDatas => rankDatas;

	public int CurTabIndex
	{
		get
		{
			return curTabIndex;
		}
		set
		{
			Set(ref curTabIndex, value, "CurTabIndex");
		}
	}

	public InteractionRequest OnTabClickRst => onTabClickRst;

	public GuildRankViewModel()
	{
	}

	public GuildRankViewModel(OptionBase parent, int tabIndex = 1)
	{
		base.parent = parent;
		myGuildRankData = new GuildRankItemData(this);
		CurTabIndex = tabIndex;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemData tabItemData)
		{
			SetTabSelected(tabItemData, requestData: true);
		}
		else if (obj is OptionArg { OptionName: "OpenReport", Obj: GuildItemData obj2 })
		{
			OpenReportPopupWindow(obj2.WorldPosition, obj2.GuildData.Name, obj2.GuildData.Uid);
		}
	}

	public async void SetTabSelected(TabItemData tabItemData, bool requestData)
	{
		if (curSelectTab != null)
		{
			curSelectTab.IsSelected = false;
		}
		curSelectTab = tabItemData;
		curSelectTab.IsSelected = true;
		CurTabIndex = tabItemData.TabIndex;
		if (requestData)
		{
			await RequestRankData();
		}
		onTabClickRst.Raise();
	}

	public async Task RequestRankData()
	{
		Loading loading = await Loading.Show();
		List<GuildData> list = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestGuildRankData();
		loading?.Dispose();
		if (list == null)
		{
			return;
		}
		long uid = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData().Uid;
		rankDatas.Clear();
		bool flag = false;
		for (int i = 1; i <= list.Count; i++)
		{
			rankDatas.Add(new KeyValuePair<int, GuildData>(i, list[i - 1]));
			if (list[i - 1].Uid == uid)
			{
				flag = true;
				myGuildRankData.RefreshData(list[i - 1], i, clickEnable: false);
			}
		}
		if (!flag)
		{
			myGuildRankData.NoRank = true;
		}
	}

	private void OpenReportPopupWindow(Vector3 worldPosition, string name, long uid)
	{
		if (openReportEnable)
		{
			openReportEnable = false;
			base.ItemOnClick((object)new OpenViewArg(typeof(ReportPopupWindow), new ReportPopupViewModel(parent, worldPosition, ReportTypeEnum.Guild, name, uid), "GuildRank", isOpenWindow: true, "DEFAULT", delegate
			{
				openReportEnable = true;
			}));
		}
	}
}
