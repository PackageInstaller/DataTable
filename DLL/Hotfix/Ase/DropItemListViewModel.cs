using System.Collections.Generic;

namespace Ase;

public class DropItemListViewModel : OptionBase
{
	private List<InteractivePointData> _pointDatas = new List<InteractivePointData>();

	public List<InteractivePointData> PointDatas
	{
		get
		{
			return _pointDatas;
		}
		set
		{
			_pointDatas = value;
		}
	}

	public DropItemListViewModel(OptionBase parent)
	{
		base.parent = parent;
	}

	public DropItemListViewModel()
	{
	}

	public void Hide()
	{
		parent.ItemOnClick(this);
	}

	public override void ItemOnClick(object obj)
	{
		parent.ItemOnClick(obj);
	}
}
