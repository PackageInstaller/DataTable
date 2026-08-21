using System.Collections.Generic;

namespace Ase;

public class TeamViewModel : OptionBase
{
	private int _teamId;

	private string _teamName;

	private List<HeroModel> _heroModels;

	private PrepareTeamViewModel _prepareTeamViewModel;

	private List<HeroItemViewModel> _itemViewModels;

	public string TeamName
	{
		get
		{
			return _teamName;
		}
		set
		{
			Set(ref _teamName, value, "TeamName");
		}
	}

	public List<HeroModel> HeroModels => _heroModels;

	public List<HeroItemViewModel> ItemViewModels => _itemViewModels;

	public TeamViewModel(PrepareTeamViewModel prepareTeamViewModel, int teamId, List<HeroModel> heroModels = null)
	{
		_prepareTeamViewModel = prepareTeamViewModel;
		_teamId = teamId;
		_heroModels = heroModels;
		_itemViewModels = new List<HeroItemViewModel>();
		for (int i = 0; i < 3; i++)
		{
			_itemViewModels.Add(new HeroItemViewModel(this));
		}
	}

	public void Select(bool isOn)
	{
		if (isOn)
		{
			_prepareTeamViewModel.CurSelectTeamId = _teamId;
		}
	}

	public void UpdateTeamData(TeamModel teamModel)
	{
		TeamName = teamModel.TeamName;
		_heroModels = teamModel.GetHeroModels();
		for (int i = 0; i < 3; i++)
		{
			_itemViewModels[i].SetData(_heroModels[i]);
		}
	}
}
