namespace Ase;

public class BattleStatSkillItemViewModel : OptionBase
{
	private BSData data;

	private bool isSelect;

	private bool canSelect;

	private bool isOther;

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		private set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public bool CanSelect
	{
		get
		{
			return canSelect;
		}
		private set
		{
			Set(ref canSelect, value, "CanSelect");
		}
	}

	public bool IsOther
	{
		get
		{
			return isOther;
		}
		private set
		{
			Set(ref isOther, value, "IsOther");
		}
	}

	public BSData Data
	{
		get
		{
			return data;
		}
		private set
		{
			Set(ref data, value, "Data");
		}
	}

	public BattleStatSkillItemViewModel()
	{
	}

	public BattleStatSkillItemViewModel(OptionBase parent, BSData data)
	{
		base.parent = parent;
		this.data = data;
		canSelect = data.IsTotalItem;
	}

	public void SetSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}

	public void OnSelect()
	{
		if (canSelect && data.HasChild)
		{
			parent.ItemOnClick(this);
		}
	}

	public void SetOther()
	{
		IsOther = true;
	}
}
