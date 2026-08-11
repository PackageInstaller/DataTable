using System.Collections.Generic;

namespace Ase;

public class SortTypeViewModel : OptionBase
{
	private string sortTypeName;

	private string sortType;

	private List<SortItemViewModel> sortItemList;

	public string SortTypeName
	{
		get
		{
			return sortTypeName;
		}
		private set
		{
			Set(ref sortTypeName, value, "SortTypeName");
		}
	}

	public List<SortItemViewModel> SortItemList => sortItemList;

	public override void ItemOnClick(object obj)
	{
	}

	public SortTypeViewModel()
	{
	}

	public SortTypeViewModel(OptionBase parent, string sortType, string sortTypeNmae, List<SortItemViewModel> sortItemList)
	{
		base.parent = parent;
		this.sortType = sortType;
		sortTypeName = sortTypeNmae;
		this.sortItemList = sortItemList;
	}

	public void SaveSelect()
	{
		foreach (SortItemViewModel sortItem in sortItemList)
		{
			sortItem.Save();
		}
	}

	public void ClearSelect()
	{
		foreach (SortItemViewModel sortItem in sortItemList)
		{
			sortItem.ClearSelect();
		}
	}
}
