using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PropOperationWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private LoopGridView propList;

	[SerializeField]
	private TabItem tabCompose;

	[SerializeField]
	private TabItem tabDecompose;

	[SerializeField]
	private KnapsackItemNew targetProp;

	[SerializeField]
	private TextMeshProUGUI targetPropHaveCount;

	[SerializeField]
	private KnapsackItemNew consumeProp;

	[SerializeField]
	private TextMeshProUGUI sliderOpeCount;

	[SerializeField]
	private OpeCountBtnSlider btnSlider;

	[SerializeField]
	private Button btnOperate;

	[SerializeField]
	private GameObject btnOperateMask;

	[SerializeField]
	private TextMeshProUGUI btnOperateText;

	private Animator animator;

	private PropOperationViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		animator = GetComponent<Animator>();
		base.OnCreate(bundle);
		_viewModel = GetData<PropOperationViewModel>();
		BindingSet<PropOperationWindow, PropOperationViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((PropOperationWindow v) => v.OnDismissRequest).To((PropOperationViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((PropOperationWindow v) => v.OpenUguiWindow).To((PropOperationViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((PropOperationViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind<TextMeshProUGUI>(targetPropHaveCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PropOperationViewModel vm) => $"拥有数量：{vm.TargetPropHaveCount}");
		bindingSet.Bind<TextMeshProUGUI>(sliderOpeCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PropOperationViewModel vm) => $"{vm.OperationMode.GetDescription()}数量：{vm.SliderOpeCount}");
		bindingSet.Bind(btnOperate).For((Button v) => v.onClick).To((PropOperationViewModel vm) => vm.OperateCmd);
		bindingSet.Bind(btnOperate).For((Button v) => v.enabled).ToExpression((PropOperationViewModel vm) => !vm.ShowOpeBtnMask);
		bindingSet.Bind(btnOperateMask).For((GameObject v) => v.activeSelf).To((PropOperationViewModel vm) => vm.ShowOpeBtnMask);
		bindingSet.Bind<TextMeshProUGUI>(btnOperateText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropOperationViewModel vm) => vm.OpeBtnText);
		bindingSet.Bind().For((PropOperationWindow v) => v.RefreshDisplayDatas).To((PropOperationViewModel vm) => vm.RefreshDisplayDatas);
		bindingSet.Build();
		propList.InitGridView(_viewModel.DisplayDatas.Count, OnGetItemByIndex);
		targetProp.Init(_viewModel.TargetProp);
		consumeProp.Init(_viewModel.ConsumeProp);
		targetProp.GetComponent<Button>()?.onClick.AddListener(delegate
		{
			_viewModel.OpenPropInfoWindow(_viewModel.TargetProp);
		});
		consumeProp.GetComponent<Button>()?.onClick.AddListener(delegate
		{
			_viewModel.OpenPropInfoWindow(_viewModel.ConsumeProp);
		});
		btnSlider.Init(_viewModel.SliderViewModel);
		tabCompose.Init(_viewModel.TabComposeItemData);
		tabDecompose.Init(_viewModel.TabDecomposeItemData);
		if (_viewModel.OperationMode == KnapsackDefinition.PropOperationMode.Compose)
		{
			tabCompose.ViewModel.TabOnClick();
		}
		else if (_viewModel.OperationMode == KnapsackDefinition.PropOperationMode.Decompose)
		{
			tabDecompose.ViewModel.TabOnClick();
		}
		int num = -1;
		if (_viewModel.PropId > 0)
		{
			num = _viewModel.DisplayDatas.FindIndex((KnapsackItemViewModel p) => p.PropDataBase.Id == _viewModel.PropId);
		}
		RefreshDisplayDatas();
		if (num >= 0)
		{
			propList.MovePanelToItemByIndex(num);
		}
	}

	private void RefreshDisplayDatas(object sender = null, InteractionEventArgs e = null)
	{
		propList.SetListItemCount(_viewModel.DisplayDatas.Count);
		propList.RefreshAllShownItem();
		if ((UnityEngine.Object)(object)animator != null)
		{
			animator.SetTrigger("move");
		}
		if (sender != null)
		{
			propList.MovePanelToItemByIndex(0);
		}
	}

	private LoopGridViewItem OnGetItemByIndex(LoopGridView arg1, int dataIndex, int row, int column)
	{
		if (dataIndex < 0 || dataIndex >= _viewModel.DisplayDatas.Count)
		{
			return null;
		}
		KnapsackItemViewModel knapsackItemViewModel = _viewModel.DisplayDatas[dataIndex];
		if (knapsackItemViewModel == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = propList.NewListViewItem("PropItem");
		KnapsackItemNew component = loopGridViewItem.GetComponent<KnapsackItemNew>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(knapsackItemViewModel);
		}
		else
		{
			component.RefreshData(knapsackItemViewModel);
		}
		if (_viewModel.PropId > 0)
		{
			if (knapsackItemViewModel.PropDataBase.Id == _viewModel.PropId)
			{
				knapsackItemViewModel.OnClick();
			}
		}
		else if (dataIndex == 0)
		{
			knapsackItemViewModel.OnClick();
		}
		return loopGridViewItem;
	}
}
