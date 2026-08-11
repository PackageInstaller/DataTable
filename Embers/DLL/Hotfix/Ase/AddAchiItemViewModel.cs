namespace Ase;

public class AddAchiItemViewModel : OptionBase
{
	private bool isSelf;

	public bool IsSelf
	{
		get
		{
			return isSelf;
		}
		private set
		{
			Set(ref isSelf, value, "IsSelf");
		}
	}

	public AddAchiItemViewModel(OptionBase parent, bool isSelf)
	{
		base.parent = parent;
		this.isSelf = isSelf;
	}

	public void AddAchi()
	{
		parent.ItemOnClick(this);
	}
}
