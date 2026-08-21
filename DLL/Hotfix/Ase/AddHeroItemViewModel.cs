namespace Ase;

public class AddHeroItemViewModel : OptionBase
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

	public override void ItemOnClick(object obj)
	{
	}

	public AddHeroItemViewModel()
	{
	}

	public AddHeroItemViewModel(OptionBase parent, bool isSelf)
	{
		base.parent = parent;
		this.isSelf = isSelf;
	}

	public void AddHero()
	{
		parent.ItemOnClick(this);
	}
}
