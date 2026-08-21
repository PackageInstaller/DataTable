using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class WeaponUpgradeView : UGuiView
{
	[SerializeField]
	private LoopGridView expItemList;

	[SerializeField]
	private Toggle sortToggle;

	[SerializeField]
	private TextMeshProUGUI sortModeText;

	[SerializeField]
	private TabToggle tabToggleObj;

	[SerializeField]
	private Button toggleScreenBack;

	[SerializeField]
	private CanvasGroup sortPanel;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private TextMeshProUGUI weaponEnum;

	[SerializeField]
	private UIStarGroup _uiStarGroup;

	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private TextMeshProUGUI addLevel;

	[SerializeField]
	private TextMeshProUGUI exp;

	[SerializeField]
	private TextMeshProUGUI addExp;

	[SerializeField]
	private GameObject maxObj;

	[SerializeField]
	private TextMeshProUGUI needCoin;

	[SerializeField]
	private Image curExpProgress;

	[SerializeField]
	private Image preExpProgress;

	[SerializeField]
	private Button upgradeBtn;

	[SerializeField]
	private GameObject upgradeBtnObj;

	[SerializeField]
	private TabItemNormal btnAutoSelect;

	[SerializeField]
	private Button closePopBtn;

	[SerializeField]
	private LoopListView2 weaponAttributeList;

	[SerializeField]
	private LoopListView2 rarityLimitList;

	[SerializeField]
	private GameObject rarityLimitListObj;

	[SerializeField]
	private TabItemNormal btnOpenRarityLimit;

	[SerializeField]
	private Button btnCloseRarityLimit;

	private WeaponUpgradeViewModel _viewModel;

	public void Init(WeaponUpgradeViewModel viewModel)
	{
		_viewModel = viewModel;
		BindingSet<WeaponUpgradeView, WeaponUpgradeViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(sortModeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponUpgradeViewModel vm) => vm.CurSortName);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((WeaponUpgradeViewModel vm) => vm.WeaponData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((WeaponUpgradeViewModel vm) => $"RarityBG_Middle_{vm.WeaponData.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponUpgradeViewModel vm) => vm.WeaponData.Name);
		bindingSet.Bind<TextMeshProUGUI>(weaponEnum).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponUpgradeViewModel vm) => vm.WeaponEnumName);
		bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((WeaponUpgradeViewModel vm) => $"<size=32>Lv.</size><size=56><color=#DAD2CD>{vm.WeaponData.Level}</color></size>");
		bindingSet.Bind<TextMeshProUGUI>(needCoin).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponUpgradeViewModel vm) => vm.ShowCoin);
		bindingSet.Bind<TextMeshProUGUI>(addLevel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponUpgradeViewModel vm) => vm.ShowAddLevel);
		bindingSet.Bind<TextMeshProUGUI>(exp).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponUpgradeViewModel vm) => vm.ShowExp);
		bindingSet.Bind<TextMeshProUGUI>(addExp).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponUpgradeViewModel vm) => vm.ShowAddExp);
		bindingSet.Bind(maxObj).For((GameObject v) => v.activeSelf).To((WeaponUpgradeViewModel vm) => vm.IsMax);
		bindingSet.Bind(curExpProgress).For((Image v) => v.fillAmount).To((WeaponUpgradeViewModel vm) => vm.CurExpProgress);
		bindingSet.Bind(preExpProgress).For((Image v) => v.fillAmount).To((WeaponUpgradeViewModel vm) => vm.PreExpProgress);
		bindingSet.Bind(upgradeBtn).For((Button v) => v.onClick).To((WeaponUpgradeViewModel vm) => vm.UpgradeCmd);
		bindingSet.Bind(upgradeBtnObj).For((GameObject v) => v.activeSelf).ToExpression((WeaponUpgradeViewModel vm) => vm.CoinNeed <= (float)MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Coin));
		bindingSet.Bind(this).For((WeaponUpgradeView v) => v.UpdateInfoShow).To((WeaponUpgradeViewModel vm) => vm.RefreshInfoRequest);
		bindingSet.Bind(this).For((WeaponUpgradeView v) => v.UpdateDataShow).To((WeaponUpgradeViewModel vm) => vm.RefreshShowDataRequest);
		bindingSet.Bind(this).For((WeaponUpgradeView v) => v.OpenWindow).To((WeaponUpgradeViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(closePopBtn).For((Button v) => v.onClick).To((WeaponUpgradeViewModel vm) => vm.CloseProp);
		bindingSet.Bind(btnCloseRarityLimit).For((Button v) => v.onClick).To((WeaponUpgradeViewModel vm) => vm.CloseRarityLimitView);
		bindingSet.Bind(rarityLimitListObj).For((GameObject v) => v.activeSelf).To((WeaponUpgradeViewModel vm) => vm.ShowRarityLimitView);
		bindingSet.Build();
		InitScreenToggles();
		sortToggle.onValueChanged.AddListener(delegate(bool v)
		{
			sortPanel.alpha = (v ? 1 : 0);
			sortPanel.blocksRaycasts = v;
			toggleScreenBack.GetComponent<Image>().raycastTarget = v;
			toggleScreenBack.GetComponent<Button>().interactable = v;
		});
		toggleScreenBack.onClick.AddListener(CloseScreen);
		expItemList.InitGridView(viewModel.EquipExpItemDataNews.Count, OnGetEquipExpItemByIndex);
		weaponAttributeList.InitListView(viewModel.AttributeUpgradeItemDatas.Count, OnGetAttributeItemByIndex);
		_uiStarGroup.CurCount = viewModel.WeaponData.Star;
		btnAutoSelect.Init(viewModel.AutoSelectData);
		btnOpenRarityLimit.Init(viewModel.SelectLimitItemData);
		rarityLimitList.InitListView(viewModel.RarityLimitItemDataList.Count, OnRarityLimitItemByIndex);
	}

	public void CloseScreen()
	{
		sortPanel.alpha = 0f;
		sortPanel.blocksRaycasts = false;
		sortToggle.isOn = false;
		_viewModel.CloseRarityLimitView();
	}

	public void ResetContent()
	{
		expItemList.ContainerTrans.SetLocalPositionY(0f);
	}

	private void InitScreenToggles()
	{
		foreach (KeyValuePair<int, string> item in _viewModel.SortTypeEnum)
		{
			TabToggle component = UnityEngine.Object.Instantiate(tabToggleObj, ((Component)(object)sortPanel).transform).GetComponent<TabToggle>();
			component.enumId = item.Key;
			component.SetToggleText(item.Value, item.Value);
			component.AddSelectedAction(OnScreenToggleClick);
			component.gameObject.SetActive(value: true);
		}
		((Component)(object)sortPanel).transform.GetChild(0).gameObject.GetComponent<Toggle>().isOn = true;
	}

	private void OnScreenToggleClick(int index)
	{
		_viewModel.ItemOnClick(index);
		sortToggle.isOn = false;
	}

	private void UpdateInfoShow(object sender, InteractionEventArgs e)
	{
		weaponAttributeList.SetListItemCount(_viewModel.AttributeUpgradeItemDatas.Count);
		weaponAttributeList.RefreshAllShownItem();
		_uiStarGroup.CurCount = _viewModel.WeaponData.Star;
	}

	private void UpdateDataShow(object sender, InteractionEventArgs e)
	{
		expItemList.SetListItemCount(_viewModel.EquipExpItemDataNews.Count);
		expItemList.RefreshAllShownItem();
		_uiStarGroup.CurCount = _viewModel.WeaponData.Star;
	}

	private async void OpenWindow(object sender, InteractionEventArgs args)
	{
		Action callback = args.Callback;
		OpenViewArg openViewArg = (OpenViewArg)args.Context;
		_ = openViewArg.Path;
		try
		{
			ViewConfig[] viewConfigs = ViewConfigSetting.GetViewConfigs((ViewConfig p) => p.ViewClass.Equals(openViewArg.ViewName));
			if (viewConfigs == null || viewConfigs.Length == 0)
			{
				throw new Exception("找不到类型" + openViewArg.ViewName + " 的视图路径");
			}
			string viewPath = viewConfigs[0].ViewPath;
			UGuiWindow w = await GameEntry.UI.OpenWindow<UGuiWindow>(viewPath, openViewArg.UiGroupName, openViewArg.UserData);
			if (w != null)
			{
				w.OnDismissed += Handler;
			}
			void Handler(object window, EventArgs e)
			{
				w.OnDismissed -= Handler;
				callback?.Invoke();
			}
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			throw;
		}
	}

	private LoopGridViewItem OnGetEquipExpItemByIndex(LoopGridView arg1, int index, int row, int colum)
	{
		EquipExpItemDataNew equipExpItemDataNew = _viewModel.EquipExpItemDataNews[index];
		if (equipExpItemDataNew == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = expItemList.NewListViewItem("EquipExpItemNew");
		EquipExpItemNew component = loopGridViewItem.GetComponent<EquipExpItemNew>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(equipExpItemDataNew);
		}
		else
		{
			component.RefreshData(equipExpItemDataNew);
		}
		return loopGridViewItem;
	}

	private LoopListViewItem2 OnGetAttributeItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.AttributeUpgradeItemDatas.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("AttributeUpgradeItem");
		if (loopListViewItem != null)
		{
			AttributeUpgradeItem component = loopListViewItem.GetComponent<AttributeUpgradeItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(_viewModel.AttributeUpgradeItemDatas[index]);
			}
			else
			{
				component.RefreshAttributeData(_viewModel.AttributeUpgradeItemDatas[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnRarityLimitItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.RarityLimitItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("RarityLimitItem");
		if (loopListViewItem != null)
		{
			TabItemNormal component = loopListViewItem.GetComponent<TabItemNormal>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(_viewModel.RarityLimitItemDataList[index]);
			}
			else
			{
				component.RefreshData(_viewModel.RarityLimitItemDataList[index]);
			}
		}
		return loopListViewItem;
	}
}
