using GameFramework.Runtime;
using UnityEngine.UI;

namespace Ase;

public class TabItemView : SelectItemView
{
	public Image icon;

	private TabItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<TabItemViewModel>(userData);
		BindingSet<TabItemView, TabItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((TabItemViewModel vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		viewModel = GetUserData<TabItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
