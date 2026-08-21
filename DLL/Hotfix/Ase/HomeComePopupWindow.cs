using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HomeComePopupWindow : UGuiWindow
{
	[SerializeField]
	private Button claimButton;

	private HomeComePopupWindowViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<HomeComePopupWindowViewModel>();
		if (viewModel == null)
		{
			viewModel = new HomeComePopupWindowViewModel();
		}
		BindingSet<HomeComePopupWindow, HomeComePopupWindowViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((HomeComePopupWindow v) => v.OnDismissRequest).To((HomeComePopupWindowViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((HomeComePopupWindow v) => v.OpenUguiWindow).To((HomeComePopupWindowViewModel vm) => vm.OpenWindowRequest);
		if (claimButton != null)
		{
			bindingSet.Bind(claimButton).For((Button v) => v.onClick).To((HomeComePopupWindowViewModel vm) => vm.ClaimOrCloseCommand);
		}
		bindingSet.Build();
	}

	private Button EnsureButton(GameObject go)
	{
		Button button = go.GetComponent<Button>();
		if (button == null)
		{
			button = go.AddComponent<Button>();
		}
		Graphic component = go.GetComponent<Graphic>();
		if (component != null)
		{
			component.raycastTarget = true;
			if (button.targetGraphic == null)
			{
				button.targetGraphic = component;
			}
		}
		return button;
	}

	protected override void OnDestroy()
	{
		viewModel?.Dispose();
		viewModel = null;
		base.OnDestroy();
	}
}
