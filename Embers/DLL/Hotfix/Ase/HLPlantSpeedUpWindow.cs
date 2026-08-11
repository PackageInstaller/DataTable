using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HLPlantSpeedUpWindow : UGuiWindow
{
	[SerializeField]
	private Button btnCancel;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private ButtonLong btnAddProp;

	[SerializeField]
	private ButtonLong btnDecProp;

	[SerializeField]
	private Slider useCountSlider;

	[SerializeField]
	private TextMeshProUGUI useCount;

	[SerializeField]
	private GameObject addDisable;

	[SerializeField]
	private GameObject decDisable;

	[SerializeField]
	private float pressSpeed = 0.5f;

	[SerializeField]
	private LoopListView2 speedItemList;

	[SerializeField]
	private TextMeshProUGUI leftTimeText;

	private HLPlantSpeedUpViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<HLPlantSpeedUpViewModel>();
		BindingSet<HLPlantSpeedUpWindow, HLPlantSpeedUpViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((HLPlantSpeedUpWindow v) => v.OnDismissRequest).To((HLPlantSpeedUpViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnCancel).For((Button v) => v.onClick).To((HLPlantSpeedUpViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((HLPlantSpeedUpViewModel vm) => vm.ConfirmCmd);
		bindingSet.Bind(btnAddProp).For((ButtonLong v) => v.onClick).To((HLPlantSpeedUpViewModel vm) => vm.AddProp);
		bindingSet.Bind(btnDecProp).For((ButtonLong v) => v.onClick).To((HLPlantSpeedUpViewModel vm) => vm.DecProp);
		bindingSet.Bind(addDisable).For((GameObject v) => v.activeSelf).ToExpression((HLPlantSpeedUpViewModel vm) => !vm.CanAdd);
		bindingSet.Bind(decDisable).For((GameObject v) => v.activeSelf).ToExpression((HLPlantSpeedUpViewModel vm) => !vm.CanDec);
		bindingSet.Bind(useCountSlider).For((Slider v) => v.value, (Slider v) => v.onValueChanged).To((HLPlantSpeedUpViewModel vm) => vm.UseFillAmount);
		bindingSet.Bind(this).For((HLPlantSpeedUpWindow v) => v.FixSlider).To((HLPlantSpeedUpViewModel vm) => vm.FixSliderRequest);
		bindingSet.Bind<TextMeshProUGUI>(useCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HLPlantSpeedUpViewModel vm) => vm.UseCount);
		bindingSet.Bind(this).For((HLPlantSpeedUpWindow v) => v.OpenUguiWindow).To((HLPlantSpeedUpViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind<TextMeshProUGUI>(leftTimeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HLPlantSpeedUpViewModel vm) => vm.LeftTimeText);
		bindingSet.Build();
		btnAddProp.onPress.AddListener(AddPropPress);
		btnDecProp.onPress.AddListener(DecPropPress);
		speedItemList.InitListView(viewModel.KnapsackItemViewList.Count, OnGetSpeedUpItemByIndex);
	}

	private LoopListViewItem2 OnGetSpeedUpItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.KnapsackItemViewList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("UseItem");
		if (loopListViewItem != null)
		{
			KnapsackItemNew component = loopListViewItem.GetComponent<KnapsackItemNew>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.KnapsackItemViewList[index]);
			}
			else
			{
				component.RefreshData(viewModel.KnapsackItemViewList[index]);
			}
		}
		return loopListViewItem;
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
