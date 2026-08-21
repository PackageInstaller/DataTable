using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AddHeroItemView : UGuiView
{
	[SerializeField]
	private Button btnAddHero;

	private AddHeroItemViewModel viewModel;

	public void Init(AddHeroItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<AddHeroItemView, AddHeroItemViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(btnAddHero).For((Button v) => v.onClick).To((AddHeroItemViewModel vm) => vm.AddHero);
		bindingSet.Bind(btnAddHero.gameObject).For((GameObject v) => v.activeSelf).To((AddHeroItemViewModel vm) => vm.IsSelf);
		bindingSet.Build();
	}

	public void RefreshData(AddHeroItemViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
