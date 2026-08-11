using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class WeaponPopupView : UGuiView
{
	[SerializeField]
	private RectTransform mainPanel;

	[SerializeField]
	private Image titleBg;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private TextMeshProUGUI weaponName;

	[SerializeField]
	private UIStarGroup uiStarGroup;

	[SerializeField]
	private Image weaponImg;

	[SerializeField]
	private TextMeshProUGUI type;

	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private TextMeshProUGUI refineText;

	[SerializeField]
	private Button lockBtn;

	[SerializeField]
	private GameObject lockImg;

	[SerializeField]
	private GameObject unLockImg;

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

	[SerializeField]
	private GameObject heroInfoObj;

	[SerializeField]
	private Image heroImg;

	[SerializeField]
	private TextMeshProUGUI heroText;

	[SerializeField]
	private Button mask1;

	[SerializeField]
	private Button mask2;

	[SerializeField]
	private GameObject fillImg;

	private WeaponPopupViewModel _viewModel;

	public void Init(WeaponPopupViewModel viewModel)
	{
		_viewModel = viewModel;
		BindingSet<WeaponPopupView, WeaponPopupViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((WeaponPopupView v) => v.OnVisibleChanged).To((WeaponPopupViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind<TextMeshProUGUI>(weaponName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponPopupViewModel vm) => vm.WeaponData.Name);
		bindingSet.Bind(weaponImg).For((Image v) => v.sprite).ToExpression((WeaponPopupViewModel vm) => $"{vm.WeaponIconName}Info")
			.WithConversion("ItemIcon");
		bindingSet.Bind(titleBg).For((Image v) => v.sprite).ToExpression((WeaponPopupViewModel vm) => $"Prop_Title_{vm.WeaponData.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((WeaponPopupViewModel vm) => $"Prop_Bg_{vm.WeaponData.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(type).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponPopupViewModel vm) => vm.Type);
		bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((WeaponPopupViewModel vm) => $"Lv.{vm.WeaponData.Level}<color=#d1bba6>/{vm.WeaponData.MaxLevel}</color>");
		bindingSet.Bind<TextMeshProUGUI>(refineText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((WeaponPopupViewModel vm) => $"精炼{vm.WeaponData.WeaponRefine}阶");
		bindingSet.Bind(lockImg).For((GameObject v) => v.activeSelf).To((WeaponPopupViewModel vm) => vm.WeaponData.IsLock);
		bindingSet.Bind(unLockImg).For((GameObject v) => v.activeSelf).ToExpression((WeaponPopupViewModel vm) => !vm.WeaponData.IsLock);
		bindingSet.Bind(this).For((WeaponPopupView v) => v.RefreshWeaponData).To((WeaponPopupViewModel vm) => vm.RefreshDataRequest);
		bindingSet.Bind(mainPanel).For((RectTransform v) => v.anchoredPosition).To((WeaponPopupViewModel vm) => vm.ShowPos);
		bindingSet.Bind(mask1.gameObject).For((GameObject v) => v.activeSelf).To((WeaponPopupViewModel vm) => vm.ShowMask1);
		bindingSet.Bind(mask2.gameObject).For((GameObject v) => v.activeSelf).To((WeaponPopupViewModel vm) => vm.ShowMask2);
		bindingSet.Bind(mask1).For((Button v) => v.onClick).To((WeaponPopupViewModel vm) => vm.Hide);
		bindingSet.Bind(mask2).For((Button v) => v.onClick).To((WeaponPopupViewModel vm) => vm.Hide);
		if (heroInfoObj != null)
		{
			bindingSet.Bind(heroInfoObj).For((GameObject v) => v.activeSelf).ToExpression((WeaponPopupViewModel vm) => vm.ShowHeroInfo && !vm.HeroName.Equals(""));
			bindingSet.Bind(heroImg).For((Image v) => v.sprite).ToExpression((WeaponPopupViewModel vm) => vm.HeroImg)
				.WithConversion("ItemIcon");
			bindingSet.Bind<TextMeshProUGUI>(heroText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponPopupViewModel vm) => vm.HeroName);
		}
		bindingSet.Bind(lockBtn.gameObject).For((GameObject v) => v.activeSelf).To((WeaponPopupViewModel vm) => vm.ShowLockBtn);
		bindingSet.Build();
		lockBtn.onClick.AddListener(_viewModel.Lock);
		RefreshWeaponData();
	}

	public void RefreshWeaponData(object sender = null, InteractionEventArgs e = null)
	{
		if (_viewModel.WeaponData != null)
		{
			RefreshRoot(_viewModel.WeaponData);
			uiStarGroup.CurCount = _viewModel.WeaponData.Star;
		}
	}

	private void RefreshRoot(WeaponData weaponData)
	{
		if (weaponData == null)
		{
			return;
		}
		for (int i = 0; i < root.childCount; i++)
		{
			UnityEngine.Object.Destroy(root.GetChild(i).gameObject);
		}
		foreach (AttributeItemData attributeItemDatum in _viewModel.AttributeItemData)
		{
			GameObject obj = UnityEngine.Object.Instantiate(attributeItem, root);
			obj.transform.GetComponent<AttributeItem>().Init(attributeItemDatum);
			obj.gameObject.SetActive(value: true);
		}
		foreach (EntryItemData entryItemDatum in _viewModel.EntryItemData)
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
		if (!_viewModel.HeroName.Equals("") && heroInfoObj != null)
		{
			UnityEngine.Object.Instantiate(fillImg, root).gameObject.SetActive(value: true);
		}
		uiGameObjectSort.Sort();
	}

	public void SetAnchorAndPivot(Vector2 anchorMin, Vector2 anchorMax, Vector2 pivot)
	{
		mainPanel.anchorMin = anchorMin;
		mainPanel.anchorMax = anchorMax;
		mainPanel.pivot = pivot;
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
