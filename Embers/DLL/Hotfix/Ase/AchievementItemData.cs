namespace Ase;

public class AchievementItemData : OptionBase
{
	private string title1;

	private string title2;

	private int rate;

	private float fill;

	private string img;

	private int type;

	private bool showRedPoint;

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

	public string Title1
	{
		get
		{
			return title1;
		}
		set
		{
			Set(ref title1, value, "Title1");
		}
	}

	public string Title2
	{
		get
		{
			return title2;
		}
		set
		{
			Set(ref title2, value, "Title2");
		}
	}

	public int Rate
	{
		get
		{
			return rate;
		}
		set
		{
			Set(ref rate, value, "Rate");
		}
	}

	public float Fill
	{
		get
		{
			return fill;
		}
		set
		{
			Set(ref fill, value, "Fill");
		}
	}

	public int Type
	{
		get
		{
			return type;
		}
		set
		{
			Set(ref type, value, "Type");
		}
	}

	public bool ShowRedPoint
	{
		get
		{
			return showRedPoint;
		}
		set
		{
			Set(ref showRedPoint, value, "ShowRedPoint");
		}
	}

	public AchievementItemData(OptionBase parent, string title1, string title2, int rate, string img, int type, bool showRedPoint)
	{
		base.parent = parent;
		this.title1 = title1;
		this.title2 = title2;
		this.rate = rate;
		fill = (float)rate / 100f;
		this.img = img;
		this.type = type;
		this.showRedPoint = showRedPoint;
	}

	public void OnClick()
	{
		parent?.ItemOnClick(new OptionArg(this, "OpenAchieve"));
	}
}
