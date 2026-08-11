using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityPackItem : UGuiView
{
	[SerializeField]
	private KnapsackItemNew prop;

	[SerializeField]
	private GameObject canGet;

	[SerializeField]
	private GameObject got;

	[SerializeField]
	private Button button;

	private ActivityPackItemData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<ActivityPackItemData>(userData);
		BindingSet<ActivityPackItem, ActivityPackItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if (canGet != null)
		{
			bindingSet.Bind(canGet).For((GameObject v) => v.activeSelf).To((ActivityPackItemData vm) => vm.Highlight);
		}
		if (got != null)
		{
			bindingSet.Bind(got).For((GameObject v) => v.activeSelf).To((ActivityPackItemData vm) => vm.Received);
		}
		if (button != null)
		{
			bindingSet.Bind(button).For((Button v) => v.onClick).To((ActivityPackItemData vm) => vm.OnItemClick);
		}
		bindingSet.Build();
		if (prop != null)
		{
			prop.Init(new KnapsackItemViewModel((OptionBase)_viewModel.Parent, _viewModel.PropDataBase));
		}
	}
}
