using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RockCultureWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private TabItemNormal rockDetailTab;

	[SerializeField]
	private TabItemNormal rockDevelopTab;

	[SerializeField]
	private ArmourShowView armourShowView;

	[SerializeField]
	private RockPopupView rockPopupView;

	[SerializeField]
	private RockDevelopView rockDevelopView;

	[SerializeField]
	private R6RockDevelopView r6RockDevelopView;

	private RockCultureViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<RockCultureViewModel>();
		BindingSet<RockCultureWindow, RockCultureViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((RockCultureViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((RockCultureWindow v) => v.OpenUguiWindow).To((RockCultureViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((RockCultureWindow v) => v.CloseWindow).To((RockCultureViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((RockCultureWindow v) => v.RefreshView).To((RockCultureViewModel vm) => vm.RefreshViewRequest);
		bindingSet.Bind(this).For((RockCultureWindow v) => v.ClosePopupView).To((RockCultureViewModel vm) => vm.ClosePopupRequest);
		bindingSet.Bind(this).For((RockCultureWindow v) => v.OpenPropPopupRst).To((RockCultureViewModel vm) => vm.OpenPropPopupRst);
		bindingSet.Build();
		InitTab();
		InitView();
		RefreshView();
	}

	protected override void OnShow()
	{
		base.OnShow();
		viewModel.OpenSuccess();
	}

	private void RefreshView(object sender = null, InteractionEventArgs e = null)
	{
		armourShowView.gameObject.SetActive(viewModel.RockDetailBtn.IsSelected);
		bool isSelected = viewModel.RockDevelopBtn.IsSelected;
		bool flag = viewModel.ArmourData.Rank >= 6;
		if (flag)
		{
			rockDevelopView.CanvasGroup.alpha = 0f;
			rockDevelopView.CanvasGroup.blocksRaycasts = false;
			r6RockDevelopView.CanvasGroup.alpha = (isSelected ? 1 : 0);
			r6RockDevelopView.CanvasGroup.blocksRaycasts = isSelected;
			if (isSelected)
			{
				r6RockDevelopView.Open();
			}
		}
		else
		{
			r6RockDevelopView.CanvasGroup.alpha = 0f;
			r6RockDevelopView.CanvasGroup.blocksRaycasts = false;
			rockDevelopView.CanvasGroup.alpha = (isSelected ? 1 : 0);
			rockDevelopView.CanvasGroup.blocksRaycasts = isSelected;
		}
		rockPopupView.gameObject.SetActive(!(isSelected & flag));
	}

	private void ClosePopupView(object sender, InteractionEventArgs e)
	{
		rockPopupView.gameObject.SetActive(value: false);
	}

	private void InitTab()
	{
		rockDetailTab.Init(viewModel.RockDetailBtn);
		rockDevelopTab.Init(viewModel.RockDevelopBtn);
	}

	private void InitView()
	{
		armourShowView.SetArmourData(viewModel.ArmourData);
		rockPopupView.Init(viewModel.RockPopupViewModel);
		rockDevelopView.Init(viewModel.RockDevelopViewModel);
		r6RockDevelopView.Init(viewModel.R6RockDevelopViewModel);
	}

	private void OpenPropPopupRst(object sender, InteractionEventArgs e)
	{
		if (e != null && e.Context is KeyValuePair<RoleMoneyEnum, Vector3> keyValuePair)
		{
			OpenPropInfoWindow(keyValuePair.Key, keyValuePair.Value);
		}
	}

	private void OpenPropInfoWindow(RoleMoneyEnum moneyEnum, Vector3 iconWorldPos)
	{
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>((int)moneyEnum);
		if (dataRow != null)
		{
			Vector2 vector = RectTransformUtility.WorldToScreenPoint(UIUtilly.GetUICamera(), iconWorldPos);
			Vector2 pos = default(Vector2);
			RectTransformUtility.ScreenPointToLocalPointInRectangle(RectTransform, vector, UIUtilly.GetUICamera(), ref pos);
			viewModel.OpenPropPopupWindow(dataRow, pos);
		}
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
