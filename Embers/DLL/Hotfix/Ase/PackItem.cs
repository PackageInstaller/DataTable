using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PackItem : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI itemName;

	[SerializeField]
	private TextMeshProUGUI itemDesc;

	[SerializeField]
	private TextMeshProUGUI itemCount;

	[SerializeField]
	private TextMeshProUGUI itemTotal;

	[SerializeField]
	private Transform weaponObjPos;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image itemRarity;

	[SerializeField]
	private GameObject selectObj;

	[SerializeField]
	private Button btn;

	private PackItemData viewModel;

	private GameObject createObj;

	public void Init(PackItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<PackItem, PackItemData> bindingSet = this.CreateBindingSet(this.viewModel);
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((PackItemData vm) => vm.ItemIcon)
				.WithConversion("ItemIcon");
		}
		if (itemRarity != null)
		{
			bindingSet.Bind(itemRarity).For((Image v) => v.sprite).ToExpression((PackItemData vm) => $"RarityBG_Large_{vm.ItemRarity}")
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)itemCount != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(itemCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PackItemData vm) => vm.ItemCount);
		}
		if ((UnityEngine.Object)(object)itemTotal != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(itemTotal).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PackItemData vm) => vm.ItemTotal);
		}
		if (selectObj != null)
		{
			bindingSet.Bind(selectObj).For((GameObject v) => v.activeSelf).To((PackItemData vm) => vm.Select);
		}
		bindingSet.Bind<TextMeshProUGUI>(itemName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PackItemData vm) => vm.ItemName);
		bindingSet.Bind<TextMeshProUGUI>(itemDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PackItemData vm) => vm.ItemDesc);
		bindingSet.Bind<TextMeshProUGUI>(itemName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PackItemData vm) => vm.ItemName);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((PackItemData vm) => vm.OnClick);
		bindingSet.Build();
		LoadImg();
	}

	private async void LoadImg()
	{
		if (viewModel.ItemType == 5)
		{
			string uIItemAsset = AssetUtility.GetUIItemAsset("WeaponPrefabs/" + viewModel.ItemIcon);
			createObj = await InstantiateAsync(uIItemAsset, weaponObjPos);
		}
	}

	public void RefreshPackItemData(PackItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}

	protected override void OnDestroy()
	{
		if (createObj != null)
		{
			UnityEngine.Object.Destroy(createObj);
		}
		base.OnDestroy();
	}
}
