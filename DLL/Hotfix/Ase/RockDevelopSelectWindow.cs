using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RockDevelopSelectWindow : UGuiWindow
{
	[SerializeField]
	private Transform rockListRoot;

	[SerializeField]
	private Button confirm;

	[SerializeField]
	private GameObject rockView;

	[SerializeField]
	private RockPopupView rockPopupView;

	[SerializeField]
	private EntryInfoView entryInfoView;

	[SerializeField]
	private Button btnOpenHeroEntryView;

	[SerializeField]
	private GameObject btnOpenHeroEntryViewObj;

	private RockDevelopSelectViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<RockDevelopSelectViewModel>();
		BindingSet<RockDevelopSelectWindow, RockDevelopSelectViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((RockDevelopSelectWindow v) => v.OpenUguiWindow).To((RockDevelopSelectViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((RockDevelopSelectWindow v) => v.CloseWindow).To((RockDevelopSelectViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(confirm).For((Button v) => v.onClick).To((RockDevelopSelectViewModel vm) => vm.ConfirmCmd);
		bindingSet.Bind(this).For((RockDevelopSelectWindow v) => v.ShowEntryDetail).To((RockDevelopSelectViewModel vm) => vm.ShowEntryDetailRequest);
		bindingSet.Bind(btnOpenHeroEntryView).For((Button v) => v.onClick).To((RockDevelopSelectViewModel vm) => vm.OpenHeroEntryDetailViewCmd);
		bindingSet.Bind(btnOpenHeroEntryViewObj).For((GameObject v) => v.activeSelf).To((RockDevelopSelectViewModel vm) => vm.ShowHeroEntryDetailView);
		bindingSet.Build();
		rockPopupView.Init(viewModel.OldPopupViewModel);
		CreateRockView();
		entryInfoView.Init();
	}

	private void ShowEntryDetail(object sender, InteractionEventArgs e)
	{
		Vector2 position = new Vector2(viewModel.PositionX, -140f);
		entryInfoView.SetPosition(position);
		if (e.Context is EntryItemData entryItemData)
		{
			entryInfoView.Show(entryItemData, null, !entryItemData.IsMainEntry);
		}
	}

	private void CreateRockView()
	{
		foreach (RockPopupViewModel rockPopupViewModel in viewModel.RockPopupViewModelList)
		{
			GameObject obj = Object.Instantiate(rockView, rockListRoot);
			obj.transform.GetComponent<RockPopupView>().Init(rockPopupViewModel);
			obj.gameObject.SetActive(value: true);
		}
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
