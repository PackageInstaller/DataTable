#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class CopyST5EnterItemViewModel : OptionBase
{
	private List<CopyTeamItemViewModel> teamItemList;

	private InteractionRequest<string> optRequest;

	private SimpleCommand<string> optCommand;

	private bool isBlock;

	private int copyId;

	private TeamBPConfigViewModel bpConfigViewModel;

	private int teamTag;

	private bool isHighlight;

	private CopyType5Team teamConfig;

	private BattlePropConfigViewModel configViewModel;

	public BattlePropConfigViewModel BPConfigVM => configViewModel;

	public bool IsBlock
	{
		get
		{
			return isBlock;
		}
		set
		{
			Set(ref isBlock, value, "IsBlock");
		}
	}

	public int TeamTag
	{
		get
		{
			return teamTag;
		}
		set
		{
			Set(ref teamTag, value, "TeamTag");
		}
	}

	public int CopyId => copyId;

	public IInteractionRequest OptRequest => optRequest;

	public ICommand OptCommand => optCommand;

	public TeamBPConfigViewModel BpConfigViewModel => bpConfigViewModel;

	public List<CopyTeamItemViewModel> TeamItemList => teamItemList;

	public int CopyTypeId => teamConfig?.CopyType ?? 0;

	public int EnvironId => teamConfig?.BuffId ?? 0;

	public CopyType5Team TeamConfig => teamConfig;

	public CopyST5EnterItemViewModel()
	{
	}

	public CopyST5EnterItemViewModel(OptionBase parent, CopyType5Team teamConfig)
	{
		base.parent = parent;
		optRequest = new InteractionRequest<string>();
		optCommand = new SimpleCommand<string>(OnOpt);
		SetTeamConfig(teamConfig);
	}

	private void SetTeamConfig(CopyType5Team teamConfig)
	{
		this.teamConfig = teamConfig;
		if (teamItemList == null)
		{
			teamItemList = new List<CopyTeamItemViewModel>();
			for (int i = 0; i < 3; i++)
			{
				teamItemList.Add(new CopyTeamItemViewModel(this));
			}
		}
		if (teamConfig != null && teamConfig.HeroList != null)
		{
			for (int j = 0; j < teamItemList.Count; j++)
			{
				teamItemList[j].RefreshData(teamConfig.GetHeroModel(j));
			}
		}
		if (bpConfigViewModel == null)
		{
			bpConfigViewModel = new TeamBPConfigViewModel(this, teamConfig?.BpList);
		}
		else
		{
			bpConfigViewModel.RefreshData(teamConfig.BpList);
		}
		IsBlock = teamConfig.IsBlock;
		TeamTag = teamConfig.TeamTag;
	}

	public void RefreshData(CopyType5Team teamConfig)
	{
		SetTeamConfig(teamConfig);
	}

	public void Save()
	{
		teamConfig.RefreshData(GetHeroListInt(), isBlock);
	}

	public void SetBlock(bool block)
	{
		teamConfig.SetBlock(block);
		IsBlock = block;
	}

	public void RemoveHero(int heroId)
	{
		for (int i = 0; i < teamItemList.Count; i++)
		{
			if (teamItemList[i].HeroId == heroId)
			{
				teamItemList[i].RefreshData(0, "", 0);
			}
		}
	}

	public bool AddHero(int heroId, string heroSkin, int skinConfigId)
	{
		for (int i = 0; i < teamItemList.Count; i++)
		{
			if (teamItemList[i].HeroId == heroId)
			{
				return false;
			}
			if (teamItemList[i].HeroId == 0)
			{
				teamItemList[i].RefreshData(heroId, heroSkin, skinConfigId);
				return true;
			}
		}
		return false;
	}

	public void SetHero(List<HeroModel> heroList)
	{
		for (int i = 0; i < teamItemList.Count && heroList.Count >= i; i++)
		{
			if (teamItemList[i].HeroId != heroList[i].Id)
			{
				teamItemList[i].RefreshData(heroList[i].Id, heroList[i].SkinSuffix, heroList[i].SkinConfigId);
			}
		}
		TeamConfig.RefreshData(GetHeroListInt(), isBlock: false);
	}

	public List<int> GetHeroListInt()
	{
		List<int> list = new List<int>();
		for (int i = 0; i < teamItemList.Count; i++)
		{
			list.Add(teamItemList[i].HeroId);
		}
		return list;
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is BattlePropConfigViewModel battlePropConfigViewModel)
		{
			configViewModel = battlePropConfigViewModel;
			parent.ItemOnClick(new OptionArg(this, "OpenBpConfig"));
		}
		else if (obj is CopyTeamItemViewModel obj2)
		{
			if (isHighlight)
			{
				parent.ItemOnClick(new OptionArg(obj2, "UnselectTeamHero"));
			}
			else if (!isBlock)
			{
				parent.ItemOnClick(new OptionArg(this, "OpenTeamConfigView"));
			}
			else
			{
				Toast.ShowInfo("阵容已锁定！");
			}
		}
	}

	public void SetHighlight(bool isHighlight)
	{
		this.isHighlight = isHighlight;
		optRequest.Raise(isHighlight ? "HighlightTeam" : "ResetTeam");
	}

	public List<TeamMember> GetTeamCopyData()
	{
		List<TeamMember> list = new List<TeamMember>();
		try
		{
			for (int i = 0; i < 3; i++)
			{
				HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(teamConfig.HeroList[i]);
				if (!heroById.IsNullOrEmpty())
				{
					bool flag = i + 1 == 1;
					list.Add(new TeamMember(i + 1, flag, heroById, flag, !flag));
				}
				if (i == 0 && teamConfig.BpList != null && teamConfig.BpList.Count > 0)
				{
					Dictionary<int, BPData> dictionary = new Dictionary<int, BPData>();
					for (int j = 0; j < teamConfig.BpList.Count; j++)
					{
						BPData bpDataById = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetBpDataById(teamConfig.BpList[j]);
						dictionary.Add((j == 0) ? 1 : 2, bpDataById);
					}
					heroById.AddBPData(dictionary);
				}
			}
		}
		catch (Exception ex)
		{
			Log.Error("获取队伍数据发生异常 " + ex.Message + " / " + ex.StackTrace);
		}
		return list;
	}

	private void OnOpt(string obj)
	{
		if ("ResetTeam".Equals(obj))
		{
			OnResetTeam();
		}
	}

	private void OnResetTeam()
	{
		parent?.ItemOnClick(new OptionArg(this, "ResetTeam"));
	}

	public void ResetTeam()
	{
		if (teamConfig != null)
		{
			teamConfig.Clear();
		}
		for (int i = 0; i < teamItemList.Count; i++)
		{
			teamItemList[i].RefreshData();
		}
		if (bpConfigViewModel != null)
		{
			bpConfigViewModel.ClearBPType5();
		}
		IsBlock = false;
	}

	public void SetBpList()
	{
		teamConfig.SetBpList(GetBPList());
	}

	public bool BPEnough()
	{
		return bpConfigViewModel.CheckBPEnough();
	}

	public bool BPCountEnough()
	{
		return bpConfigViewModel.CheckBPCountEnough();
	}

	public List<int> GetBPList()
	{
		return bpConfigViewModel.GetBPIds();
	}

	public void RemoveCofigVM()
	{
		bpConfigViewModel.RemoveCofigVM();
	}

	public void SetCopyId(int copyId)
	{
		this.copyId = copyId;
	}

	public void SetEnterResult(bool result)
	{
		parent.ItemOnClick(new OptionArg(result, "EnterResult"));
	}

	public void SetBuff(int buffId)
	{
		if (teamConfig != null)
		{
			teamConfig.SetBuff(buffId);
		}
	}
}
