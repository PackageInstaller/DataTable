using System;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class WeaponRefineView : UGuiView
{
	[SerializeField]
	private RectTransform content;

	[SerializeField]
	private TextMeshProUGUI refineText;

	[SerializeField]
	private TextMeshProUGUI effectName;

	[SerializeField]
	private LoopListView2 materialLoopList;

	[SerializeField]
	private TextMeshProUGUI curEffectTitle;

	[SerializeField]
	private TextMeshProUGUI curEffectDesc;

	[SerializeField]
	private GameObject nextEffectObj;

	[SerializeField]
	private TextMeshProUGUI nextEffectTitle;

	[SerializeField]
	private TextMeshProUGUI nextEffectDesc;

	[SerializeField]
	private Button btnRefine;

	[SerializeField]
	private Button btnOpenMaterialView;

	[SerializeField]
	private GameObject maxStateObj;

	[SerializeField]
	private GameObject noMaxStateObj;

	[SerializeField]
	private GameObject materialListView;

	[SerializeField]
	private LoopGridView materialGridListView;

	[SerializeField]
	private Button btnCloseMaterialView;

	private WeaponRefineViewModel viewModel;

	public void Init(WeaponRefineViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<WeaponRefineView, WeaponRefineViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((WeaponRefineView v) => v.OnVisibleChanged).To((WeaponRefineViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind<TextMeshProUGUI>(refineText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((WeaponRefineViewModel vm) => $"精炼{vm.Refine}阶");
		bindingSet.Bind<TextMeshProUGUI>(effectName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponRefineViewModel vm) => vm.EffectName);
		bindingSet.Bind<TextMeshProUGUI>(curEffectTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((WeaponRefineViewModel vm) => $"{vm.Refine}阶效果");
		bindingSet.Bind<TextMeshProUGUI>(curEffectDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((WeaponRefineViewModel vm) => $"<pos=137>{vm.CurEffectDescText}");
		bindingSet.Bind<TextMeshProUGUI>(nextEffectTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((WeaponRefineViewModel vm) => $"{vm.NextRefine}阶效果");
		bindingSet.Bind<TextMeshProUGUI>(nextEffectDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((WeaponRefineViewModel vm) => $"<pos=137>{vm.NextEffectDescText}");
		bindingSet.Bind(nextEffectObj).For((GameObject v) => v.activeSelf).ToExpression((WeaponRefineViewModel vm) => !vm.IsMax);
		bindingSet.Bind(noMaxStateObj).For((GameObject v) => v.activeSelf).ToExpression((WeaponRefineViewModel vm) => !vm.IsMax);
		bindingSet.Bind(maxStateObj).For((GameObject v) => v.activeSelf).To((WeaponRefineViewModel vm) => vm.IsMax);
		bindingSet.Bind(btnRefine).For((Button v) => v.onClick).To((WeaponRefineViewModel vm) => vm.ConfirmCmd);
		bindingSet.Bind(btnOpenMaterialView).For((Button v) => v.onClick).To((WeaponRefineViewModel vm) => vm.OpenMaterialView);
		bindingSet.Bind(btnCloseMaterialView).For((Button v) => v.onClick).To((WeaponRefineViewModel vm) => vm.CloseMaterialView);
		bindingSet.Bind(materialListView).For((GameObject v) => v.activeSelf).To((WeaponRefineViewModel vm) => vm.IsOpenMaterialView);
		bindingSet.Bind(this).For((WeaponRefineView v) => v.UpdateMaterial).To((WeaponRefineViewModel vm) => vm.RefreshMaterialList);
		bindingSet.Bind(this).For((WeaponRefineView v) => v.OpenWindow).To((WeaponRefineViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Build();
		SetText();
		materialLoopList.InitListView(viewModel.CostMaterialList.Count, OnGetCostMaterialItemByIndex);
		materialGridListView.InitGridView(viewModel.MaterialList.Count, OnGetMaterialItemByIndex);
	}

	public void ClearMaterial()
	{
		viewModel.ReSetMaterial();
	}

	private void UpdateMaterial(object sender, InteractionEventArgs e)
	{
		materialGridListView.SetListItemCount(viewModel.MaterialList.Count);
		materialGridListView.RefreshAllShownItem();
		SetText();
	}

	private void SetText()
	{
		float width = content.gameObject.GetComponent<RectTransform>().rect.width;
		int num = Encoding.UTF8.GetBytes(viewModel.CurEffectDescText).Length;
		int num2 = viewModel.CurEffectDescText.Count((char c) => c == '<') / 2 * 23;
		int num3 = viewModel.CurEffectDescText.Count((char c) => c == '%') * 2;
		int num4 = (num - 36 - num2 + num3) / 45 + 2;
		if (!viewModel.IsMax)
		{
			num = Encoding.UTF8.GetBytes(viewModel.NextEffectDescText).Length;
			num2 = viewModel.NextEffectDescText.Count((char c) => c == '<') / 2 * 23;
			num3 = viewModel.NextEffectDescText.Count((char c) => c == '%') * 2;
			num4 += (num - 36 - num2 + num3) / 45 + 2;
		}
		float y = num4 * 50 + 20 + 200;
		content.sizeDelta = new Vector2(width, y);
	}

	private LoopListViewItem2 OnGetCostMaterialItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.CostMaterialList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("MaterialItem");
		if (loopListViewItem != null)
		{
			WeaponMaterialItem component = loopListViewItem.GetComponent<WeaponMaterialItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.CostMaterialList[index]);
			}
			else
			{
				component.RefreshWeaponMaterialData(viewModel.CostMaterialList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopGridViewItem OnGetMaterialItemByIndex(LoopGridView arg1, int index, int row, int column)
	{
		WeaponMaterialItemData weaponMaterialItemData = viewModel.MaterialList[index];
		if (weaponMaterialItemData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = materialGridListView.NewListViewItem("MaterialItem");
		WeaponMaterialItem component = loopGridViewItem.GetComponent<WeaponMaterialItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(weaponMaterialItemData);
		}
		else
		{
			component.RefreshWeaponMaterialData(weaponMaterialItemData);
		}
		return loopGridViewItem;
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
}
