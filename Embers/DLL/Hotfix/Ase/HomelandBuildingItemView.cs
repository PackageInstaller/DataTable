using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HomelandBuildingItemView : UGuiView
{
	public bool friendOpen;

	public bool controlFriendRed;

	public GameObject redRoot;

	public int buildingId;

	public TextMeshProUGUI buildingLevel;

	public TextMeshProUGUI buildingLevel2;

	public GameObject red;

	public Button btnOpen;

	public GameObject nameRoot;

	public GameObject nameRootOther;

	public GameObject lockRoot;

	public GameObject lockRoot1;

	private bool isSelf;

	private bool playlockEffect = true;

	public GameObject upgradeEffect;

	private HomelandBuildingItemViewModel viewModel;

	public bool PlaylockEffect
	{
		get
		{
			return playlockEffect;
		}
		set
		{
			if (!value)
			{
				playlockEffect = value;
			}
			else
			{
				_ = !playlockEffect & value;
			}
		}
	}

	public bool IsSelf
	{
		get
		{
			return isSelf;
		}
		set
		{
			isSelf = value;
			if (viewModel == null)
			{
				return;
			}
			if (isSelf)
			{
				nameRoot.gameObject.SetActive(!viewModel.Data.IsBuildingLock);
				if (nameRootOther != null)
				{
					nameRootOther.gameObject.SetActive(value: false);
				}
			}
			else if (friendOpen)
			{
				nameRoot.gameObject.SetActive(!viewModel.Data.IsBuildingLock);
				if (nameRootOther != null)
				{
					nameRootOther.gameObject.SetActive(value: false);
				}
			}
			else
			{
				nameRoot.gameObject.SetActive(value: false);
				if (nameRootOther != null)
				{
					nameRootOther.gameObject.SetActive(!viewModel.Data.IsBuildingLock);
				}
			}
			if (controlFriendRed && redRoot != null)
			{
				redRoot.gameObject.SetActive(value);
			}
		}
	}

	protected override void OnInit(object userData)
	{
		if (userData == null)
		{
			return;
		}
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<HomelandBuildingItemViewModel>(userData);
		BindingSet<HomelandBuildingItemView, HomelandBuildingItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(buildingLevel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HomelandBuildingItemViewModel vm) => $"Lv.<size=36>{vm.Data.Level}</size>");
		if ((UnityEngine.Object)(object)buildingLevel2 != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(buildingLevel2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HomelandBuildingItemViewModel vm) => $"Lv.<size=36>{vm.Data.Level}</size>");
		}
		bindingSet.Bind(btnOpen).For((Button v) => v.onClick).To((HomelandBuildingItemViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenWindow");
		bindingSet.Bind(red).For((GameObject v) => v.activeSelf).To((HomelandBuildingItemViewModel vm) => vm.Data.IsRed);
		bindingSet.Bind().For((HomelandBuildingItemView v) => v.PlayUpgradeEffect).To((HomelandBuildingItemViewModel vm) => vm.PlayUpgradeEffectRequest);
		bindingSet.Bind(lockRoot).For((GameObject v) => v.activeSelf).To((HomelandBuildingItemViewModel vm) => vm.Data.IsBuildingLock);
		bindingSet.Bind().For((HomelandBuildingItemView v) => v.PlaylockEffect).To((HomelandBuildingItemViewModel vm) => vm.Data.IsBuildingLock);
		bindingSet.Bind(lockRoot1).For((GameObject v) => v.activeSelf).ToExpression((HomelandBuildingItemViewModel vm) => !vm.Data.IsBuildingLock);
		bindingSet.Build();
	}

	private void PlayUpgradeEffect(object sender, InteractionEventArgs e)
	{
		upgradeEffect.SetActive(value: false);
		upgradeEffect.SetActive(value: true);
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

	public void ShowNameTab(bool isShow)
	{
		nameRoot.gameObject.SetActive(isShow && !viewModel.Data.IsBuildingLock && (isSelf || friendOpen));
		if (nameRootOther != null)
		{
			nameRootOther.gameObject.SetActive(isShow && !viewModel.Data.IsBuildingLock && !isSelf && !friendOpen);
		}
	}
}
