using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AvatarItemView : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image iconFrame;

	[SerializeField]
	private Button btnSel;

	[SerializeField]
	private StateItem stateItem;

	[SerializeField]
	private GameObject selRoot;

	[SerializeField]
	private GameObject timeLimit;

	private AvatarItemViewModel viewModel;

	public void Init(AvatarItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<AvatarItemView, AvatarItemViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(btnSel).For((Button v) => v.onClick).To((AvatarItemViewModel vm) => vm.OnSelect);
		bindingSet.Bind(selRoot).For((GameObject v) => v.activeSelf).To((AvatarItemViewModel vm) => vm.IsSelect);
		bindingSet.Bind(stateItem).For((StateItem v) => v.CurState).To((AvatarItemViewModel vm) => vm.State);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((AvatarItemViewModel vm) => $"{vm.Icon}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(iconFrame).For((Image v) => v.sprite).ToExpression((AvatarItemViewModel vm) => $"HeadAdorn{vm.IconFrameId}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(timeLimit).For((GameObject v) => v.activeSelf).ToExpression((AvatarItemViewModel vm) => vm.TitleTimeLimitType != 1);
		bindingSet.Build();
	}

	public void RefreshData(AvatarItemViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
