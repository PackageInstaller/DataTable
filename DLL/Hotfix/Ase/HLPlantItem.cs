using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HLPlantItem : UGuiView
{
	[SerializeField]
	private GameObject emptyObj;

	[SerializeField]
	private GameObject plantObj;

	[SerializeField]
	private GameObject lockObj;

	[SerializeField]
	private GameObject increaseObj;

	[SerializeField]
	private GameObject exObj;

	[SerializeField]
	private Button btnCloseExObj;

	[SerializeField]
	private GameObject leftTimeObj;

	[SerializeField]
	private TextMeshProUGUI leftTimeText;

	[SerializeField]
	private TextMeshProUGUI HarvestingCount;

	[SerializeField]
	private GameObject leftTimeTextObj;

	[SerializeField]
	private GameObject harvestObj;

	[SerializeField]
	private Button btnItem;

	[SerializeField]
	private Button btnAbort;

	[SerializeField]
	private Button btnSpeedUp;

	[SerializeField]
	private GameObject isSelect;

	[SerializeField]
	private GameObject mask;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private GameObject HarvestStateObj;

	private HLPlantItemData viewModel;

	public void Init(HLPlantItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<HLPlantItem, HLPlantItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(lockObj).For((GameObject v) => v.activeSelf).ToExpression((HLPlantItemData vm) => vm.State == 1);
		bindingSet.Bind(emptyObj).For((GameObject v) => v.activeSelf).ToExpression((HLPlantItemData vm) => vm.State == 2);
		bindingSet.Bind(plantObj).For((GameObject v) => v.activeSelf).ToExpression((HLPlantItemData vm) => vm.State == 3 || vm.State == 4);
		bindingSet.Bind(HarvestStateObj).For((GameObject v) => v.activeSelf).ToExpression((HLPlantItemData vm) => vm.State == 4);
		bindingSet.Bind(leftTimeObj).For((GameObject v) => v.activeSelf).ToExpression((HLPlantItemData vm) => vm.State == 3);
		bindingSet.Bind(increaseObj).For((GameObject v) => v.activeSelf).To((HLPlantItemData vm) => vm.IsIncrease);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((HLPlantItemData vm) => vm.SeedIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(exObj).For((GameObject v) => v.activeSelf).ToExpression((HLPlantItemData vm) => vm.IsShowExBtn);
		bindingSet.Bind(btnCloseExObj).For((Button v) => v.onClick).To((HLPlantItemData vm) => vm.CloseBtn);
		bindingSet.Bind<TextMeshProUGUI>(leftTimeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HLPlantItemData vm) => vm.LeftTimeText);
		bindingSet.Bind(leftTimeTextObj).For((GameObject v) => v.activeSelf).ToExpression((HLPlantItemData vm) => vm.State == 3);
		bindingSet.Bind<TextMeshProUGUI>(HarvestingCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HLPlantItemData vm) => vm.HarvestingCount);
		bindingSet.Bind(harvestObj).For((GameObject v) => v.activeSelf).ToExpression((HLPlantItemData vm) => vm.State == 4);
		bindingSet.Bind(btnItem).For((Button v) => v.onClick).To((HLPlantItemData vm) => vm.BtnOnClick);
		bindingSet.Bind(btnAbort).For((Button v) => v.onClick).To((HLPlantItemData vm) => vm.AbortPlantCmd);
		bindingSet.Bind(btnSpeedUp).For((Button v) => v.onClick).To((HLPlantItemData vm) => vm.SpeedUpPlantCmd);
		if (isSelect != null)
		{
			bindingSet.Bind(isSelect).For((GameObject v) => v.activeSelf).To((HLPlantItemData vm) => vm.IsSelect);
		}
		if (mask != null)
		{
			bindingSet.Bind(mask).For((GameObject v) => v.activeSelf).To((HLPlantItemData vm) => vm.IsMask);
		}
		bindingSet.Build();
	}
}
