using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleResultFailWindow : BattleResultBaseWindow
{
	[SerializeField]
	private Button btnOpenHeroUpgrade;

	[SerializeField]
	private Button btnOpenWeaponUpgrade;

	[SerializeField]
	private Button btnOpenArmourUpgrade;

	[SerializeField]
	private Button btnOpenHeroTalent;

	private BattleResultViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<BattleResultViewModel>();
		BindingSet<BattleResultFailWindow, BattleResultViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnOpenHeroUpgrade).For((Button v) => v.onClick).To((BattleResultViewModel vm) => vm.OpenHeroCultivateCmd);
		bindingSet.Bind(btnOpenWeaponUpgrade).For((Button v) => v.onClick).To((BattleResultViewModel vm) => vm.OpenWeaponCmd);
		bindingSet.Bind(btnOpenArmourUpgrade).For((Button v) => v.onClick).To((BattleResultViewModel vm) => vm.OpenArmourCmd);
		bindingSet.Bind(btnOpenHeroTalent).For((Button v) => v.onClick).To((BattleResultViewModel vm) => vm.OpenHeroTalendCmd);
		bindingSet.Build();
	}
}
