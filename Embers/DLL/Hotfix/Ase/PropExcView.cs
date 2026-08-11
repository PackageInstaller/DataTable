using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PropExcView : UGuiWindow
{
	[SerializeField]
	protected Button btnBack;

	[SerializeField]
	protected Button btnCancel;

	[SerializeField]
	protected Button btnConfirm;

	[SerializeField]
	protected GameObject confirmUnable;

	[SerializeField]
	protected ButtonLong btnAddProp;

	[SerializeField]
	protected ButtonLong btnDecProp;

	[SerializeField]
	protected TextMeshProUGUI showName;

	[SerializeField]
	private TextMeshProUGUI showDesc;

	[SerializeField]
	protected KnapsackItemNew excItem;

	[SerializeField]
	private TextMeshProUGUI usePropName;

	[SerializeField]
	private Image usePropIcon;

	[SerializeField]
	protected Slider useCountSlider;

	[SerializeField]
	private TextMeshProUGUI useCount;

	[SerializeField]
	protected GameObject addDisable;

	[SerializeField]
	protected GameObject decDisable;

	[SerializeField]
	private TextMeshProUGUI propNeed;

	[SerializeField]
	private ListPaddingCal padding;

	[SerializeField]
	private List<string> coinColor;

	[SerializeField]
	protected float pressSpeed = 0.5f;

	protected PropExcViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<PropExcViewModel>();
		BindingSet<PropExcView, PropExcViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((PropExcView v) => v.OpenUguiWindow).To((PropExcViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((PropExcView v) => v.OnDismissRequest).To((PropExcViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((PropExcViewModel vm) => vm.Close);
		bindingSet.Bind(btnCancel).For((Button v) => v.onClick).To((PropExcViewModel vm) => vm.Close);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((PropExcViewModel vm) => vm.ConfirmCmd);
		bindingSet.Bind(btnConfirm.gameObject).For((GameObject v) => v.activeSelf).ToExpression((PropExcViewModel vm) => vm.PropCountNeed <= vm.UsePropInBag.Amount && vm.UseCount > 0);
		bindingSet.Bind(confirmUnable).For((GameObject v) => v.activeSelf).ToExpression((PropExcViewModel vm) => vm.PropCountNeed > vm.UsePropInBag.Amount || vm.UseCount <= 0);
		bindingSet.Bind<TextMeshProUGUI>(showName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropExcViewModel vm) => vm.TargetProp.Name);
		bindingSet.Bind<TextMeshProUGUI>(showDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropExcViewModel vm) => vm.TargetProp.Description);
		bindingSet.Bind<TextMeshProUGUI>(usePropName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PropExcViewModel vm) => $"需要消耗{vm.UsePropInBag.Name}");
		bindingSet.Bind(usePropIcon).For((Image v) => v.sprite).ToExpression((PropExcViewModel vm) => vm.UsePropInBag.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(btnAddProp).For((ButtonLong v) => v.onClick).To((PropExcViewModel vm) => vm.AddProp);
		bindingSet.Bind(btnDecProp).For((ButtonLong v) => v.onClick).To((PropExcViewModel vm) => vm.DecProp);
		bindingSet.Bind(addDisable).For((GameObject v) => v.activeSelf).ToExpression((PropExcViewModel vm) => !vm.CanAdd);
		bindingSet.Bind(decDisable).For((GameObject v) => v.activeSelf).ToExpression((PropExcViewModel vm) => !vm.CanDec);
		bindingSet.Bind<TextMeshProUGUI>(propNeed).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PropExcViewModel vm) => (vm.PropCountNeed <= vm.UsePropInBag.Amount) ? $"<color=#{coinColor[0]}>{vm.PropCountNeed}</color>" : $"<color=#{coinColor[1]}>{vm.PropCountNeed}</color>");
		bindingSet.Bind(useCountSlider).For((Slider v) => v.value, (Slider v) => v.onValueChanged).To((PropExcViewModel vm) => vm.UseFillAmount);
		bindingSet.Bind(this).For((PropExcView v) => v.FixSlider).To((PropExcViewModel vm) => vm.FixSliderRequest);
		bindingSet.Bind<TextMeshProUGUI>(useCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropExcViewModel vm) => vm.UseCount);
		bindingSet.Build();
		btnAddProp.onPress.AddListener(AddPropPress);
		btnDecProp.onPress.AddListener(DecPropPress);
		excItem.Init(new KnapsackItemViewModel(null, viewModel.TargetProp));
		AddMoneyView();
	}

	protected virtual void FixSlider(object sender, InteractionEventArgs e)
	{
		float value = (float)e.Context;
		useCountSlider.value = value;
	}

	protected virtual void AddMoneyView()
	{
	}

	protected virtual void AddPropPress()
	{
		float value = Mathf.Clamp(useCountSlider.value + pressSpeed / (float)viewModel.UseCountMax, 0f, 1f);
		useCountSlider.value = value;
	}

	protected virtual void DecPropPress()
	{
		float value = Mathf.Clamp(useCountSlider.value - pressSpeed / (float)viewModel.UseCountMax, 0f, 1f);
		useCountSlider.value = value;
	}
}
