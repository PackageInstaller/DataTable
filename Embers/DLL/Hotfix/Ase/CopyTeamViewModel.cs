using System.Collections.Generic;

namespace Ase;

public class CopyTeamViewModel : OptionBase
{
	private string teamName;

	private bool isSelect;

	private List<CopyHeroItemViewModel> heroItemViewModels = new List<CopyHeroItemViewModel>();

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		private set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public string TeamName
	{
		get
		{
			return teamName;
		}
		set
		{
			Set(ref teamName, value, "TeamName");
		}
	}

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

	public CopyTeamViewModel()
	{
	}

	public CopyTeamViewModel(OptionBase parent, string teamName, List<HeroModel> heroModels)
	{
		base.parent = parent;
		this.teamName = teamName;
		for (int i = 0; i < heroModels.Count; i++)
		{
			heroItemViewModels.Add(new CopyHeroItemViewModel(this, heroModels[i]));
		}
		for (int j = heroItemViewModels.Count; j < 3; j++)
		{
			heroItemViewModels.Add(new CopyHeroItemViewModel(this, null));
		}
	}

	public void Select()
	{
		parent.ItemOnClick(new OptionArg(this, "SelectPrefig"));
	}

	public void SetTag(int tagId, bool isBlock = false)
	{
		for (int i = 0; i < heroItemViewModels.Count; i++)
		{
			heroItemViewModels[i].SetTag(tagId, i + 1);
			heroItemViewModels[i].SetBlock(isBlock);
		}
	}

	public bool CheckInConfig(List<int> heroIds)
	{
		bool result = true;
		for (int i = 0; i < heroIds.Count; i++)
		{
			if (heroItemViewModels.Count > i && heroItemViewModels[i].HeroModel.Id != heroIds[i])
			{
				result = false;
			}
		}
		for (int j = heroIds.Count; j < 3; j++)
		{
			if (heroItemViewModels[j].HeroModel != null && heroItemViewModels[j].HeroModel.Id != 0)
			{
				result = false;
			}
		}
		return result;
	}

	public void GetHeroIds(in List<HeroModel> heroModels, in List<int> heroId)
	{
		for (int i = 0; i < heroItemViewModels.Count; i++)
		{
			if (heroItemViewModels[i].HeroModel == null)
			{
				heroModels.Add(HeroModel.CreateEmpty());
				heroId.Add(0);
			}
			else
			{
				heroModels.Add(heroItemViewModels[i].HeroModel);
				heroId.Add(heroItemViewModels[i].HeroModel.Id);
			}
		}
		for (int j = heroModels.Count; j < 3; j++)
		{
			heroModels.Add(HeroModel.CreateEmpty());
			heroId.Add(0);
		}
	}

	public void CheckSelect(int teamTag)
	{
		if (heroItemViewModels[0].HaveTag && heroItemViewModels[0].TagIndex == teamTag)
		{
			SetSelect(isSelect: true);
		}
		else
		{
			SetSelect(isSelect: false);
		}
	}

	public void SetSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}

	public void ResetTeamTag()
	{
		SetSelect(isSelect: false);
		for (int i = 0; i < heroItemViewModels.Count; i++)
		{
			heroItemViewModels[i].ResetAllTag();
		}
	}
}
