namespace Ase;

public class MailItemViewModel : OptionBase
{
	private MailData data;

	private bool isSelected;

	private bool isTypeChanged;

	public MailData Data
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

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		set
		{
			Set(ref isSelected, value, "IsSelected");
		}
	}

	public bool IsTypeChanged => isTypeChanged;

	public override void ItemOnClick(object obj)
	{
	}

	public MailItemViewModel()
	{
	}

	public MailItemViewModel(OptionBase parent, MailData data)
	{
		base.parent = parent;
		this.data = data;
	}

	public void OnClick()
	{
		IsSelected = true;
		isTypeChanged = data.OnSelected();
		parent.ItemOnClick(this);
	}

	public void ResetTypeChanged()
	{
		isTypeChanged = false;
	}
}
