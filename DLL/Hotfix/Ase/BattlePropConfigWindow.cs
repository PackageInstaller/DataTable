using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattlePropConfigWindow : UGuiWindow
{
	[SerializeField]
	private Color carryLackColor;

	[SerializeField]
	private Color carryNormalColor;

	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private TextMeshProUGUI desc;

	[SerializeField]
	private TextMeshProUGUI carryCount;

	[SerializeField]
	private TextMeshProUGUI carryCountMax;

	[SerializeField]
	private UIStarGroup star;

	[SerializeField]
	private GameObject carryingRoot;

	[SerializeField]
	private GameObject canCarryRoot;

	[SerializeField]
	private Button btnCarry;

	[SerializeField]
	private Button btnRemove;

	[SerializeField]
	private Button btnMake;

	[SerializeField]
	private GameObject disableCarry;

	[SerializeField]
	private BPCarryItemView tab1;

	[SerializeField]
	private BPCarryItemView tab2;

	[SerializeField]
	private AutoDispose btnEffect;

	[SerializeField]
	private AutoDispose makeEffect;

	[SerializeField]
	private AutoDispose config1Effect;

	[SerializeField]
	private AutoDispose config2Effect;

	[SerializeField]
	private LoopGridView itemList;

	private BattlePropConfigViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<BattlePropConfigViewModel>();
		BindingSet<BattlePropConfigWindow, BattlePropConfigViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((BattlePropConfigWindow v) => v.OnDismissRequest).To((BattlePropConfigViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((BattlePropConfigWindow v) => v.OpenUguiWindow).To((BattlePropConfigViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((BattlePropConfigWindow v) => v.RefreshItems).To((BattlePropConfigViewModel vm) => vm.RefreshItemRequest);
		bindingSet.Bind(this).For((BattlePropConfigWindow v) => v.OnOpt).To((BattlePropConfigViewModel vm) => vm.OptRequest);
		bindingSet.Bind(btnCarry).For((Button v) => v.onClick).To((BattlePropConfigViewModel vm) => vm.OptCommand)
			.CommandParameter("OnCarry");
		bindingSet.Bind(btnRemove).For((Button v) => v.onClick).To((BattlePropConfigViewModel vm) => vm.OptCommand)
			.CommandParameter("OnRemove");
		bindingSet.Bind(canCarryRoot).For((GameObject v) => v.activeSelf).ToExpression((BattlePropConfigViewModel vm) => !vm.Carrying);
		bindingSet.Bind(carryingRoot).For((GameObject v) => v.activeSelf).To((BattlePropConfigViewModel vm) => vm.Carrying);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((BattlePropConfigViewModel vm) => vm.Close);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((BattlePropConfigViewModel vm) => vm.Close);
		bindingSet.Bind(btnMake).For((Button v) => v.onClick).To((BattlePropConfigViewModel vm) => vm.MakeCommand);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattlePropConfigViewModel vm) => vm.CurSelect.Data.Name);
		bindingSet.Bind(disableCarry).For((GameObject v) => v.activeSelf).ToExpression((BattlePropConfigViewModel vm) => vm.CurSelect.Data.Count <= 0);
		bindingSet.Bind<TextMeshProUGUI>(desc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattlePropConfigViewModel vm) => vm.CurSelect.Data.Desc);
		bindingSet.Bind<TextMeshProUGUI>(carryCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattlePropConfigViewModel vm) => vm.CurSelect.Data.Count);
		bindingSet.Bind<TextMeshProUGUI>(carryCount).For((Expression<Func<TextMeshProUGUI, Color>>)((TextMeshProUGUI v) => ((Graphic)v).color)).ToExpression((BattlePropConfigViewModel vm) => (vm.CurSelect.Data.Count < vm.CurSelect.Data.CarryMax) ? carryLackColor : carryNormalColor);
		bindingSet.Bind<TextMeshProUGUI>(carryCountMax).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattlePropConfigViewModel vm) => vm.CurSelect.Data.CarryMax);
		bindingSet.Bind(star).For((UIStarGroup v) => v.MaxCount).To((BattlePropConfigViewModel vm) => vm.CurSelect.Data.LevelMax);
		bindingSet.Bind(star).For((UIStarGroup v) => v.CurCount).To((BattlePropConfigViewModel vm) => vm.CurSelect.Data.Level);
		bindingSet.Build();
		itemList.InitGridView(viewModel.BpItemVMs.Count, OnGetPropItemByIndex);
		tab1.Init(viewModel.GetItemByNum(1));
		tab2.Init(viewModel.GetItemByNum(2));
		btnMake.onClick.AddListener(delegate
		{
			btnEffect.gameObject.SetActive(value: false);
			btnEffect.gameObject.SetActive(value: true);
		});
		btnEffect.AddDisposeAction((Action<GameObject>)delegate
		{
			btnEffect.gameObject.SetActive(value: false);
		});
		makeEffect.AddDisposeAction((Action<GameObject>)delegate
		{
			makeEffect.gameObject.SetActive(value: false);
		});
		config1Effect.AddDisposeAction((Action<GameObject>)delegate
		{
			config1Effect.gameObject.SetActive(value: false);
		});
		config2Effect.AddDisposeAction((Action<GameObject>)delegate
		{
			config2Effect.gameObject.SetActive(value: false);
		});
	}

	private void RefreshItems(object sender, InteractionEventArgs e)
	{
		tab1.Init(viewModel.GetItemByNum(1));
		tab2.Init(viewModel.GetItemByNum(2));
	}

	private LoopGridViewItem OnGetPropItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.BpItemVMs.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("BPItemView");
		if (loopGridViewItem != null)
		{
			BPItemView component = loopGridViewItem.GetComponent<BPItemView>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.BpItemVMs[index]);
			}
			else
			{
				component.RefreshData(viewModel.BpItemVMs[index]);
			}
		}
		return loopGridViewItem;
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("PlayMakeSuccessEffect".Equals(optName))
		{
			makeEffect.gameObject.SetActive(value: false);
			makeEffect.gameObject.SetActive(value: true);
		}
		else if ("PlayConfig1Effect".Equals(optName))
		{
			config1Effect.gameObject.SetActive(value: false);
			config1Effect.gameObject.SetActive(value: true);
		}
		else if ("PlayConfig2Effect".Equals(optName))
		{
			config2Effect.gameObject.SetActive(value: false);
			config2Effect.gameObject.SetActive(value: true);
		}
	}
}
