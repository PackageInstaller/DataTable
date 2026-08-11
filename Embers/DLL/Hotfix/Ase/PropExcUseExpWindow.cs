using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PropExcUseExpWindow : UGuiWindow
{
	[SerializeField]
	private KnapsackItemNew targetProp;

	[SerializeField]
	private TextMeshProUGUI tips1;

	[SerializeField]
	private RectTransform consumePropRoot;

	[SerializeField]
	private KnapsackItemNew consumePropTpl;

	private GameObjectPool _consumePropPool;

	[SerializeField]
	private TextMeshProUGUI consumeCoinCount;

	[SerializeField]
	protected Slider slider;

	[SerializeField]
	private TextMeshProUGUI sliderValue;

	[SerializeField]
	protected ButtonLong btnAddProp;

	[SerializeField]
	protected ButtonLong btnDecProp;

	[SerializeField]
	protected GameObject addDisable;

	[SerializeField]
	protected GameObject decDisable;

	[SerializeField]
	protected float pressSpeed = 0.5f;

	[SerializeField]
	private Button btnOutside;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private TextMeshProUGUI btnConfirmText;

	[SerializeField]
	private GameObject btnConfirmMask;

	[SerializeField]
	private MoneyView moneyView;

	private PropExcUseExpViewModel _viewModel;

	private float _btnPressTime;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<PropExcUseExpViewModel>();
		BindingSet<PropExcUseExpWindow, PropExcUseExpViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((PropExcUseExpWindow v) => v.OpenUguiWindow).To((PropExcUseExpViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((PropExcUseExpWindow v) => v.OnDismissRequest).To((PropExcUseExpViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnOutside).For((Button v) => v.onClick).To((PropExcUseExpViewModel vm) => vm.Close);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((PropExcUseExpViewModel vm) => vm.Close);
		bindingSet.Bind(slider).For((Slider v) => v.minValue).To((PropExcUseExpViewModel vm) => vm.UseCountMin);
		bindingSet.Bind(slider).For((Slider v) => v.maxValue).To((PropExcUseExpViewModel vm) => vm.UseCountMax);
		bindingSet.Bind<TextMeshProUGUI>(sliderValue).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropExcUseExpViewModel vm) => vm.UseCount);
		bindingSet.Bind<TextMeshProUGUI>(consumeCoinCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PropExcUseExpViewModel vm) => vm.UseCount * vm.SingleCoinCost);
		bindingSet.Bind(btnAddProp).For((ButtonLong v) => v.enabled).ToExpression((PropExcUseExpViewModel vm) => vm.UseCountMax > vm.UseCount);
		bindingSet.Bind(btnDecProp).For((ButtonLong v) => v.enabled).ToExpression((PropExcUseExpViewModel vm) => vm.UseCount > vm.UseCountMin);
		bindingSet.Bind(addDisable).For((GameObject v) => v.activeSelf).ToExpression((PropExcUseExpViewModel vm) => vm.UseCount >= vm.UseCountMax);
		bindingSet.Bind(decDisable).For((GameObject v) => v.activeSelf).ToExpression((PropExcUseExpViewModel vm) => vm.UseCount <= vm.UseCountMin);
		if ((UnityEngine.Object)(object)tips1 != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(tips1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropExcUseExpViewModel vm) => vm.Tips1);
		}
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((PropExcUseExpViewModel vm) => vm.ConfirmCmd);
		bindingSet.Bind(btnConfirm).For((Button v) => v.enabled).ToExpression((PropExcUseExpViewModel vm) => !vm.ShowConfirmMask);
		bindingSet.Bind(btnConfirmMask).For((GameObject v) => v.activeSelf).To((PropExcUseExpViewModel vm) => vm.ShowConfirmMask);
		bindingSet.Bind<TextMeshProUGUI>(btnConfirmText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropExcUseExpViewModel vm) => vm.ConfirmText);
		bindingSet.Bind().For((PropExcUseExpWindow v) => v.OnUseCountChangeRst).To((PropExcUseExpViewModel vm) => vm.UseCountChangeRst);
		bindingSet.Build();
		InitSlider();
		InitPropItems();
		moneyView.Init(new MoneyViewModel(_viewModel));
		moneyView.SetShow(new List<RoleMoneyEnum>
		{
			RoleMoneyEnum.ArmourExp1,
			RoleMoneyEnum.ArmourExp2,
			RoleMoneyEnum.ArmourExp3,
			RoleMoneyEnum.ArmourExp4,
			RoleMoneyEnum.Coin
		});
	}

	private void InitSlider()
	{
		btnAddProp.onClick.AddListener(AddProp);
		btnDecProp.onClick.AddListener(DecProp);
		btnAddProp.onPress.AddListener(AddPropPress);
		btnDecProp.onPress.AddListener(DecPropPress);
		slider.onValueChanged.AddListener(SetPropCount);
		slider.wholeNumbers = true;
		slider.SetValueWithoutNotify(_viewModel.UseCount);
	}

	private void InitPropItems()
	{
		targetProp.Init(_viewModel.TargetProp);
		_consumePropPool = new GameObjectPool(consumePropTpl.gameObject, consumePropRoot);
		if (_viewModel.ConsumePropDatas == null)
		{
			return;
		}
		foreach (KnapsackItemViewModel value in _viewModel.ConsumePropDatas.Values)
		{
			_consumePropPool.Allocate().GetComponent<KnapsackItemNew>().Init(value);
		}
	}

	private void SetPropCount(float sliderCount)
	{
		_viewModel.SetUseCount((int)sliderCount);
	}

	private void AddProp()
	{
		if (_viewModel.AddProp())
		{
			slider.SetValueWithoutNotify(_viewModel.UseCount);
		}
	}

	private void DecProp()
	{
		if (_viewModel.DecProp())
		{
			slider.SetValueWithoutNotify(_viewModel.UseCount);
		}
	}

	private void AddPropPress()
	{
		_btnPressTime += pressSpeed;
		if (_btnPressTime >= 1f)
		{
			_btnPressTime--;
			AddProp();
		}
	}

	private void DecPropPress()
	{
		_btnPressTime += pressSpeed;
		if (_btnPressTime >= 1f)
		{
			_btnPressTime--;
			DecProp();
		}
	}

	private void OnUseCountChangeRst(object sender, InteractionEventArgs e)
	{
		slider.SetValueWithoutNotify(_viewModel.UseCount);
	}
}
