using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RankHeroSelectItem : UGuiView
{
	[SerializeField]
	private Image heroImg;

	[SerializeField]
	private TextMeshProUGUI heroName;

	[SerializeField]
	private GameObject myScoreGo;

	[SerializeField]
	private TextMeshProUGUI rank;

	[SerializeField]
	private GameObject selectFrame;

	[SerializeField]
	private Button button;

	private RankHeroSelectItemData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<RankHeroSelectItemData>(userData);
		BindingSet<RankHeroSelectItem, RankHeroSelectItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(heroImg).For((Image v) => v.sprite).To((RankHeroSelectItemData vm) => vm.HeroImg)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(heroName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RankHeroSelectItemData vm) => vm.HeroName);
		bindingSet.Bind(myScoreGo).For((GameObject v) => v.activeSelf).To((RankHeroSelectItemData vm) => vm.ShowMyScore);
		bindingSet.Bind<TextMeshProUGUI>(rank).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RankHeroSelectItemData vm) => vm.Rank);
		bindingSet.Bind(selectFrame).For((GameObject v) => v.activeSelf).To((RankHeroSelectItemData vm) => vm.Selected);
		bindingSet.Bind(button).For((Button v) => v.onClick).To((RankHeroSelectItemData vm) => vm.OnItemClick);
		bindingSet.Build();
	}
}
