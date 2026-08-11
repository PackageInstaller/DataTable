using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class CopyHeroSelectViewModel : OptionBase
{
	private InteractionRequest<string> optRequest;

	private SimpleCommand<string> optCommand;

	private bool isSelectConfig;

	private List<CopyHeroItemViewModel> heroItemViewModels = new List<CopyHeroItemViewModel>();

	private List<CopyTeamViewModel> teamViewModels = new List<CopyTeamViewModel>();

	private CopyHeroItemViewModel curSelect;

	public bool IsSelectConfig
	{
		get
		{
			return isSelectConfig;
		}
		private set
		{
			Set(ref isSelectConfig, value, "IsSelectConfig");
		}
	}

	public ICommand OptCommand => optCommand;

	public IInteractionRequest OptRequest => optRequest;

	public List<CopyHeroItemViewModel> HeroItemViewModels
	{
		get
		{
			return heroItemViewModels;
		}
		private set
		{
			Set(ref value, heroItemViewModels, "HeroItemViewModels");
		}
	}

	public List<CopyTeamViewModel> TeamItemList
	{
		get
		{
			return teamViewModels;
		}
		private set
		{
			Set(ref value, teamViewModels, "TeamItemList");
		}
	}

	public CopyHeroSelectViewModel()
	{
	}

	public CopyHeroSelectViewModel(OptionBase parent)
	{
		base.parent = parent;
		optRequest = new InteractionRequest<string>();
		optCommand = new SimpleCommand<string>(OnOpt);
		isSelectConfig = true;
		foreach (HeroModel item in Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetAllHeroData().Values.ToList())
		{
			heroItemViewModels.Add(new CopyHeroItemViewModel(this, item));
		}
		foreach (KeyValuePair<int, TeamModel> allTeamDatum in Singleton<ServiceSystem>.Instance.GetService<ITeamService>().GetAllTeamData())
		{
			List<HeroModel> heroModels = allTeamDatum.Value.GetHeroModels();
			bool flag = true;
			for (int i = 0; i < heroModels.Count; i++)
			{
				if (heroModels[i].Id != 0)
				{
					flag = false;
				}
			}
			if (!flag)
			{
				teamViewModels.Add(new CopyTeamViewModel(this, allTeamDatum.Value.TeamName, heroModels));
			}
		}
	}

	public void CheckAllPrefigAndConfigSelect(List<CopyST4EnterItemViewModel> allConfig, int selectIndex, CopyTeamViewModel except = null)
	{
		for (int i = 0; i < heroItemViewModels.Count; i++)
		{
			heroItemViewModels[i].SetTag(haveTag: false, 0);
		}
		if (teamViewModels == null || teamViewModels.Count == 0)
		{
			for (int j = 0; j < allConfig.Count; j++)
			{
				List<int> heroListInt = allConfig[j].GetHeroListInt();
				for (int k = 0; k < heroItemViewModels.Count; k++)
				{
					if (heroListInt.Contains(heroItemViewModels[k].HeroModel.Id))
					{
						heroItemViewModels[k].SetTag(haveTag: true, allConfig[j].TeamTag);
					}
				}
			}
		}
		for (int l = 0; l < teamViewModels.Count; l++)
		{
			if (teamViewModels[l] == except)
			{
				continue;
			}
			bool flag = false;
			for (int m = 0; m < allConfig.Count; m++)
			{
				List<int> heroListInt2 = allConfig[m].GetHeroListInt();
				if (teamViewModels[l].CheckInConfig(heroListInt2))
				{
					flag = true;
					teamViewModels[l].SetSelect(selectIndex == m);
					teamViewModels[l].SetTag(allConfig[m].TeamTag);
				}
				for (int n = 0; n < heroItemViewModels.Count; n++)
				{
					if (!heroItemViewModels[n].HaveTag && heroListInt2.Contains(heroItemViewModels[n].HeroModel.Id))
					{
						heroItemViewModels[n].SetTag(haveTag: true, allConfig[m].TeamTag);
					}
				}
			}
			if (!flag)
			{
				teamViewModels[l].SetSelect(isSelect: false);
				teamViewModels[l].SetTag(0);
			}
		}
	}

	public void RefreshHeroInPrefig(int curTeamTag, Dictionary<int, CopyType5Team> curConfigs)
	{
		for (int i = 0; i < TeamItemList.Count; i++)
		{
			TeamItemList[i].ResetTeamTag();
		}
		for (int j = 0; j < TeamItemList.Count; j++)
		{
			CopyHeroItemViewModel copyHeroItemViewModel = TeamItemList[j].HeroItemViewModels[0];
			CopyHeroItemViewModel copyHeroItemViewModel2 = TeamItemList[j].HeroItemViewModels[1];
			CopyHeroItemViewModel copyHeroItemViewModel3 = TeamItemList[j].HeroItemViewModels[2];
			if (copyHeroItemViewModel.HeroModel.Id == 0 && copyHeroItemViewModel2.HeroModel.Id == 0 && copyHeroItemViewModel3.HeroModel.Id == 0)
			{
				continue;
			}
			foreach (KeyValuePair<int, CopyType5Team> curConfig in curConfigs)
			{
				List<int> heroList = curConfig.Value.HeroList;
				int teamTag = curConfig.Value.TeamTag;
				bool isBlock = curConfig.Value.IsBlock;
				if (copyHeroItemViewModel.HeroModel.Id == heroList[0] && copyHeroItemViewModel2.HeroModel.Id == heroList[1] && copyHeroItemViewModel3.HeroModel.Id == heroList[2])
				{
					TeamItemList[j].SetTag(teamTag, isBlock);
					TeamItemList[j].SetSelect(teamTag == curTeamTag);
					continue;
				}
				for (int k = 0; k < heroList.Count; k++)
				{
					if (heroList[k] == copyHeroItemViewModel.HeroModel.Id)
					{
						copyHeroItemViewModel.SetTag(teamTag, k + 1);
						copyHeroItemViewModel.SetBlock(isBlock);
					}
					else if (heroList[k] == copyHeroItemViewModel2.HeroModel.Id)
					{
						copyHeroItemViewModel2.SetTag(teamTag, k + 1);
						copyHeroItemViewModel2.SetBlock(isBlock);
					}
					else if (heroList[k] == copyHeroItemViewModel3.HeroModel.Id)
					{
						copyHeroItemViewModel3.SetTag(teamTag, k + 1);
						copyHeroItemViewModel3.SetBlock(isBlock);
					}
				}
			}
		}
	}

	public void SetPrefigSelect(int teamTag)
	{
		for (int i = 0; i < teamViewModels.Count; i++)
		{
			teamViewModels[i].CheckSelect(teamTag);
		}
	}

	public void SortHeroList(List<int> team1, List<int> team2)
	{
		heroItemViewModels.Sort(new HeroSortByLevel());
		if (team2 != null)
		{
			for (int num = team2.Count - 1; num >= 0; num--)
			{
				if (team2[num] != 0)
				{
					for (int i = 0; i < heroItemViewModels.Count; i++)
					{
						if (heroItemViewModels[i].HeroModel.Id == team2[num])
						{
							heroItemViewModels.Insert(0, heroItemViewModels[i]);
							heroItemViewModels.RemoveAt(i + 1);
							break;
						}
					}
				}
			}
		}
		for (int num2 = team1.Count - 1; num2 >= 0; num2--)
		{
			if (team1[num2] != 0)
			{
				for (int j = 0; j < heroItemViewModels.Count; j++)
				{
					if (heroItemViewModels[j].HeroModel.Id == team1[num2])
					{
						heroItemViewModels.Insert(0, heroItemViewModels[j]);
						heroItemViewModels.RemoveAt(j + 1);
						break;
					}
				}
			}
		}
		optRequest.Raise("RefreshHeroList");
	}

	public async void OnOpt(string optName)
	{
		if ("Config".Equals(optName))
		{
			CancelCurSelect();
			IsSelectConfig = true;
			parent.ItemOnClick(new OptionArg(this, "SortTeam"));
		}
		else if ("Prefig".Equals(optName))
		{
			IsSelectConfig = false;
			parent.ItemOnClick(new OptionArg(this, "SortTeam"));
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is CopyHeroItemViewModel heroItemVM)
		{
			CancelCurSelect(heroItemVM);
			parent.ItemOnClick(obj);
		}
		else
		{
			parent.ItemOnClick(obj);
		}
	}

	public void SetSelectConfig(bool isSelect)
	{
		IsSelectConfig = isSelect;
	}

	public void CancelCurSelect(CopyHeroItemViewModel heroItemVM = null)
	{
		if (heroItemVM == null)
		{
			if (curSelect != null)
			{
				curSelect.SetSelected(value: false);
			}
			return;
		}
		if (curSelect != heroItemVM && curSelect != null)
		{
			curSelect.SetSelected(value: false);
		}
		curSelect = heroItemVM;
	}

	public void CancelHeroSelectType5(int heroId)
	{
		for (int i = 0; i < heroItemViewModels.Count; i++)
		{
			if (heroItemViewModels[i].HeroModel.Id == heroId)
			{
				heroItemViewModels[i].ResetAllTag();
			}
		}
	}
}
