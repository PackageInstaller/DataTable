using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourDetailView : UGuiView
{
	[SerializeField]
	private GameObject self;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private Image frame;

	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private TextMeshProUGUI armourEnum;

	[SerializeField]
	private TextMeshProUGUI rankLevel;

	[SerializeField]
	private Image rankBg;

	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private GameObject levelObj;

	[SerializeField]
	private Transform armourInfoRoot;

	[SerializeField]
	private GameObject armourMainAttributeItem;

	[SerializeField]
	private GameObject armourAttributeItem;

	[SerializeField]
	private GameObject armourEntryItem;

	[SerializeField]
	private TabItemNormal lockBtn;

	[SerializeField]
	private EquipWearerItem equipWearerItem;

	[SerializeField]
	private GameObject normalObj;

	[SerializeField]
	private GameObject rockObj;

	[SerializeField]
	private Image mainEntryIcon;

	[SerializeField]
	private GameObject mainEntryIconObj;

	[SerializeField]
	private GameObject rockMainEntryItem;

	[SerializeField]
	private GameObject rockEntryItem;

	[SerializeField]
	private Transform rockInfoRoot;

	[SerializeField]
	private Button leftBtn;

	[SerializeField]
	private TextMeshProUGUI leftButtonText;

	[SerializeField]
	private Button rightBtn;

	[SerializeField]
	private TextMeshProUGUI rightButtonText;

	private ArmourDetailViewModel viewModel;

	public void Init(ArmourDetailViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<ArmourDetailView, ArmourDetailViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(self).For((GameObject v) => v.activeSelf).To((ArmourDetailViewModel vm) => vm.IsShow);
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((ArmourDetailViewModel vm) => vm.ArmourData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((ArmourDetailViewModel vm) => $"RarityBG_Middle_{vm.ArmourData.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(frame).For((Image v) => v.sprite).ToExpression((ArmourDetailViewModel vm) => $"Rarity_Middle_{vm.ArmourData.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourDetailViewModel vm) => vm.ArmourData.Name);
		bindingSet.Bind<TextMeshProUGUI>(armourEnum).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourDetailViewModel vm) => vm.ArmourEnumName);
		bindingSet.Bind<TextMeshProUGUI>(rankLevel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ArmourDetailViewModel vm) => $"RANK · {vm.ArmourData.Rank}");
		bindingSet.Bind(rankBg).For((Image v) => v.color).To((ArmourDetailViewModel vm) => vm.RankBgColor);
		bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ArmourDetailViewModel vm) => $"+{vm.ArmourData.Level}");
		bindingSet.Bind<TextMeshProUGUI>(leftButtonText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourDetailViewModel vm) => vm.LeftBtnText);
		bindingSet.Bind<TextMeshProUGUI>(rightButtonText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourDetailViewModel vm) => vm.RightBtnText);
		bindingSet.Bind(this).For((ArmourDetailView v) => v.RefreshWeapon).To((ArmourDetailViewModel vm) => vm.RefreshDataRequest);
		bindingSet.Bind(levelObj).For((GameObject v) => v.activeSelf).ToExpression((ArmourDetailViewModel vm) => !vm.IsRock);
		bindingSet.Bind(normalObj).For((GameObject v) => v.activeSelf).ToExpression((ArmourDetailViewModel vm) => !vm.IsRock);
		bindingSet.Bind(rockObj).For((GameObject v) => v.activeSelf).To((ArmourDetailViewModel vm) => vm.IsRock);
		bindingSet.Bind(leftBtn).For((Button v) => v.onClick).To((ArmourDetailViewModel vm) => vm.LeftBtnCmd);
		bindingSet.Bind(rightBtn).For((Button v) => v.onClick).To((ArmourDetailViewModel vm) => vm.RightBtnCmd);
		bindingSet.Build();
		InitTabItem();
	}

	private void InitTabItem()
	{
		if (equipWearerItem != null)
		{
			equipWearerItem.Init(viewModel.EquipWearerItemData);
		}
		lockBtn.Init(viewModel.LockBtn);
		CreateArmourData();
	}

	private void RefreshWeapon(object sender, InteractionEventArgs e)
	{
		CreateArmourData();
	}

	private void CreateArmourData()
	{
		if (viewModel.ArmourData != null)
		{
			ClearArmourData();
			if (viewModel.IsRock)
			{
				CreateRockInfo();
			}
			else
			{
				CreateArmourInfo();
			}
		}
	}

	private void CreateArmourInfo()
	{
		GameObject obj = UnityEngine.Object.Instantiate(armourMainAttributeItem, armourInfoRoot);
		obj.transform.GetComponent<AttributeItem>().Init(new AttributeItemData(viewModel.ArmourData.GetMainAttribute()));
		obj.gameObject.SetActive(value: true);
		foreach (AttributeItemData attributeItem in viewModel.AttributeItemList)
		{
			GameObject obj2 = UnityEngine.Object.Instantiate(armourAttributeItem, armourInfoRoot);
			obj2.transform.GetComponent<AttributeItem>().Init(attributeItem);
			obj2.gameObject.SetActive(value: true);
		}
		foreach (EntryItemData entryItemData in viewModel.EntryItemDataList)
		{
			GameObject obj3 = UnityEngine.Object.Instantiate(armourEntryItem, armourInfoRoot);
			obj3.transform.GetComponent<EntryItem>().Init(entryItemData);
			obj3.gameObject.SetActive(value: true);
		}
	}

	private async void CreateRockInfo()
	{
		if (mainEntryIcon != null)
		{
			string textureIconSprite = AssetUtility.GetTextureIconSprite("BuffIcon/Folder/EntryIcon/" + viewModel.ArmourData.EntryDataList[0].IconPath + "_Rock.png");
			Image image = mainEntryIcon;
			image.sprite = await LoadSpriteAsync(textureIconSprite);
		}
		List<EntryItemData> entryItemDataList = viewModel.EntryItemDataList;
		for (int i = 0; i < entryItemDataList.Count; i++)
		{
			GameObject obj = ((i == 0) ? UnityEngine.Object.Instantiate(rockMainEntryItem, rockInfoRoot) : UnityEngine.Object.Instantiate(rockEntryItem, rockInfoRoot));
			obj.transform.GetComponent<EntryItem>().Init(entryItemDataList[i]);
			obj.gameObject.SetActive(value: true);
		}
	}

	private void ClearArmourData()
	{
		for (int i = 0; i < armourInfoRoot.childCount; i++)
		{
			UnityEngine.Object.Destroy(armourInfoRoot.GetChild(i).gameObject);
		}
		for (int j = 0; j < rockInfoRoot.childCount; j++)
		{
			UnityEngine.Object.Destroy(rockInfoRoot.GetChild(j).gameObject);
		}
		mainEntryIconObj.SetActive(viewModel.IsRock);
	}

	protected override void OnDestroy()
	{
		ClearArmourData();
		base.OnDestroy();
	}
}
