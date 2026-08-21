using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class CopyTypeItemViewModel : OptionBase
{
	private SimpleCommand<string> optCommand;

	private CopyTypeData data;

	private bool isSelect;

	private bool isComplete;

	private long score;

	private InteractionRequest<string> optRequest = new InteractionRequest<string>();

	private List<CopyTeamItemViewModel> teamItemList;

	private int teamTag;

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

	public bool IsComplete
	{
		get
		{
			return isComplete;
		}
		private set
		{
			Set(ref isComplete, value, "IsComplete");
		}
	}

	public ICommand OptCommand => optCommand;

	public CopyTypeData Data
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

	public IInteractionRequest OptRequest => optRequest;

	public List<CopyTeamItemViewModel> TeamItemList => teamItemList;

	public int TeamTag
	{
		get
		{
			return teamTag;
		}
		private set
		{
			Set(ref teamTag, value, "TeamTag");
		}
	}

	public CopyTypeItemViewModel()
	{
	}

	public CopyTypeItemViewModel(OptionBase parent, CopyTypeData data)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		this.data = data;
	}

	public CopyTypeItemViewModel(OptionBase parent, CopyTypeData data, bool isComplete)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		this.data = data;
		this.isComplete = isComplete;
	}

	public async void OnOpt(string optName)
	{
		if (data.CopyMainId == 4 && data.IsLockPrevious)
		{
			CopyTypeData copyType4ByZone = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyType4ByZone(data.Zone - 1);
			if (copyType4ByZone != null)
			{
				Toast.ShowInfo("完成" + copyType4ByZone.CopyTypeName + "后解锁");
			}
			else
			{
				Toast.ShowInfo("副本未开放");
			}
		}
		else if (!data.IsLockTime && !data.IsLockCondition && data.IsLockPrevious)
		{
			Toast.ShowInfo("需完成前一高度后开启");
		}
		else if (!isSelect)
		{
			parent.ItemOnClick(this);
		}
	}

	public void SetSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}

	public void SetComplete(bool isComplete)
	{
		IsComplete = isComplete;
	}

	public void PlayUnlockEffect()
	{
		if (!data.IsLock && !data.HasPlayUnlock)
		{
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().PlayUnlockEffect(data);
			optRequest.Raise("PlayUnlockEffect");
		}
	}

	public static CopyTypeItemViewModel CreateType5(OptionBase parent, CopyTypeData copyTypeData, CopyType5Team teamConfig)
	{
		CopyTypeItemViewModel copyTypeItemViewModel = new CopyTypeItemViewModel(parent, copyTypeData);
		copyTypeItemViewModel.SetTeamConfig(teamConfig);
		copyTypeItemViewModel.optRequest = new InteractionRequest<string>();
		return copyTypeItemViewModel;
	}

	public void SetTeamConfig(CopyType5Team teamConfig)
	{
		if (teamItemList == null)
		{
			teamItemList = new List<CopyTeamItemViewModel>();
			for (int i = 0; i < 3; i++)
			{
				teamItemList.Add(new CopyTeamItemViewModel(this));
			}
		}
		if (teamConfig == null || teamConfig.HeroList == null)
		{
			for (int j = 0; j < teamItemList.Count; j++)
			{
				teamItemList[j].RefreshData(null);
			}
		}
		else
		{
			for (int k = 0; k < teamItemList.Count; k++)
			{
				teamItemList[k].RefreshData(teamConfig.GetHeroModel(k));
			}
		}
		TeamTag = teamConfig.TeamTag;
		optRequest.Raise("RefreshType5List");
	}
}
