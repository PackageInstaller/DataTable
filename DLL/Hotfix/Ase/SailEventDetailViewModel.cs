using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class SailEventDetailViewModel : OptionBase
{
	private string icon;

	private string eventName;

	private string description;

	private List<KnapsackItemViewModel> normalRewardList;

	private List<KnapsackItemViewModel> greatRewardList;

	private int state;

	private string costTimeText;

	private string leftTimes;

	private SimpleCommand autoSelectCmd;

	private SimpleCommand startCmd;

	private SimpleCommand confirmCmd;

	private string startText;

	private InteractionRequest refreshRequest;

	private InteractionRequest playAudioRequest;

	public string Icon
	{
		get
		{
			return icon;
		}
		set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public string EventName
	{
		get
		{
			return eventName;
		}
		set
		{
			Set(ref eventName, value, "EventName");
		}
	}

	public string Description
	{
		get
		{
			return description;
		}
		set
		{
			Set(ref description, value, "Description");
		}
	}

	public List<KnapsackItemViewModel> NormalRewardList
	{
		get
		{
			return normalRewardList;
		}
		set
		{
			Set(ref normalRewardList, value, "NormalRewardList");
		}
	}

	public List<KnapsackItemViewModel> GreatRewardList
	{
		get
		{
			return greatRewardList;
		}
		set
		{
			Set(ref greatRewardList, value, "GreatRewardList");
		}
	}

	public int State
	{
		get
		{
			return state;
		}
		set
		{
			Set(ref state, value, "State");
		}
	}

	public string CostTimeText
	{
		get
		{
			return costTimeText;
		}
		set
		{
			Set(ref costTimeText, value, "CostTimeText");
		}
	}

	public string LeftTimes
	{
		get
		{
			return leftTimes;
		}
		set
		{
			Set(ref leftTimes, value, "LeftTimes");
		}
	}

	public string StartText
	{
		get
		{
			return startText;
		}
		set
		{
			Set(ref startText, value, "StartText");
		}
	}

	public SimpleCommand AutoSelectCmd => autoSelectCmd;

	public SimpleCommand StartCmd => startCmd;

	public SimpleCommand ConfirmCmd => confirmCmd;

	public InteractionRequest RefreshRequest => refreshRequest;

	public InteractionRequest PlayAudioRequest => playAudioRequest;

	public SailEventDetailViewModel(OptionBase parent, SailEventItemData sailEventItemData)
	{
		base.parent = parent;
		autoSelectCmd = new SimpleCommand(AutoSelect);
		startCmd = new SimpleCommand(Start);
		confirmCmd = new SimpleCommand(Confirm);
		normalRewardList = new List<KnapsackItemViewModel>();
		greatRewardList = new List<KnapsackItemViewModel>();
		refreshRequest = new InteractionRequest();
		playAudioRequest = new InteractionRequest();
		SetEventInfo(sailEventItemData);
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is KnapsackItemViewModel obj2)
		{
			parent?.ItemOnClick(obj2);
		}
	}

	public void PlayAudio()
	{
		playAudioRequest.Raise();
	}

	public void SetLeftTimeText(int useTimes, int maxTimes)
	{
		LeftTimes = ((useTimes == 0) ? $"<color=#FF0000>{useTimes}</color>/{maxTimes}" : $"{useTimes}/{maxTimes}");
		startCmd.Enabled = useTimes > 0;
		StartText = ((useTimes > 0) ? "启航" : "次数不足");
	}

	private void SetEventInfo(SailEventItemData sailEventItemData)
	{
		Icon = sailEventItemData.Icon;
		EventName = sailEventItemData.EventName;
		State = sailEventItemData.State;
		DRSailEvent dataRow = GameEntry.DataTable.GetDataRow<DRSailEvent>(sailEventItemData.EventId);
		if (dataRow == null)
		{
			return;
		}
		Description = dataRow.Desc;
		SetCostTime(dataRow.Time);
		NormalRewardList.Clear();
		if (dataRow.RewardUI.Count == dataRow.RewardNumUI.Count)
		{
			for (int i = 0; i < dataRow.RewardUI.Count; i++)
			{
				KnapsackPropData data = KnapsackPropData.Create(dataRow.RewardUI[i], dataRow.RewardNumUI[i]);
				KnapsackItemViewModel item = new KnapsackItemViewModel(this, data);
				NormalRewardList.Add(item);
			}
		}
		else
		{
			Toast.ShowError($"ID:{sailEventItemData.EventId}--成功奖励数据不匹配!");
		}
		GreatRewardList.Clear();
		if (dataRow.GreatRewardUI.Count == dataRow.GreatRewardNumUI.Count)
		{
			for (int j = 0; j < dataRow.GreatRewardUI.Count; j++)
			{
				KnapsackPropData data2 = KnapsackPropData.Create(dataRow.GreatRewardUI[j], dataRow.GreatRewardNumUI[j]);
				KnapsackItemViewModel item2 = new KnapsackItemViewModel(this, data2);
				GreatRewardList.Add(item2);
			}
		}
		else
		{
			Toast.ShowError($"ID:{sailEventItemData.EventId}--大成功奖励数据不匹配!");
		}
	}

	private void SetCostTime(int time)
	{
		string leftDateTimeWithLatest = Utility.DateTime.GetLeftDateTimeWithLatest(time);
		CostTimeText = "耗时:" + leftDateTimeWithLatest;
	}

	public void Refresh(SailEventItemData sailEventItemData)
	{
		SetEventInfo(sailEventItemData);
		refreshRequest.Raise();
	}

	private void AutoSelect()
	{
		parent?.ItemOnClick(new OptionArg(this, "AutoSelect"));
	}

	private void Start()
	{
		startCmd.Enabled = false;
		parent?.ItemOnClick(new OptionArg(this, "Start"));
	}

	public void SetStartCmdState2(bool value)
	{
		startCmd.Enabled = value;
	}

	private void Confirm()
	{
		parent?.ItemOnClick(new OptionArg(this, "Finish"));
	}
}
