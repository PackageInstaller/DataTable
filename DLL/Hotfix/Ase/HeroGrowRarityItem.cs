using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroGrowRarityItem : UGuiView
{
	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject itemBgBlack;

	[SerializeField]
	private GameObject itemBgBrown;

	[SerializeField]
	private GameObject itemBgYellow;

	[SerializeField]
	private Image itemIcon;

	[SerializeField]
	private GameObject itemLock;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private GameObject red;

	[SerializeField]
	private GameObject lightLine;

	[SerializeField]
	private GameObject lightEffect;

	[SerializeField]
	private List<GameObject> hideGosInPreview;

	public float lightEffectTime = 1.5f;

	private HeroGrowRarityItemData itemData;

	public void Init(HeroGrowRarityItemData data)
	{
		lightEffect.SetActive(value: false);
		itemData = data;
		BindingSet<HeroGrowRarityItem, HeroGrowRarityItemData> bindingSet = this.CreateBindingSet(data);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((HeroGrowRarityItemData vm) => vm.OnClick);
		bindingSet.Bind(itemBgBlack).For((GameObject v) => v.activeSelf).ToExpression((HeroGrowRarityItemData vm) => vm.State.Equals(HeroGrowRarityItemData.ItemStateEnum.Lock) || vm.State.Equals(HeroGrowRarityItemData.ItemStateEnum.NotEnough));
		bindingSet.Bind(itemBgBrown).For((GameObject v) => v.activeSelf).ToExpression((HeroGrowRarityItemData vm) => vm.State.Equals(HeroGrowRarityItemData.ItemStateEnum.Enough));
		bindingSet.Bind(itemBgYellow).For((GameObject v) => v.activeSelf).ToExpression((HeroGrowRarityItemData vm) => vm.State.Equals(HeroGrowRarityItemData.ItemStateEnum.Lighted));
		bindingSet.Bind(itemIcon).For((Image v) => v.sprite).To((HeroGrowRarityItemData vm) => vm.ItemIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(itemLock).For((GameObject v) => v.activeSelf).ToExpression((HeroGrowRarityItemData vm) => vm.State.Equals(HeroGrowRarityItemData.ItemStateEnum.Lock));
		bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((HeroGrowRarityItemData vm) => vm.Selected);
		bindingSet.Bind(red).For((GameObject v) => v.activeSelf).To((HeroGrowRarityItemData vm) => vm.ShowRed);
		bindingSet.Bind(lightLine).For((GameObject v) => v.activeSelf).ToExpression((HeroGrowRarityItemData vm) => vm.State.Equals(HeroGrowRarityItemData.ItemStateEnum.Lighted));
		bindingSet.Build();
	}

	public void RefreshData(int index, DRHeroSeat config, int destinyLevel, List<int> destinyData)
	{
		itemData.RefreshData(index, config, destinyLevel, destinyData);
	}

	public void OnLighted()
	{
		lightEffect.SetActive(value: false);
		lightEffect.SetActive(value: true);
		Invoke("HideLightEffect", lightEffectTime);
		itemData.OnLighted();
	}

	private void HideLightEffect()
	{
		lightEffect.SetActive(value: false);
	}

	public void RefreshItemState(int destinyLevel, List<int> destinyData)
	{
		itemData.RefreshItemState(destinyLevel, destinyData);
	}

	public void SetInPreviewMode(bool inPreview)
	{
		if (hideGosInPreview == null)
		{
			return;
		}
		foreach (GameObject item in hideGosInPreview)
		{
			if (item != null)
			{
				item.SetActive(!inPreview);
			}
		}
	}
}
