#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class CopyST4EnterItemViewModel : OptionBase
{
	private CopyData data;

	private string bossName;

	private CopyT4Stage copyStage;

	private string bossIcon;

	private List<int> adItemList;

	private List<CopyTeamItemViewModel> teamItemList;

	private InteractionRequest<string> optRequest;

	private SimpleCommand<string> optCommand;

	private List<StarConditionItemData> conditionItems = new List<StarConditionItemData>();

	private bool multiCopy;

	private bool isConfigging;

	private TeamBPConfigViewModel bpConfigViewModel;

	private int teamTag;

	private BattlePropConfigViewModel configViewModel;

	private List<StarConditionItemData> conditionDatas;

	public BattlePropConfigViewModel BPConfigVM => configViewModel;

	public List<int> AdItemList => adItemList;

	public CopyData Data
	{
		get
		{
			return data;
		}
		private set
		{
			Set(ref data, value, "Data");
		}
	}

	public string BossIcon
	{
		get
		{
			return bossIcon;
		}
		private set
		{
			Set(ref bossIcon, value, "BossIcon");
		}
	}

	public string BossName
	{
		get
		{
			return bossName;
		}
		private set
		{
			Set(ref bossName, value, "BossName");
		}
	}

	public CopyT4Stage CopyStage
	{
		get
		{
			return copyStage;
		}
		private set
		{
			Set(ref copyStage, value, "CopyStage");
		}
	}

	public bool MultiCopy
	{
		get
		{
			return multiCopy;
		}
		private set
		{
			Set(ref multiCopy, value, "MultiCopy");
		}
	}

	public bool IsConfigging
	{
		get
		{
			return isConfigging;
		}
		set
		{
			Set(ref isConfigging, value, "IsConfigging");
		}
	}

	public IInteractionRequest OptRequest => optRequest;

	public ICommand OptCommand => optCommand;

	public List<StarConditionItemData> ConditionItems => conditionItems;

	public TeamBPConfigViewModel BpConfigViewModel => bpConfigViewModel;

	public List<CopyTeamItemViewModel> TeamItemList => teamItemList;

	public int TeamTag => teamTag;

	public CopyST4EnterItemViewModel()
	{
	}

	public CopyST4EnterItemViewModel(OptionBase parent, CopyData data, CopyType4TeamConfig teamConfig, int teamTag, bool isMultiCopy)
	{
		base.parent = parent;
		optRequest = new InteractionRequest<string>();
		optCommand = new SimpleCommand<string>(OnOpt);
		this.teamTag = teamTag;
		Data = data;
		multiCopy = isMultiCopy;
		adItemList = new List<int>();
		if (data.Buffs != null)
		{
			for (int i = 0; i < data.Buffs.Count; i++)
			{
				adItemList.Insert(0, data.Buffs[i]);
			}
		}
		DRMonsterInfo dataRow = GameEntry.DataTable.GetDataRow((DRMonsterInfo p) => p.Id == this.data.BossTypes[0]);
		if (dataRow != null)
		{
			bossName = dataRow.Name;
			bossIcon = data.BossIcon;
		}
		else
		{
			Log.Error("Copy表配置异常，找不到MonsterInfo Id【this.data.BossTypes[0]】");
		}
		conditionItems.Clear();
		List<StarConditionItemData> conditions = GetConditions(data.StarCondition);
		for (int num = 0; num < conditions.Count; num++)
		{
			conditionItems.Add(conditions[num]);
		}
		SetTeamConfig(teamConfig);
	}

	private void SetTeamConfig(CopyType4TeamConfig teamConfig)
	{
		if (teamItemList == null)
		{
			teamItemList = new List<CopyTeamItemViewModel>();
		}
		bool flag = false;
		if (teamConfig == null || teamConfig.HeroList == null)
		{
			for (int i = 0; i < 3; i++)
			{
				teamItemList.Add(new CopyTeamItemViewModel(this));
			}
		}
		else
		{
			for (int j = 0; j < teamItemList.Count; j++)
			{
				if (teamConfig.HeroList.Count > j)
				{
					teamItemList[j].RefreshData(teamConfig.GetHeroListIndex(j));
					if (teamConfig.HeroList[j] != 0)
					{
						flag = true;
					}
				}
				else
				{
					teamItemList.Add(new CopyTeamItemViewModel(this));
				}
			}
			for (int k = teamItemList.Count; k < 3; k++)
			{
				teamItemList.Add(new CopyTeamItemViewModel(this, (teamConfig.HeroList.Count > k) ? teamConfig.GetHeroListIndex(k) : null));
				if (teamConfig.HeroList.Count > k && teamConfig.HeroList[k] != 0)
				{
					flag = true;
				}
			}
		}
		bpConfigViewModel = new TeamBPConfigViewModel(this, teamConfig?.BpList);
		CopyStage = (flag ? CopyT4Stage.Entered : CopyT4Stage.None);
	}

	public bool HaveTeam()
	{
		for (int i = 0; i < teamItemList.Count; i++)
		{
			if (teamItemList[i].HeroId != 0)
			{
				return true;
			}
		}
		return false;
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

	public void SetHero(in List<HeroModel> heroIds)
	{
		for (int i = 0; i < teamItemList.Count; i++)
		{
			if (heroIds.Count > i)
			{
				teamItemList[i].RefreshData(heroIds[i]);
			}
		}
	}

	public void RemoveSameHero(in List<int> heroIds)
	{
		for (int i = 0; i < teamItemList.Count; i++)
		{
			if (heroIds.Contains(teamItemList[i].HeroId))
			{
				teamItemList[i].RefreshData();
			}
		}
	}

	public bool CheckInTeam(int heroId)
	{
		if (heroId == 0)
		{
			return false;
		}
		for (int i = 0; i < teamItemList.Count; i++)
		{
			if (heroId == teamItemList[i].HeroId)
			{
				return true;
			}
		}
		return false;
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

	public List<HeroSkinBind> GetHeroList()
	{
		List<HeroSkinBind> list = new List<HeroSkinBind>();
		for (int i = 0; i < teamItemList.Count; i++)
		{
			list.Add(new HeroSkinBind
			{
				heroId = teamItemList[i].HeroId,
				heroSkinSuffix = teamItemList[i].HeroSkinSuffix,
				skinConfigId = teamItemList[i].SkinConfigId
			});
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
		else if (obj is CopyTeamItemViewModel obj2 && copyStage != CopyT4Stage.Entered)
		{
			parent.ItemOnClick(new OptionArg(obj2, "UnselectTeamHero"));
			parent.ItemOnClick(new OptionArg(this, "OpenTeamConfigView"));
		}
	}

	public void SetHighlight(bool isHighlight)
	{
		optRequest.Raise(isHighlight ? "HighlightTeam" : "ResetTeam");
	}

	public List<TeamMember> GetTeamCopyData()
	{
		List<TeamMember> list = new List<TeamMember>();
		CopyType4TeamConfig teamConfig = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetTeamConfig(data.Id);
		for (int i = 0; i < 3; i++)
		{
			HeroModel heroById = teamConfig.GetHeroById(teamItemList[i].HeroId);
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
		return list;
	}

	private void OnOpt(string obj)
	{
		if ("EnterCopy".Equals(obj))
		{
			parent.ItemOnClick(new OptionArg(this, obj));
		}
	}

	public void SetTeam(List<HeroSkinBind> t)
	{
		for (int i = 0; i < t.Count; i++)
		{
			teamItemList[i].RefreshData(t[i].heroId, t[i].heroSkinSuffix, t[i].skinConfigId);
		}
		for (int j = t.Count; j < 3; j++)
		{
			teamItemList[j].RefreshData(0, "", 0);
		}
	}

	public void ClearTeam()
	{
		for (int i = 0; i < teamItemList.Count; i++)
		{
			teamItemList[i].RefreshData(0, "", 0);
		}
	}

	public void ClearTeamAndBP()
	{
		for (int i = 0; i < teamItemList.Count; i++)
		{
			teamItemList[i].RefreshData();
		}
		bpConfigViewModel.ClearBP();
	}

	public void ChangeStage(CopyT4Stage stage)
	{
		CopyStage = stage;
	}

	public List<StarConditionItemData> GetConditions(Dictionary<int, bool> curStar)
	{
		if (conditionDatas == null)
		{
			conditionDatas = new List<StarConditionItemData>();
			DRStarCondition[] conditions = GameEntry.DataTable.GetDataRows((DRStarCondition p) => p.CopyId == data.Id);
			int i;
			for (i = 0; i < conditions.Length; i++)
			{
				DRStarConditionList dataRow = GameEntry.DataTable.GetDataRow((DRStarConditionList p) => p.Id == conditions[i].StarCondition);
				if (dataRow == null)
				{
					Log.Error($"starConditionList 找不到星级条件Id {conditions[i].StarCondition}");
					continue;
				}
				StarConditionItemData item = new StarConditionItemData(curStar != null && curStar.ContainsKey(i) && curStar[i], conditions[i].StarConditionNum, conditions[i].JudgingCondition, dataRow, conditions[i].Star);
				conditionDatas.Add(item);
			}
		}
		return conditionDatas;
	}

	public void OnBuffClick()
	{
		parent.ItemOnClick(new OptionArg(this, "ShowCopyBuffDesc"));
	}

	public bool CheckHasP0()
	{
		if (teamItemList == null || teamItemList.Count == 0)
		{
			return false;
		}
		if (teamItemList[0].HeroId != 0)
		{
			return true;
		}
		return false;
	}

	public bool HeroCount()
	{
		if (teamItemList == null || teamItemList.Count == 0)
		{
			return false;
		}
		int num = 0;
		for (int i = 0; i < teamItemList.Count; i++)
		{
			if (teamItemList[i].HeroId != 0)
			{
				num++;
			}
		}
		return num >= 2;
	}

	public bool BPEnough()
	{
		return bpConfigViewModel.CheckBPEnough();
	}

	public List<int> GetBPList()
	{
		return bpConfigViewModel.GetBPIds();
	}

	public void SetEnterResult(bool result)
	{
		parent.ItemOnClick(new OptionArg(result, "EnterResult"));
	}

	public void ResetCondition()
	{
		for (int i = 0; i < conditionItems.Count; i++)
		{
			conditionItems[i].IsTrue = false;
		}
	}

	public void SetCondition()
	{
		for (int i = 0; i < conditionItems.Count; i++)
		{
			conditionItems[i].IsTrue = data.StarCondition != null && data.StarCondition.ContainsKey(i) && data.StarCondition[i];
		}
	}
}
