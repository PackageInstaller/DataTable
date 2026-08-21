using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class WeaponUpStarView : UGuiView
{
	[SerializeField]
	private GameObject view1;

	[SerializeField]
	private UIStarGroup uiStarGroup1;

	[SerializeField]
	private TextMeshProUGUI levelRemind;

	[SerializeField]
	private LoopListView2 attributeList1;

	[SerializeField]
	private LoopListView2 materialList;

	[SerializeField]
	private TextMeshProUGUI needCoin;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject btnObj;

	[SerializeField]
	private GameObject retuenMaterialTipObj;

	[SerializeField]
	private TextMeshProUGUI btnText;

	[SerializeField]
	private GameObject view2;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI weaponName;

	[SerializeField]
	private UIStarGroup uiStarGroup2;

	[SerializeField]
	private TextMeshProUGUI weaponEnum;

	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private LoopListView2 attributeList2;

	[SerializeField]
	private EntryInfoView entryInfoView;

	private WeaponUpStarViewModel _viewModel;

	public void Init(WeaponUpStarViewModel viewModel)
	{
		_viewModel = viewModel;
		BindingSet<WeaponUpStarView, WeaponUpStarViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(needCoin).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponUpStarViewModel vm) => vm.ShowCoin);
		bindingSet.Bind<TextMeshProUGUI>(levelRemind).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((WeaponUpStarViewModel vm) => $"等级上限开放至{vm.TargetLevel}");
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((WeaponUpStarViewModel vm) => vm.UpStarCmd);
		bindingSet.Bind(btnObj).For((GameObject v) => v.activeSelf).To((WeaponUpStarViewModel vm) => vm.ShowBtn);
		bindingSet.Bind(retuenMaterialTipObj).For((GameObject v) => v.activeSelf).To((WeaponUpStarViewModel vm) => vm.ShowReturnMaterial);
		bindingSet.Bind<TextMeshProUGUI>(btnText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponUpStarViewModel vm) => vm.BtnText);
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((WeaponUpStarViewModel vm) => vm.WeaponData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((WeaponUpStarViewModel vm) => $"RarityBG_Large_{vm.WeaponData.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(weaponName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponUpStarViewModel vm) => vm.WeaponData.Name);
		bindingSet.Bind<TextMeshProUGUI>(weaponEnum).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponUpStarViewModel vm) => vm.WeaponEnumName);
		bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((WeaponUpStarViewModel vm) => $"Lv.{vm.WeaponData.Level}/{vm.WeaponData.MaxLevel}");
		bindingSet.Bind(this).For((WeaponUpStarView v) => v.ShowEntryDetail).To((WeaponUpStarViewModel vm) => vm.ShowEntryDetailRequest);
		bindingSet.Bind(this).For((WeaponUpStarView v) => v.RefreshWeaponStarView).To((WeaponUpStarViewModel vm) => vm.RefreshRequest);
		bindingSet.Bind(this).For((WeaponUpStarView v) => v.RefreshMaterial).To((WeaponUpStarViewModel vm) => vm.RefreshMaterialRequest);
		bindingSet.Bind(this).For((WeaponUpStarView v) => v.OpenWindow).To((WeaponUpStarViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Build();
		attributeList1.InitListView(viewModel.AttributeUpgradeItemDataList.Count, OnGetAttributeUpgradeItemByIndex);
		attributeList2.InitListView(viewModel.AttributeItemDataList.Count, OnGetAttributeItemByIndex);
		materialList.InitListView(viewModel.MaterialItemDataList.Count, OnGetMaterialItemByIndex);
		entryInfoView.Init();
		RefreshWeapon();
	}

	private void ShowEntryDetail(object sender, InteractionEventArgs e)
	{
		EntryUpgradeItem entryUpgradeItem = (EntryUpgradeItem)e.Context;
		entryInfoView.Show(null, entryUpgradeItem._viewModel);
	}

	public void RefreshWeapon()
	{
		view1.SetActive(_viewModel.IsUpStar);
		view2.SetActive(!_viewModel.IsUpStar);
		if (_viewModel.IsUpStar)
		{
			uiStarGroup1.CurCount = _viewModel.WeaponData.Star;
			UpdateAttribute();
			RefreshMaterial();
		}
		else
		{
			UpdateAttribute();
			uiStarGroup2.CurCount = _viewModel.WeaponData.Star;
		}
	}

	public void RefreshWeaponStarView(object sender, InteractionEventArgs e)
	{
		RefreshWeapon();
	}

	private void RefreshMaterial(object sender = null, InteractionEventArgs e = null)
	{
		materialList.SetListItemCount(_viewModel.MaterialItemDataList.Count);
		materialList.RefreshAllShownItem();
		((TMP_Text)needCoin).text = _viewModel.ShowCoin;
	}

	private void UpdateAttribute()
	{
		attributeList1.SetListItemCount(_viewModel.AttributeUpgradeItemDataList.Count);
		attributeList1.RefreshAllShownItem();
		attributeList2.SetListItemCount(_viewModel.AttributeItemDataList.Count);
		attributeList2.RefreshAllShownItem();
	}

	private async void OpenWindow(object sender, InteractionEventArgs args)
	{
		Action callback = args.Callback;
		object context = args.Context;
		Window w = null;
		if (context is OpenViewArg openViewArg && openViewArg.UserData is WeaponSuccessViewModel)
		{
			w = await GameEntry.UI.OpenWindow<WeaponSuccessView>("Hero/Upgrade/EquipUpgradeSuccessWindow", openViewArg.UserData);
		}
		if (w != null && callback != null)
		{
			w.OnDismissed += Handler;
		}
		void Handler(object window, EventArgs e)
		{
			w.OnDismissed -= Handler;
			callback();
		}
	}

	private LoopListViewItem2 OnGetAttributeUpgradeItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.AttributeUpgradeItemDataList.Count)
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
				component.Init(_viewModel.AttributeUpgradeItemDataList[index]);
			}
			else
			{
				component.RefreshAttributeData(_viewModel.AttributeUpgradeItemDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetAttributeItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.AttributeItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("AttributeItem");
		if (loopListViewItem != null)
		{
			AttributeItem component = loopListViewItem.GetComponent<AttributeItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(_viewModel.AttributeItemDataList[index]);
			}
			else
			{
				component.RefreshData(_viewModel.AttributeItemDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetMaterialItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.MaterialItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("CastingMaterialItem");
		if (loopListViewItem != null)
		{
			CastingMaterialItem component = loopListViewItem.GetComponent<CastingMaterialItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(_viewModel.MaterialItemDataList[index]);
			}
			else
			{
				component.RefreshData(_viewModel.MaterialItemDataList[index]);
			}
		}
		return loopListViewItem;
	}
}
