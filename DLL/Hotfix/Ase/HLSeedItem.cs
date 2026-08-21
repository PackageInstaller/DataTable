using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HLSeedItem : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image rarity;

	[SerializeField]
	private GameObject lockObj;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject isSelected;

	[SerializeField]
	private GameObject redPoint;

	private HLSeedItemData viewModel;

	public void Init(HLSeedItemData viewModel)
	{
		this.viewModel = viewModel;
		Init((object)this.viewModel);
		BindingSet<HLSeedItem, HLSeedItemData> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((HLSeedItemData vm) => vm.SeedIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(rarity).For((Image v) => v.sprite).ToExpression((HLSeedItemData vm) => $"Rarity_Middle_{vm.SeedRarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(lockObj).For((GameObject v) => v.activeSelf).To((HLSeedItemData vm) => vm.IsLock);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((HLSeedItemData vm) => vm.OnClick);
		bindingSet.Bind(isSelected).For((GameObject v) => v.activeSelf).To((HLSeedItemData vm) => vm.IsSelected);
		bindingSet.Bind(redPoint).For((GameObject v) => v.activeSelf).To((HLSeedItemData vm) => vm.ShowRedPoint);
		bindingSet.Build();
	}

	public void RefreshSeedData(HLSeedItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
