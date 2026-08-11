using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroUpgradeWindow : UGuiWindow
{
	[SerializeField]
	private GameObject root;

	[SerializeField]
	private LoopListView2 expItemList;

	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnCancel;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private GameObject confirmUnable;

	[SerializeField]
	private ButtonLong btnAddProp;

	[SerializeField]
	private ButtonLong btnDecProp;

	[SerializeField]
	private Image heroColor;

	[SerializeField]
	private TextMeshProUGUI heroName;

	[SerializeField]
	private Image heroImg;

	[SerializeField]
	private UIStarGroup heroStar;

	[SerializeField]
	private GameObject isMaxLevel;

	[SerializeField]
	private TextMeshProUGUI levelCur;

	[SerializeField]
	private TextMeshProUGUI levelAdd;

	[SerializeField]
	private TextMeshProUGUI expCur;

	[SerializeField]
	private TextMeshProUGUI expAdd;

	[SerializeField]
	private Image expSliderCur;

	[SerializeField]
	private Image expSliderAdd;

	[SerializeField]
	private Slider useCountSlider;

	[SerializeField]
	private TextMeshProUGUI useCount;

	[SerializeField]
	private GameObject addDisable;

	[SerializeField]
	private GameObject decDisable;

	[SerializeField]
	private TextMeshProUGUI coinNeed;

	[SerializeField]
	private TextMeshProUGUI coinMax;

	[SerializeField]
	private RectTransform rTF;

	[SerializeField]
	private ListPaddingCal padding;

	[SerializeField]
	private List<string> attributeColor;

	[SerializeField]
	private List<string> coinColor;

	[SerializeField]
	private float pressSpeed = 0.5f;

	private HeroUpgradeViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<HeroUpgradeViewModel>();
		BindingSet<HeroUpgradeWindow, HeroUpgradeViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((HeroUpgradeWindow v) => v.OpenUguiWindow).To((HeroUpgradeViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((HeroUpgradeWindow v) => v.CloseWindow).To((HeroUpgradeViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((HeroUpgradeWindow v) => ((UGuiWindow)v).OnVisibleChanged).To((HeroUpgradeViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((HeroUpgradeViewModel vm) => vm.Close);
		bindingSet.Bind(btnCancel).For((Button v) => v.onClick).To((HeroUpgradeViewModel vm) => vm.Close);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((HeroUpgradeViewModel vm) => vm.ConfirmCmd);
		bindingSet.Bind(btnConfirm.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroUpgradeViewModel vm) => (long)vm.CoinNeed <= vm.CoinDataAmount && vm.UseCount > 0);
		bindingSet.Bind(confirmUnable).For((GameObject v) => v.activeSelf).ToExpression((HeroUpgradeViewModel vm) => (long)vm.CoinNeed > vm.CoinDataAmount || vm.UseCount <= 0);
		bindingSet.Bind<TextMeshProUGUI>(heroName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroUpgradeViewModel vm) => vm.ShowName);
		bindingSet.Bind(heroImg).For((Image v) => v.sprite).ToExpression((HeroUpgradeViewModel vm) => $"{vm.HeroModel.Id}SquareHead")
			.WithConversion("ItemIcon");
		bindingSet.Bind(heroStar).For((UIStarGroup v) => v.CurCount).ToExpression((HeroUpgradeViewModel vm) => vm.HeroModel.StarLevel);
		bindingSet.Bind(btnAddProp).For((ButtonLong v) => v.onClick).To((HeroUpgradeViewModel vm) => vm.AddProp);
		bindingSet.Bind(btnDecProp).For((ButtonLong v) => v.onClick).To((HeroUpgradeViewModel vm) => vm.DecProp);
		bindingSet.Bind(addDisable).For((GameObject v) => v.activeSelf).ToExpression((HeroUpgradeViewModel vm) => !vm.CanAdd);
		bindingSet.Bind(decDisable).For((GameObject v) => v.activeSelf).ToExpression((HeroUpgradeViewModel vm) => !vm.CanDec);
		bindingSet.Bind<TextMeshProUGUI>(levelCur).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroUpgradeViewModel vm) => vm.HeroModel.Level);
		bindingSet.Bind<TextMeshProUGUI>(levelAdd).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HeroUpgradeViewModel vm) => (vm.LevelAdd > 0) ? $"+{vm.LevelAdd}" : "");
		bindingSet.Bind(isMaxLevel).For((GameObject v) => v.activeSelf).ToExpression((HeroUpgradeViewModel vm) => vm.IsLevelMax);
		bindingSet.Bind<TextMeshProUGUI>(expAdd).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HeroUpgradeViewModel vm) => (vm.ExpAdd > 0) ? $"+{vm.ExpAdd}" : "");
		bindingSet.Bind<TextMeshProUGUI>(expCur).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HeroUpgradeViewModel vm) => $"{vm.HeroModel.Exp}/{vm.ExpMax}");
		bindingSet.Bind(expSliderCur).For((Image v) => v.fillAmount).To((HeroUpgradeViewModel vm) => vm.LevelExpFillCur);
		bindingSet.Bind(expSliderAdd).For((Image v) => v.fillAmount).To((HeroUpgradeViewModel vm) => vm.LevelExpFillAdd);
		bindingSet.Bind<TextMeshProUGUI>(coinNeed).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HeroUpgradeViewModel vm) => ((long)vm.CoinNeed <= vm.CoinDataAmount) ? $"<color=#{coinColor[0]}>{vm.CoinDataAmount}</color>" : $"<color=#{coinColor[1]}>{vm.CoinDataAmount}</color>");
		bindingSet.Bind<TextMeshProUGUI>(coinMax).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HeroUpgradeViewModel vm) => $"/{vm.CoinNeed}");
		bindingSet.Bind(useCountSlider).For((Slider v) => v.value, (Slider v) => v.onValueChanged).To((HeroUpgradeViewModel vm) => vm.UseFillAmount);
		bindingSet.Bind(this).For((HeroUpgradeWindow v) => v.FixSlider).To((HeroUpgradeViewModel vm) => vm.FixSliderRequest);
		bindingSet.Bind<TextMeshProUGUI>(useCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroUpgradeViewModel vm) => vm.UseCount);
		bindingSet.Build();
		EnterAnimation.OnEnd(delegate
		{
			Animator component = GetComponent<Animator>();
			if ((UnityEngine.Object)(object)component != null)
			{
				((Behaviour)(object)component).enabled = false;
			}
		});
	}

	protected override void OnVisibleChanged(object sender, InteractionEventArgs e)
	{
		bool active = (bool)e.Context;
		root.SetActive(active);
	}

	private void FixSlider(object sender, InteractionEventArgs e)
	{
		float value = (float)e.Context;
		useCountSlider.value = value;
	}

	protected override void OnShow()
	{
		base.OnShow();
		InitListParam();
		ColorUtility.TryParseHtmlString((viewModel.HeroModel == null) ? "FFFFFF" : UiConvert.Hero.Attribute2Color[viewModel.HeroModel.Attribute], out var color);
		heroColor.color = color;
		btnAddProp.onPress.AddListener(AddPropPress);
		btnDecProp.onPress.AddListener(DecPropPress);
	}

	public void InitListParam()
	{
		expItemList.ArrangeType = padding.Cal(viewModel.ExpItemDatas.Count, rTF.rect.width);
		expItemList.InitListView(viewModel.ExpItemDatas.Count, OnGetExpItemItemByIndex);
	}

	private LoopListViewItem2 OnGetExpItemItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ExpItemDatas.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("ExpItem");
		if (loopListViewItem != null)
		{
			KnapsackItemNew component = loopListViewItem.GetComponent<KnapsackItemNew>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ExpItemDatas[index]);
			}
			else
			{
				component.RefreshData(viewModel.ExpItemDatas[index]);
			}
		}
		return loopListViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}

	private void AddPropPress()
	{
		if (viewModel.UseCount > 0)
		{
			float value = Mathf.Clamp(useCountSlider.value + pressSpeed / (float)viewModel.UseCountMax, viewModel.UseFillAmountMin, 1f);
			useCountSlider.value = value;
		}
	}

	private void DecPropPress()
	{
		if (viewModel.UseCount > 0)
		{
			float value = Mathf.Clamp(useCountSlider.value - pressSpeed / (float)viewModel.UseCountMax, viewModel.UseFillAmountMin, 1f);
			useCountSlider.value = value;
		}
	}
}
