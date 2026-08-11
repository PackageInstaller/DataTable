using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourChangeWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private LoopGridView equipmentList;

	[SerializeField]
	private ArmourDetailView armourSelected;

	[SerializeField]
	private ArmourDetailView armourContrast;

	[SerializeField]
	private EntryCompareView entryContrast;

	[SerializeField]
	private List<TabItem> tablist;

	[SerializeField]
	private TextMeshProUGUI currentSlotTitleText;

	[SerializeField]
	private CanvasGroup contrastPanel;

	[SerializeField]
	private TabItem tabArmourContrast;

	[SerializeField]
	private TabItem tabEntryContrast;

	[SerializeField]
	private Toggle sortToggle;

	[SerializeField]
	private TextMeshProUGUI sortModeText;

	[SerializeField]
	private TabToggle tabToggleObj;

	[SerializeField]
	private Button btnToggleBack;

	[SerializeField]
	private CanvasGroup sortPanel;

	[SerializeField]
	private Button screenBtn;

	[SerializeField]
	private CanvasGroup screenPanel;

	[SerializeField]
	private Button screenBackMask;

	[SerializeField]
	private Button confirmBtn;

	[SerializeField]
	private GameObject screenToggleNormalObj;

	[SerializeField]
	private GameObject screenToggleSelectedObj;

	[SerializeField]
	private Button clearBtn;

	[SerializeField]
	private GameObject clearBtnImg;

	[SerializeField]
	private TabItemNormal exactBtn;

	[SerializeField]
	private TabItemNormal fuzzyBtn;

	[SerializeField]
	private GameObject noEquip;

	[SerializeField]
	private ArmourShowView armourShowView;

	[SerializeField]
	private GameObject armourShowObj;

	[SerializeField]
	private GameObject armourMask;

	[SerializeField]
	private GameObject armourScreenItem;

	[SerializeField]
	private Transform screenPos;

	[SerializeField]
	private LoopGridView selectedList;

	[SerializeField]
	private EntryInfoView entryInfoView;

	[SerializeField]
	private ArmourFilterView filterView;

	[SerializeField]
	private Button btnRecommend;

	[SerializeField]
	private UIParticlePlayer armourChangeEffect;

	[SerializeField]
	private Vector2 equipArmourEntryPos;

	[SerializeField]
	private Vector2 contrastArmourEntryPos;

	private ArmourChangeViewModel viewModel;

	private bool entryInfoViewInitialized;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<ArmourChangeViewModel>();
		BindingSet<ArmourChangeWindow, ArmourChangeViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((ArmourChangeViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((ArmourChangeWindow v) => v.OpenUguiWindow).To((ArmourChangeViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((ArmourChangeWindow v) => v.SetChildViewVisibility).To((ArmourChangeViewModel vm) => vm.ShowViewRequest);
		bindingSet.Bind(this).For((ArmourChangeWindow v) => v.CloseWindow).To((ArmourChangeViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((ArmourChangeWindow v) => v.UpdateDataShow).To((ArmourChangeViewModel vm) => vm.RefreshShowDatasRequest);
		bindingSet.Bind(this).For((ArmourChangeWindow v) => v.RefreshArmourShow).To((ArmourChangeViewModel vm) => vm.RefreshArmourShowRequest);
		bindingSet.Bind(this).For((ArmourChangeWindow v) => v.ShowEntryDetail).To((ArmourChangeViewModel vm) => vm.ShowEntryDetailRequest);
		bindingSet.Bind(this).For((ArmourChangeWindow v) => v.HideEntryDetail).To((ArmourChangeViewModel vm) => vm.HideEntryDetailRequest);
		bindingSet.Bind(this).For((ArmourChangeWindow v) => v.ArmourChangeEffect).To((ArmourChangeViewModel vm) => vm.ArmourChangeRequest);
		bindingSet.Bind(this).For((ArmourChangeWindow v) => v.CloseEffect).To((ArmourChangeViewModel vm) => vm.CloseEffectRequest);
		bindingSet.Bind(this).For((ArmourChangeWindow v) => v.RefreshRedPoint).To((ArmourChangeViewModel vm) => vm.RefreshRedPointRequest);
		bindingSet.Bind(this).For((ArmourChangeWindow v) => v.OnOpt).To((ArmourChangeViewModel vm) => vm.OptRequest);
		bindingSet.Bind<TextMeshProUGUI>(sortModeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourChangeViewModel vm) => vm.CurSortName);
		bindingSet.Bind(noEquip).For((GameObject v) => v.activeSelf).To((ArmourChangeViewModel vm) => vm.IsEmpty);
		bindingSet.Bind(armourShowObj).For((GameObject v) => v.activeSelf).To((ArmourChangeViewModel vm) => vm.ShowArmour);
		bindingSet.Bind(armourMask).For((GameObject v) => v.activeSelf).To((ArmourChangeViewModel vm) => vm.ShowArmourMask);
		bindingSet.Bind(this).For((ArmourChangeWindow v) => v.RefreshScreenItem).To((ArmourChangeViewModel vm) => vm.RefreshScreenItemRequest);
		bindingSet.Bind(confirmBtn).For((Button v) => v.onClick).To((ArmourChangeViewModel vm) => vm.RefreshScreenArmour);
		bindingSet.Bind(clearBtn).For((Button v) => v.onClick).To((ArmourChangeViewModel vm) => vm.ClearSelectedScreenTags);
		bindingSet.Bind(clearBtnImg).For((GameObject v) => v.activeSelf).To((ArmourChangeViewModel vm) => vm.ClearBtnCanClick);
		bindingSet.Bind(screenToggleNormalObj).For((GameObject v) => v.activeSelf).ToExpression((ArmourChangeViewModel vm) => !vm.IsShowScreenResult);
		bindingSet.Bind(screenToggleSelectedObj).For((GameObject v) => v.activeSelf).To((ArmourChangeViewModel vm) => vm.IsShowScreenResult);
		if ((UnityEngine.Object)(object)currentSlotTitleText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(currentSlotTitleText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourChangeViewModel vm) => vm.CurrentSlotTitle);
		}
		bindingSet.Bind(this).For((ArmourChangeWindow v) => UpdateSelectedTagShow).To((ArmourChangeViewModel vm) => vm.RefreshSelectedRequest);
		bindingSet.Bind().For((ArmourChangeWindow v) => v.CloseScreen).To((ArmourChangeViewModel vm) => vm.CloseScreenRequest);
		bindingSet.Bind<CanvasGroup>(contrastPanel).For((Expression<Func<CanvasGroup, float>>)((CanvasGroup v) => v.alpha)).ToExpression((ArmourChangeViewModel vm) => vm.ContrastPanelVisible ? 1 : 0);
		bindingSet.Bind<CanvasGroup>(contrastPanel).For((Expression<Func<CanvasGroup, bool>>)((CanvasGroup v) => v.blocksRaycasts)).To((ArmourChangeViewModel vm) => vm.ContrastPanelVisible);
		bindingSet.Build();
		if (filterView != null)
		{
			filterView.Init(viewModel.FilterSubViewModel);
		}
		if (btnRecommend != null)
		{
			btnRecommend.onClick.AddListener(viewModel.OpenRecommendView);
		}
		exactBtn.Init(viewModel.ExactBtn);
		fuzzyBtn.Init(viewModel.FuzzyBtn);
		equipmentList.InitGridView(viewModel.EquipmentShowList.Count, OnGetEquipmentItemByIndex);
		InitTabList();
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
		armourShowView.SetArmourData(viewModel.ArmourData);
		InitScreenTypeToggles();
		screenBtn.onClick.AddListener(viewModel.OpenFilterView);
		screenBackMask.onClick.AddListener(ScreenPanelHide);
		selectedList.InitGridView(viewModel.SelectedScreenTagData.Count, OnGetSelectedItemByIndex);
		if (entryInfoView != null && (!(filterView != null) || !filterView.UsesEntryInfoView(entryInfoView)) && !entryInfoViewInitialized)
		{
			entryInfoView.Init();
			entryInfoView.gameObject.SetActive(value: false);
			entryInfoViewInitialized = true;
		}
		RefreshAllRedPoint();
	}

	private void ShowEntryDetail(object sender, InteractionEventArgs e)
	{
		EntryItemData entryItemData = (EntryItemData)e.Context;
		Vector2 position = ((entryItemData.Type == 1) ? equipArmourEntryPos : contrastArmourEntryPos);
		entryInfoView.SetPosition(position);
		entryInfoView.Show(entryItemData, null, !entryItemData.IsMainEntry);
	}

	private void HideEntryDetail(object sender, InteractionEventArgs e)
	{
		entryInfoView.Hide();
	}

	private void RefreshRedPoint(object sender, InteractionEventArgs e)
	{
		RefreshAllRedPoint();
	}

	private void RefreshAllRedPoint()
	{
		for (int i = 0; i < tablist.Count; i++)
		{
			bool redPoint = viewModel.GetRedPoint(i);
			tablist[i].transform.Find("Normal")?.transform.Find("RedPoint")?.gameObject.SetActive(redPoint);
			tablist[i].transform.Find("Selected")?.transform.Find("RedPoint")?.gameObject.SetActive(redPoint);
		}
	}

	private void ArmourChangeEffect(object sender, InteractionEventArgs e)
	{
		armourChangeEffect.Play();
	}

	private void CloseEffect(object sender, InteractionEventArgs e)
	{
		armourChangeEffect.gameObject.SetActive(value: false);
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string value = (string)e.Context;
		if ("OpenFilterView".Equals(value))
		{
			filterView?.SetVisible(visible: true);
			filterView?.RefreshFilterList();
		}
		else if ("CloseFilterView".Equals(value))
		{
			filterView?.HideEntryInfo();
			filterView?.SetVisible(visible: false);
		}
		else if ("RefreshFilterList".Equals(value))
		{
			filterView?.RefreshFilterList();
		}
		else if ("ShowFilterEntryInfo".Equals(value))
		{
			entryInfoView?.Hide();
			filterView?.ShowFilterEntryInfo();
		}
	}

	private void ScreenPanelShow()
	{
		screenPanel.alpha = 1f;
		screenPanel.blocksRaycasts = true;
		screenBackMask.gameObject.SetActive(value: true);
	}

	private void ScreenPanelHide()
	{
		screenPanel.alpha = 0f;
		screenPanel.blocksRaycasts = false;
		screenBackMask.gameObject.SetActive(value: false);
	}

	private void UpdateDataShow(object sender, InteractionEventArgs e)
	{
		equipmentList.SetListItemCount(viewModel.EquipmentShowList.Count);
		equipmentList.RefreshAllShownItem();
	}

	private void RefreshScreenItem(object sender, InteractionEventArgs e)
	{
		LayoutRebuilder.ForceRebuildLayoutImmediate(screenPos.GetComponent<RectTransform>());
	}

	private void RefreshArmourShow(object sender, InteractionEventArgs e)
	{
		armourShowView.SetArmourData(viewModel.ArmourData);
	}

	private void CloseScreen(object sender, InteractionEventArgs e)
	{
		ScreenPanelHide();
	}

	private void InitTabList()
	{
		for (int i = 0; i < tablist.Count; i++)
		{
			tablist[i].Init(viewModel.TabDataList[i]);
		}
	}

	protected override void OnShow()
	{
		base.OnShow();
		armourSelected.Init(viewModel.SelectedViewModel);
		armourContrast.Init(viewModel.ContrastViewModel);
		entryContrast.Init(viewModel.EntryContrastViewModel);
		tabArmourContrast.Init(viewModel.ArmourContrastTabItemData);
		tabEntryContrast.Init(viewModel.EntryContrastTabItemData);
	}

	private void InitScreenToggles()
	{
		foreach (KeyValuePair<int, string> item in viewModel.SortTypeName)
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

	private void InitScreenTypeToggles()
	{
		foreach (ArmourScreenItemData screenItemDatum in viewModel.ScreenItemData)
		{
			ArmourScreenItem component = UnityEngine.Object.Instantiate(armourScreenItem, screenPos).GetComponent<ArmourScreenItem>();
			component.Init(screenItemDatum);
			component.gameObject.SetActive(value: true);
		}
	}

	private LoopGridViewItem OnGetEquipmentItemByIndex(LoopGridView arg1, int index, int row, int column)
	{
		ArmourItemData armourItemData = viewModel.GetArmourItemData(index);
		if (armourItemData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = equipmentList.NewListViewItem("ArmourItem");
		ArmourItem component = loopGridViewItem.GetComponent<ArmourItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(armourItemData);
		}
		else
		{
			component.RefreshData(armourItemData);
		}
		return loopGridViewItem;
	}

	private LoopGridViewItem OnGetSelectedItemByIndex(LoopGridView arg1, int index, int row, int colum)
	{
		ArmourScreenTagItemData armourScreenTagItemData = viewModel.SelectedScreenTagData[index];
		if (armourScreenTagItemData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = selectedList.NewListViewItem("ArmourTagView");
		ArmourScreenView component = loopGridViewItem.GetComponent<ArmourScreenView>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(armourScreenTagItemData);
		}
		else
		{
			component.RefreshData(armourScreenTagItemData);
		}
		return loopGridViewItem;
	}

	private void UpdateSelectedTagShow(object sender, InteractionEventArgs e)
	{
		selectedList.SetListItemCount(viewModel.SelectedScreenTagData.Count);
		selectedList.RefreshAllShownItem();
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		armourShowView.ClearObj();
		Dismiss();
	}
}
