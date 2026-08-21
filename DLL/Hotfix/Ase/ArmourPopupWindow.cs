using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourPopupWindow : UGuiWindow
{
	[SerializeField]
	private Button outsideBtn;

	[SerializeField]
	private Button outsideBtn2;

	[SerializeField]
	private EntryInfoView entryInfoView;

	[SerializeField]
	private RectTransform mainPanel;

	[SerializeField]
	private Image titleBg;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private TextMeshProUGUI armourName;

	[SerializeField]
	private Image armourImg;

	[SerializeField]
	private TextMeshProUGUI type;

	[SerializeField]
	private TextMeshProUGUI rank;

	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private GameObject levelObj;

	[SerializeField]
	private TabItemNormal lockBtn;

	[SerializeField]
	private Transform armourInfoRoot;

	[SerializeField]
	private GameObject armourMainAttributeItem;

	[SerializeField]
	private GameObject armourAttributeItem;

	[SerializeField]
	private GameObject armourEntryItem;

	[SerializeField]
	private EquipWearerItem equipWearerItem;

	private ArmourPopupViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<ArmourPopupViewModel>();
		BindingSet<ArmourPopupWindow, ArmourPopupViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((ArmourPopupWindow v) => v.CloseWindow).To((ArmourPopupViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(mainPanel).For((RectTransform v) => v.anchoredPosition).To((ArmourPopupViewModel vm) => vm.ShowPos);
		bindingSet.Bind<TextMeshProUGUI>(armourName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourPopupViewModel vm) => vm.ArmourData.Name);
		bindingSet.Bind<TextMeshProUGUI>(rank).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ArmourPopupViewModel vm) => $"RANK*{vm.ArmourData.Rank}");
		bindingSet.Bind(armourImg).For((Image v) => v.sprite).ToExpression((ArmourPopupViewModel vm) => vm.ArmourData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(titleBg).For((Image v) => v.sprite).ToExpression((ArmourPopupViewModel vm) => $"Prop_Title_{vm.ArmourData.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((ArmourPopupViewModel vm) => $"Prop_Bg_{vm.ArmourData.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(type).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourPopupViewModel vm) => vm.Type);
		bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ArmourPopupViewModel vm) => $"+{vm.ArmourData.Level}");
		bindingSet.Bind(this).For((ArmourPopupWindow v) => v.RefreshArmourData).To((ArmourPopupViewModel vm) => vm.RefreshDataRequest);
		bindingSet.Bind(outsideBtn.gameObject).For((GameObject v) => v.activeSelf).To((ArmourPopupViewModel vm) => vm.ShowOutsideMask);
		bindingSet.Bind(outsideBtn).For((Button v) => v.onClick).To((ArmourPopupViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(outsideBtn2.gameObject).For((GameObject v) => v.activeSelf).To((ArmourPopupViewModel vm) => vm.ShowOutsideMask2);
		bindingSet.Bind(outsideBtn2).For((Button v) => v.onClick).To((ArmourPopupViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((ArmourPopupWindow v) => v.ShowEntryDetail).To((ArmourPopupViewModel vm) => vm.ShowEntryDetailRequest);
		bindingSet.Build();
		InitEquipData();
	}

	public void SetAnchorAndPivot(Vector2 anchorMin, Vector2 anchorMax, Vector2 pivot)
	{
		mainPanel.anchorMin = anchorMin;
		mainPanel.anchorMax = anchorMax;
		mainPanel.pivot = pivot;
	}

	private void ShowEntryDetail(object sender, InteractionEventArgs e)
	{
		entryInfoView.gameObject.SetActive(value: true);
		EntryItem entryItem = (EntryItem)e.Context;
		entryInfoView.SetPosition(viewModel.EntryInfoPos);
		entryInfoView.Show(entryItem.ViewModel);
	}

	public void RefreshArmourData(object sender = null, InteractionEventArgs e = null)
	{
		CreateArmourData();
	}

	private void InitEquipData()
	{
		equipWearerItem.Init(viewModel.EquipWearerItemData);
		entryInfoView.Init();
		entryInfoView.SetPosition(viewModel.EntryInfoPos);
		lockBtn.Init(viewModel.LockBtn);
		CreateArmourData();
	}

	private void CreateArmourData()
	{
		if (viewModel.ArmourData != null)
		{
			ClearArmourData();
			CreateArmourInfo();
		}
	}

	private void CreateArmourInfo()
	{
		GameObject obj = UnityEngine.Object.Instantiate(armourMainAttributeItem, armourInfoRoot);
		obj.transform.GetComponent<AttributeItem>().Init(new AttributeItemData(viewModel.ArmourData.GetMainAttribute()));
		obj.gameObject.SetActive(value: true);
		foreach (AttributeItemData attributeItemData in viewModel.AttributeItemDataList)
		{
			GameObject obj2 = UnityEngine.Object.Instantiate(armourAttributeItem, armourInfoRoot);
			obj2.transform.GetComponent<AttributeItem>().Init(attributeItemData);
			obj2.gameObject.SetActive(value: true);
		}
		foreach (EntryItemData entryItemDatum in viewModel.EntryItemData)
		{
			GameObject obj3 = UnityEngine.Object.Instantiate(armourEntryItem, armourInfoRoot);
			obj3.transform.GetComponent<EntryItem>().Init(entryItemDatum);
			obj3.gameObject.SetActive(value: true);
		}
	}

	private void ClearArmourData()
	{
		for (int i = 0; i < armourInfoRoot.childCount; i++)
		{
			UnityEngine.Object.Destroy(armourInfoRoot.GetChild(i).gameObject);
		}
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		ClearArmourData();
		Dismiss();
	}
}
