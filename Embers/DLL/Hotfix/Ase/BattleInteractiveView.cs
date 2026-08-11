using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleInteractiveView : UGuiView
{
	public Image icon;

	public Image iconSlider;

	public Button interactiveButton;

	private BattleInteractiveViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<BattleInteractiveViewModel>(userData);
		BindingSet<BattleInteractiveView, BattleInteractiveViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((BattleInteractiveViewModel vm) => vm.IconType)
			.WithConversion("ItemIcon");
		bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).To((BattleInteractiveViewModel vm) => vm.Active);
		bindingSet.Bind(interactiveButton).For((Button v) => v.onClick).To((BattleInteractiveViewModel vm) => vm.OnInteractiveButtonClickCommand);
		bindingSet.Bind(iconSlider.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleInteractiveViewModel vm) => vm.Process > 0f);
		bindingSet.Bind(iconSlider).For((Image v) => v.fillAmount).To((BattleInteractiveViewModel vm) => vm.Process);
		bindingSet.Bind().For((BattleInteractiveView v) => v.OnIconTypeUpdatRequest).To((BattleInteractiveViewModel vm) => vm.OnIconTypeUpdatRequest);
		bindingSet.Build();
	}

	private void OnIconTypeUpdatRequest(object sender, InteractionEventArgs e)
	{
		icon.SetNativeSize();
	}
}
