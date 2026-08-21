using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DrawCardOptionalItem : UIView
{
	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject hero;

	[SerializeField]
	private Image heroIcon;

	[SerializeField]
	private Image heroRarity;

	[SerializeField]
	private Image heroAttribute;

	[SerializeField]
	private Image heroDestiny;

	[SerializeField]
	private GameObject selected1;

	[SerializeField]
	private Button previewHeroBtn;

	[SerializeField]
	private GameObject weapon;

	[SerializeField]
	private RectTransform weaponIcon;

	[SerializeField]
	private Image weaponEnumIcon;

	[SerializeField]
	private TextMeshProUGUI weaponEnumText;

	[SerializeField]
	private GameObject selected2;

	[SerializeField]
	private Button previewWeaponBtn;

	private DrawCardOptionalItemData viewModel;

	private GameObject createObj;

	private string loadedWeaponIconKey;

	private int weaponLoadToken;

	public void Init(DrawCardOptionalItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<DrawCardOptionalItem, DrawCardOptionalItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((DrawCardOptionalItemData vm) => vm.OnClick);
		bindingSet.Bind(selected1).For((GameObject v) => v.activeSelf).To((DrawCardOptionalItemData vm) => vm.IsSelected);
		bindingSet.Bind(selected2).For((GameObject v) => v.activeSelf).To((DrawCardOptionalItemData vm) => vm.IsSelected);
		bindingSet.Bind(hero).For((GameObject v) => v.activeSelf).ToExpression((DrawCardOptionalItemData vm) => vm.ItemType == 4);
		bindingSet.Bind(heroIcon).For((Image v) => v.sprite).ToExpression((DrawCardOptionalItemData vm) => vm.ItemIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(heroRarity).For((Image v) => v.sprite).ToExpression((DrawCardOptionalItemData vm) => $"hero_rarity_tag_{vm.ItemRarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(heroAttribute).For((Image v) => v.sprite).ToExpression((DrawCardOptionalItemData vm) => $"hero_attr_{vm.HeroAttribute}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(heroDestiny).For((Image v) => v.sprite).ToExpression((DrawCardOptionalItemData vm) => $"Hero_Seat_{vm.HeroDestiny}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(weapon).For((GameObject v) => v.activeSelf).ToExpression((DrawCardOptionalItemData vm) => vm.ItemType == 5);
		bindingSet.Bind(weaponEnumIcon).For((Image v) => v.sprite).ToExpression((DrawCardOptionalItemData vm) => $"WeaponIcon_{vm.WeaponEnum}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(weaponEnumText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardOptionalItemData vm) => vm.WeaponEnumText);
		bindingSet.Bind(previewHeroBtn).For((Button v) => v.onClick).To((DrawCardOptionalItemData vm) => vm.OpenPreview);
		bindingSet.Bind(previewWeaponBtn).For((Button v) => v.onClick).To((DrawCardOptionalItemData vm) => vm.OpenPreview);
		bindingSet.Build();
		LoadHeroItem();
		RefreshWeaponIcon();
	}

	private async void LoadHeroItem()
	{
		if (viewModel.ItemType == 5)
		{
			string uIItemAsset = AssetUtility.GetUIItemAsset("WeaponPrefabs/" + viewModel.ItemIcon);
			createObj = await GameEntry.Resource.InstantiateAsync(uIItemAsset, weaponIcon);
		}
	}

	public void RefreshOptionalItemData(DrawCardOptionalItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
		RefreshWeaponIcon();
	}

	private async void RefreshWeaponIcon()
	{
		if (weaponIcon == null)
		{
			return;
		}
		if (viewModel == null || viewModel.ItemType != 5 || string.IsNullOrEmpty(viewModel.ItemIcon))
		{
			ClearWeaponIconChildren();
		}
		else
		{
			if (createObj != null && loadedWeaponIconKey == viewModel.ItemIcon)
			{
				return;
			}
			ClearWeaponIconChildren();
			string requestIconKey = viewModel.ItemIcon;
			int token = weaponLoadToken;
			loadedWeaponIconKey = requestIconKey;
			string uIItemAsset = AssetUtility.GetUIItemAsset("WeaponPrefabs/" + requestIconKey);
			GameObject gameObject = await GameEntry.Resource.InstantiateAsync(uIItemAsset, weaponIcon);
			if (token != weaponLoadToken || viewModel == null || viewModel.ItemType != 5 || viewModel.ItemIcon != requestIconKey || weaponIcon == null)
			{
				if (gameObject != null)
				{
					UnityEngine.Object.Destroy(gameObject);
				}
			}
			else
			{
				createObj = gameObject;
			}
		}
	}

	private void ClearWeaponIconChildren()
	{
		weaponLoadToken++;
		loadedWeaponIconKey = null;
		if (createObj != null)
		{
			UnityEngine.Object.Destroy(createObj);
			createObj = null;
		}
		if (!(weaponIcon != null))
		{
			return;
		}
		for (int num = weaponIcon.childCount - 1; num >= 0; num--)
		{
			Transform child = weaponIcon.GetChild(num);
			if (child != null)
			{
				UnityEngine.Object.Destroy(child.gameObject);
			}
		}
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		ClearWeaponIconChildren();
	}
}
