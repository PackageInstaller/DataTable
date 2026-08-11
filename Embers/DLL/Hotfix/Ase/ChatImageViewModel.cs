#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class ChatImageViewModel : OptionBase
{
	private string tabName;

	private bool isInit;

	private TabItemViewModel curSelectTab;

	private List<TabItemViewModel> tabList = new List<TabItemViewModel>();

	private Dictionary<int, List<CharImageItemViewModel>> imageDic = new Dictionary<int, List<CharImageItemViewModel>>();

	private InteractionRequest<string> optRequest = new InteractionRequest<string>();

	private int curTabImageCount;

	private const int recentTabId = 1;

	public string TabName
	{
		get
		{
			return tabName;
		}
		private set
		{
			Set(ref tabName, value, "TabName");
		}
	}

	public List<TabItemViewModel> TabList => tabList;

	public Dictionary<int, List<CharImageItemViewModel>> ImageDic => imageDic;

	public int CurTabId => curSelectTab?.ID ?? 1;

	public int CurTabImageCount
	{
		get
		{
			return curTabImageCount;
		}
		private set
		{
			Set(ref curTabImageCount, value, "CurTabImageCount");
		}
	}

	public IInteractionRequest OptRequest => optRequest;

	public ChatImageViewModel()
	{
	}

	public ChatImageViewModel(OptionBase parent)
	{
		base.parent = parent;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is CharImageItemViewModel imageItem)
		{
			SelectImage(imageItem);
		}
		else if (obj is TabItemViewModel tabItem)
		{
			SelectTab(tabItem);
		}
	}

	public void Init(List<int> unlockType)
	{
		try
		{
			if (!isInit)
			{
				DREmoticonType[] allDataRow = GameEntry.DataTable.GetAllDataRow<DREmoticonType>();
				if (allDataRow != null && allDataRow.Length != 0)
				{
					for (int i = 0; i < allDataRow.Length; i++)
					{
						if (allDataRow[i].UnclockType == 0 || unlockType == null || unlockType.Contains(allDataRow[i].Id))
						{
							TabItemViewModel tabItemViewModel = new TabItemViewModel(this, allDataRow[i]);
							tabList.Add(tabItemViewModel);
							imageDic.Add(tabItemViewModel.ID, null);
						}
					}
				}
				if (tabList.Count > 0)
				{
					RefreshRecent();
					SelectTab(tabList[0]);
				}
				isInit = true;
				return;
			}
			for (int j = 0; j < unlockType.Count; j++)
			{
				if (!imageDic.ContainsKey(unlockType[j]))
				{
					DREmoticonType dataRow = GameEntry.DataTable.GetDataRow<DREmoticonType>(unlockType[j]);
					if (dataRow != null)
					{
						TabItemViewModel tabItemViewModel2 = new TabItemViewModel(this, dataRow);
						tabList.Add(tabItemViewModel2);
						imageDic.Add(tabItemViewModel2.ID, null);
					}
				}
			}
			tabList.Sort((TabItemViewModel x, TabItemViewModel y) => x.ID.CompareTo(y.ID));
			if (tabList != null && tabList.Count > 0)
			{
				SelectTab(tabList[0]);
			}
		}
		catch (Exception ex)
		{
			Log.Error("打开表情包界面发生异常 " + ex.Message + " / " + ex.StackTrace);
		}
	}

	private void RefreshImages(int type)
	{
		if (!imageDic.ContainsKey(type))
		{
			Log.Error($"不合法的EmoticonType {type}");
			return;
		}
		if (imageDic[type] == null)
		{
			List<CharImageItemViewModel> list = new List<CharImageItemViewModel>();
			DREmoticon[] dataRows = GameEntry.DataTable.GetDataRows((DREmoticon p) => p.TypeId == type);
			if (dataRows == null || dataRows.Length == 0)
			{
				imageDic[type] = new List<CharImageItemViewModel>();
				CurTabImageCount = 0;
				return;
			}
			for (int num = 0; num < dataRows.Length; num++)
			{
				CharImageItemViewModel item = new CharImageItemViewModel(this, dataRows[num]);
				list.Add(item);
			}
			imageDic[type] = list;
			CurTabImageCount = list.Count;
			return;
		}
		if (type == 1)
		{
			int constantConfigInt = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.ChatEmojiMaxCount);
			if (imageDic[type].Count > constantConfigInt)
			{
				imageDic[type] = imageDic[type].GetRange(0, constantConfigInt);
			}
		}
		CurTabImageCount = imageDic[type].Count;
	}

	private void RefreshRecent()
	{
		List<int> ids = Singleton<ServiceSystem>.Instance.GetService<IChatService>().GetChatViewModel().GetRecentImages();
		List<CharImageItemViewModel> list = new List<CharImageItemViewModel>();
		int i;
		for (i = 0; i < ids.Count; i++)
		{
			DREmoticon dataRow = GameEntry.DataTable.GetDataRow((DREmoticon p) => p.Id == ids[i]);
			CharImageItemViewModel item = new CharImageItemViewModel(this, dataRow);
			list.Add(item);
		}
		imageDic[1] = list;
	}

	private void SelectTab(TabItemViewModel tabItem)
	{
		if (curSelectTab == null || curSelectTab != tabItem)
		{
			if (curSelectTab != null)
			{
				curSelectTab.SetSelect(isSelect: false);
			}
			curSelectTab = tabItem;
			curSelectTab.SetSelect(isSelect: true);
			TabName = curSelectTab.Name;
			RefreshImages(curSelectTab.ID);
			optRequest.Raise("RefreshTab");
		}
	}

	private void SelectImage(CharImageItemViewModel imageItem)
	{
		AddRecent(imageItem);
		SaveRecent();
		parent?.ItemOnClick(new OptionArg(imageItem, "SendImage"));
	}

	public override void Close()
	{
		parent?.ItemOnClick(new OptionArg(this, "CloseChatImage"));
	}

	private void AddRecent(CharImageItemViewModel imageItem)
	{
		if (!imageDic.ContainsKey(1) || imageDic[1] == null)
		{
			return;
		}
		List<CharImageItemViewModel> list = imageDic[1];
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i].ID == imageItem.ID)
			{
				if (i == 0)
				{
					return;
				}
				list.RemoveAt(i);
				break;
			}
		}
		list.Insert(0, imageItem);
	}

	private void SaveRecent()
	{
		List<int> list = new List<int>();
		if (imageDic.ContainsKey(1) && imageDic[1] != null)
		{
			List<CharImageItemViewModel> list2 = imageDic[1];
			for (int i = 0; i < list2.Count; i++)
			{
				list.Add(list2[i].ID);
			}
		}
		Singleton<ServiceSystem>.Instance.GetService<IChatService>().GetChatViewModel().SaveRecentImages(list);
	}
}
