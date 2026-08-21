using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HomeComeSignRewardCellView : UGuiView
{
	[SerializeField]
	private Image rewardImg;

	[SerializeField]
	private GameObject state;

	[SerializeField]
	private Button button;

	private HomeComeSignRewardCellViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<HomeComeSignRewardCellViewModel>(userData);
		BindingSet<HomeComeSignRewardCellView, HomeComeSignRewardCellViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (rewardImg != null)
		{
			bindingSet.Bind(rewardImg).For((Image v) => v.sprite).ToExpression((HomeComeSignRewardCellViewModel vm) => vm.Icon)
				.WithConversion("ItemIcon");
		}
		if (state != null)
		{
			bindingSet.Bind(state).For((GameObject v) => v.activeSelf).To((HomeComeSignRewardCellViewModel vm) => vm.ShowState);
		}
		if (button != null)
		{
			bindingSet.Bind(button).For((Button v) => v.onClick).To((HomeComeSignRewardCellViewModel vm) => vm.ClickCommand);
		}
		bindingSet.Build();
	}

	public void RefreshData(HomeComeSignRewardCellViewModel data)
	{
		viewModel = data;
		this.SetDataContext(data);
	}
}
