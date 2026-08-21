using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GameStoryCGWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnPrevious;

	[SerializeField]
	private Button btnNext;

	[SerializeField]
	private Button btnCount;

	[SerializeField]
	private TextMeshProUGUI countText;

	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private TextMeshProUGUI desc;

	[SerializeField]
	private RollingView rollingView;

	private GameStoryCGViewModel viewModel;

	private string imgPath = "";

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<GameStoryCGViewModel>();
		BindingSet<GameStoryCGWindow, GameStoryCGViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((GameStoryCGViewModel vm) => vm.Close);
		bindingSet.Bind(this).For((GameStoryCGWindow v) => v.OpenUguiWindow).To((GameStoryCGViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((GameStoryCGWindow v) => v.CloseWindow).To((GameStoryCGViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnPrevious).For((Button v) => v.onClick).To((GameStoryCGViewModel vm) => vm.Previous);
		bindingSet.Bind(btnNext).For((Button v) => v.onClick).To((GameStoryCGViewModel vm) => vm.Next);
		bindingSet.Bind(btnCount).For((Button v) => v.onClick).To((GameStoryCGViewModel vm) => vm.Next);
		bindingSet.Bind<TextMeshProUGUI>(countText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameStoryCGViewModel vm) => vm.CountText);
		bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameStoryCGViewModel vm) => vm.Title);
		bindingSet.Bind<TextMeshProUGUI>(desc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameStoryCGViewModel vm) => vm.Desc);
		bindingSet.Build();
		rollingView.Init(viewModel.RollingViewModel);
		btnPrevious.gameObject.SetActive(viewModel.Count > 1);
		btnNext.gameObject.SetActive(viewModel.Count > 1);
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
