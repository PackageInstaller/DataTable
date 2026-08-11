using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroEquipItem : MonoBehaviour
{
	private bool isInit;

	public Image heroIcon;

	public GameObject UpRoot;

	public void Init(HeroEquipItemViewModel viewModel)
	{
		if (isInit)
		{
			RefreshData(viewModel);
			return;
		}
		BindingSet<HeroEquipItem, HeroEquipItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(heroIcon).For((Image v) => v.sprite).ToExpression((HeroEquipItemViewModel vm) => HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.BoardIcon, vm.HeroId))
			.WithConversion("ItemIcon");
		bindingSet.Bind(UpRoot).For((GameObject v) => v.activeSelf).To((HeroEquipItemViewModel vm) => vm.IsUp);
		bindingSet.Build();
		isInit = true;
	}

	public void RefreshData(HeroEquipItemViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
