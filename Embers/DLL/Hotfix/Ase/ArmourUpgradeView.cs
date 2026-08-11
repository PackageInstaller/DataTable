using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourUpgradeView : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI armourName;

	[SerializeField]
	private ArmourShowView armourShowView;

	[SerializeField]
	private TextMeshProUGUI needCoin;

	[SerializeField]
	private Button upgradeBtn;

	[SerializeField]
	private Button btnDecompose;

	[SerializeField]
	private UIGameObjectSort uIGameObjectSort;

	[SerializeField]
	private RectTransform root;

	[SerializeField]
	private GameObject mainAttributeUpgradeItem;

	[SerializeField]
	private GameObject attributeUpgradeItem;

	[SerializeField]
	private GameObject attributeItem;

	[SerializeField]
	private GameObject mainAttributeItem;

	[SerializeField]
	private GameObject allLevelObj;

	[SerializeField]
	private GameObject levelNoMaxObj;

	[SerializeField]
	private GameObject levelMaxObj;

	[SerializeField]
	private GameObject addLevelNoMaxObj;

	[SerializeField]
	private GameObject addLevelMaxObj;

	[SerializeField]
	private EntryInfoView _entryInfoView;

	[SerializeField]
	private GameObject settingTipObj;

	[SerializeField]
	private TextMeshProUGUI settingTipText;

	[SerializeField]
	private Button settingBtn;

	[SerializeField]
	private TextMeshProUGUI settingBtnText;

	[SerializeField]
	private Button autoSelectBtn;

	[SerializeField]
	private TextMeshProUGUI autoSelectBtnText;

	[SerializeField]
	private LoopGridView expItemList;

	[SerializeField]
	private GameObject expItemListObj;

	[SerializeField]
	private GameObject maskObj;

	[SerializeField]
	private Toggle sortToggle;

	[SerializeField]
	private TextMeshProUGUI sortModeText;

	[SerializeField]
	private TabToggle tabToggleObj;

	[SerializeField]
	private Button toggleScreenBack;

	[SerializeField]
	private Button sortButton;

	[SerializeField]
	private CanvasGroup sortPanel;

	[SerializeField]
	private TextMeshProUGUI curLevelText;

	[SerializeField]
	private TextMeshProUGUI addLevelText;

	[SerializeField]
	private TextMeshProUGUI addExpText;

	[SerializeField]
	private TextMeshProUGUI curExpText;

	[SerializeField]
	private Image preExpFillImg;

	[SerializeField]
	private Image curExpFillImg;

	[SerializeField]
	private GameObject expMaxObj;

	private ArmourUpgradeViewModel _viewModel;

	public void Init(ArmourUpgradeViewModel viewModel)
	{
		_viewModel = viewModel;
		BindingSet<ArmourUpgradeView, ArmourUpgradeViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(armourName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourUpgradeViewModel vm) => vm.ArmourData.Name);
		bindingSet.Bind<TextMeshProUGUI>(needCoin).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourUpgradeViewModel vm) => vm.ShowCoin);
		bindingSet.Bind(expMaxObj).For((GameObject v) => v.activeSelf).To((ArmourUpgradeViewModel vm) => vm.IsMax);
		bindingSet.Bind(this).For((ArmourUpgradeView v) => v.UpdateInfoShow).To((ArmourUpgradeViewModel vm) => vm.RefreshInfoRequest);
		bindingSet.Bind(upgradeBtn).For((Button v) => v.onClick).To((ArmourUpgradeViewModel vm) => vm.UpgradeOnClick);
		if (btnDecompose != null)
		{
			bindingSet.Bind(btnDecompose).For((Button v) => v.onClick).To((ArmourUpgradeViewModel vm) => vm.OpenDecompose);
		}
		bindingSet.Bind(this).For((ArmourUpgradeView v) => v.ShowEntryDetail).To((ArmourUpgradeViewModel vm) => vm.ShowEntryDetailRequest);
		bindingSet.Bind<TextMeshProUGUI>(curLevelText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ArmourUpgradeViewModel vm) => $"+{vm.ArmourData.Level}");
		bindingSet.Bind<TextMeshProUGUI>(addLevelText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourUpgradeViewModel vm) => vm.AddLevelText);
		bindingSet.Bind<TextMeshProUGUI>(addExpText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourUpgradeViewModel vm) => vm.AddExpText);
		bindingSet.Bind<TextMeshProUGUI>(curExpText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourUpgradeViewModel vm) => vm.CurExpText);
		bindingSet.Bind(preExpFillImg).For((Image v) => v.fillAmount).To((ArmourUpgradeViewModel vm) => vm.PreExpFillAmount);
		bindingSet.Bind(curExpFillImg).For((Image v) => v.fillAmount).To((ArmourUpgradeViewModel vm) => vm.CurExpFillAmount);
		bindingSet.Bind(this).For((ArmourUpgradeView v) => v.UpdateExpItemList).To((ArmourUpgradeViewModel vm) => vm.RefreshExpItemListRequest);
		bindingSet.Bind(settingBtn).For((Button v) => v.onClick).To((ArmourUpgradeViewModel vm) => vm.OpenArmourSelectRuleWindow);
		bindingSet.Bind(settingTipObj).For((GameObject v) => v.activeSelf).To((ArmourUpgradeViewModel vm) => vm.IsOpenUpLimit);
		bindingSet.Bind<TextMeshProUGUI>(settingTipText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourUpgradeViewModel vm) => vm.SettingText);
		bindingSet.Bind(autoSelectBtn).For((Button v) => v.onClick).To((ArmourUpgradeViewModel vm) => vm.AutoSelect);
		bindingSet.Bind<TextMeshProUGUI>(settingBtnText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourUpgradeViewModel vm) => vm.SettingBtnText);
		bindingSet.Bind<TextMeshProUGUI>(autoSelectBtnText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourUpgradeViewModel vm) => vm.AutoSelectBtnText);
		bindingSet.Bind(expItemListObj).For((GameObject v) => v.activeSelf).ToExpression((ArmourUpgradeViewModel vm) => !vm.IsRealMax);
		bindingSet.Bind(maskObj).For((GameObject v) => v.activeSelf).ToExpression((ArmourUpgradeViewModel vm) => !vm.IsRealMax);
		bindingSet.Bind(allLevelObj).For((GameObject v) => v.activeSelf).ToExpression((ArmourUpgradeViewModel vm) => !vm.IsRealMax);
		bindingSet.Bind<TextMeshProUGUI>(sortModeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourUpgradeViewModel vm) => vm.CurSortName);
		bindingSet.Bind(this).For((ArmourUpgradeView v) => v.OpenWindow).To((ArmourUpgradeViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Build();
		UpdateInfoShow();
		_entryInfoView.Init();
		InitScreenToggles();
		sortToggle.onValueChanged.AddListener(delegate(bool v)
		{
			sortPanel.alpha = (v ? 1 : 0);
			sortPanel.blocksRaycasts = v;
			toggleScreenBack.GetComponent<Image>().raycastTarget = v;
			toggleScreenBack.GetComponent<Button>().interactable = v;
		});
		toggleScreenBack.onClick.AddListener(CloseScreen);
		expItemList.InitGridView(viewModel.EquipExpItemDataList.Count, OnGetEquipExpItemByIndex);
	}

	private void UpdateInfoShow(object sender = null, InteractionEventArgs e = null)
	{
		UpdateArmourData();
		armourShowView.SetArmourData(_viewModel.ArmourData);
		levelNoMaxObj.SetActive(_viewModel.ArmourData.Level != _viewModel.ArmourData.MaxLevel);
		levelMaxObj.SetActive(_viewModel.ArmourData.Level == _viewModel.ArmourData.MaxLevel);
		addLevelNoMaxObj.SetActive(_viewModel.ArmourData.Level != _viewModel.ArmourData.MaxLevel);
		addLevelMaxObj.SetActive(_viewModel.ArmourData.Level == _viewModel.ArmourData.MaxLevel);
	}

	private void ShowEntryDetail(object sender, InteractionEventArgs e)
	{
		EntryItem entryItem = (EntryItem)e.Context;
		_entryInfoView.Show(entryItem.ViewModel);
	}

	public void CloseScreen()
	{
		sortPanel.alpha = 0f;
		sortPanel.blocksRaycasts = false;
		sortToggle.isOn = false;
	}

	private void UpdateArmourData()
	{
		for (int i = 0; i < root.childCount; i++)
		{
			UnityEngine.Object.Destroy(root.GetChild(i).gameObject);
		}
		if (_viewModel.ArmourData.Level == _viewModel.ArmourData.MaxLevel)
		{
			for (int j = 0; j < _viewModel.ArmourData.EquipAttributeList.Count; j++)
			{
				AttributeItemData userData = new AttributeItemData(_viewModel.ArmourData.EquipAttributeList[j], _viewModel.ArmourData.EquipAttributeList[j].BaseValue);
				GameObject obj = ((j == 0) ? UnityEngine.Object.Instantiate(mainAttributeItem, root) : UnityEngine.Object.Instantiate(attributeItem, root));
				obj.GetComponent<AttributeItem>().Init(userData);
				obj.gameObject.SetActive(value: true);
			}
			foreach (EquipAttribute equipAttribute in _viewModel.ArmourData.EquipAttributeList)
			{
				_ = equipAttribute;
			}
		}
		else
		{
			if (_viewModel.AttributeUpgradeItemData != null)
			{
				GameObject obj2 = UnityEngine.Object.Instantiate(mainAttributeUpgradeItem, root);
				obj2.GetComponent<AttributeUpgradeItem>()?.Init(_viewModel.AttributeUpgradeItemData);
				obj2.gameObject.SetActive(value: true);
			}
			for (int k = 0; k < _viewModel.AttributeItemDataList.Count; k++)
			{
				GameObject obj3 = UnityEngine.Object.Instantiate(attributeUpgradeItem, root);
				obj3.GetComponent<AttributeUpgradeItem>().Init(_viewModel.AttributeItemDataList[k]);
				obj3.gameObject.SetActive(value: true);
			}
		}
		uIGameObjectSort.Sort();
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

	private void UpdateExpItemList(object sender, InteractionEventArgs e)
	{
		expItemList.SetListItemCount(_viewModel.EquipExpItemDataList.Count);
		expItemList.RefreshAllShownItem();
	}

	private LoopGridViewItem OnGetEquipExpItemByIndex(LoopGridView arg1, int index, int row, int colum)
	{
		EquipExpItemDataNew equipExpItemDataNew = _viewModel.EquipExpItemDataList[index];
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

	public void ClearObj()
	{
		armourShowView.ClearObj();
	}
}
