using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroWeaponView : HeroCultivateView
{
	[SerializeField]
	private WeaponDetailView _weaponDetailView;

	[SerializeField]
	private Image heroImg;

	[SerializeField]
	private Transform weaponObjPos;

	[SerializeField]
	private EntryInfoView _entryInfoView;

	private GameObject weaponObj;

	private string weaponPath = "";

	private HeroCultivateViewModel viewModel;

	private int loadCount;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<HeroCultivateViewModel>(userData);
		BindingSet<HeroWeaponView, HeroCultivateViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((HeroWeaponView v) => v.Refresh).To((HeroCultivateViewModel vm) => vm.OnRefreshRequest);
		bindingSet.Bind(heroImg).For((Image v) => v.sprite).ToExpression((HeroCultivateViewModel vm) => vm.HeroModel.IsNullOrEmpty() ? "" : $"{viewModel.HeroModel.Id}_Card")
			.WithConversion("ItemIcon");
		bindingSet.Bind(this).For((HeroWeaponView v) => v.ShowEntryDetail).To((HeroCultivateViewModel vm) => vm.ShowEntryDetailRequest);
		bindingSet.Build();
		_weaponDetailView.Init(viewModel.WeaponDetailViewModel);
		_entryInfoView.Init();
	}

	private void ShowEntryDetail(object sender, InteractionEventArgs e)
	{
		EntryItem entryItem = (EntryItem)e.Context;
		_entryInfoView.Show(entryItem.ViewModel);
	}

	public void HideEntryInfoView()
	{
		_entryInfoView.Hide();
	}

	private void Refresh(object sender, InteractionEventArgs e)
	{
		loadCount = 0;
		_weaponDetailView.RefreshData();
		LoadWeaponObj();
	}

	private async void LoadWeaponObj()
	{
		if (weaponObj != null)
		{
			Object.Destroy(weaponObj);
		}
		weaponPath = AssetUtility.GetUIItemAsset("WeaponPrefabs/" + viewModel.HeroModel.HeldWeapon.Icon);
		GameObject gameObject = await InstantiateAsync(weaponPath, weaponObjPos);
		loadCount++;
		if (gameObject == null)
		{
			if (loadCount < 5)
			{
				LoadWeaponObj();
			}
			return;
		}
		weaponObj = gameObject;
		UIStarGroup componentInChildren = weaponObj.GetComponentInChildren<UIStarGroup>();
		if (componentInChildren != null)
		{
			componentInChildren.CurCount = viewModel.HeroModel.HeldWeapon.Star;
		}
	}

	public override void Show()
	{
		base.Show();
		loadCount = 0;
		_weaponDetailView.RefreshData();
		LoadWeaponObj();
		showArrowPart = false;
		showHeroFimage = false;
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
	}
}
