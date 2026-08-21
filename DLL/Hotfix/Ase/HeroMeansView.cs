using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class HeroMeansView : HeroCultivateView
{
	[SerializeField]
	private TextMeshProUGUI birthText;

	[SerializeField]
	private TextMeshProUGUI faction;

	[SerializeField]
	private TextMeshProUGUI storyText;

	[SerializeField]
	private new TextMeshProUGUI name;

	private HeroCultivateViewModel _viewModel;

	public void Init(HeroCultivateViewModel viewModel)
	{
		_viewModel = viewModel;
		BindingSet<HeroMeansView, HeroCultivateViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(birthText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroCultivateViewModel vm) => vm.HeroModel.Birthday);
		bindingSet.Bind<TextMeshProUGUI>(faction).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroCultivateViewModel vm) => vm.HeroModel.Faction);
		bindingSet.Bind<TextMeshProUGUI>(storyText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HeroCultivateViewModel vm) => vm.HeroModel.Story.Replace("\\n", "\n"));
		bindingSet.Bind().For((HeroMeansView v) => v.RefreshHero).To((HeroCultivateViewModel vm) => vm.OnRefreshRequest);
		bindingSet.Build();
	}

	public void RefreshHero(object sender, InteractionEventArgs e)
	{
		if (_viewModel.HeroModel.Name.Length == 2)
		{
			((TMP_Text)name).text = $"{_viewModel.HeroModel.Name[0]} {_viewModel.HeroModel.Name[1]}";
		}
		else
		{
			((TMP_Text)name).text = _viewModel.HeroModel.Name;
		}
	}
}
