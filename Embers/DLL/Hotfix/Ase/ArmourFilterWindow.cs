using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourFilterWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnPreference;

	[SerializeField]
	private GameObject hasFilterGo;

	[SerializeField]
	private Button btnAutoSelect;

	[SerializeField]
	private Button btnDecompose;

	[SerializeField]
	private TextMeshProUGUI selectedCountText;

	[SerializeField]
	private GameObject decomposeProductGo;

	[SerializeField]
	private KnapsackItemNew decomposeProductTpl;

	[SerializeField]
	private RectTransform decomposeProductRoot;

	[SerializeField]
	private ArmourFilterView filterView;

	[SerializeField]
	private EntryInfoView entryInfoView;

	[SerializeField]
	private LoopGridView armourList;

	[SerializeField]
	private ArmourPopupView armourPopupView;

	[SerializeField]
	private RockPopupView rockPopupView;

	private ArmourFilterViewModel viewModel;

	private GameObjectPool decomposeProductPool;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<ArmourFilterViewModel>();
		BindingSet<ArmourFilterWindow, ArmourFilterViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((ArmourFilterWindow v) => v.OnOpt).To((ArmourFilterViewModel vm) => vm.OptRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((ArmourFilterViewModel vm) => vm.Close);
		bindingSet.Bind(this).For((ArmourFilterWindow v) => v.OpenUguiWindow).To((ArmourFilterViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((ArmourFilterWindow v) => v.CloseWindow).To((ArmourFilterViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnPreference).For((Button v) => v.onClick).To((ArmourFilterViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenFilterView");
		bindingSet.Bind(btnAutoSelect).For((Button v) => v.onClick).To((ArmourFilterViewModel vm) => vm.OptCommand)
			.CommandParameter("AutoSelect");
		bindingSet.Bind(btnDecompose).For((Button v) => v.onClick).To((ArmourFilterViewModel vm) => vm.OptCommand)
			.CommandParameter("Decompose");
		if ((UnityEngine.Object)(object)selectedCountText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(selectedCountText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourFilterViewModel vm) => vm.SelectedCountText);
		}
		if (hasFilterGo != null)
		{
			bindingSet.Bind(hasFilterGo).For((GameObject v) => v.activeSelf).To((ArmourFilterViewModel vm) => vm.HasFilterSelected);
		}
		bindingSet.Bind(this).For((ArmourFilterWindow v) => v.RefreshDecomposeProducts).To((ArmourFilterViewModel vm) => vm.RefreshDecomposeProducts);
		bindingSet.Build();
		if (filterView != null)
		{
			filterView.Init(viewModel.FilterSubViewModel);
		}
		if (btnPreference != null)
		{
			btnPreference.gameObject.SetActive(viewModel.FilterTypes != null && viewModel.FilterTypes.Count > 0);
		}
		if (entryInfoView != null)
		{
			entryInfoView.Init();
			entryInfoView.gameObject.SetActive(value: false);
		}
		if (decomposeProductTpl != null && decomposeProductRoot != null)
		{
			decomposeProductPool = new GameObjectPool(decomposeProductTpl.gameObject, decomposeProductRoot);
		}
		if (decomposeProductGo != null)
		{
			decomposeProductGo.SetActive(value: false);
		}
		if (decomposeProductPool != null)
		{
			decomposeProductPool.RecycleAll();
		}
		if (armourPopupView != null)
		{
			armourPopupView.Init(viewModel.ArmourPopupViewModel);
			armourPopupView.SetAnchorAndPivot(new Vector2(1f, 0.5f), new Vector2(1f, 0.5f), new Vector2(1f, 0.5f));
			armourPopupView.gameObject.SetActive(viewModel.EquipmentEnum != EquipmentEnum.SuitBox);
		}
		if (rockPopupView != null)
		{
			rockPopupView.Init(viewModel.RockPopupViewModel);
			rockPopupView.gameObject.SetActive(viewModel.EquipmentEnum == EquipmentEnum.SuitBox);
		}
		if (armourList != null)
		{
			armourList.InitGridView(Math.Max(viewModel.ArmourItemDataList.Count, 0), OnGetArmourItemByIndex);
			LayoutArmourListSetting();
		}
	}

	private void RefreshDecomposeProducts(object sender, InteractionEventArgs e)
	{
		if (decomposeProductGo == null || decomposeProductPool == null)
		{
			return;
		}
		if (viewModel.DecomposeProducts == null || viewModel.DecomposeProducts.Count <= 0)
		{
			decomposeProductGo.SetActive(value: false);
			decomposeProductPool.RecycleAll();
			return;
		}
		decomposeProductPool.RecycleAll();
		for (int i = 0; i < viewModel.DecomposeProducts.Count; i++)
		{
			KnapsackItemNew component = decomposeProductPool.Allocate(out var newCreate).GetComponent<KnapsackItemNew>();
			KnapsackItemViewModel knapsackItemViewModel = new KnapsackItemViewModel(viewModel, viewModel.DecomposeProducts[i]);
			if (newCreate)
			{
				component.Init(knapsackItemViewModel);
			}
			else
			{
				component.RefreshData(knapsackItemViewModel);
			}
			component.transform.SetAsLastSibling();
			component.gameObject.SetActive(value: true);
		}
		decomposeProductGo.SetActive(value: true);
	}

	private void LayoutArmourListSetting()
	{
		if (armourList == null)
		{
			return;
		}
		RectTransform component = armourList.GetComponent<RectTransform>();
		float num = ((component != null) ? component.rect.width : 0f);
		if (num <= 0.01f)
		{
			num = UIUtilly.GetCanvasSize().x;
			if (armourPopupView != null)
			{
				RectTransform component2 = armourPopupView.GetComponent<RectTransform>();
				if (component2 != null)
				{
					num -= component2.rect.width;
				}
			}
			num = Mathf.Max(0f, num);
			if (component != null)
			{
				component.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, num);
			}
		}
		int b = Mathf.FloorToInt((num - (float)armourList.Padding.left + armourList.ItemPadding.x) / (armourList.ItemSize.x + armourList.ItemPadding.x));
		b = Mathf.Max(1, b);
		armourList.SetGridFixedGroupCount(GridFixedType.ColumnCountFixed, b);
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("OpenFilterView".Equals(optName))
		{
			if (viewModel.FilterTypes != null && viewModel.FilterTypes.Count > 0)
			{
				ShowFilterView();
			}
		}
		else if ("CloseFilterView".Equals(optName))
		{
			HideFilterView();
		}
		else if ("RefreshFilterList".Equals(optName))
		{
			filterView?.RefreshFilterList();
		}
		else if ("RefreshArmourList".Equals(optName))
		{
			RefreshArmourList();
		}
		else if ("ShowArmourEntryInfo".Equals(optName))
		{
			if (!(entryInfoView == null))
			{
				EntryItemData armourEntryItemData = viewModel.ArmourEntryItemData;
				if (armourEntryItemData != null)
				{
					entryInfoView.Show(armourEntryItemData);
				}
			}
		}
		else if ("ShowFilterEntryInfo".Equals(optName))
		{
			if (entryInfoView != null)
			{
				entryInfoView.Hide();
			}
			filterView?.ShowFilterEntryInfo();
		}
		else if ("ScrollToSelectedArmour".Equals(optName) && !(armourList == null))
		{
			int scrollToArmourIndex = viewModel.ScrollToArmourIndex;
			if (scrollToArmourIndex >= 0 && scrollToArmourIndex < viewModel.ArmourItemDataList.Count)
			{
				armourList.MovePanelToItemByIndex(scrollToArmourIndex, 0f, -20f);
			}
		}
	}

	private void ShowFilterView()
	{
		if (!(filterView == null))
		{
			filterView.SetVisible(visible: true);
			filterView.RefreshFilterList();
		}
	}

	private void HideFilterView()
	{
		if (!(filterView == null))
		{
			filterView.HideEntryInfo();
			filterView.SetVisible(visible: false);
		}
	}

	private LoopGridViewItem OnGetArmourItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.ArmourItemDataList.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("ArmourItem");
		if (loopGridViewItem != null)
		{
			ArmourItem component = loopGridViewItem.GetComponent<ArmourItem>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ArmourItemDataList[index]);
			}
			else
			{
				component.RefreshData(viewModel.ArmourItemDataList[index]);
			}
		}
		return loopGridViewItem;
	}

	private void RefreshArmourList(object sender = null, InteractionEventArgs e = null)
	{
		if (!(armourList == null))
		{
			armourList.SetListItemCount(viewModel.ArmourItemDataList.Count);
			armourList.RefreshAllShownItem();
		}
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
