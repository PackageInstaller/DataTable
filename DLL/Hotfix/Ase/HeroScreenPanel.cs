using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroScreenPanel : UIView
{
	[SerializeField]
	private Toggle screenToggle1;

	[SerializeField]
	private TextMeshProUGUI screenModeText;

	[SerializeField]
	private TabToggle _tabToggle;

	[SerializeField]
	private Button sortButton;

	[SerializeField]
	private CanvasGroup screenPanel1;

	[SerializeField]
	private Button btnScreenPanel1Back;

	[SerializeField]
	private Toggle screenToggle2;

	[SerializeField]
	private GameObject unScreeningIcon;

	[SerializeField]
	private GameObject screeningIcon;

	[SerializeField]
	private Sprite screenToggleSelected;

	[SerializeField]
	private Sprite screenToggleNormal;

	[SerializeField]
	private Button ConfirmBtn;

	[SerializeField]
	private Button ClearBtn;

	[SerializeField]
	private GameObject ClearBtnImg;

	[SerializeField]
	private CanvasGroup screenPanel2;

	[SerializeField]
	private Button btnScreenPanel2Back;

	[SerializeField]
	private GameObject screenPanel3;

	[SerializeField]
	private GameObject screenPanel4;

	[SerializeField]
	private LoopListView2 selectedList;

	[SerializeField]
	private GameObject HeroWareHouseSortBtn;

	private HeroScreenPanelViewModel _viewModel;

	public void Init(HeroScreenPanelViewModel viewModel)
	{
		_viewModel = viewModel;
		BindingSet<HeroScreenPanel, HeroScreenPanelViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(sortButton).For((Button v) => v.onClick).To((HeroScreenPanelViewModel vm) => vm.SortHeroModels);
		bindingSet.Bind<TextMeshProUGUI>(screenModeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroScreenPanelViewModel vm) => vm.CurSortName);
		bindingSet.Bind(ConfirmBtn).For((Button v) => v.onClick).To((HeroScreenPanelViewModel vm) => vm.RefreshScreeningHeroModels);
		bindingSet.Bind(ClearBtn).For((Button v) => v.onClick).To((HeroScreenPanelViewModel vm) => vm.ClearSelectedHeroModels);
		bindingSet.Bind(ClearBtnImg).For((GameObject v) => v.activeSelf).To((HeroScreenPanelViewModel vm) => vm.ClearBtnCanClick);
		bindingSet.Bind(ClearBtn).For((Button v) => v.interactable).To((HeroScreenPanelViewModel vm) => vm.ClearBtnCanClick);
		bindingSet.Bind(unScreeningIcon).For((GameObject v) => v.activeSelf).ToExpression((HeroScreenPanelViewModel vm) => !vm.IsShowScreenResult);
		bindingSet.Bind(screeningIcon).For((GameObject v) => v.activeSelf).To((HeroScreenPanelViewModel vm) => vm.IsShowScreenResult);
		bindingSet.Bind().For((HeroScreenPanel v) => v.RefreshHeroSelected).To((HeroScreenPanelViewModel vm) => vm.RefreshSelectedRequest);
		bindingSet.Bind().For((HeroScreenPanel v) => v.CloseScreen).To((HeroScreenPanelViewModel vm) => vm.CloseScreenRequest);
		bindingSet.Build();
		InitScreenToggles();
		InitScreenAttributeToggles();
		InitScreenWeaponTypeToggles();
		selectedList.InitListView(_viewModel.SelectedSortData.Count, OnGetSelectedItemByIndex);
		screenToggle1.onValueChanged.AddListener(delegate(bool v)
		{
			screenPanel1.alpha = (v ? 1 : 0);
			screenPanel1.blocksRaycasts = v;
			btnScreenPanel1Back.interactable = v;
			btnScreenPanel1Back.gameObject.SetActive(v);
		});
		screenToggle2.onValueChanged.AddListener(delegate(bool v)
		{
			screenPanel2.alpha = (v ? 1 : 0);
			screenPanel2.blocksRaycasts = v;
			btnScreenPanel2Back.interactable = v;
			btnScreenPanel2Back.GetComponent<Image>().raycastTarget = v;
		});
		btnScreenPanel1Back.onClick.AddListener(delegate
		{
			screenToggle1.isOn = false;
		});
		btnScreenPanel2Back.onClick.AddListener(delegate
		{
			screenToggle2.isOn = false;
		});
	}

	private void InitScreenToggles()
	{
		foreach (KeyValuePair<int, string> item in _viewModel.SortTypeEnum)
		{
			TabToggle component = UnityEngine.Object.Instantiate(_tabToggle, ((Component)(object)screenPanel1).transform).GetComponent<TabToggle>();
			component.enumId = item.Key;
			component.SetToggleText(item.Value, item.Value);
			component.AddSelectedAction(OnScreenToggleClick);
			component.gameObject.SetActive(value: true);
		}
		((Component)(object)screenPanel1).transform.GetChild(0).gameObject.GetComponent<Toggle>().isOn = true;
	}

	private void InitScreenAttributeToggles()
	{
		HeroAttributeEnum[] heroAttributeEnums = _viewModel.HeroAttributeEnums;
		foreach (HeroAttributeEnum heroAttributeEnum in heroAttributeEnums)
		{
			if (heroAttributeEnum == HeroAttributeEnum.Normal)
			{
				break;
			}
			HeroWarehouseSortButtonView component = UnityEngine.Object.Instantiate(HeroWareHouseSortBtn, screenPanel3.transform).GetComponent<HeroWarehouseSortButtonView>();
			HeroWarehouseSortButtonViewModel viewModel = new HeroWarehouseSortButtonViewModel(_viewModel, heroAttributeEnum);
			component.Init(viewModel);
			component.gameObject.SetActive(value: true);
		}
	}

	private void InitScreenWeaponTypeToggles()
	{
		WeaponEnum[] weaponEnums = _viewModel.WeaponEnums;
		foreach (WeaponEnum weaponEnum in weaponEnums)
		{
			if (weaponEnum != WeaponEnum.None)
			{
				HeroWarehouseSortButtonView component = UnityEngine.Object.Instantiate(HeroWareHouseSortBtn, screenPanel4.transform).GetComponent<HeroWarehouseSortButtonView>();
				HeroWarehouseSortButtonViewModel viewModel = new HeroWarehouseSortButtonViewModel(_viewModel, weaponEnum);
				component.Init(viewModel);
				component.gameObject.SetActive(value: true);
			}
		}
	}

	private LoopListViewItem2 OnGetSelectedItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.SelectedSortData.Count)
		{
			return null;
		}
		if (_viewModel.SelectedSortData[index] == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = selectedList.NewListViewItem("HeroWareHouseSortBtn");
		HeroWarehouseSortButtonView component = loopListViewItem.GetComponent<HeroWarehouseSortButtonView>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(_viewModel.SelectedSortData[index]);
		}
		else
		{
			component.RefreshData(_viewModel.SelectedSortData[index]);
		}
		return loopListViewItem;
	}

	private void OnScreenToggleClick(int index)
	{
		_viewModel.ItemOnClick(index);
		screenToggle1.isOn = false;
	}

	private void RefreshHeroModels(object sender, InteractionEventArgs e)
	{
		if (!_viewModel.IsShowScreenResult)
		{
			screenToggle2.GetComponent<Image>().sprite = screenToggleNormal;
			ColorUtility.TryParseHtmlString("#FFFFFF", out var color);
			screenToggle2.transform.GetChild(0).GetComponent<Image>().color = color;
		}
		else
		{
			screenToggle2.GetComponent<Image>().sprite = screenToggleSelected;
			ColorUtility.TryParseHtmlString("#49536b", out var color2);
			screenToggle2.transform.GetChild(0).GetComponent<Image>().color = color2;
		}
	}

	private void CloseScreen(object sender, InteractionEventArgs e)
	{
		screenToggle2.isOn = false;
	}

	private void RefreshHeroSelected(object sender, InteractionEventArgs e)
	{
		selectedList.SetListItemCount(_viewModel.SelectedSortData.Count);
		selectedList.RefreshAllShownItem();
	}
}
