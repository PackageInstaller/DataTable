using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GamePlayTipsWindow : UGuiWindow
{
	[SerializeField]
	private Button btnClose1;

	[SerializeField]
	private Button btnClose2;

	[SerializeField]
	private TextMeshProUGUI textTitle;

	[SerializeField]
	private TextMeshProUGUI textContent;

	private GamePlayTipsViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<GamePlayTipsViewModel>();
		BindingSet<GamePlayTipsWindow, GamePlayTipsViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((GamePlayTipsWindow v) => v.OpenUguiWindow).To((GamePlayTipsViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((GamePlayTipsWindow v) => v.CloseWindow).To((GamePlayTipsViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnClose1).For((Button v) => v.onClick).To((GamePlayTipsViewModel vm) => vm.Close);
		bindingSet.Bind(btnClose2).For((Button v) => v.onClick).To((GamePlayTipsViewModel vm) => vm.Close);
		bindingSet.Bind<TextMeshProUGUI>(textTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GamePlayTipsViewModel vm) => vm.Title);
		bindingSet.Bind<TextMeshProUGUI>(textContent).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GamePlayTipsViewModel vm) => vm.Content);
		bindingSet.Build();
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
