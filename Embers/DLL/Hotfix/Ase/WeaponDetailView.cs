using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class WeaponDetailView : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private TextMeshProUGUI weaponEnum;

	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private UIStarGroup star;

	[SerializeField]
	private Button lockBtn;

	[SerializeField]
	private GameObject lockNormal;

	[SerializeField]
	private GameObject lockSelected;

	[SerializeField]
	private TextMeshProUGUI refineText;

	[SerializeField]
	private RectTransform root;

	[SerializeField]
	private GameObject attributeItem;

	[SerializeField]
	private GameObject entryItem;

	[SerializeField]
	private GameObject effectNameText;

	[SerializeField]
	private GameObject effectDescText;

	[SerializeField]
	private GameObject effectLine;

	[SerializeField]
	private GameObject descText;

	[SerializeField]
	private GameObject disBtn;

	[SerializeField]
	private Button leftBtn;

	[SerializeField]
	private GameObject leftBtnObj;

	[SerializeField]
	private TextMeshProUGUI leftButtonText;

	[SerializeField]
	private Button rightBtn;

	[SerializeField]
	private TextMeshProUGUI rightButtonText;

	[SerializeField]
	private GameObject heroImgObj;

	[SerializeField]
	private Image heroImg;

	[SerializeField]
	private TextMeshProUGUI heroName;

	[SerializeField]
	private UIGameObjectSort uiGameObjectSort;

	private WeaponDetailViewModel _viewModel;

	public void Init(WeaponDetailViewModel viewModel)
	{
		_viewModel = viewModel;
		BindingSet<WeaponDetailView, WeaponDetailViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((WeaponDetailViewModel vm) => vm.WeaponData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((WeaponDetailViewModel vm) => $"RarityBG_Middle_{vm.WeaponData.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponDetailViewModel vm) => vm.WeaponData.Name);
		bindingSet.Bind<TextMeshProUGUI>(weaponEnum).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponDetailViewModel vm) => vm.WeaponEnumName);
		bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((WeaponDetailViewModel vm) => $"{vm.WeaponData.Level}<size=32><color=#7F766E>/{vm.WeaponData.MaxLevel}</color></size>");
		bindingSet.Bind(lockNormal).For((GameObject v) => v.activeSelf).ToExpression((WeaponDetailViewModel vm) => !vm.WeaponData.IsLock);
		bindingSet.Bind(lockSelected).For((GameObject v) => v.activeSelf).To((WeaponDetailViewModel vm) => vm.WeaponData.IsLock);
		bindingSet.Bind<TextMeshProUGUI>(refineText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((WeaponDetailViewModel vm) => $"精炼{vm.WeaponData.WeaponRefine}阶");
		bindingSet.Bind<TextMeshProUGUI>(leftButtonText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponDetailViewModel vm) => vm.LeftBtnText);
		bindingSet.Bind<TextMeshProUGUI>(rightButtonText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponDetailViewModel vm) => vm.RightBtnText);
		bindingSet.Bind(leftBtnObj).For((GameObject v) => v.activeSelf).To((WeaponDetailViewModel vm) => vm.IsShowChange);
		if (heroImgObj != null)
		{
			bindingSet.Bind(heroImgObj).For((GameObject v) => v.activeSelf).To((WeaponDetailViewModel vm) => vm.ShowHero);
			bindingSet.Bind(heroImg).For((Image v) => v.sprite).ToExpression((WeaponDetailViewModel vm) => vm.HeroImg)
				.WithConversion("ItemIcon");
			bindingSet.Bind<TextMeshProUGUI>(heroName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponDetailViewModel vm) => vm.HeroName);
		}
		bindingSet.Bind(this).For((WeaponDetailView v) => v.RefreshWeapon).To((WeaponDetailViewModel vm) => vm.RefreshDatasRequest);
		if (!viewModel.isPreview)
		{
			bindingSet.Bind(leftBtn).For((Button v) => v.onClick).To((WeaponDetailViewModel vm) => vm.LeftBtnCmd);
			bindingSet.Bind(rightBtn).For((Button v) => v.onClick).To((WeaponDetailViewModel vm) => vm.RightBtnCmd);
		}
		if (!viewModel.IsSelf && !viewModel.isPreview)
		{
			bindingSet.Bind(leftBtn.gameObject).For((GameObject v) => v.activeSelf).To((WeaponDetailViewModel vm) => vm.IsSelf);
			bindingSet.Bind(rightBtn.gameObject).For((GameObject v) => v.activeSelf).To((WeaponDetailViewModel vm) => vm.IsSelf);
			bindingSet.Bind(disBtn).For((GameObject v) => v.activeSelf).To((WeaponDetailViewModel vm) => vm.IsSelf);
		}
		bindingSet.Build();
		star.CurCount = viewModel.WeaponData.Star;
		if (_viewModel.isPreview)
		{
			leftBtn.gameObject.SetActive(value: false);
			rightBtn.gameObject.SetActive(value: false);
			lockBtn.gameObject.SetActive(value: false);
			disBtn.SetActive(value: false);
		}
		else
		{
			lockBtn.onClick.AddListener(viewModel.Lock);
		}
		RefreshData();
	}

	private void RefreshWeapon(object sender, InteractionEventArgs e)
	{
		RefreshData();
	}

	public void RefreshData()
	{
		RefreshAttribute(_viewModel.WeaponData);
		star.CurCount = _viewModel.WeaponData.Star;
	}

	private void RefreshAttribute(WeaponData weaponData)
	{
		if (weaponData != null)
		{
			for (int i = 0; i < root.childCount; i++)
			{
				UnityEngine.Object.Destroy(root.GetChild(i).gameObject);
			}
			for (int j = 0; j < _viewModel.WeaponData.EquipAttributeList.Count; j++)
			{
				GameObject obj = UnityEngine.Object.Instantiate(attributeItem, root);
				obj.GetComponent<AttributeItem>().Init(_viewModel.AttributeItemData[j]);
				obj.gameObject.SetActive(value: true);
			}
			for (int k = 0; k < _viewModel.WeaponData.EntryDataList.Count; k++)
			{
				GameObject obj2 = UnityEngine.Object.Instantiate(entryItem, root);
				obj2.GetComponent<EntryItem>().Init(_viewModel.EntryItemData[k]);
				obj2.gameObject.SetActive(value: true);
			}
			if (weaponData.BuffIdList.Count > 0)
			{
				GameObject obj3 = UnityEngine.Object.Instantiate(effectNameText, root);
				((TMP_Text)obj3.GetComponent<TextMeshProUGUI>()).text = weaponData.EffectName;
				obj3.gameObject.SetActive(value: true);
				UnityEngine.Object.Instantiate(effectLine, root).gameObject.SetActive(value: true);
				GameObject obj4 = UnityEngine.Object.Instantiate(effectDescText, root);
				((TMP_Text)obj4.GetComponent<TextMeshProUGUI>()).text = weaponData.EffectDesc;
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
	}

	protected override void OnDestroy()
	{
		for (int i = 0; i < root.childCount; i++)
		{
			UnityEngine.Object.Destroy(root.GetChild(i).gameObject);
		}
		base.OnDestroy();
	}
}
