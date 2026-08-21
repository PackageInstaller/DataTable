using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class BFBEViewModel : OptionBase
{
	private int curTabIndex = 1;

	private TabItemData curSelectTab;

	private BattleEmoteSetViewModel battleEmoteSetViewModel;

	private List<TabItemData> tabItemDatas = new List<TabItemData>();

	private InteractionRequest onTabClickRst = new InteractionRequest();

	private SimpleCommand<JumpWindowParams> _jumpWindowCmd;

	public InteractionRequest OnTabClickRst => onTabClickRst;

	public BattleEmoteSetViewModel BattleEmoteSetViewModel => battleEmoteSetViewModel;

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

	public BFBEViewModel(OptionBase parent, int tabIndex = 1)
	{
		base.parent = parent;
		_jumpWindowCmd = new SimpleCommand<JumpWindowParams>(JumpWindow);
		CurTabIndex = tabIndex;
	}

	public override async void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemData tabSelected)
		{
			SetTabSelected(tabSelected);
		}
		else if (obj is JumpWindowParams jumpWindowParams)
		{
			_jumpWindowCmd.Execute(jumpWindowParams);
		}
	}

	private void SetTabSelected(TabItemData tabItemData)
	{
		if (curSelectTab != null)
		{
			curSelectTab.IsSelected = false;
		}
		curSelectTab = tabItemData;
		curSelectTab.IsSelected = true;
		CurTabIndex = tabItemData.TabIndex;
		onTabClickRst.Raise();
	}

	public TabItemData CreateTabItemData(int tabIndex)
	{
		TabItemData tabItemData = new TabItemData(this, tabIndex);
		tabItemDatas.Add(tabItemData);
		return tabItemData;
	}

	public void ByViewSetSelectTab()
	{
		SetTabSelected(tabItemDatas[CurTabIndex - 1]);
	}

	public async void JumpWindow(JumpWindowParams param)
	{
		if (_jumpWindowCmd.Enabled && !string.IsNullOrEmpty(param.WindowName) && (parent == null || parent.CheckOpen(this, param)))
		{
			OpenViewArg openViewArg = await new UIJumpHelper().CreateViewJumpData(param, parent, "BFBEWindow", delegate
			{
				_jumpWindowCmd.Enabled = true;
			});
			if (openViewArg != null)
			{
				_jumpWindowCmd.Enabled = false;
				parent?.ItemOnClick(openViewArg);
				Close();
			}
		}
	}
}
