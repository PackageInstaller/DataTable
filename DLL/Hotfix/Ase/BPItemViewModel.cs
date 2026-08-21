namespace Ase;

public class BPItemViewModel : OptionBase
{
	private BPData data;

	private bool isSelect;

	private int num;

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

	public BPData Data
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

	public int Num
	{
		get
		{
			return num;
		}
		set
		{
			Set(ref num, value, "Num");
		}
	}

	public BPItemViewModel()
	{
	}

	public BPItemViewModel(OptionBase parent, BPData data)
	{
		this.data = data;
		base.parent = parent;
	}

	public BPItemViewModel(OptionBase parent, BPData data, int count)
	{
		this.data = BPData.Create(data, count);
		base.parent = parent;
	}

	public void OnClick()
	{
		if (!isSelect)
		{
			IsSelect = true;
			parent?.ItemOnClick(this);
		}
	}
}
