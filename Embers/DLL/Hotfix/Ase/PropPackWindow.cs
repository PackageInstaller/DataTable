using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PropPackWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private TextMeshProUGUI packName;

	[SerializeField]
	private TextMeshProUGUI packTip;

	[SerializeField]
	private ButtonLong btnAddProp;

	[SerializeField]
	private ButtonLong btnDecProp;

	[SerializeField]
	private Slider useCountSlider;

	[SerializeField]
	private TextMeshProUGUI count;

	[SerializeField]
	private TextMeshProUGUI useCountText;

	[SerializeField]
	private GameObject addDisable;

	[SerializeField]
	private GameObject decDisable;

	[SerializeField]
	private LoopGridView propItemList;

	[SerializeField]
	private Button confirmBtn;

	[SerializeField]
	protected float pressSpeed = 0.5f;

	private PropPackViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<PropPackViewModel>();
		BindingSet<PropPackWindow, PropPackViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((PropPackWindow v) => v.OpenUguiWindow).To((PropPackViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((PropPackWindow v) => v.OnDismissRequest).To((PropPackViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((PropPackViewModel vm) => vm.Close);
		bindingSet.Bind<TextMeshProUGUI>(packName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropPackViewModel vm) => vm.PackName);
		bindingSet.Bind<TextMeshProUGUI>(packTip).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropPackViewModel vm) => vm.PackTip);
		bindingSet.Bind(useCountSlider).For((Slider v) => v.value, (Slider v) => v.onValueChanged).To((PropPackViewModel vm) => vm.UseFillAmount);
		bindingSet.Bind(this).For((PropPackWindow v) => v.FixSlider).To((PropPackViewModel vm) => vm.FixSliderRequest);
		bindingSet.Bind<TextMeshProUGUI>(count).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropPackViewModel vm) => vm.UseCount);
		bindingSet.Bind<TextMeshProUGUI>(useCountText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropPackViewModel vm) => vm.UseCountMax);
		bindingSet.Bind(btnAddProp).For((ButtonLong v) => v.onClick).To((PropPackViewModel vm) => vm.AddProp);
		bindingSet.Bind(btnDecProp).For((ButtonLong v) => v.onClick).To((PropPackViewModel vm) => vm.DecProp);
		bindingSet.Bind(addDisable).For((GameObject v) => v.activeSelf).ToExpression((PropPackViewModel vm) => !vm.CanAdd);
		bindingSet.Bind(decDisable).For((GameObject v) => v.activeSelf).ToExpression((PropPackViewModel vm) => !vm.CanDec);
		bindingSet.Bind(confirmBtn).For((Button v) => v.onClick).To((PropPackViewModel vm) => vm.ConfirmOnClickCmd);
		bindingSet.Build();
		btnAddProp.onPress.AddListener(AddPropPress);
		btnDecProp.onPress.AddListener(DecPropPress);
		propItemList.InitGridView(viewModel.PropPackItemViewModelList.Count, OnGetPackItemByIndex);
	}

	private LoopGridViewItem OnGetPackItemByIndex(LoopGridView arg1, int index, int row, int column)
	{
		PropPackItemViewModel propPackItemViewModel = viewModel.PropPackItemViewModelList[index];
		if (propPackItemViewModel == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = propItemList.NewListViewItem("PropItem");
		PropPackItem component = loopGridViewItem.GetComponent<PropPackItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(propPackItemViewModel);
		}
		else
		{
			component.RefreshData(propPackItemViewModel);
		}
		return loopGridViewItem;
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
