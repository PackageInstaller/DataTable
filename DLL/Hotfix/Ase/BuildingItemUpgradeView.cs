using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BuildingItemUpgradeView : UGuiView
{
	public TextMeshProUGUI buildingLevelCur;

	public TextMeshProUGUI buildingLevelMax;

	public GameObject red;

	public Image buildIcon;

	public GameObject unlockRoot;

	public GameObject lockBuildingRoot;

	public GameObject maxRoot;

	public Button btnUpgrade;

	public TextMeshProUGUI conditionText;

	public new Image name;

	private HomelandBuildingItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (userData != null)
		{
			viewModel = GetUserData<HomelandBuildingItemViewModel>(userData);
			BindingSet<BuildingItemUpgradeView, HomelandBuildingItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
			bindingSet.Bind(name).For((Image v) => v.sprite).To((HomelandBuildingItemViewModel vm) => vm.Data.NameIcon)
				.WithConversion("ItemIcon");
			bindingSet.Bind<TextMeshProUGUI>(buildingLevelCur).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HomelandBuildingItemViewModel vm) => $"Lv.<size=42>{vm.Data.Level}</size>");
			bindingSet.Bind<TextMeshProUGUI>(buildingLevelMax).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HomelandBuildingItemViewModel vm) => $"/{vm.Data.LevelMax}");
			bindingSet.Bind(red).For((GameObject v) => v.activeSelf).To((HomelandBuildingItemViewModel vm) => vm.Data.IsRed);
			bindingSet.Bind(lockBuildingRoot).For((GameObject v) => v.activeSelf).To((HomelandBuildingItemViewModel vm) => vm.Data.IsBuildingLock);
			bindingSet.Bind(((Component)(object)conditionText).gameObject).For((GameObject v) => v.activeSelf).To((HomelandBuildingItemViewModel vm) => vm.Data.IsBuildingLock);
			bindingSet.Bind<TextMeshProUGUI>(conditionText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HomelandBuildingItemViewModel vm) => $"原初之灯{vm.Data.UnlockNeedHomelandlevel}级开放");
			bindingSet.Bind(unlockRoot).For((GameObject v) => v.activeSelf).ToExpression((HomelandBuildingItemViewModel vm) => !vm.Data.IsBuildingLock);
			bindingSet.Bind(buildIcon).For((Image v) => v.sprite).To((HomelandBuildingItemViewModel vm) => vm.Data.Icon)
				.WithConversion("ItemIcon");
			bindingSet.Bind(maxRoot).For((GameObject v) => v.activeSelf).ToExpression((HomelandBuildingItemViewModel vm) => vm.Data.Level == vm.Data.LevelMax);
			bindingSet.Bind(btnUpgrade).For((Button v) => v.onClick).ToExpression((HomelandBuildingItemViewModel vm) => vm.OptCommand)
				.CommandParameter("OpenBuildingUpgradeView");
			bindingSet.Build();
		}
	}

	public override void RefreshData(object userData)
	{
		if (userData != null)
		{
			base.RefreshData(userData);
			viewModel = GetUserData<HomelandBuildingItemViewModel>(userData);
			this.SetDataContext(viewModel);
		}
	}
}
