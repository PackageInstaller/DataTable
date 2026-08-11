namespace Ase;

public class TowerTalentItemViewModel : OptionBase
{
	private TowerTalentViewModel data;

	private bool isSelect;

	public TowerTalentViewModel Data
	{
		get
		{
			return data;
		}
		set
		{
			Set(ref data, value, "Data");
		}
	}

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public TowerTalentItemViewModel(OptionBase parent, TowerTalentViewModel towerTalentViewModel)
	{
		base.parent = parent;
		data = towerTalentViewModel;
	}

	public void OnClick()
	{
		if (base.Parent != null)
		{
			parent.ItemOnClick(this);
		}
	}
}
