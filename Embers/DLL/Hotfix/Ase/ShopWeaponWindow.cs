#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Linq.Expressions;
using GameFramework;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class ShopWeaponWindow : PropExchangeView
{
	[SerializeField]
	private TextMeshProUGUI weaponRefine;

	[SerializeField]
	private RectTransform weapon;

	[SerializeField]
	private TextMeshProUGUI weaponEnumText;

	private GameObject weaponObj;

	private PropExchangeViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<PropExchangeViewModel>(userData);
		BindingSet<ShopWeaponWindow, PropExchangeViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(weaponRefine).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropExchangeViewModel vm) => vm.WeaponRefineText);
		bindingSet.Bind<TextMeshProUGUI>(weaponEnumText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropExchangeViewModel vm) => vm.WeaponTypeText);
		bindingSet.Build();
		LoadImg();
	}

	protected override void OnEnable()
	{
		LoadImg();
		base.OnEnable();
	}

	private async void LoadImg()
	{
		try
		{
			if (weaponObj != null)
			{
				UnityEngine.Object.Destroy(weaponObj);
			}
			string path = "";
			if (viewModel?.PropData != null)
			{
				if (viewModel.PropData is WeaponData weaponData)
				{
					path = AssetUtility.GetUIItemAsset("WeaponPrefabs/" + weaponData.Icon);
				}
				GameObject gameObject = await InstantiateAsync(path, weapon);
				if (!(gameObject == null))
				{
					(weaponObj = gameObject).GetComponent<RectTransform>().Find("Type")?.gameObject.SetActive(value: false);
				}
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
	}
}
