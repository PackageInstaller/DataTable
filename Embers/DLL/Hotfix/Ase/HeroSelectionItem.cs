using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class HeroSelectionItem : HeroItem
{
	[SerializeField]
	private List<GameObject> fixPlayerIndex;

	[SerializeField]
	private GameObject heroTryTag;

	[SerializeField]
	private GameObject seatLockTag;

	public new void Init(HeroItemViewModel viewModel)
	{
		base.Init(viewModel);
		BindingSet<HeroSelectionItem, HeroItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (heroTryTag != null)
		{
			bindingSet.Bind(heroTryTag).For((GameObject v) => v.activeSelf).To((HeroItemViewModel vm) => vm.HeroTryTag);
		}
		if (seatLockTag != null)
		{
			bindingSet.Bind(seatLockTag).For((GameObject v) => v.activeSelf).To((HeroItemViewModel vm) => vm.SeatLockTag);
		}
		if (fixPlayerIndex != null)
		{
			for (int num = 0; num < fixPlayerIndex.Count; num++)
			{
				int index = num;
				bindingSet.Bind(fixPlayerIndex[num]).For((GameObject v) => v.activeSelf).ToExpression((HeroItemViewModel vm) => vm.SeatId - 1 == index);
			}
		}
		bindingSet.Build();
	}
}
