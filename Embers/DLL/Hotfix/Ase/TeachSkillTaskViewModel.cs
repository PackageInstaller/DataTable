using System;
using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class TeachSkillTaskViewModel : OptionBase
{
	public DRHeroTeachingInfo teachConfig;

	private int teachIndex;

	private Action<BattleGMEnum> gameGM;

	private Action gameSettlementAction;

	private InteractionRequest<bool> teachSkillTaskUpdate = new InteractionRequest<bool>();

	private string teachName;

	private string teachContent;

	private bool showFinishLevelBtn;

	private bool showTeachContent;

	private bool nextTeachContentIsEmpty;

	private bool lastTeachContentIsEmpty;

	private bool infiniteEnergy;

	private bool infiniteSp;

	private bool isExpand;

	public InteractionRequest<bool> TeachSkillTaskUpdate => teachSkillTaskUpdate;

	public float NextTeachDelayTime
	{
		get
		{
			if (teachIndex - 1 >= 0 && teachIndex - 1 < teachConfig.NextTeachDelayTime.Count)
			{
				return teachConfig.NextTeachDelayTime[teachIndex - 1];
			}
			return 0f;
		}
	}

	public int NextTeachBanInputSkill
	{
		get
		{
			if (teachIndex - 1 > 0 && teachIndex - 1 < teachConfig.NextTeachBanInputSkill.Count)
			{
				return teachConfig.NextTeachBanInputSkill[teachIndex - 1];
			}
			return 0;
		}
	}

	public int TeachTaskId
	{
		get
		{
			if (teachIndex < teachConfig.TeachingGroupConfig.Count)
			{
				return teachConfig.TeachingGroupConfig[teachIndex];
			}
			return 0;
		}
	}

	public int TeachTaskGroupId => teachConfig.Id;

	public int NextTeachGroupId => teachConfig.NextTeachingGroup;

	public bool FinishLevel => teachConfig.FinishLevel;

	public float DelayShowTime => teachConfig.DelayTime;

	public int TeachGroupType => teachConfig.TeachingGroupType;

	public List<string> SetPropertyName => teachConfig.SetPropertyName;

	public List<float> BornPoint => teachConfig.BornPoint;

	public List<float> SetPropertyValue => teachConfig.SetPropertyValue;

	public List<int> FinshAddBuff => teachConfig.FinishAddBuff;

	public List<int> FinshClearBuff => teachConfig.FinishClearBuff;

	public List<int> CreateAddBuff => teachConfig.CreateAddBuff;

	public bool ChangeMonsterState => teachConfig.SetState;

	public int MonsterState => teachConfig.MonsterState;

	public bool ChangeMonsterPhase => teachConfig.SetPhaseEnum;

	public MonsterPhaseEnum MonsterPhase => teachConfig.MonsterPhaseEnum;

	public string TeachName
	{
		get
		{
			return teachName;
		}
		set
		{
			teachName = value;
		}
	}

	public string TeachContent
	{
		get
		{
			return teachContent;
		}
		set
		{
			teachContent = value;
		}
	}

	public bool ShowFinishLevelBtn
	{
		get
		{
			return showFinishLevelBtn;
		}
		set
		{
			Set(ref showFinishLevelBtn, value, "ShowFinishLevelBtn");
		}
	}

	public bool ShowTeachContent
	{
		get
		{
			return showTeachContent;
		}
		set
		{
			Set(ref showTeachContent, value, "ShowTeachContent");
		}
	}

	public bool NextTeachContentIsEmpty => nextTeachContentIsEmpty;

	public bool LastTeachContentIsEmpty => lastTeachContentIsEmpty;

	public bool InfiniteEnergy => infiniteEnergy;

	public bool InfiniteSp => infiniteSp;

	public bool IsExpand => isExpand;

	public TeachSkillTaskViewModel(DRHeroTeachingInfo heroTeachingInfo, Action<BattleGMEnum> gmAction, Action gameSettlement)
	{
		UpdateData(heroTeachingInfo);
		gameGM = gmAction;
		isExpand = true;
		gameSettlementAction = gameSettlement;
	}

	public void UpdateData(DRHeroTeachingInfo heroTeachingInfo)
	{
		string text = "";
		if (teachConfig == null)
		{
			lastTeachContentIsEmpty = true;
		}
		else
		{
			text = teachConfig.FrameText;
			lastTeachContentIsEmpty = string.IsNullOrEmpty(teachConfig.FrameText);
		}
		teachConfig = heroTeachingInfo;
		TeachName = heroTeachingInfo.FrameName;
		TeachContent = heroTeachingInfo.FrameText;
		ShowFinishLevelBtn = false;
		teachIndex = 0;
		ShowTeachContent = !string.IsNullOrEmpty(TeachName) && !string.IsNullOrEmpty(TeachContent);
		nextTeachContentIsEmpty = GetTeachConfigTextIsEmpty(heroTeachingInfo.NextTeachingGroup);
		if (text != teachContent)
		{
			teachSkillTaskUpdate.Raise(context: false);
		}
	}

	private bool GetTeachConfigTextIsEmpty(int teachGroupId)
	{
		DRHeroTeachingInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroTeachingInfo>(teachGroupId);
		if (dataRow == null)
		{
			return true;
		}
		return string.IsNullOrEmpty(dataRow.FrameText);
	}

	public bool GetFinishTeachTaskGroup()
	{
		teachIndex++;
		if (teachIndex >= teachConfig.TeachingGroupConfig.Count)
		{
			return true;
		}
		return false;
	}

	public bool GetIsLastTeachTaskGroup()
	{
		if (teachIndex >= teachConfig.TeachingGroupConfig.Count - 1)
		{
			return true;
		}
		return false;
	}

	public override void Dispose()
	{
		base.Dispose();
		gameGM = null;
		gameSettlementAction = null;
		teachConfig = null;
	}

	public void OnClickFinish()
	{
		gameSettlementAction();
	}

	public void OnClickExpand()
	{
		isExpand = !isExpand;
	}

	public void FinishLevelSet()
	{
		ShowTeachContent = false;
		ShowFinishLevelBtn = true;
		teachSkillTaskUpdate.Raise(context: true);
	}

	public void OnClickGM(BattleGMEnum gmEnum)
	{
		gameGM?.Invoke(gmEnum);
		switch (gmEnum)
		{
		case BattleGMEnum.InfiniteEnergy:
			infiniteEnergy = !infiniteEnergy;
			break;
		case BattleGMEnum.InfiniteSp:
			infiniteSp = !infiniteSp;
			break;
		}
	}
}
