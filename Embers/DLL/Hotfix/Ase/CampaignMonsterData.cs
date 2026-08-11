#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class CampaignMonsterData : CampaignAreaData
{
	private List<string> _labels;

	private string _info;

	private List<int> _envBuff;

	private PropDataBase _consume;

	private List<PropDataBase> _rewards;

	private long _bossHp;

	private long _totalBossHp;

	private long _times;

	private long _totalTimes;

	private bool _defeated;

	private bool _showChallengeInfo;

	private string _timesInfo;

	private string _leftTimeInfo;

	private bool _showBossChallengeInfo;

	private string _bossHpInfo;

	private bool _searchNew;

	private long _leftTime;

	private Timer _leftTimer;

	public List<string> Labels
	{
		get
		{
			return _labels;
		}
		set
		{
			Set(ref _labels, value, "Labels");
		}
	}

	public string Info
	{
		get
		{
			return _info;
		}
		set
		{
			Set(ref _info, value, "Info");
		}
	}

	public List<int> EnvBuff
	{
		get
		{
			return _envBuff;
		}
		set
		{
			Set(ref _envBuff, value, "EnvBuff");
		}
	}

	public PropDataBase Consume
	{
		get
		{
			return _consume;
		}
		set
		{
			Set(ref _consume, value, "Consume");
		}
	}

	public List<PropDataBase> Rewards
	{
		get
		{
			return _rewards;
		}
		set
		{
			Set(ref _rewards, value, "Rewards");
		}
	}

	public long BossHp
	{
		get
		{
			return _bossHp;
		}
		set
		{
			Set(ref _bossHp, value, "BossHp");
		}
	}

	public long TotalBossHp
	{
		get
		{
			return _totalBossHp;
		}
		set
		{
			Set(ref _totalBossHp, value, "TotalBossHp");
		}
	}

	public long Times
	{
		get
		{
			return _times;
		}
		set
		{
			Set(ref _times, value, "Times");
		}
	}

	public long TotalTimes
	{
		get
		{
			return _totalTimes;
		}
		set
		{
			Set(ref _totalTimes, value, "TotalTimes");
		}
	}

	public bool Defeated
	{
		get
		{
			return _defeated;
		}
		set
		{
			Set(ref _defeated, value, "Defeated");
		}
	}

	public bool ShowChallengeInfo
	{
		get
		{
			return _showChallengeInfo;
		}
		set
		{
			Set(ref _showChallengeInfo, value, "ShowChallengeInfo");
		}
	}

	public string TimesInfo
	{
		get
		{
			return _timesInfo;
		}
		set
		{
			Set(ref _timesInfo, value, "TimesInfo");
		}
	}

	public string LeftTimeInfo
	{
		get
		{
			return _leftTimeInfo;
		}
		set
		{
			Set(ref _leftTimeInfo, value, "LeftTimeInfo");
		}
	}

	public bool ShowBossChallengeInfo
	{
		get
		{
			return _showBossChallengeInfo;
		}
		set
		{
			Set(ref _showBossChallengeInfo, value, "ShowBossChallengeInfo");
		}
	}

	public string BossHpInfo
	{
		get
		{
			return _bossHpInfo;
		}
		set
		{
			Set(ref _bossHpInfo, value, "BossHpInfo");
		}
	}

	public bool SearchNew
	{
		get
		{
			return _searchNew;
		}
		set
		{
			Set(ref _searchNew, value, "SearchNew");
		}
	}

	public static CampaignMonsterData CreateByServerData(OptionBase parent, CampaignServiceData.WorldBossInfo worldBossInfo)
	{
		if (worldBossInfo == null)
		{
			return null;
		}
		DRCampaignLevel dataRow = GameEntry.DataTable.GetDataRow<DRCampaignLevel>(worldBossInfo.PlayId);
		if (dataRow == null)
		{
			Log.Error($"创建战役怪物数据失败：CampaignLevel表 Id:{worldBossInfo.PlayId}不存在");
			return null;
		}
		DRCampaignClass dataRow2 = GameEntry.DataTable.GetDataRow<DRCampaignClass>(worldBossInfo.PointId);
		if (dataRow2 == null)
		{
			Log.Error($"创建战役怪物数据失败：CampaignClass表 Id:{worldBossInfo.PointId}不存在");
			return null;
		}
		DRCopy dataRow3 = GameEntry.DataTable.GetDataRow<DRCopy>(dataRow.CopyId);
		if (dataRow3 == null)
		{
			Log.Error($"创建战役怪物数据失败：Copy表 Id:{dataRow.CopyId}不存在");
			return null;
		}
		CampaignMonsterData campaignMonsterData = new CampaignMonsterData(parent)
		{
			Type = GetMonsterAreaType(dataRow.Type),
			PositionId = worldBossInfo.PointId,
			Name = dataRow.Name,
			Icon = dataRow.Icon,
			IconSize = dataRow.IconSize,
			ClickRange = dataRow2.ActRange,
			Labels = dataRow.Label,
			Info = dataRow.InfoText,
			CopyId = dataRow.CopyId,
			EnvBuff = dataRow.EnviBuff,
			PlayId = dataRow.Id,
			Consume = PropDataBase.CreateByType(dataRow3.CostType, dataRow3.CostId, dataRow3.CostNum),
			Rewards = PropHelper.AnalyzePropListByConfig(dataRow.DropDescType, dataRow.DropDescId, dataRow.DropDescNum),
			BossHp = worldBossInfo.BossHP,
			TotalBossHp = dataRow.HpCount,
			Times = worldBossInfo.Times,
			TotalTimes = dataRow.CopyCount
		};
		campaignMonsterData.Defeated = campaignMonsterData.Type == CampaignAreaType.WorldBoss && worldBossInfo.BossHP <= 0;
		campaignMonsterData.ShowChallengeInfo = campaignMonsterData.Type == CampaignAreaType.LordMonster;
		campaignMonsterData.TimesInfo = $"{dataRow.CopyCount - campaignMonsterData.Times}/{dataRow.CopyCount}";
		campaignMonsterData.ShowBossChallengeInfo = campaignMonsterData.Type == CampaignAreaType.WorldBoss;
		campaignMonsterData.BossHpInfo = $"{Math.Ceiling((double)campaignMonsterData.BossHp / (double)campaignMonsterData.TotalBossHp * 100.0)}%";
		campaignMonsterData.StartTimer(dataRow.GeneTimelimit);
		return campaignMonsterData;
	}

	public static CampaignAreaType GetMonsterAreaType(int type)
	{
		switch (type)
		{
		case 1:
			return CampaignAreaType.EliteMonster;
		case 100:
			return CampaignAreaType.LordMonster;
		case 90:
		case 91:
		case 92:
		case 93:
		case 94:
		case 95:
		case 96:
		case 97:
		case 98:
		case 99:
			return CampaignAreaType.WorldBoss;
		default:
			return CampaignAreaType.None;
		}
	}

	public CampaignMonsterData()
	{
	}

	public CampaignMonsterData(OptionBase parent)
		: base(parent)
	{
	}

	private void StartTimer(int timeLimitId)
	{
		DRCampaignTimelimit dataRow = GameEntry.DataTable.GetDataRow<DRCampaignTimelimit>(timeLimitId);
		if (dataRow != null && TimeHelper.StringToDateTime(dataRow.EndTime, "yyyy.MM.dd.HH.mm", out var time))
		{
			long targetTimeStamp = (long)(time.ToUniversalTime() - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalSeconds;
			_leftTime = (long)Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetLeftServiceTime(targetTimeStamp).TotalSeconds;
			_leftTimer = Timer.Register(1f, OnComplete, null, isLooped: true, useRealTime: true);
		}
	}

	private void OnComplete()
	{
		_leftTime--;
		if (_leftTime <= 0)
		{
			_leftTime = 0L;
			CancelTimer();
		}
		TimeSpan timeSpan = TimeSpan.FromSeconds(_leftTime);
		LeftTimeInfo = new TimeSpan((int)timeSpan.TotalHours, timeSpan.Minutes, timeSpan.Seconds).ToString("hh\\:mm\\:ss");
	}

	private void CancelTimer()
	{
		if (_leftTimer != null)
		{
			_leftTimer.Cancel();
			_leftTimer = null;
		}
	}

	protected override void Dispose(bool disposing)
	{
		CancelTimer();
		base.Dispose(disposing);
	}
}
