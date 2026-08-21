using System.Collections.Generic;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroEquipView : HeroCultivateView
{
	[SerializeField]
	private List<EquipSlotNew> equipSlotNews;

	[SerializeField]
	private LoopListView2 attributeList;

	[SerializeField]
	private LoopListView2 entryList;

	[SerializeField]
	private TabItemNormal attributeBtn;

	[SerializeField]
	private TabItemNormal entryBtn;

	[SerializeField]
	private EntryInfoView entryInfoView;

	[SerializeField]
	private GameObject btnCultureObj;

	[SerializeField]
	private Button btnCulture;

	[SerializeField]
	private Button btnPreset;

	[SerializeField]
	private Button btnEntryDetail;

	[SerializeField]
	private Button btnRecommend;

	private HeroCultivateViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<HeroCultivateViewModel>(userData);
		BindingSet<HeroEquipView, HeroCultivateViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((HeroEquipView v) => v.Refresh).To((HeroCultivateViewModel vm) => vm.OnRefreshRequest);
		bindingSet.Bind().For((HeroEquipView v) => v.Refresh).To((HeroCultivateViewModel vm) => vm.OnRefreshEquipRequest);
		bindingSet.Bind(this).For((HeroEquipView v) => v.ShowEntryDetail).To((HeroCultivateViewModel vm) => vm.OpenHeroEquipViewEntryPanelRequest);
		bindingSet.Bind(btnEntryDetail).For((Button v) => v.onClick).To((HeroCultivateViewModel vm) => vm.OpenArmourEntryDetailCmd);
		bindingSet.Bind(btnCultureObj).For((GameObject v) => v.activeSelf).To((HeroCultivateViewModel vm) => vm.IsSelf);
		if (btnPreset != null)
		{
			bindingSet.Bind(btnPreset.gameObject).For((GameObject v) => v.activeSelf).To((HeroCultivateViewModel vm) => vm.IsSelf);
		}
		if (btnRecommend != null)
		{
			bindingSet.Bind(btnRecommend.gameObject).For((GameObject v) => v.activeSelf).To((HeroCultivateViewModel vm) => vm.IsSelf);
		}
		bindingSet.Build();
		InitArmourSlots();
		InitTabItem();
		btnCulture.onClick.AddListener(delegate
		{
			OpenArmourWindow(ArmourEnum.Box);
		});
		if (btnPreset != null)
		{
			btnPreset.onClick.AddListener(delegate
			{
				viewModel.OpenArmourPresetWindow();
			});
		}
		if (btnRecommend != null)
		{
			btnRecommend.onClick.AddListener(delegate
			{
				viewModel.OpenArmourRecommendWindow();
			});
		}
		entryInfoView.Init();
	}

	private void InitTabItem()
	{
		attributeBtn.Init(viewModel.ArmourAttributeBtn);
		entryBtn.Init(viewModel.ArmourEntryBtn);
		attributeList.InitListView(viewModel.ArmourAttributeItemDataList.Count, OnGetAttributeItemByIndex);
		entryList.InitListView(viewModel.ArmourEntryDataList.Count, OnGetEntryItemByIndex);
	}

	private void ShowEntryDetail(object sender, InteractionEventArgs e)
	{
		EntryLevelItem entryLevelItem = (EntryLevelItem)e.Context;
		EntryItemData entryItemData = new EntryItemData(entryLevelItem.viewModel.EntryData);
		entryItemData.AllLevel = entryLevelItem.viewModel.CurLevel;
		entryInfoView.Show(entryItemData, null, entryLevelItem.viewModel.ShowLevel);
	}

	public void HideEntryInfoView()
	{
		entryInfoView.Hide();
	}

	public void Refresh(object sender = null, InteractionEventArgs e = null)
	{
		UpdateEquipProp();
	}

	private void UpdateEquipProp()
	{
		Dictionary<int, ArmourData> armours = viewModel.HeroModel.Armours;
		for (int i = 0; i < 6; i++)
		{
			List<ArmourData> armourListByType = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetArmourListByType((ArmourEnum)i);
			bool tipShow = false;
			foreach (ArmourData item in armourListByType)
			{
				if (item.GetOwnerId() == 0 && viewModel.IsSelf)
				{
					tipShow = true;
					break;
				}
			}
			armours.TryGetValue(i, out var value);
			equipSlotNews[i].RefreshData(value, tipShow);
		}
		attributeList.SetListItemCount(viewModel.ArmourAttributeItemDataList.Count);
		attributeList.RefreshAllShownItem();
		entryList.SetListItemCount(viewModel.ArmourEntryDataList.Count);
		entryList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetAttributeItemByIndex(LoopListView2 listView2, int index)
	{
		AttributeItemData attributeItemData = viewModel.ArmourAttributeItemDataList[index];
		if (attributeItemData == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = attributeList.NewListViewItem("AttributeItem");
		AttributeItem component = loopListViewItem.GetComponent<AttributeItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(attributeItemData);
		}
		else
		{
			component.RefreshAttributeData(attributeItemData);
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetEntryItemByIndex(LoopListView2 listView2, int index)
	{
		EntryLevelItemData entryLevelItemData = viewModel.ArmourEntryDataList[index];
		if (entryLevelItemData == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = entryList.NewListViewItem("EntryLevelItem");
		EntryLevelItem component = loopListViewItem.GetComponent<EntryLevelItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(entryLevelItemData);
		}
		else
		{
			component.RefreshEntryLevelItemData(entryLevelItemData);
		}
		return loopListViewItem;
	}

	private void InitArmourSlots()
	{
		Dictionary<int, ArmourData> armours = viewModel.HeroModel.Armours;
		for (int i = 0; i < equipSlotNews.Count; i++)
		{
			List<ArmourData> armourListByType = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetArmourListByType((ArmourEnum)i);
			bool tipShow = false;
			foreach (ArmourData item in armourListByType)
			{
				if (item.GetOwnerId() == 0)
				{
					tipShow = true;
					break;
				}
			}
			armours.TryGetValue(i, out var value);
			equipSlotNews[i].RefreshData(value, tipShow);
			int j = i;
			equipSlotNews[i].button.onClick.AddListener(delegate
			{
				OpenArmourWindow((ArmourEnum)j);
			});
		}
	}

	private async void OpenArmourWindow(ArmourEnum armourEnum)
	{
		if (viewModel.IsSelf)
		{
			viewModel.OpenArmourChangeWindow(armourEnum);
		}
	}

	public override void Show()
	{
		base.Show();
		Refresh();
		showArrowPart = false;
		showHeroFimage = false;
	}

	public void OnEquipClick(int enterType)
	{
		viewModel.OpenEquipWarehouseCmd?.Execute(enterType);
	}
}
