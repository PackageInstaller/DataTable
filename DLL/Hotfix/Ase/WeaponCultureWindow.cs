using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class WeaponCultureWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private List<TabToggle> _toggles;

	[SerializeField]
	private Transform weaponObjPos;

	private GameObject _weaponObj;

	private WeaponPopupView _weaponPopupView;

	[SerializeField]
	private Transform weaponInfoRoot;

	[SerializeField]
	private WeaponUpgradeView weaponUpgradeView;

	[SerializeField]
	private WeaponUpStarView weaponUpStarView;

	[SerializeField]
	private WeaponRefineView weaponRefineView;

	[SerializeField]
	private EntryInfoView _entryInfoView;

	[SerializeField]
	private MoneyView moneyView;

	private WeaponCultureViewModel _viewModel;

	private int curIndex = -1;

	private string path = "";

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<WeaponCultureViewModel>();
		BindingSet<WeaponCultureWindow, WeaponCultureViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((WeaponCultureViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((WeaponCultureWindow v) => v.CloseWindow).To((WeaponCultureViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((WeaponCultureWindow v) => v.OpenUguiWindow).To((WeaponCultureViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((WeaponCultureWindow v) => v.OpenUpStarView).To((WeaponCultureViewModel vm) => vm.GotoUpStarViewRequest);
		bindingSet.Bind(this).For((WeaponCultureWindow v) => v.OpenUpLevel).To((WeaponCultureViewModel vm) => vm.OpenUpLevelRequest);
		bindingSet.Bind(this).For((WeaponCultureWindow v) => v.ShowEntryDetail).To((WeaponCultureViewModel vm) => vm.ShowEntryDetailRequest);
		bindingSet.Build();
		moneyView.Init(new MoneyViewModel(_viewModel));
		weaponUpgradeView.Init(_viewModel.WeaponUpgradeViewModel);
		weaponUpStarView.Init(_viewModel.WeaponUpStarViewModel);
		weaponRefineView.Init(_viewModel.WeaponRefineViewModel);
		LoadWeaponObj();
		InitToggle();
		SetToggleObj();
		_entryInfoView.Init();
	}

	private void SetToggleObj()
	{
		if (_viewModel.WeaponData.Level == _viewModel.WeaponData.MaxLevel)
		{
			_toggles[1].gameObject.SetActive(value: false);
			_toggles[2].gameObject.SetActive(value: true);
		}
		else
		{
			_toggles[1].gameObject.SetActive(value: true);
			_toggles[2].gameObject.SetActive(value: false);
		}
		_toggles[3].gameObject.SetActive(_viewModel.WeaponData.BuffIdList.Count > 0);
	}

	private void ShowEntryDetail(object sender, InteractionEventArgs e)
	{
		EntryItem entryItem = (EntryItem)e.Context;
		_entryInfoView.Show(entryItem.ViewModel);
	}

	protected override void OnShow()
	{
		base.OnShow();
		LoadWeaponPopupView();
	}

	private async void LoadWeaponPopupView()
	{
		if (_weaponPopupView == null)
		{
			_weaponPopupView = await GameEntry.UI.OpenUIView<WeaponPopupView>("PopupView/WeaponPopupView");
			AddView(_weaponPopupView);
			_weaponPopupView.transform.SetParent(weaponInfoRoot);
			_weaponPopupView.Init(_viewModel.WeaponPopupViewModel);
			_weaponPopupView.SetAnchorAndPivot(new Vector2(1f, 0.5f), new Vector2(1f, 0.5f), new Vector2(1f, 0.5f));
		}
		_weaponPopupView.Visibility = _toggles[0].isOn;
	}

	private void InitToggle()
	{
		for (int i = 0; i < _toggles.Count; i++)
		{
			_toggles[i].enumId = i;
			_toggles[i].AddSelectedAction(UpdatePanel);
		}
	}

	private void OpenUpStarView(object sender, InteractionEventArgs e)
	{
		UpdatePanel(2);
	}

	private void OpenUpLevel(object sender, InteractionEventArgs e)
	{
		UpdatePanel(1);
	}

	private async void LoadWeaponObj()
	{
		if (_weaponObj != null)
		{
			Object.Destroy(_weaponObj);
		}
		path = AssetUtility.GetUIItemAsset("WeaponPrefabs/" + _viewModel.WeaponData.Icon);
		GameObject gameObject = await InstantiateAsync(path, weaponObjPos);
		if (!(gameObject == null))
		{
			GameObject weaponObj = gameObject;
			_weaponObj = weaponObj;
		}
	}

	private void UpdatePanel(int id)
	{
		if (curIndex == id)
		{
			return;
		}
		curIndex = id;
		_viewModel.CloseProp();
		weaponInfoRoot.gameObject.SetActive(value: false);
		weaponUpgradeView.gameObject.SetActive(value: false);
		weaponUpgradeView.CloseScreen();
		weaponUpStarView.gameObject.SetActive(value: false);
		weaponRefineView.gameObject.SetActive(value: false);
		moneyView.Visibility = id != 0 && id != 3;
		if (_weaponPopupView != null)
		{
			_weaponPopupView.Visibility = id == 0;
		}
		switch (id)
		{
		case 0:
			weaponInfoRoot.gameObject.SetActive(value: true);
			if (_weaponPopupView != null)
			{
				_weaponPopupView.RefreshWeaponData();
			}
			break;
		case 1:
			weaponUpgradeView.ResetContent();
			weaponUpgradeView.gameObject.SetActive(value: true);
			_toggles[1].gameObject.SetActive(value: true);
			_toggles[1].isOn = true;
			_toggles[2].gameObject.SetActive(value: false);
			_viewModel.WeaponUpgradeViewModel.LoadExpItem();
			_viewModel.WeaponUpgradeViewModel.ClearExpItem();
			break;
		case 2:
			weaponUpStarView.gameObject.SetActive(value: true);
			weaponUpStarView.RefreshWeapon();
			_toggles[1].gameObject.SetActive(value: false);
			_toggles[2].gameObject.SetActive(value: true);
			_toggles[2].isOn = true;
			break;
		case 3:
			weaponRefineView.ClearMaterial();
			weaponRefineView.gameObject.SetActive(value: true);
			break;
		}
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		if (_weaponObj != null)
		{
			Object.Destroy(_weaponObj);
		}
		if (_weaponPopupView != null)
		{
			Object.Destroy(_weaponPopupView.gameObject);
			_weaponPopupView = null;
			GameEntry.Resource.UnloadAsset(AssetUtility.GetUIFormAsset("PopupView/WeaponPopupView"));
		}
		_viewModel = null;
		Dismiss();
	}
}
