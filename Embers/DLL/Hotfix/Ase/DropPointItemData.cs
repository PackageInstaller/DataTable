namespace Ase;

public class DropPointItemData : OptionBase
{
	private InteractivePointData _pointData = new InteractivePointData();

	private string _icon = "";

	private string _name;

	public InteractivePointData PointData => _pointData;

	public string Icon
	{
		get
		{
			return _icon;
		}
		set
		{
			Set(ref _icon, value, "Icon");
		}
	}

	public string Name
	{
		get
		{
			return _name;
		}
		set
		{
			Set(ref _name, value, "Name");
		}
	}

	public DropPointItemData(OptionBase parent, InteractivePointData pointData)
	{
		base.parent = parent;
		_pointData = pointData;
		Name = pointData.PointInfo.Name;
		Icon = InteractivePoint.GetPointIcon(pointData.PointInfo);
	}

	public void ItemOnClick()
	{
		parent.ItemOnClick(this);
	}
}
