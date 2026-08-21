using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PassportShowView : UGuiView
{
	[SerializeField]
	private LoopListView2 weaponList;

	[SerializeField]
	private RectTransform weaponRect;

	[SerializeField]
	private TabItemNormal btnOriginal;

	[SerializeField]
	private TabItemNormal btnMax;

	[SerializeField]
	private Image rarity;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private TextMeshProUGUI refine;

	[SerializeField]
	private UIStarGroup uiStarGroup;

	[SerializeField]
	private TextMeshProUGUI type;

	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private RectTransform root;

	[SerializeField]
	private GameObject attributeItem;

	[SerializeField]
	private GameObject entry;

	[SerializeField]
	private GameObject effectNameText;

	[SerializeField]
	private GameObject effectDescText;

	[SerializeField]
	private GameObject effectLine;

	[SerializeField]
	private GameObject descText;

	[SerializeField]
	private UIGameObjectSort uiGameObjectSort;

	private GameObject weaponShowObj;

	private string weaponPath = "";

	private PassportShowViewModel viewModel;

	public void Init(PassportShowViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<PassportShowView, PassportShowViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PassportShowViewModel vm) => vm.WeaponData.Name);
		bindingSet.Bind<TextMeshProUGUI>(refine).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PassportShowViewModel vm) => $"精炼{vm.WeaponData.WeaponRefine}阶");
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((PassportShowViewModel vm) => vm.WeaponData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(rarity).For((Image v) => v.sprite).ToExpression((PassportShowViewModel vm) => $"RarityBG_Large_{vm.WeaponData.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(type).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PassportShowViewModel vm) => vm.Type);
		bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PassportShowViewModel vm) => $"Lv.{vm.WeaponData.Level}<color=#d1bba6>/{vm.WeaponData.MaxLevel}</color>");
		bindingSet.Bind(this).For((PassportShowView v) => v.RefreshWeaponData).To((PassportShowViewModel vm) => vm.RefreshWeaponDataRequest);
		bindingSet.Bind(this).For((PassportShowView v) => v.LoadWeaponObj).To((PassportShowViewModel vm) => vm.RefreshWeaponObjRequest);
		bindingSet.Build();
		weaponList.InitListView(viewModel.WeaponItemDataList.Count, OnGetLevelItemByIndex);
		LoadWeaponObj();
		RefreshWeaponData();
		btnOriginal.Init(viewModel.BtnOriginLevel);
		btnMax.Init(viewModel.BtnMaxLevel);
	}

	public void RefreshWeaponData(object sender = null, InteractionEventArgs e = null)
	{
		if (viewModel.WeaponData != null)
		{
			RefreshRoot(viewModel.WeaponData);
			uiStarGroup.CurCount = viewModel.WeaponData.Star;
		}
	}

	private async void LoadWeaponObj(object sender = null, InteractionEventArgs e = null)
	{
		if (weaponShowObj != null)
		{
			UnityEngine.Object.Destroy(weaponShowObj);
		}
		weaponPath = AssetUtility.GetUIItemAsset("WeaponPrefabs/" + viewModel.WeaponData.Icon);
		GameObject gameObject = await InstantiateAsync(weaponPath, weaponRect);
		if (!(gameObject == null))
		{
			GameObject gameObject2 = gameObject;
			weaponShowObj = gameObject2;
			UIStarGroup componentInChildren = weaponShowObj.GetComponentInChildren<UIStarGroup>();
			if (componentInChildren != null)
			{
				componentInChildren.CurCount = viewModel.WeaponData.Star;
			}
		}
	}

	private void RefreshRoot(WeaponData weaponData)
	{
		if (weaponData == null)
		{
			return;
		}
		if (weaponShowObj != null)
		{
			UIStarGroup componentInChildren = weaponShowObj.GetComponentInChildren<UIStarGroup>();
			if (componentInChildren != null)
			{
				componentInChildren.CurCount = viewModel.WeaponData.Star;
			}
		}
		for (int i = 0; i < root.childCount; i++)
		{
			UnityEngine.Object.Destroy(root.GetChild(i).gameObject);
		}
		foreach (AttributeItemData attributeItemDatum in viewModel.AttributeItemData)
		{
			GameObject obj = UnityEngine.Object.Instantiate(attributeItem, root);
			obj.transform.GetComponent<AttributeItem>().Init(attributeItemDatum);
			obj.gameObject.SetActive(value: true);
		}
		foreach (EntryItemData entryItemDatum in viewModel.EntryItemData)
		{
			GameObject obj2 = UnityEngine.Object.Instantiate(entry, root);
			obj2.GetComponent<EntryItem>().Init(entryItemDatum);
			obj2.gameObject.SetActive(value: true);
		}
		if (weaponData.BuffIdList.Count > 0)
		{
			GameObject obj3 = UnityEngine.Object.Instantiate(effectNameText, root);
			((TMP_Text)obj3.GetComponent<TextMeshProUGUI>()).text = weaponData.EffectName.Replace("\\n", "\n");
			obj3.gameObject.SetActive(value: true);
			UnityEngine.Object.Instantiate(effectLine, root).gameObject.SetActive(value: true);
			GameObject obj4 = UnityEngine.Object.Instantiate(effectDescText, root);
			((TMP_Text)obj4.GetComponent<TextMeshProUGUI>()).text = weaponData.EffectDesc.Replace("\\n", "\n");
			obj4.gameObject.SetActive(value: true);
		}
		if (weaponData.Description != null && !weaponData.Description.Equals(""))
		{
			GameObject obj5 = UnityEngine.Object.Instantiate(descText, root);
			((TMP_Text)obj5.GetComponent<TextMeshProUGUI>()).text = weaponData.Description;
			obj5.gameObject.SetActive(value: true);
		}
		uiGameObjectSort.Sort();
	}

	private LoopListViewItem2 OnGetLevelItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.WeaponItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("WeaponItem");
		if (loopListViewItem != null)
		{
			WeaponItem component = loopListViewItem.GetComponent<WeaponItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.WeaponItemDataList[index]);
			}
			else
			{
				component.RefreshData(viewModel.WeaponItemDataList[index]);
			}
		}
		return loopListViewItem;
	}
}
