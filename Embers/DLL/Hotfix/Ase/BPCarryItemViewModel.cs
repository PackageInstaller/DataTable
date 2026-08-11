namespace Ase;

public class BPCarryItemViewModel : OptionBase
{
	private BPData data;

	private bool isEmpty;

	private string icon;

	private bool isSelect;

	private bool canAdd = true;

	private int num;

	private int count;

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

	public int Num
	{
		get
		{
			return num;
		}
		private set
		{
			Set(ref num, value, "Num");
		}
	}

	public int Count
	{
		get
		{
			return count;
		}
		private set
		{
			Set(ref count, value, "Count");
		}
	}

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

	public bool CanAdd
	{
		get
		{
			return canAdd;
		}
		private set
		{
			Set(ref canAdd, value, "CanAdd");
		}
	}

	public bool IsEmpty
	{
		get
		{
			return isEmpty;
		}
		private set
		{
			Set(ref isEmpty, value, "IsEmpty");
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

	public BPCarryItemViewModel(OptionBase parent, BPData data, int num)
	{
		base.parent = parent;
		this.data = data;
		this.num = num;
		icon = ((data == null) ? "" : data.Icon);
		count = data?.Count ?? 0;
		isEmpty = data == null;
	}

	public BPCarryItemViewModel()
	{
	}

	public void ClearData()
	{
		Data = null;
		Icon = "";
		Count = 0;
		IsEmpty = true;
	}

	public void OnClick()
	{
		parent?.ItemOnClick(this);
	}

	public void RefreshData(BPData data)
	{
		this.data = data;
		Icon = ((data == null) ? "" : data.Icon);
		IsEmpty = data == null;
		Count = data?.Count ?? 0;
	}

	public void SetSelect(bool val)
	{
		IsSelect = val;
	}

	public void SetCanAdd(bool val)
	{
		CanAdd = val;
	}
}
