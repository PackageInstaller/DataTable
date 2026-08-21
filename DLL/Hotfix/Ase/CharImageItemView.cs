using GameFramework.Runtime;
using UnityEngine.UI;

namespace Ase;

public class CharImageItemView : SelectItemView
{
	public Image icon;

	private CharImageItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<CharImageItemViewModel>(userData);
		BindingSet<CharImageItemView, CharImageItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((CharImageItemViewModel vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		viewModel = GetUserData<CharImageItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
