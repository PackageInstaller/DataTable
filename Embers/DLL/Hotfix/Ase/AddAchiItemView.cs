using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AddAchiItemView : UGuiView
{
	[SerializeField]
	private Button btnAddAchi;

	private AddAchiItemViewModel viewModel;

	public void Init(AddAchiItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<AddAchiItemView, AddAchiItemViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(btnAddAchi).For((Button v) => v.onClick).To((AddAchiItemViewModel vm) => vm.AddAchi);
		bindingSet.Bind(btnAddAchi.gameObject).For((GameObject v) => v.activeSelf).To((AddAchiItemViewModel vm) => vm.IsSelf);
		bindingSet.Build();
	}
}
