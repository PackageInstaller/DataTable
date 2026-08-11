using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GamePropGuideWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private LoopGridView propList;

	[SerializeField]
	private RectTransform tagListRect;

	[SerializeField]
	private GameObject tagItem;

	[SerializeField]
	private TextMeshProUGUI tipText;

	[SerializeField]
	private GameObject tipTextObj;

	[SerializeField]
	private GameObject propInfoObj;

	[SerializeField]
	private Image propIcon;

	[SerializeField]
	private GameObject propIconObj;

	[SerializeField]
	private TextMeshProUGUI propName;

	[SerializeField]
	private TextMeshProUGUI propDesc;

	[SerializeField]
	private RectTransform weaponPos;

	private GameObject weaponShowObj;

	private string weaponPath = "";

	private GamePropGuideViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<GamePropGuideViewModel>();
		BindingSet<GamePropGuideWindow, GamePropGuideViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((GamePropGuideViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((GamePropGuideWindow v) => v.OpenUguiWindow).To((GamePropGuideViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((GamePropGuideWindow v) => v.CloseWindow).To((GamePropGuideViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(propIcon).For((Image v) => v.sprite).ToExpression((GamePropGuideViewModel vm) => vm.PropIconPath)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(propName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GamePropGuideViewModel vm) => vm.PropName);
		bindingSet.Bind<TextMeshProUGUI>(propDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GamePropGuideViewModel vm) => vm.PropDesc);
		bindingSet.Bind<TextMeshProUGUI>(tipText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GamePropGuideViewModel vm) => vm.TipText);
		bindingSet.Bind(tipTextObj).For((GameObject v) => v.activeSelf).To((GamePropGuideViewModel vm) => vm.IsLock);
		bindingSet.Bind(propInfoObj).For((GameObject v) => v.activeSelf).ToExpression((GamePropGuideViewModel vm) => !vm.IsLock);
		bindingSet.Bind(this).For((GamePropGuideWindow v) => v.RefreshShowPropGuideItem).To((GamePropGuideViewModel vm) => vm.RefreshShowPropGuideItemRequest);
		bindingSet.Bind(this).For((GamePropGuideWindow v) => v.LoadWeaponObj).To((GamePropGuideViewModel vm) => vm.RefreshItemRequest);
		bindingSet.Build();
		InitTagList();
		propList.InitGridView(viewModel.ShowPropGuideItemDataList.Count, OnGetSelectedItemByIndex);
		SuitSetting();
		LoadWeaponObj();
	}

	private void SuitSetting()
	{
		int num = ((RectTransform.rect.width >= 2400f) ? 5 : 4);
		int num2 = ((num == 5) ? 1400 : 920);
		propList.GetComponent<RectTransform>().SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, num2);
		propList.SetGridFixedGroupCount(GridFixedType.ColumnCountFixed, num);
	}

	private async void LoadWeaponObj(object sender = null, InteractionEventArgs e = null)
	{
		if (weaponShowObj != null)
		{
			UnityEngine.Object.Destroy(weaponShowObj);
		}
		propIconObj.SetActive(viewModel.CurPropGuideItemData.PropGuideType != 1);
		if (!viewModel.IsLock && viewModel.CurPropGuideItemData.PropGuideType == 1)
		{
			weaponPath = AssetUtility.GetUIItemAsset("WeaponPrefabs/" + viewModel.PropIconPath);
			GameObject gameObject = await InstantiateAsync(weaponPath, weaponPos);
			if (!(gameObject == null))
			{
				GameObject gameObject2 = gameObject;
				weaponShowObj = gameObject2;
			}
		}
	}

	private void InitTagList()
	{
		foreach (TabItemNormalData tagData in viewModel.TagDataList)
		{
			GameObject obj = UnityEngine.Object.Instantiate(tagItem, tagListRect);
			obj.transform.GetComponent<TabItemNormal>().Init(tagData);
			obj.gameObject.SetActive(value: true);
		}
	}

	private void RefreshShowPropGuideItem(object sender, InteractionEventArgs e)
	{
		propList.SetListItemCount(viewModel.ShowPropGuideItemDataList.Count);
		propList.RefreshAllShownItem();
	}

	private LoopGridViewItem OnGetSelectedItemByIndex(LoopGridView arg1, int index, int row, int colum)
	{
		GamePropGuideItemData gamePropGuideItemData = viewModel.ShowPropGuideItemDataList[index];
		if (gamePropGuideItemData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = propList.NewListViewItem("GamePropGuideItem");
		GamePropGuideItem component = loopGridViewItem.GetComponent<GamePropGuideItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(gamePropGuideItemData);
		}
		else
		{
			component.RefreshPropGuideItem(gamePropGuideItemData);
		}
		return loopGridViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		if (weaponShowObj != null)
		{
			UnityEngine.Object.Destroy(weaponShowObj);
		}
		Dismiss();
	}
}
