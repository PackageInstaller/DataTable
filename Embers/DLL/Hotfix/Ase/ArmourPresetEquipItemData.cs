namespace Ase;

public class ArmourPresetEquipItemData : OptionBase
{
	private readonly int position;

	private ArmourData armourData;

	private ArmourItemData armourItemData;

	private bool isEmpty;

	private bool isBar;

	private bool showRedPoint;

	private string positionName;

	private string emptyIconPath;

	public int Position => position;

	public ArmourData ArmourData
	{
		get
		{
			return armourData;
		}
		private set
		{
			Set(ref armourData, value, "ArmourData");
		}
	}

	public ArmourItemData ArmourItemData
	{
		get
		{
			return armourItemData;
		}
		private set
		{
			Set(ref armourItemData, value, "ArmourItemData");
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

	public bool IsBar
	{
		get
		{
			return isBar;
		}
		private set
		{
			Set(ref isBar, value, "IsBar");
		}
	}

	public bool ShowRedPoint
	{
		get
		{
			return showRedPoint;
		}
		private set
		{
			Set(ref showRedPoint, value, "ShowRedPoint");
		}
	}

	public string PositionName
	{
		get
		{
			return positionName;
		}
		private set
		{
			Set(ref positionName, value, "PositionName");
		}
	}

	public string EmptyIconPath
	{
		get
		{
			return emptyIconPath;
		}
		private set
		{
			Set(ref emptyIconPath, value, "EmptyIconPath");
		}
	}

	public ArmourPresetEquipItemData(OptionBase parent, int position, ArmourData armourData, bool showEmptyRedPoint = false)
	{
		base.parent = parent;
		this.position = position;
		IsBar = false;
		PositionName = (UiConvert.Equip.ArmourEnum2Name.TryGetValue((ArmourEnum)position, out var value) ? value : string.Empty);
		EmptyIconPath = $"ArmourEnum_{position}";
		Refresh(armourData);
		ShowRedPoint = IsEmpty & showEmptyRedPoint;
	}

	public ArmourPresetEquipItemData(OptionBase parent)
	{
		base.parent = parent;
		position = -1;
		IsBar = true;
		IsEmpty = false;
		ShowRedPoint = false;
		PositionName = string.Empty;
		EmptyIconPath = string.Empty;
	}

	public void Refresh(ArmourData data)
	{
		if (!IsBar)
		{
			ArmourData = data;
			IsEmpty = data == null;
			ArmourItemData = ((data == null) ? null : new ArmourItemData(this, data, data.GetOwnerId()));
		}
	}

	public void OnClick()
	{
		if (!IsBar)
		{
			parent?.ItemOnClick(this);
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is ArmourItemData)
		{
			OnClick();
		}
		else
		{
			base.ItemOnClick(obj);
		}
	}
}
