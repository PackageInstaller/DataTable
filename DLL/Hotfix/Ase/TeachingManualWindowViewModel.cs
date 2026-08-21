using System.Collections.Generic;

namespace Ase;

public class TeachingManualWindowViewModel : OptionBase
{
	private TeachingDefinition.TeachingType curTabIndex;

	private TabItemData curSelectTab;

	private TeachingManualViewModel viewData;

	public TeachingDefinition.TeachingType CurTabIndex
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

	public TeachingManualViewModel ViewData => viewData;

	public TeachingManualWindowViewModel()
	{
	}

	public TeachingManualWindowViewModel(OptionBase parent, TeachingDefinition.TeachingType tab = TeachingDefinition.TeachingType.All)
	{
		base.parent = parent;
		viewData = new TeachingManualViewModel(this, showSearch: true);
		AddChild(viewData);
		CurTabIndex = tab;
	}

	public override async void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemData tabSelected)
		{
			SetTabSelected(tabSelected);
		}
		else if (obj is List<PropData> itemsGet)
		{
			parent?.ItemOnClick(new OpenViewArg(typeof(PropGetWindow), new PropGetViewModel(parent, itemsGet)));
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
		CurTabIndex = (TeachingDefinition.TeachingType)tabItemData.TabIndex;
		RefreshManualData();
	}

	private void RefreshManualData()
	{
		DRManual[] array = new DRManual[0];
		if (CurTabIndex == TeachingDefinition.TeachingType.All)
		{
			array = GameEntry.DataTable.GetAllDataRow<DRManual>();
		}
		else if (CurTabIndex == TeachingDefinition.TeachingType.Combat)
		{
			array = GameEntry.DataTable.GetDataRows((DRManual p) => p.Type == 1);
		}
		else if (CurTabIndex == TeachingDefinition.TeachingType.Level)
		{
			array = GameEntry.DataTable.GetDataRows((DRManual p) => p.Type == 2);
		}
		else if (CurTabIndex == TeachingDefinition.TeachingType.System)
		{
			array = GameEntry.DataTable.GetDataRows((DRManual p) => p.Type == 3);
		}
		List<TeachingPoint> list = new List<TeachingPoint>();
		if (array != null)
		{
			DRManual[] array2 = array;
			foreach (DRManual drManual in array2)
			{
				if (TeachingDefinition.GetTeachingPointOpenState(drManual))
				{
					list.Add(new TeachingPoint(drManual));
				}
			}
		}
		viewData.RefreshData(list);
	}

	public override void Close()
	{
		if (viewData.Rewards != null && viewData.Rewards.Count > 0)
		{
			parent?.ItemOnClick(new OpenViewArg(typeof(PropGetWindow), new PropGetViewModel(parent, viewData.Rewards)));
		}
		base.Close();
	}
}
