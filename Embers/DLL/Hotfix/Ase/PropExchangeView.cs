using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PropExchangeView : UGuiView
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnCancel;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private GameObject confirmUnable;

	[SerializeField]
	private GameObject limitExchangeInfoRect;

	[SerializeField]
	private TextMeshProUGUI limitExchangeInfo;

	[SerializeField]
	private TextMeshProUGUI showName;

	[SerializeField]
	private TextMeshProUGUI showDesc;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image rarityColor;

	[SerializeField]
	private GameObject armourRank;

	[SerializeField]
	private TextMeshProUGUI armourRankText;

	[SerializeField]
	private Image armourType;

	[SerializeField]
	private Image weaponTypeIcon;

	[SerializeField]
	private Button btnWeaponPreview;

	[SerializeField]
	private TextMeshProUGUI disableMsg;

	[SerializeField]
	private GameObject exchangeBar;

	[SerializeField]
	private ButtonLong btnAddProp;

	[SerializeField]
	private ButtonLong btnDecProp;

	[SerializeField]
	private Slider useCountSlider;

	[SerializeField]
	private TextMeshProUGUI useCount;

	[SerializeField]
	private TextMeshProUGUI maxCount;

	[SerializeField]
	private GameObject addDisable;

	[SerializeField]
	private GameObject decDisable;

	[SerializeField]
	private GameObject singleScheme;

	[SerializeField]
	private Image icon1;

	[SerializeField]
	private TextMeshProUGUI count1;

	[SerializeField]
	private Image icon2;

	[SerializeField]
	private TextMeshProUGUI count2;

	[SerializeField]
	private GameObject multipleScheme;

	[SerializeField]
	private TabItem schemeTab0;

	[SerializeField]
	private Image tabIcon1;

	[SerializeField]
	private TabItem schemeTab1;

	[SerializeField]
	private Image tabIcon2;

	[SerializeField]
	private float pressSpeed = 0.5f;

	private float pressValue;

	private PropExchangeViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<PropExchangeViewModel>(userData);
		BindingSet<PropExchangeView, PropExchangeViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((PropExchangeView v) => v.OnVisibleChanged).To((PropExchangeViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((PropExchangeViewModel vm) => vm.ConfirmCmd);
		bindingSet.Bind(btnConfirm.gameObject).For((GameObject v) => v.activeSelf).To((PropExchangeViewModel vm) => vm.EnableConfirm);
		bindingSet.Bind(confirmUnable).For((GameObject v) => v.activeSelf).ToExpression((PropExchangeViewModel vm) => !vm.EnableConfirm);
		bindingSet.Bind<TextMeshProUGUI>(disableMsg).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropExchangeViewModel vm) => vm.DisableMsg);
		bindingSet.Bind(((Component)(object)disableMsg).gameObject).For((GameObject v) => v.activeSelf).To((PropExchangeViewModel vm) => vm.ShowDisableMsg);
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((PropExchangeViewModel vm) => vm.PropData.Icon)
				.WithConversion("ItemIcon");
		}
		bindingSet.Bind(rarityColor).For((Image v) => v.sprite).To((PropExchangeViewModel vm) => vm.RarityColorBg)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(showName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropExchangeViewModel vm) => vm.NameAndCount);
		bindingSet.Bind<TextMeshProUGUI>(showDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropExchangeViewModel vm) => vm.PropDesc);
		if (armourRank != null)
		{
			bindingSet.Bind(armourRank).For((GameObject v) => v.activeSelf).To((PropExchangeViewModel vm) => vm.ShowArmourRank);
		}
		if ((UnityEngine.Object)(object)armourRankText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(armourRankText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropExchangeViewModel vm) => vm.ArmourRankText);
		}
		if (armourType != null)
		{
			bindingSet.Bind(armourType.gameObject).For((GameObject v) => v.activeSelf).ToExpression((PropExchangeViewModel vm) => !string.IsNullOrEmpty(vm.ArmourTypeIcon));
			bindingSet.Bind(armourType).For((Image v) => v.sprite).To((PropExchangeViewModel vm) => vm.ArmourTypeIcon)
				.WithConversion("ItemIcon");
		}
		if (weaponTypeIcon != null)
		{
			bindingSet.Bind(weaponTypeIcon.gameObject).For((GameObject v) => v.activeSelf).To((PropExchangeViewModel vm) => vm.ShowWeaponType);
			bindingSet.Bind(weaponTypeIcon).For((Image v) => v.sprite).To((PropExchangeViewModel vm) => vm.WeaponTypeIcon)
				.WithConversion("ItemIcon");
		}
		if (btnWeaponPreview != null)
		{
			bindingSet.Bind(btnWeaponPreview).For((Button v) => v.onClick).To((PropExchangeViewModel vm) => vm.OpenWeaponPreviewCmd);
			bindingSet.Bind(btnWeaponPreview).For((Button v) => v.enabled).To((PropExchangeViewModel vm) => vm.ShowWeaponType);
		}
		bindingSet.Bind(limitExchangeInfoRect).For((GameObject v) => v.activeSelf).ToExpression((PropExchangeViewModel vm) => !string.IsNullOrEmpty(vm.LimitExchangeText));
		bindingSet.Bind<TextMeshProUGUI>(limitExchangeInfo).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropExchangeViewModel vm) => vm.LimitExchangeText);
		bindingSet.Bind(exchangeBar).For((GameObject v) => v.activeSelf).ToExpression((PropExchangeViewModel vm) => !vm.ShowDisableMsg);
		bindingSet.Bind(btnAddProp).For((ButtonLong v) => v.onClick).To((PropExchangeViewModel vm) => vm.AddProp);
		bindingSet.Bind(btnDecProp).For((ButtonLong v) => v.onClick).To((PropExchangeViewModel vm) => vm.DecProp);
		bindingSet.Bind(addDisable).For((GameObject v) => v.activeSelf).ToExpression((PropExchangeViewModel vm) => !vm.CanAdd);
		bindingSet.Bind(decDisable).For((GameObject v) => v.activeSelf).ToExpression((PropExchangeViewModel vm) => !vm.CanDec);
		bindingSet.Bind(useCountSlider).For((Slider v) => v.value, (Slider v) => v.onValueChanged).To((PropExchangeViewModel vm) => vm.UseCount);
		bindingSet.Bind(useCountSlider).For((Slider v) => v.minValue).To((PropExchangeViewModel vm) => vm.UseCountMin);
		bindingSet.Bind(useCountSlider).For((Slider v) => v.maxValue).To((PropExchangeViewModel vm) => vm.UseCountMax);
		bindingSet.Bind(useCountSlider).For((Slider v) => v.enabled).To((PropExchangeViewModel vm) => vm.SliderEnable);
		bindingSet.Bind<TextMeshProUGUI>(useCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropExchangeViewModel vm) => vm.UseCount);
		bindingSet.Bind<TextMeshProUGUI>(maxCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropExchangeViewModel vm) => vm.UseCountMax);
		bindingSet.Bind(singleScheme).For((GameObject v) => v.activeSelf).ToExpression((PropExchangeViewModel vm) => (int)vm.ConsumeSchemeType == 1 || (int)vm.ConsumeSchemeType == 2);
		bindingSet.Bind(icon1).For((Image v) => v.sprite).To((PropExchangeViewModel vm) => vm.SingleConsumeIcon1)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(count1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropExchangeViewModel vm) => vm.SingleConsumeCount1);
		bindingSet.Bind(icon2.gameObject).For((GameObject v) => v.activeSelf).ToExpression((PropExchangeViewModel vm) => (int)vm.ConsumeSchemeType == 2);
		bindingSet.Bind(icon2).For((Image v) => v.sprite).To((PropExchangeViewModel vm) => vm.SingleConsumeIcon2)
			.WithConversion("ItemIcon");
		bindingSet.Bind(((Component)(object)count2).gameObject).For((GameObject v) => v.activeSelf).ToExpression((PropExchangeViewModel vm) => (int)vm.ConsumeSchemeType == 2);
		bindingSet.Bind<TextMeshProUGUI>(count2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropExchangeViewModel vm) => vm.SingleConsumeCount2);
		bindingSet.Bind(multipleScheme).For((GameObject v) => v.activeSelf).ToExpression((PropExchangeViewModel vm) => (int)vm.ConsumeSchemeType == 3);
		bindingSet.Bind(tabIcon1).For((Image v) => v.sprite).To((PropExchangeViewModel vm) => vm.MultiConsumeIcon1)
			.WithConversion("ItemIcon");
		bindingSet.Bind(tabIcon2).For((Image v) => v.sprite).To((PropExchangeViewModel vm) => vm.MultiConsumeIcon2)
			.WithConversion("ItemIcon");
		bindingSet.Build();
		btnBack.onClick.AddListener(delegate
		{
			Visibility = false;
		});
		btnCancel.onClick.AddListener(delegate
		{
			Visibility = false;
		});
		InitSchemeTabs();
		btnAddProp.onPress.AddListener(AddPropPress);
		btnDecProp.onPress.AddListener(DecPropPress);
		btnAddProp.onPointUp.AddListener(delegate
		{
			pressValue = 0f;
		});
	}

	private void InitSchemeTabs()
	{
		schemeTab0.Init(viewModel.SchemeTab0);
		schemeTab1.Init(viewModel.SchemeTab1);
		schemeTab0.ViewModel.IsSelected = true;
		schemeTab1.ViewModel.IsSelected = false;
	}

	private void AddPropPress()
	{
		if (pressValue == 0f)
		{
			pressValue = viewModel.UseCount;
		}
		pressValue = Mathf.Clamp(pressValue + pressSpeed, viewModel.UseCountMin, viewModel.UseCountMax);
		if (viewModel.UseCount != Mathf.FloorToInt(pressValue))
		{
			useCountSlider.value = Mathf.FloorToInt(pressValue);
		}
	}

	private void DecPropPress()
	{
		if (pressValue == 0f)
		{
			pressValue = viewModel.UseCount;
		}
		pressValue = Mathf.Clamp(pressValue - pressSpeed, viewModel.UseCountMin, viewModel.UseCountMax);
		if (viewModel.UseCount != Mathf.CeilToInt(pressValue))
		{
			useCountSlider.value = Mathf.CeilToInt(pressValue);
		}
	}
}
