using GameFramework.Runtime;
using UnityEngine.UI;

namespace Ase;

public class CopyBuffItemView : UGuiView
{
	public Button btn;

	public Image icon;

	private CopyBuffItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		if (btn == null)
		{
			btn = GetComponent<Button>();
		}
		if (icon == null)
		{
			icon = GetComponent<Image>();
		}
		viewModel = new CopyBuffItemViewModel();
		BindingSet<CopyBuffItemView, CopyBuffItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((CopyBuffItemViewModel vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Build();
	}

	public void SetIcon(int buffIcon)
	{
		if (viewModel == null)
		{
			viewModel = new CopyBuffItemViewModel();
		}
		viewModel.Icon = $"boss_property_{buffIcon}";
	}
}
