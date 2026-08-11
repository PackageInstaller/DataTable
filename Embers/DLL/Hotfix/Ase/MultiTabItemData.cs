using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class MultiTabItemData : TabItemData
{
	private object tabArg;

	private List<TabItemData> subTabDatas = new List<TabItemData>();

	private TabItemData curSubTabData;

	private bool haveSubTab;

	private bool cacheVisible;

	private int subTabSelectIndex = -1;

	private InteractionRequest showSubTabsRst = new InteractionRequest();

	private InteractionRequest hideSubTabsRst = new InteractionRequest();

	public object TabArg
	{
		get
		{
			return tabArg;
		}
		set
		{
			Set(ref tabArg, value, "TabArg");
		}
	}

	public bool HaveSubTab
	{
		get
		{
			return haveSubTab;
		}
		private set
		{
			Set(ref haveSubTab, value, "HaveSubTab");
		}
	}

	public List<TabItemData> SubTabDatas => subTabDatas;

	public bool CacheVisible => cacheVisible;

	public int SubTabSelectIndex => subTabSelectIndex;

	public InteractionRequest ShowSubTabsRst => showSubTabsRst;

	public InteractionRequest HideSubTabsRst => hideSubTabsRst;

	public MultiTabItemData()
	{
	}

	public MultiTabItemData(OptionBase parent, int tabIndex)
		: base(parent, tabIndex)
	{
	}

	public void SetSubTabDatas(List<TabItemData> tabDatas)
	{
		HaveSubTab = tabDatas != null && tabDatas.Count > 0;
		if (tabDatas != null)
		{
			subTabDatas = tabDatas;
		}
		else
		{
			subTabDatas = new List<TabItemData>();
		}
	}

	public void ShowSubTabs(int subTabIndex = -1)
	{
		cacheVisible = true;
		subTabSelectIndex = subTabIndex;
		showSubTabsRst.Raise();
	}

	public void HideSubTabs()
	{
		cacheVisible = false;
		hideSubTabsRst.Raise();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemData obj2)
		{
			if (curSubTabData != null)
			{
				curSubTabData.IsSelected = false;
			}
			curSubTabData = obj2;
			curSubTabData.IsSelected = true;
			parent?.ItemOnClick(obj2);
		}
	}
}
