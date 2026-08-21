namespace Ase;

public class SortItemViewModel : OptionBase
{
	private string name;

	private string sortType;

	private object sortData;

	private bool isSelected;

	private bool isSave;

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		private set
		{
			Set(ref isSelected, value, "IsSelected");
		}
	}

	public bool IsSave
	{
		get
		{
			return isSave;
		}
		private set
		{
			Set(ref isSave, value, "IsSave");
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public string SortType => sortType;

	public object SortData => sortData;

	public override void ItemOnClick(object obj)
	{
	}

	public SortItemViewModel()
	{
	}

	public SortItemViewModel(OptionBase parent, string sortType, string name, object sortData)
	{
		base.parent = parent;
		this.name = name;
		this.sortType = sortType;
		this.sortData = sortData;
	}

	public void Save()
	{
		IsSave = isSelected;
	}

	public void ClearSelect()
	{
		if (!isSave)
		{
			IsSelected = false;
		}
	}

	public void OnSelect()
	{
		IsSelected = !isSelected;
	}
}
