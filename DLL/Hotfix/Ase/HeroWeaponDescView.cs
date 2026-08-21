using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroWeaponDescView : UGuiView
{
	public ScrollRect scrollRect;

	public Button btnBack;

	public Button btnBack2;

	public GameObject isSelfItem;

	public List<WeaponDescItemView> buttonList;

	public RectTransform content;

	private HeroWeaponDescViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<HeroWeaponDescViewModel>(userData);
		BindingSet<HeroWeaponDescView, HeroWeaponDescViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((HeroWeaponDescView v) => v.SetButton).To((HeroWeaponDescViewModel vm) => vm.ShowWeaponRequest);
		bindingSet.Build();
		if (buttonList != null)
		{
			for (int num = 0; num < buttonList.Count; num++)
			{
				buttonList[num].AddAction(viewModel.OnButtonClick);
			}
		}
		btnBack.onClick.AddListener(delegate
		{
			base.gameObject.SetActive(value: false);
		});
		btnBack2.onClick.AddListener(delegate
		{
			base.gameObject.SetActive(value: false);
		});
		SetWeapon(viewModel.CurHeroWeaponEnum);
	}

	private void SetButton(object sender, InteractionEventArgs e)
	{
		WeaponEnum weapon = (WeaponEnum)e.Context;
		SetWeapon(weapon);
	}

	private void SetWeapon(WeaponEnum weaponEnum)
	{
		for (int i = 0; i < buttonList.Count; i++)
		{
			buttonList[i].sel.gameObject.SetActive(buttonList[i].weaponEnum == weaponEnum);
			buttonList[i].content.gameObject.SetActive(buttonList[i].weaponEnum == weaponEnum);
			if (buttonList[i].weaponEnum == weaponEnum)
			{
				content.sizeDelta = new Vector2(content.sizeDelta.x, buttonList[i].height);
			}
		}
		isSelfItem.gameObject.SetActive(weaponEnum == viewModel.CurHeroWeaponEnum);
		scrollRect.verticalNormalizedPosition = 1f;
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<HeroWeaponDescViewModel>(userData);
		this.SetDataContext(viewModel);
		SetWeapon(viewModel.CurHeroWeaponEnum);
	}
}
