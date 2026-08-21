using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class EquipCastingDetailView : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI equipName;

	[SerializeField]
	private TextMeshProUGUI equipDesc;

	[SerializeField]
	private Image equipIcon;

	[SerializeField]
	private LoopListView2 materialList;

	[SerializeField]
	private TextMeshProUGUI needGold;

	[SerializeField]
	private Button btnCreateEquip;

	[SerializeField]
	private Button btnShowCasting;

	[SerializeField]
	private RectTransform rTF;

	[SerializeField]
	private ListPaddingCal padding;

	private EquipCastingDetailViewModel viewModel;

	public void Init(EquipCastingDetailViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<EquipCastingDetailView, EquipCastingDetailViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(equipName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EquipCastingDetailViewModel vm) => vm.ItemData.PropDataBase.Name);
		bindingSet.Bind<TextMeshProUGUI>(equipDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EquipCastingDetailViewModel vm) => vm.ItemData.PropDataBase.Description);
		bindingSet.Bind(equipIcon).For((Image v) => v.sprite).To((EquipCastingDetailViewModel vm) => vm.ItemData.PropDataBase.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(needGold).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EquipCastingDetailViewModel vm) => vm.ItemData.CastingDataBase.NeedGold);
		bindingSet.Bind(btnCreateEquip).For((Button v) => v.onClick).To((EquipCastingDetailViewModel vm) => vm.btnCreateEquip);
		bindingSet.Bind(btnShowCasting).For((Button v) => v.onClick).To((EquipCastingDetailViewModel vm) => vm.ShowCastingInfo);
		bindingSet.Bind(this).For((EquipCastingDetailView v) => v.RefreshMaterial).To((EquipCastingDetailViewModel vm) => vm.RefreshMaterialRequest);
		bindingSet.Build();
		InitListParam();
		equipIcon.SetNativeSize();
	}

	public void InitListParam()
	{
		materialList.ArrangeType = padding.Cal(viewModel.MaterialDataList.Count, rTF.rect.width);
		materialList.InitListView(viewModel.MaterialDataList.Count, OnGetMaterialListByIndex);
	}

	private void RefreshMaterial(object sender, InteractionEventArgs e)
	{
		materialList.ChangeArrangeType(padding.Cal(viewModel.MaterialDataList.Count, rTF.rect.width));
		materialList.SetListItemCount(viewModel.MaterialDataList.Count);
		materialList.RefreshAllShownItem();
		equipIcon.SetNativeSize();
	}

	public LoopListViewItem2 OnGetMaterialListByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0)
		{
			return null;
		}
		CastingMaterialItemData castingMaterialItemData = viewModel.MaterialDataList[index];
		if (castingMaterialItemData == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("CastingMaterialItem");
		CastingMaterialItem component = loopListViewItem.GetComponent<CastingMaterialItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(castingMaterialItemData);
		}
		else
		{
			component.RefreshData(castingMaterialItemData);
		}
		return loopListViewItem;
	}
}
