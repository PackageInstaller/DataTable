using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourPopupView : UGuiView
{
	[SerializeField]
	private Button outsideBtn;

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

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<ArmourPopupViewModel>(userData);
		BindingSet<ArmourPopupView, ArmourPopupViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((ArmourPopupView v) => v.OnVisibleChanged).To((ArmourPopupViewModel vm) => vm.VisibleRequest);
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
		bindingSet.Bind(this).For((ArmourPopupView v) => v.RefreshArmourData).To((ArmourPopupViewModel vm) => vm.RefreshDataRequest);
		bindingSet.Bind(outsideBtn.gameObject).For((GameObject v) => v.activeSelf).To((ArmourPopupViewModel vm) => vm.ShowOutsideMask);
		bindingSet.Bind(outsideBtn).For((Button v) => v.onClick).To((ArmourPopupViewModel vm) => vm.Hide);
		bindingSet.Bind(lockBtn.gameObject).For((GameObject v) => v.activeSelf).To((ArmourPopupViewModel vm) => vm.ShowLockBtn);
		bindingSet.Build();
		InitEquipData();
	}

	public void SetAnchorAndPivot(Vector2 anchorMin, Vector2 anchorMax, Vector2 pivot)
	{
		mainPanel.anchorMin = anchorMin;
		mainPanel.anchorMax = anchorMax;
		mainPanel.pivot = pivot;
	}

	private void InitEquipData()
	{
		equipWearerItem.Init(viewModel.EquipWearerItemData);
		lockBtn.Init(viewModel.LockBtn);
		CreateArmourData();
	}

	public void RefreshArmourData(object sender = null, InteractionEventArgs e = null)
	{
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

	protected override void OnDestroy()
	{
		ClearArmourData();
		base.OnDestroy();
	}
}
