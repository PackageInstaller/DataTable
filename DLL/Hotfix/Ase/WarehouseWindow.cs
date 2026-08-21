#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class WarehouseWindow : UGuiWindow
{
	[SerializeField]
	private Button backBtn;

	[SerializeField]
	private Transform tabGroup;

	[SerializeField]
	private LoopGridView itemList;

	[SerializeField]
	private RectTransform bottomRect;

	[SerializeField]
	private TextMeshProUGUI itemCountText;

	[SerializeField]
	private Toggle screenToggle;

	[SerializeField]
	private TextMeshProUGUI screenModeText;

	[SerializeField]
	private CanvasGroup screenPanel;

	[SerializeField]
	private Button funcBtn;

	[SerializeField]
	private TextMeshProUGUI funcBtnText;

	[SerializeField]
	private GameObject decomposePart;

	[SerializeField]
	private Button btnOpenDecompose;

	[SerializeField]
	private Button btnCancelDecompose;

	[SerializeField]
	private Button btnAutoSelectDecompose;

	[SerializeField]
	private Button btnDecompose;

	[SerializeField]
	private Toggle decomposeScreenToggle;

	[SerializeField]
	private TextMeshProUGUI autoDecomposeScreenText;

	[SerializeField]
	private CanvasGroup autoDecomposeScreenPanel;

	[SerializeField]
	private GameObject decomposeProductGo;

	[SerializeField]
	private KnapsackItemNew decomposeProductTpl;

	[SerializeField]
	private RectTransform decomposeProductRoot;

	[SerializeField]
	private Button btnPropOperate;

	[SerializeField]
	private GameObject warehouseGo;

	[SerializeField]
	private GameObject nothingGo;

	[SerializeField]
	private Transform infoViewRoot;

	[SerializeField]
	private WeaponPopupView weaponPopupView;

	[SerializeField]
	private ArmourPopupView armourPropView;

	[SerializeField]
	private PropInfoView propInfoView;

	[SerializeField]
	private RockPopupView suitBoxInfoView;

	[SerializeField]
	private Button windowMask;

	[SerializeField]
	private EntryInfoView _entryInfoView;

	private List<TabToggle> _screenToggleList = new List<TabToggle>();

	private List<TabToggle> _decomposeScreenToggles = new List<TabToggle>();

	private WarehouseViewModel _viewModel;

	private GameObjectPool _decomposeProductPool;

	protected override void OnCreate(IBundle bundle)
	{
		_decomposeProductPool = new GameObjectPool(decomposeProductTpl.gameObject, decomposeProductRoot);
		base.OnCreate(bundle);
		_viewModel = GetData<WarehouseViewModel>();
		BindingSet<WarehouseWindow, WarehouseViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((WarehouseWindow v) => v.CloseWindow).To((WarehouseViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((WarehouseWindow v) => v.OpenUguiWindow).To((WarehouseViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(backBtn).For((Button v) => v.onClick).To((WarehouseViewModel vm) => vm.Close);
		bindingSet.Bind(screenToggle.gameObject).For((GameObject v) => v.activeSelf).To((WarehouseViewModel vm) => vm.ShowScreenToggle);
		bindingSet.Bind<TextMeshProUGUI>(screenModeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WarehouseViewModel vm) => vm.CurScreenMode);
		bindingSet.Bind(btnPropOperate.gameObject).For((GameObject v) => v.activeSelf).ToExpression((WarehouseViewModel vm) => (int)vm.CurTabType == 4);
		bindingSet.Bind(btnPropOperate).For((Button v) => v.onClick).To((WarehouseViewModel vm) => vm.OnPropOpeBtnClick);
		bindingSet.Bind(btnOpenDecompose.gameObject).For((GameObject v) => v.activeSelf).ToExpression((WarehouseViewModel vm) => vm.ShowDecompose && !vm.StateMode.Equals(KnapsackDefinition.WarehouseStateMode.Decompose));
		bindingSet.Bind(decomposePart).For((GameObject v) => v.activeSelf).ToExpression((WarehouseViewModel vm) => vm.StateMode.Equals(KnapsackDefinition.WarehouseStateMode.Decompose));
		bindingSet.Bind(btnOpenDecompose).For((Button v) => v.onClick).To((WarehouseViewModel vm) => vm.OnBtnOpenDecomposeClick);
		bindingSet.Bind(btnCancelDecompose).For((Button v) => v.onClick).To((WarehouseViewModel vm) => vm.OnBtnCancelDecomposeClick);
		bindingSet.Bind(btnDecompose).For((Button v) => v.onClick).To((WarehouseViewModel vm) => vm.DecomposeCommand);
		bindingSet.Bind(btnAutoSelectDecompose).For((Button v) => v.onClick).To((WarehouseViewModel vm) => vm.OnAutoSelectDecomposeClick);
		bindingSet.Bind<TextMeshProUGUI>(autoDecomposeScreenText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WarehouseViewModel vm) => vm.CurAutoDecomposeScreenMode);
		bindingSet.Bind(decomposeScreenToggle.gameObject).For((GameObject v) => v.activeSelf).To((WarehouseViewModel vm) => vm.ShowDecomposeScreen);
		bindingSet.Bind(funcBtn).For((Button v) => v.onClick).To((WarehouseViewModel vm) => vm.OnFuncBtnClick);
		bindingSet.Bind(funcBtn.gameObject).For((GameObject v) => v.activeSelf).To((WarehouseViewModel vm) => vm.ShowFuncBtn);
		bindingSet.Bind<TextMeshProUGUI>(funcBtnText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WarehouseViewModel vm) => vm.FuncBtnText);
		bindingSet.Bind(this).For((WarehouseWindow v) => v.RefreshPropList).To((WarehouseViewModel vm) => vm.RefreshPropRequest);
		bindingSet.Bind(this).For((WarehouseWindow v) => v.OpenWeaponPropView).To((WarehouseViewModel vm) => vm.OpenWeaponInfoViewRst);
		bindingSet.Bind(this).For((WarehouseWindow v) => v.OpenArmourInfoView).To((WarehouseViewModel vm) => vm.OpenArmourInfoViewRst);
		bindingSet.Bind(this).For((WarehouseWindow v) => v.OpenPropInfoView).To((WarehouseViewModel vm) => vm.OpenPropInfoViewRst);
		bindingSet.Bind(this).For((WarehouseWindow v) => v.OpenRockInfoView).To((WarehouseViewModel vm) => vm.OpenRockInfoViewRst);
		bindingSet.Bind(this).For((WarehouseWindow v) => v.ShowEntryDetail).To((WarehouseViewModel vm) => vm.ShowEntryDetailRequest);
		bindingSet.Bind(this).For((WarehouseWindow v) => v.RefreshDecomposeProducts).To((WarehouseViewModel vm) => vm.RefreshDecomposeProducts);
		bindingSet.Build();
		OnInit();
		_entryInfoView.Init();
	}

	private new void OnInit()
	{
		weaponPopupView.Init(_viewModel.WeaponPopupViewModel);
		weaponPopupView.SetAnchorAndPivot(new Vector2(1f, 0.5f), new Vector2(1f, 0.5f), new Vector2(1f, 0.5f));
		armourPropView.Init(_viewModel.ArmourPropViewModel);
		armourPropView.SetAnchorAndPivot(new Vector2(1f, 0.5f), new Vector2(1f, 0.5f), new Vector2(1f, 0.5f));
		propInfoView.Init(_viewModel.PropInfoViewModel);
		propInfoView.SetAnchorAndPivot(new Vector2(1f, 0.5f), new Vector2(1f, 0.5f), new Vector2(1f, 0.5f));
		suitBoxInfoView.Init(_viewModel.RockInfoViewModel);
		TabToggle tabToggle = null;
		TabToggle tabToggle2 = null;
		int num = 0;
		foreach (KnapsackDefinition.WarehouseTabEnum value in Enum.GetValues(typeof(KnapsackDefinition.WarehouseTabEnum)))
		{
			if (tabGroup.childCount <= num)
			{
				break;
			}
			TabToggle component = tabGroup.GetChild(num).GetComponent<TabToggle>();
			component.AddSelectedAction(OnTabClick);
			component.SetToggleText(value.GetDescription(), value.GetDescription());
			if (value == KnapsackDefinition.WarehouseTabEnum.Weapon)
			{
				tabToggle2 = component;
			}
			if (value == _viewModel.CurTabType)
			{
				tabToggle = component;
			}
			num++;
		}
		if (tabToggle == null)
		{
			tabToggle = tabToggle2;
		}
		if (tabToggle != null)
		{
			tabToggle.isOn = true;
		}
		GameObject original = ((Component)(object)screenPanel).transform.GetChild(0).gameObject;
		foreach (KnapsackDefinition.WarehouseScreenType value2 in Enum.GetValues(typeof(KnapsackDefinition.WarehouseScreenType)))
		{
			TabToggle component2 = UnityEngine.Object.Instantiate(original, ((Component)(object)screenPanel).transform).GetComponent<TabToggle>();
			component2.enumId = (int)value2;
			component2.SetToggleText(value2.GetDescription(), value2.GetDescription());
			component2.AddSelectedAction(OnScreenToggleClick);
			component2.gameObject.SetActive(value: true);
			_screenToggleList.Add(component2);
		}
		_screenToggleList[0].isOn = true;
		screenToggle.onValueChanged.AddListener(delegate(bool v)
		{
			screenPanel.alpha = (v ? 1 : 0);
			screenPanel.blocksRaycasts = v;
			if (v)
			{
				ShowWindowMask(screenToggle.transform, delegate
				{
					screenPanel.alpha = 0f;
					screenPanel.blocksRaycasts = false;
					screenToggle.isOn = false;
				});
			}
			else
			{
				windowMask.onClick?.Invoke();
			}
		});
		GameObject original2 = ((Component)(object)autoDecomposeScreenPanel).transform.GetChild(0).gameObject;
		foreach (KnapsackDefinition.WarehouseAutoScreenType value3 in Enum.GetValues(typeof(KnapsackDefinition.WarehouseAutoScreenType)))
		{
			TabToggle component3 = UnityEngine.Object.Instantiate(original2, ((Component)(object)autoDecomposeScreenPanel).transform).GetComponent<TabToggle>();
			component3.enumId = (int)value3;
			component3.SetToggleText(value3.GetDescription(), value3.GetDescription());
			component3.AddSelectedAction(OnDecomposeScreenToggleClick);
			component3.gameObject.SetActive(value: true);
			_decomposeScreenToggles.Add(component3);
		}
		_decomposeScreenToggles[0].isOn = true;
		decomposeScreenToggle.onValueChanged.AddListener(delegate(bool v)
		{
			autoDecomposeScreenPanel.alpha = (v ? 1 : 0);
			autoDecomposeScreenPanel.blocksRaycasts = v;
			if (v)
			{
				ShowWindowMask(decomposeScreenToggle.transform, delegate
				{
					autoDecomposeScreenPanel.alpha = 0f;
					autoDecomposeScreenPanel.blocksRaycasts = false;
					decomposeScreenToggle.isOn = false;
				});
			}
			else
			{
				windowMask.onClick?.Invoke();
			}
		});
		itemList.InitGridView(_viewModel.FilterDataList.Count, OnGetItemByIndex);
		LayoutSuitSetting();
		windowMask.onClick.AddListener(delegate
		{
			windowMask.gameObject.SetActive(value: false);
		});
	}

	protected override void OnShow()
	{
		base.OnShow();
		AttachMoneyView();
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		_viewModel?.TryOpenExpiredWindow();
	}

	public async void AttachMoneyView()
	{
		try
		{
			MoneyView moneyView = await OpenView<MoneyView>("Role/MoneyView", new MoneyViewModel(_viewModel), "WarehouseWindow");
			if (!(moneyView == null))
			{
				moneyView.SetShow(new List<RoleMoneyEnum>
				{
					RoleMoneyEnum.Coin,
					RoleMoneyEnum.Diamond,
					RoleMoneyEnum.Energy
				});
				moneyView.AddOpenWindowAction(delegate
				{
					_viewModel.StateMode = KnapsackDefinition.WarehouseStateMode.Normal;
				});
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
	}

	private void ShowEntryDetail(object sender, InteractionEventArgs e)
	{
		EntryItem entryItem = (EntryItem)e.Context;
		_entryInfoView.Show(entryItem.ViewModel);
	}

	private void LayoutSuitSetting()
	{
		float num = 330f;
		float num2 = 642f;
		float num3 = UIUtilly.GetCanvasSize().x - num - num2;
		int count = Mathf.FloorToInt((num3 - (float)itemList.Padding.left + itemList.ItemPadding.x) / (itemList.ItemSize.x + itemList.ItemPadding.x));
		itemList.GetComponent<RectTransform>().SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, num3);
		itemList.SetGridFixedGroupCount(GridFixedType.ColumnCountFixed, count);
	}

	private void RefreshScreenToggles(KnapsackDefinition.WarehouseTabEnum tab)
	{
		if (_screenToggleList == null || _screenToggleList.Count <= 0)
		{
			return;
		}
		_screenToggleList[2].gameObject.SetActive(value: false);
		_screenToggleList[1].gameObject.SetActive(tab != KnapsackDefinition.WarehouseTabEnum.SuitBox);
		_screenToggleList[3].gameObject.SetActive(tab == KnapsackDefinition.WarehouseTabEnum.SuitBox);
		bool flag = false;
		if (_viewModel.CurScreenType == KnapsackDefinition.WarehouseScreenType.Type && tab != KnapsackDefinition.WarehouseTabEnum.Weapon)
		{
			_screenToggleList[2].isOn = false;
			flag = true;
		}
		else if (_viewModel.CurScreenType == KnapsackDefinition.WarehouseScreenType.Rank && tab != KnapsackDefinition.WarehouseTabEnum.SuitBox)
		{
			_screenToggleList[3].isOn = false;
			flag = true;
		}
		else if (_viewModel.CurScreenType == KnapsackDefinition.WarehouseScreenType.Level && tab == KnapsackDefinition.WarehouseTabEnum.SuitBox)
		{
			_screenToggleList[1].isOn = false;
			flag = true;
		}
		if (!flag)
		{
			return;
		}
		foreach (TabToggle screenToggle in _screenToggleList)
		{
			if (screenToggle.gameObject.activeSelf)
			{
				screenToggle.isOn = true;
				break;
			}
		}
	}

	private void OnTabClick(int index)
	{
		RefreshScreenToggles((KnapsackDefinition.WarehouseTabEnum)index);
		_viewModel.ItemOnClick((KnapsackDefinition.WarehouseTabEnum)index);
		if (index != 1)
		{
			weaponPopupView.Visibility = false;
		}
		if (index != 2)
		{
			armourPropView.Visibility = false;
		}
		if (index != 3)
		{
			suitBoxInfoView.Visibility = false;
		}
		if (index != 4 && index != 5 && index != 6)
		{
			propInfoView.Visibility = false;
		}
	}

	private void OnScreenToggleClick(int index)
	{
		OnScreenToggleClick((KnapsackDefinition.WarehouseScreenType)index);
	}

	private void OnScreenToggleClick(KnapsackDefinition.WarehouseScreenType screenType)
	{
		windowMask.onClick?.Invoke();
		_viewModel.ItemOnClick(screenType);
	}

	private void OnDecomposeScreenToggleClick(int index)
	{
		windowMask.onClick?.Invoke();
		_viewModel.CurAutoDecomposeScreenType = (KnapsackDefinition.WarehouseAutoScreenType)index;
	}

	private void RefreshPropList(object sender, InteractionEventArgs e)
	{
		itemList.SetListItemCount(_viewModel.FilterDataList.Count);
		itemList.RefreshAllShownItem();
		itemList.ScrollRect.content.anchoredPosition = Vector2.zero;
		if (_viewModel.FilterDataList.Count > 0)
		{
			RefreshTypeAndCountInfo();
			warehouseGo.SetActive(value: true);
			nothingGo.SetActive(value: false);
		}
		else
		{
			warehouseGo.SetActive(value: false);
			nothingGo.SetActive(value: true);
		}
		screenToggle.isOn = false;
	}

	private void RefreshTypeAndCountInfo()
	{
		int curTabType = (int)_viewModel.CurTabType;
		int id = 199 + curTabType;
		float num = GameEntry.DataTable.GetDataRow<DRConstantConfig>(id)?.Value ?? 0f;
		if ((float)_viewModel.FilterDataList.Count <= num)
		{
			((TMP_Text)itemCountText).text = $"{_viewModel.CurTabType.GetDescription()} {_viewModel.FilterDataList.Count}<color=#e3a871>/{num}</color>";
		}
		else
		{
			((TMP_Text)itemCountText).text = $"{_viewModel.CurTabType.GetDescription()} <color=red>{_viewModel.FilterDataList.Count}</color><color=#e3a871>/{num}</color>";
		}
	}

	private LoopGridViewItem OnGetItemByIndex(LoopGridView arg1, int dataIndex, int row, int column)
	{
		KnapsackItemViewModel knapsackItemViewModel = _viewModel.FilterDataList[dataIndex];
		if (knapsackItemViewModel == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = null;
		if (knapsackItemViewModel is WeaponItemData viewModel)
		{
			loopGridViewItem = itemList.NewListViewItem("WeaponItem");
			WeaponItem component = loopGridViewItem.GetComponent<WeaponItem>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel);
			}
			else
			{
				component.RefreshData(viewModel);
			}
		}
		else if (knapsackItemViewModel is ArmourItemData viewModel2)
		{
			loopGridViewItem = itemList.NewListViewItem("ArmourItem");
			ArmourItem component2 = loopGridViewItem.GetComponent<ArmourItem>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component2.Init(viewModel2);
			}
			else
			{
				component2.RefreshData(viewModel2);
			}
		}
		else if (knapsackItemViewModel is WarehouseItemData warehouseItemData)
		{
			loopGridViewItem = itemList.NewListViewItem("WarehouseItem");
			WarehouseItem component3 = loopGridViewItem.GetComponent<WarehouseItem>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component3.Init(warehouseItemData);
			}
			else
			{
				component3.RefreshData(warehouseItemData);
			}
		}
		if (_viewModel.AutoSelect)
		{
			if (_viewModel.CurSelectData is WeaponItemData weaponItemData && knapsackItemViewModel is WeaponItemData weaponItemData2)
			{
				if (weaponItemData.Data.Uid.Equals(weaponItemData2.Data.Uid))
				{
					_viewModel.OnKnapsackItemClick(knapsackItemViewModel);
				}
			}
			else if (_viewModel.CurSelectData is ArmourItemData armourItemData && knapsackItemViewModel is ArmourItemData armourItemData2)
			{
				if (armourItemData.Data.Uid.Equals(armourItemData2.Data.Uid))
				{
					_viewModel.OnKnapsackItemClick(knapsackItemViewModel);
				}
			}
			else if (_viewModel.CurSelectData is WarehouseItemData && knapsackItemViewModel is WarehouseItemData)
			{
				if (_viewModel.CurSelectData.PropDataBase.Id.Equals(knapsackItemViewModel.PropDataBase.Id))
				{
					_viewModel.OnKnapsackItemClick(knapsackItemViewModel);
				}
			}
			else if (row == 0 && column == 0)
			{
				_viewModel.OnKnapsackItemClick(knapsackItemViewModel);
			}
		}
		return loopGridViewItem;
	}

	private void OpenWeaponPropView(object sender, InteractionEventArgs e)
	{
		weaponPopupView.Visibility = true;
	}

	private void OpenArmourInfoView(object sender, InteractionEventArgs e)
	{
		armourPropView.Visibility = true;
		armourPropView.RefreshArmourData();
	}

	private void OpenPropInfoView(object sender, InteractionEventArgs e)
	{
		propInfoView.Visibility = true;
	}

	private void OpenRockInfoView(object sender, InteractionEventArgs e)
	{
		suitBoxInfoView.Visibility = true;
	}

	private void RefreshDecomposeProducts(object sender, InteractionEventArgs e)
	{
		if (_viewModel.DecomposeProducts == null || _viewModel.DecomposeProducts.Count <= 0)
		{
			decomposeProductGo.SetActive(value: false);
			return;
		}
		_decomposeProductPool.RecycleAll();
		for (int i = 0; i < _viewModel.DecomposeProducts.Count; i++)
		{
			KnapsackItemNew component = _decomposeProductPool.Allocate(out var newCreate).GetComponent<KnapsackItemNew>();
			KnapsackItemViewModel viewModel = new KnapsackItemViewModel(_viewModel, _viewModel.DecomposeProducts[i]);
			if (newCreate)
			{
				component.Init(viewModel);
			}
			else
			{
				component.RefreshData(viewModel);
			}
			component.transform.SetAsLastSibling();
			component.gameObject.SetActive(value: true);
		}
		decomposeProductGo.SetActive(value: true);
	}

	public void ShowWindowMask(Transform target, Action action = null)
	{
		int siblingIndex = Math.Max(0, target.GetSiblingIndex() - 1);
		windowMask.transform.SetParent(target.parent);
		windowMask.transform.SetSiblingIndex(siblingIndex);
		windowMask.onClick.AddListener(Handler);
		windowMask.gameObject.SetActive(value: true);
		void Handler()
		{
			windowMask.onClick.RemoveListener(Handler);
			action?.Invoke();
		}
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
		GameEntry.Resource.UnloadAsset("Assets/Art/UI/UIForms/Role/MoneyView");
	}

	protected override void OnDestroy()
	{
		_decomposeProductPool?.Dispose();
		_decomposeProductPool = null;
		for (int num = _screenToggleList.Count - 1; num >= 0; num--)
		{
			UnityEngine.Object.DestroyImmediate(_screenToggleList[num]);
			_screenToggleList[num] = null;
		}
		_screenToggleList.Clear();
		for (int num2 = _decomposeScreenToggles.Count - 1; num2 >= 0; num2--)
		{
			UnityEngine.Object.DestroyImmediate(_decomposeScreenToggles[num2]);
			_decomposeScreenToggles[num2] = null;
		}
		_decomposeScreenToggles.Clear();
		base.OnDestroy();
	}
}
