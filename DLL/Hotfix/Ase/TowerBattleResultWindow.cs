using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TowerBattleResultWindow : UGuiWindow
{
	[SerializeField]
	private Button quitBtn;

	[SerializeField]
	private Button endlessBtn;

	[SerializeField]
	private GameObject successGo;

	[SerializeField]
	private GameObject failGo;

	[SerializeField]
	private GameObject scoreGo;

	[SerializeField]
	private TextMeshProUGUI scoreTMP;

	private TowerBattleResultViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<TowerBattleResultViewModel>();
		BindingSet<TowerBattleResultWindow, TowerBattleResultViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(successGo).For((GameObject v) => v.activeSelf).To((TowerBattleResultViewModel vm) => vm.ShowSuccess);
		bindingSet.Bind(failGo).For((GameObject v) => v.activeSelf).ToExpression((TowerBattleResultViewModel vm) => !vm.ShowSuccess);
		bindingSet.Bind(endlessBtn.gameObject).For((GameObject v) => v.activeSelf).To((TowerBattleResultViewModel vm) => vm.ShowSuccess);
		bindingSet.Bind(scoreGo).For((GameObject v) => v.activeSelf).To((TowerBattleResultViewModel vm) => vm.ShowScore);
		bindingSet.Bind<TextMeshProUGUI>(scoreTMP).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TowerBattleResultViewModel vm) => vm.Score);
		bindingSet.Bind(quitBtn).For((Button v) => v.onClick).To((TowerBattleResultViewModel vm) => vm.QuitCopyCmd);
		bindingSet.Bind(endlessBtn).For((Button v) => v.onClick).To((TowerBattleResultViewModel vm) => vm.ChallengeEndlessCmd);
		bindingSet.Build();
	}
}
