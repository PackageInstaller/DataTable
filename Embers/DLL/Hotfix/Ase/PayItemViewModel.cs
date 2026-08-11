namespace Ase;

public class PayItemViewModel : OptionBase
{
	private bool isFirst;

	private DRPay drPay;

	private string priceText;

	private string name;

	private int diamond;

	private int diamondAdd;

	private string icon;

	public bool IsFirst
	{
		get
		{
			return isFirst;
		}
		private set
		{
			Set(ref isFirst, value, "IsFirst");
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

	public string PriceText
	{
		get
		{
			return priceText;
		}
		private set
		{
			Set(ref priceText, value, "PriceText");
		}
	}

	public int Diamond
	{
		get
		{
			return diamond;
		}
		private set
		{
			Set(ref diamond, value, "Diamond");
		}
	}

	public int DiamondAdd
	{
		get
		{
			return diamondAdd;
		}
		private set
		{
			Set(ref diamondAdd, value, "DiamondAdd");
		}
	}

	public string Icon
	{
		get
		{
			return icon;
		}
		private set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public int Id => drPay.Id;

	public int Price => drPay.Price;

	public PayItemViewModel()
	{
	}

	public PayItemViewModel(OptionBase parent, DRPay drPay, bool isFirst, string name)
	{
		base.parent = parent;
		this.isFirst = isFirst;
		this.name = name;
		this.drPay = drPay;
		priceText = drPay.PriceUI;
		diamond = drPay.Diamond;
		diamondAdd = (isFirst ? drPay.FirstDiamondAdd : drPay.DiamondAdd);
		icon = drPay.Icon;
	}

	public void OnPay()
	{
		parent.ItemOnClick(new OptionArg(this, "OnPay"));
	}

	public void UpdateFirst(bool isFirst)
	{
		IsFirst = isFirst;
		DiamondAdd = (isFirst ? drPay.FirstDiamondAdd : drPay.DiamondAdd);
	}
}
