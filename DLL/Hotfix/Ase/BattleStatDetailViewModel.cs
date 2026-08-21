using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class BattleStatDetailViewModel : OptionBase
{
	private InteractionRequest<string> optRequest = new InteractionRequest<string>();

	private List<CopyTeamItemViewModel> heroList;

	private string name;

	private string playerName = "";

	private bool showHeroName;

	private Dictionary<int, string> nameDic;

	private List<BattleStatSkillItemViewModel> skillList;

	private Dictionary<int, Dictionary<int, BattleStatSkillItemViewModel>> skillAll;

	private int curPosId;

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public string PlayerName
	{
		get
		{
			return playerName;
		}
		private set
		{
			Set(ref playerName, value, "PlayerName");
		}
	}

	public List<BattleStatSkillItemViewModel> SkillList => skillList;

	public bool ShowHeroName => showHeroName;

	public List<CopyTeamItemViewModel> TeamItemList => heroList;

	public IInteractionRequest OptRequest => optRequest;

	public BattleStatDetailViewModel()
	{
	}

	public BattleStatDetailViewModel(OptionBase parent, List<TeamMember> teamMembers, Dictionary<int, Dictionary<int, BSData>> accounts, bool showHeroName)
	{
		base.parent = parent;
		this.showHeroName = showHeroName;
		heroList = new List<CopyTeamItemViewModel>();
		nameDic = new Dictionary<int, string>();
		for (int i = 0; i < teamMembers.Count; i++)
		{
			heroList.Add(new CopyTeamItemViewModel(this, teamMembers[i].HeroModel, teamMembers[i].MemberId, teamMembers[i].HeroModel.Name, showHeroName));
			nameDic.Add(teamMembers[i].MemberId, teamMembers[i].Name);
		}
		curPosId = 0;
		heroList.Sort(new CopyTeamItemSort());
		skillAll = new Dictionary<int, Dictionary<int, BattleStatSkillItemViewModel>>();
		foreach (KeyValuePair<int, Dictionary<int, BSData>> account in accounts)
		{
			int key = account.Key;
			skillAll.Add(key, new Dictionary<int, BattleStatSkillItemViewModel>());
			HeroModel heroModel = GetHeroModel(teamMembers, key);
			DRHeroSKillInfo[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroSKillInfo p) => p.HeroId == ((heroModel != null) ? heroModel.Id : 0));
			foreach (KeyValuePair<int, BSData> item in account.Value)
			{
				DRHeroSKillInfo heroSkillInfo = GetHeroSkillInfo(dataRows, item.Value.SkillId);
				if (heroSkillInfo != null)
				{
					item.Value.AddSkillInfo(heroSkillInfo);
					if (!skillAll[key].ContainsKey(-heroSkillInfo.SkillId))
					{
						List<BSData> list = new List<BSData>();
						for (int num = 0; num < heroSkillInfo.CommandBindSkillGroup.Count; num++)
						{
							if (account.Value.ContainsKey(heroSkillInfo.CommandBindSkillGroup[num]))
							{
								list.Add(account.Value[heroSkillInfo.CommandBindSkillGroup[num]]);
							}
						}
						BSData bSData = new BSData(heroSkillInfo, list, heroModel);
						skillAll[key].Add(bSData.SkillId, new BattleStatSkillItemViewModel(this, bSData));
					}
				}
				else
				{
					DRBattlePropInfo heroBattleProp = GetHeroBattleProp(item.Value.SkillId);
					if (heroBattleProp != null)
					{
						item.Value.AddSkillInfo(heroBattleProp);
						if (!skillAll[key].ContainsKey(-heroBattleProp.PropSkillID))
						{
							BSData bSData2 = new BSData(heroBattleProp, HeroSkillTypeEnum.PropSkill, new List<BSData> { account.Value[heroBattleProp.PropSkillID] });
							skillAll[key].Add(bSData2.SkillId, new BattleStatSkillItemViewModel(this, bSData2));
						}
					}
				}
				skillAll[key].Add(item.Key, new BattleStatSkillItemViewModel(this, item.Value));
			}
		}
		SetSkillList();
	}

	private int GetHeroId(List<TeamMember> teamMembers, int memberId)
	{
		for (int i = 0; i < teamMembers.Count; i++)
		{
			if (teamMembers[i].MemberId == memberId)
			{
				return teamMembers[i].HeroModel.Id;
			}
		}
		return 0;
	}

	private HeroModel GetHeroModel(List<TeamMember> teamMembers, int memberId)
	{
		for (int i = 0; i < teamMembers.Count; i++)
		{
			if (teamMembers[i].MemberId == memberId)
			{
				return teamMembers[i].HeroModel;
			}
		}
		return null;
	}

	private DRHeroSKillInfo GetHeroSkillInfo(DRHeroSKillInfo[] sKillInfos, int skillId)
	{
		for (int i = 0; i < sKillInfos.Length; i++)
		{
			if (sKillInfos[i].CommandBindSkillGroup.Contains(skillId))
			{
				return sKillInfos[i];
			}
		}
		return null;
	}

	private DRBattlePropInfo GetHeroBattleProp(int battlePropId)
	{
		return GameEntry.DataTable.GetDataRow((DRBattlePropInfo p) => p.PropSkillID == battlePropId);
	}

	public void SelectHero(int memberId)
	{
		for (int i = 0; i < heroList.Count; i++)
		{
			if (heroList[i].Pos == memberId)
			{
				if (curPosId != heroList[i].Pos)
				{
					SelectHero(heroList[i]);
					SetSkillList();
				}
				break;
			}
		}
	}

	private void SetSkillList()
	{
		if (skillList == null)
		{
			skillList = new List<BattleStatSkillItemViewModel>();
		}
		else
		{
			skillList.Clear();
		}
		if (skillAll.ContainsKey(curPosId))
		{
			Dictionary<int, BattleStatSkillItemViewModel> dictionary = skillAll[curPosId];
			foreach (KeyValuePair<int, BattleStatSkillItemViewModel> item in dictionary)
			{
				if (!item.Value.Data.IsTotalItem || item.Value.Data.SkillId == 0)
				{
					continue;
				}
				skillList.Add(item.Value);
				if (!item.Value.IsSelect || !item.Value.Data.HasChild)
				{
					continue;
				}
				List<int> deriveSkillList = item.Value.Data.DeriveSkillList;
				if (deriveSkillList == null)
				{
					continue;
				}
				for (int i = 0; i < deriveSkillList.Count; i++)
				{
					if (dictionary.ContainsKey(deriveSkillList[i]))
					{
						skillList.Add(dictionary[deriveSkillList[i]]);
					}
				}
			}
			skillList.Sort(new BattleStatSkillSort());
			if (dictionary.ContainsKey(-1))
			{
				skillList.Insert(0, dictionary[-1]);
			}
			if (dictionary.ContainsKey(-2))
			{
				dictionary[-2].SetOther();
				skillList.Add(dictionary[-2]);
			}
		}
		optRequest.Raise("RefreshSkillList");
	}

	private void SelectHero(CopyTeamItemViewModel heroItem)
	{
		if (curPosId == heroItem.Pos)
		{
			return;
		}
		for (int i = 0; i < heroList.Count; i++)
		{
			if (heroList[i].Pos == curPosId)
			{
				heroList[i].SetSelect(isSelect: false);
			}
		}
		curPosId = heroItem.Pos;
		heroItem.SetSelect(isSelect: true);
		Name = heroItem.Name;
		if (nameDic.ContainsKey(heroItem.Pos))
		{
			PlayerName = nameDic[heroItem.Pos];
		}
		optRequest.Raise("RefreshHeroSelect");
	}

	private void SelectSkill(BattleStatSkillItemViewModel skillItem)
	{
		skillItem.SetSelect(!skillItem.IsSelect);
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is CopyTeamItemViewModel copyTeamItemViewModel)
		{
			if (!copyTeamItemViewModel.IsSelect)
			{
				SelectHero(copyTeamItemViewModel);
				SetSkillList();
			}
		}
		else if (obj is BattleStatSkillItemViewModel skillItem)
		{
			SelectSkill(skillItem);
			SetSkillList();
		}
	}

	public void OnPro()
	{
		Toast.ShowInfo("功能暂未开放！");
	}
}
