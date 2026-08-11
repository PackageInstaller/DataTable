namespace Ase;

public class SelectItemViewModel : OptionBase
{
	protected bool isSelect;

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

	public SelectItemViewModel(OptionBase parent)
	{
		base.parent = parent;
	}

	public SelectItemViewModel()
	{
	}

	public virtual void OnClick()
	{
		if (!isSelect)
		{
			IsSelect = true;
			parent?.ItemOnClick(this);
		}
	}

	public virtual void OnLongClick()
	{
		parent?.ItemOnClick(new OptionArg(this, "LongPress"));
	}

	public virtual void OnPress()
	{
		parent?.ItemOnClick(new OptionArg(this, "Press"));
	}

	public virtual void SetSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}
}
