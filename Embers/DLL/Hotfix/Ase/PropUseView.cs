using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PropUseView : UGuiWindow
{
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
	private TextMeshProUGUI showName;

	[SerializeField]
	private TextMeshProUGUI showDesc;

	[SerializeField]
	private KnapsackItemNew excItem;

	[SerializeField]
	private Slider useCountSlider;

	[SerializeField]
	private TextMeshProUGUI useCount;

	[SerializeField]
	private GameObject addDisable;

	[SerializeField]
	private GameObject decDisable;

	[SerializeField]
	private ListPaddingCal padding;

	[SerializeField]
	private List<string> coinColor;

	[SerializeField]
	private float pressSpeed = 0.5f;

	private PropUseViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<PropUseViewModel>();
		BindingSet<PropUseView, PropUseViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((PropUseView v) => v.OnDismissRequest).To((PropUseViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnCancel).For((Button v) => v.onClick).To((PropUseViewModel vm) => vm.Close);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((PropUseViewModel vm) => vm.ConfirmCmd);
		bindingSet.Bind(btnConfirm.gameObject).For((GameObject v) => v.activeSelf).ToExpression((PropUseViewModel vm) => vm.PropCountNeed <= vm.UsePropInBag.Amount && vm.UseCount > 0);
		bindingSet.Bind(confirmUnable).For((GameObject v) => v.activeSelf).ToExpression((PropUseViewModel vm) => vm.PropCountNeed > vm.UsePropInBag.Amount || vm.UseCount <= 0);
		bindingSet.Bind<TextMeshProUGUI>(showName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropUseViewModel vm) => vm.UsePropInBag.Name);
		bindingSet.Bind<TextMeshProUGUI>(showDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropUseViewModel vm) => vm.UsePropInBag.Description);
		bindingSet.Bind(btnAddProp).For((ButtonLong v) => v.onClick).To((PropUseViewModel vm) => vm.AddProp);
		bindingSet.Bind(btnDecProp).For((ButtonLong v) => v.onClick).To((PropUseViewModel vm) => vm.DecProp);
		bindingSet.Bind(addDisable).For((GameObject v) => v.activeSelf).ToExpression((PropUseViewModel vm) => !vm.CanAdd);
		bindingSet.Bind(decDisable).For((GameObject v) => v.activeSelf).ToExpression((PropUseViewModel vm) => !vm.CanDec);
		bindingSet.Bind(useCountSlider).For((Slider v) => v.value, (Slider v) => v.onValueChanged).To((PropUseViewModel vm) => vm.UseFillAmount);
		bindingSet.Bind(this).For((PropUseView v) => v.FixSlider).To((PropUseViewModel vm) => vm.FixSliderRequest);
		bindingSet.Bind<TextMeshProUGUI>(useCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropUseViewModel vm) => vm.UseCount);
		bindingSet.Bind(this).For((PropUseView v) => v.OpenUguiWindow).To((PropUseViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Build();
		btnAddProp.onPress.AddListener(AddPropPress);
		btnDecProp.onPress.AddListener(DecPropPress);
		excItem.Init(new KnapsackItemViewModel(null, viewModel.UsePropInBag));
	}

	private void FixSlider(object sender, InteractionEventArgs e)
	{
		float value = (float)e.Context;
		useCountSlider.value = value;
	}

	private void AddPropPress()
	{
		float value = Mathf.Clamp(useCountSlider.value + pressSpeed / (float)viewModel.UseCountMax, 0f, 1f);
		useCountSlider.value = value;
	}

	private void DecPropPress()
	{
		float value = Mathf.Clamp(useCountSlider.value - pressSpeed / (float)viewModel.UseCountMax, 0f, 1f);
		useCountSlider.value = value;
	}
}
