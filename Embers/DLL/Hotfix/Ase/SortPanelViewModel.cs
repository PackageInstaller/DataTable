using System.Collections.Generic;

namespace Ase;

public class SortPanelViewModel : OptionBase
{
	private List<SortTypeViewModel> sortList;

	public List<SortTypeViewModel> SortList => sortList;

	public override void ItemOnClick(object obj)
	{
	}

	public SortPanelViewModel()
	{
	}

	public SortPanelViewModel(OptionBase parent, Dictionary<string, List<SortItemViewModel>> sortDatas)
	{
		base.parent = parent;
		sortList = new List<SortTypeViewModel>();
		foreach (KeyValuePair<string, List<SortItemViewModel>> sortData in sortDatas)
		{
			sortList.Add(new SortTypeViewModel(this, sortData.Key, GetNameCH(sortData.Key), sortData.Value));
		}
	}

	private string GetNameCH(string sortType)
	{
		if (sortType == "Weapon")
		{
			return "武器";
		}
		if (sortType == "Attribute")
		{
			return "元素";
		}
		return "不存在";
	}

	public void OnFunc()
	{
		foreach (SortTypeViewModel sort in sortList)
		{
			sort.SaveSelect();
		}
		parent.ItemOnClick(this);
	}

	public void ClearSelect()
	{
		foreach (SortTypeViewModel sort in sortList)
		{
			sort.ClearSelect();
		}
	}

	public override void Close()
	{
		base.IsVisible = false;
	}
}
