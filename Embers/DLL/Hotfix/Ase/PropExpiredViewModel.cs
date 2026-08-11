using System.Collections.Generic;

namespace Ase;

public class PropExpiredViewModel : OptionBase
{
	private List<PropDataBase> _expiredDataList = new List<PropDataBase>();

	public List<PropDataBase> ExpiredDataList => _expiredDataList;

	public PropExpiredViewModel()
	{
	}

	public PropExpiredViewModel(OptionBase parent, List<PropDataBase> expiredDataList)
	{
		base.parent = parent;
		_expiredDataList = expiredDataList;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else
		{
			parent?.ItemOnClick(obj);
		}
	}
}
