using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class WeaponChangeWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private LoopGridView equipmentList;

	[SerializeField]
	private Toggle sortToggle;

	[SerializeField]
	private TextMeshProUGUI sortModeText;

	[SerializeField]
	private TabToggle tabToggleObj;

	[SerializeField]
	private Button btnToggleBack;

	[SerializeField]
	private Button sortButton;

	[SerializeField]
	private CanvasGroup sortPanel;

	[SerializeField]
	private EntryInfoView entryInfoView;

	[SerializeField]
	private WeaponDetailView weaponDetailView;

	[SerializeField]
	private UIParticlePlayer weaponChangeEffect;

	[SerializeField]
	private Transform weaponObjPos;

	private GameObject _weaponObj;

	private WeaponChangeViewModel viewModel;

	private string path = "";

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<WeaponChangeViewModel>();
		BindingSet<WeaponChangeWindow, WeaponChangeViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((WeaponChangeViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((WeaponChangeWindow v) => v.CloseWindow).To((WeaponChangeViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((WeaponChangeWindow v) => v.UpdateDataShow).To((WeaponChangeViewModel vm) => vm.RefreshShowDatasRequest);
		bindingSet.Bind(this).For((WeaponChangeWindow v) => v.UpdateWeaponShow).To((WeaponChangeViewModel vm) => vm.WeaponShowRequest);
		bindingSet.Bind(this).For((WeaponChangeWindow v) => v.ShowEntryDetail).To((WeaponChangeViewModel vm) => vm.ShowEntryDetailRequest);
		bindingSet.Bind<TextMeshProUGUI>(sortModeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponChangeViewModel vm) => vm.CurSortName);
		bindingSet.Bind(sortButton).For((Button v) => v.onClick).To((WeaponChangeViewModel vm) => vm.SortWeaponReverse);
		bindingSet.Bind(this).For((WeaponChangeWindow v) => v.ShowChangeWeaponEffect).To((WeaponChangeViewModel vm) => vm.ChangeWeaponRequest);
		bindingSet.Bind(this).For((WeaponChangeWindow v) => v.OpenUguiWindow).To((WeaponChangeViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Build();
		equipmentList.InitGridView(viewModel.WeaponShowList.Count, OnGetEquipmentItemByIndex);
		InitScreenToggles();
		sortToggle.onValueChanged.AddListener(delegate(bool v)
		{
			sortPanel.alpha = (v ? 1 : 0);
			sortPanel.blocksRaycasts = v;
			btnToggleBack.interactable = v;
			btnToggleBack.GetComponent<Image>().raycastTarget = v;
		});
		btnToggleBack.onClick.AddListener(delegate
		{
			sortToggle.isOn = false;
		});
		weaponDetailView.Init(viewModel.WeaponDetailViewModel);
		LoadWeaponObj();
		entryInfoView.Init();
	}

	private void ShowEntryDetail(object sender, InteractionEventArgs e)
	{
		EntryItem entryItem = (EntryItem)e.Context;
		entryInfoView.Show(entryItem.ViewModel);
	}

	private void ShowChangeWeaponEffect(object sender, InteractionEventArgs e)
	{
		weaponChangeEffect.Play();
	}

	private void UpdateDataShow(object sender, InteractionEventArgs e)
	{
		equipmentList.SetListItemCount(viewModel.WeaponShowList.Count);
		equipmentList.RefreshAllShownItem();
	}

	private void UpdateWeaponShow(object sender, InteractionEventArgs e)
	{
		LoadWeaponObj();
	}

	private async void LoadWeaponObj()
	{
		if (_weaponObj != null)
		{
			UnityEngine.Object.Destroy(_weaponObj);
		}
		path = AssetUtility.GetUIItemAsset("WeaponPrefabs/" + viewModel.CurItemData.Data.Icon);
		GameObject gameObject = await InstantiateAsync(path, weaponObjPos);
		if (!(gameObject == null))
		{
			GameObject weaponObj = gameObject;
			_weaponObj = weaponObj;
			UIStarGroup componentInChildren = _weaponObj.GetComponentInChildren<UIStarGroup>();
			if (componentInChildren != null)
			{
				componentInChildren.CurCount = viewModel.CurItemData.Data.Star;
			}
		}
	}

	private void InitScreenToggles()
	{
		foreach (KeyValuePair<int, string> item in viewModel.SortTypeEnum)
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
		viewModel.ItemOnClick(index);
		sortToggle.isOn = false;
	}

	private LoopGridViewItem OnGetEquipmentItemByIndex(LoopGridView arg1, int index, int row, int column)
	{
		WeaponItemData weaponItemData = viewModel.WeaponShowList[index];
		if (weaponItemData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = equipmentList.NewListViewItem("WeaponItem");
		WeaponItem component = loopGridViewItem.GetComponent<WeaponItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(weaponItemData);
		}
		else
		{
			component.RefreshData(weaponItemData);
		}
		return loopGridViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		if (_weaponObj != null)
		{
			UnityEngine.Object.Destroy(_weaponObj);
		}
		Dismiss();
	}
}
