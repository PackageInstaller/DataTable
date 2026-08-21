using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SingleTeamView : UGuiView
{
	[SerializeField]
	private Toggle toggle;

	[SerializeField]
	private Text teamName;

	[SerializeField]
	private Transform cardContent;

	private TeamViewModel _viewModel;

	public Toggle Toggle => toggle;

	public TeamViewModel ViewModel => _viewModel;

	public void Init(TeamViewModel teamViewModel)
	{
		_viewModel = teamViewModel;
		BindingSet<SingleTeamView, TeamViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(teamName).For((Text v) => v.text).To((TeamViewModel vm) => vm.TeamName);
		bindingSet.Build();
		toggle.onValueChanged.AddListener(delegate(bool value)
		{
			_viewModel.Select(value);
		});
		InitCards();
	}

	private void InitCards()
	{
		for (int i = 0; i < 3; i++)
		{
			cardContent.GetChild(i).GetComponent<HeroItem>().Init(_viewModel.ItemViewModels[i]);
		}
	}
}
