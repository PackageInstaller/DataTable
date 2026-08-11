using System.Collections.Generic;

namespace Ase;

public class ExpPropReturnViewModel : OptionBase
{
	private string _tips = "本次强化经验溢出，将返还以下材料，是否继续？";

	public bool result;

	private List<KnapsackItemViewModel> expPropList;

	public string Tips
	{
		get
		{
			return _tips;
		}
		private set
		{
			Set(ref _tips, value, "Tips");
		}
	}

	public List<KnapsackItemViewModel> ExpPropList => expPropList;

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
	}

	public ExpPropReturnViewModel()
	{
	}

	public ExpPropReturnViewModel(OptionBase parent, List<KnapsackPropData> propDatas)
	{
		base.parent = parent;
		expPropList = new List<KnapsackItemViewModel>();
		foreach (KnapsackPropData propData in propDatas)
		{
			expPropList.Add(new KnapsackItemViewModel(this, propData));
		}
	}

	public ExpPropReturnViewModel(OptionBase parent, List<PropDataBase> propDatas)
	{
		base.parent = parent;
		expPropList = new List<KnapsackItemViewModel>();
		foreach (PropDataBase propData in propDatas)
		{
			expPropList.Add(new KnapsackItemViewModel(this, propData));
		}
	}

	public void SetTips(string tips)
	{
		Tips = tips;
	}

	public void Cancel()
	{
		result = false;
		Close();
	}

	public void Confirm()
	{
		result = true;
		Close();
	}
}
