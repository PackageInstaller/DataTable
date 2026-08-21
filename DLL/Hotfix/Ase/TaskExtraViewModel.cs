namespace Ase;

public class TaskExtraViewModel : OptionBase
{
	private string img;

	public string Img
	{
		get
		{
			return img;
		}
		set
		{
			Set(ref img, value, "Img");
		}
	}

	public override void ItemOnClick(object obj)
	{
	}

	public TaskExtraViewModel()
	{
	}

	public TaskExtraViewModel(OptionBase parent)
	{
		base.parent = parent;
	}

	public void SetImg(string img)
	{
		Img = img;
	}

	public override void Close()
	{
		parent.ItemOnClick(this);
	}
}
