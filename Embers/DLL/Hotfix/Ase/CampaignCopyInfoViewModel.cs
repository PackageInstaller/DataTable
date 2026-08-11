using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class CampaignCopyInfoViewModel : OptionBase
{
	private CampaignTaskData _taskData;

	private CampaignMonsterData _monsterData;

	private string _name;

	private List<string> _labels = new List<string>();

	private string _info;

	private int _copyId;

	private List<int> _envBuff = new List<int>();

	private bool _showBuffPart;

	private string _buffInfoName;

	private string _buffInfoDesc;

	private bool _showBuffInfo;

	private string _btnStartText;

	private List<PropDataBase> _rewards = new List<PropDataBase>();

	private bool _showConsume;

	private string _consumeIcon = "";

	private string _consumeCount;

	private bool _showChallengeInfo;

	private string _bossHpInfo;

	private string _bossTimesInfo;

	private bool _showMonsterInfo;

	private string _monsterIcon = "";

	private string _bossLvAndName;

	private List<int> _adItemList = new List<int>();

	private string _bossDesc;

	private InteractionRequest _areaDataRefreshRst = new InteractionRequest();

	private bool isOpeningRoom;

	public CampaignTaskData TaskData => _taskData;

	public CampaignMonsterData MonsterData => _monsterData;

	public string Name
	{
		get
		{
			return _name;
		}
		set
		{
			Set(ref _name, value, "Name");
		}
	}

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

	public int CopyId
	{
		get
		{
			return _copyId;
		}
		set
		{
			Set(ref _copyId, value, "CopyId");
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

	public bool ShowBuffPart
	{
		get
		{
			return _showBuffPart;
		}
		set
		{
			Set(ref _showBuffPart, value, "ShowBuffPart");
		}
	}

	public string BuffInfoName
	{
		get
		{
			return _buffInfoName;
		}
		set
		{
			Set(ref _buffInfoName, value, "BuffInfoName");
		}
	}

	public string BuffInfoDesc
	{
		get
		{
			return _buffInfoDesc;
		}
		set
		{
			Set(ref _buffInfoDesc, value, "BuffInfoDesc");
		}
	}

	public bool ShowBuffInfo
	{
		get
		{
			return _showBuffInfo;
		}
		set
		{
			Set(ref _showBuffInfo, value, "ShowBuffInfo");
		}
	}

	public string BtnStartText
	{
		get
		{
			return _btnStartText;
		}
		set
		{
			Set(ref _btnStartText, value, "BtnStartText");
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

	public bool ShowConsume
	{
		get
		{
			return _showConsume;
		}
		set
		{
			Set(ref _showConsume, value, "ShowConsume");
		}
	}

	public string ConsumeIcon
	{
		get
		{
			return _consumeIcon;
		}
		set
		{
			Set(ref _consumeIcon, value, "ConsumeIcon");
		}
	}

	public string ConsumeCount
	{
		get
		{
			return _consumeCount;
		}
		set
		{
			Set(ref _consumeCount, value, "ConsumeCount");
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

	public string BossTimesInfo
	{
		get
		{
			return _bossTimesInfo;
		}
		set
		{
			Set(ref _bossTimesInfo, value, "BossTimesInfo");
		}
	}

	public bool ShowMonsterInfo
	{
		get
		{
			return _showMonsterInfo;
		}
		set
		{
			Set(ref _showMonsterInfo, value, "ShowMonsterInfo");
		}
	}

	public string MonsterIcon
	{
		get
		{
			return _monsterIcon;
		}
		set
		{
			Set(ref _monsterIcon, value, "MonsterIcon");
		}
	}

	public string BossLvAndName
	{
		get
		{
			return _bossLvAndName;
		}
		set
		{
			Set(ref _bossLvAndName, value, "BossLvAndName");
		}
	}

	public List<int> AdItemList => _adItemList;

	public string BossDesc
	{
		get
		{
			return _bossDesc;
		}
		set
		{
			Set(ref _bossDesc, value, "BossDesc");
		}
	}

	public InteractionRequest AreaDataRefreshRst => _areaDataRefreshRst;

	public CampaignCopyInfoViewModel()
	{
	}

	public CampaignCopyInfoViewModel(OptionBase parent)
	{
		base.parent = parent;
	}

	public void RefreshAreaData(CampaignMonsterData areaData)
	{
		_taskData = null;
		_monsterData = areaData;
		Name = areaData.Name;
		Info = areaData.Info;
		Labels = areaData.Labels;
		EnvBuff = areaData.EnvBuff;
		ShowBuffPart = EnvBuff.Count > 0;
		Rewards = areaData.Rewards;
		RefreshLevelConfig(areaData.PlayId);
		_areaDataRefreshRst.Raise();
	}

	public void RefreshAreaData(CampaignTaskData areaData)
	{
		_monsterData = null;
		_taskData = areaData;
		Name = areaData.Name;
		Info = areaData.Info;
		Labels = areaData.Labels;
		EnvBuff = areaData.EnvBuff;
		ShowBuffPart = EnvBuff.Count > 0;
		Rewards = areaData.Rewards;
		RefreshLevelConfig(areaData.PlayId);
		_areaDataRefreshRst.Raise();
	}

	private void RefreshLevelConfig(int playId)
	{
		DRCampaignLevel dataRow = GameEntry.DataTable.GetDataRow<DRCampaignLevel>(playId);
		if (dataRow == null)
		{
			return;
		}
		DRCopy dataRow2 = GameEntry.DataTable.GetDataRow<DRCopy>(dataRow.CopyId);
		ShowChallengeInfo = dataRow.ShareType != 0;
		if (ShowChallengeInfo && _monsterData != null)
		{
			BossHpInfo = ((_monsterData.TotalBossHp > 0) ? $"剩余生命 {_monsterData.BossHp}/{_monsterData.TotalBossHp}" : "");
			BossTimesInfo = ((_monsterData.TotalTimes > 0) ? ("击退" + _monsterData.TimesInfo + "次领主后解除威胁") : "");
		}
		if (_taskData?.Consume != null && !_taskData.Consume.Empty)
		{
			ConsumeIcon = _taskData.Consume.Icon;
			ConsumeCount = $"x{_taskData.Consume.Amount}";
			ShowConsume = true;
		}
		else if (_monsterData?.Consume != null && !_monsterData.Consume.Empty)
		{
			ConsumeIcon = _monsterData.Consume.Icon;
			ConsumeCount = $"x{_monsterData.Consume.Amount}";
			ShowConsume = true;
		}
		else
		{
			ShowConsume = false;
		}
		if (string.IsNullOrEmpty(dataRow.BossIcon))
		{
			ShowMonsterInfo = false;
		}
		else
		{
			MonsterIcon = dataRow.BossIcon;
			if (dataRow2 != null)
			{
				int id = ((dataRow2.BossId.Count > 0) ? dataRow2.BossId[0] : 0);
				DRMonsterAttr dataRow3 = GameEntry.DataTable.GetDataRow<DRMonsterAttr>(id);
				if (dataRow3 != null)
				{
					BossLvAndName = $"Lv.{dataRow3.MonsterLevel} {dataRow3.Name}";
					int monsterType = dataRow3.MonsterType;
					DRMonsterInfo dataRow4 = GameEntry.DataTable.GetDataRow<DRMonsterInfo>(monsterType);
					if (dataRow4 != null)
					{
						BossDesc = dataRow4.BodyWeak;
						BossDesc = BossDesc.Replace("\\n", "\n");
					}
				}
				_adItemList = dataRow2.Buff;
			}
			ShowMonsterInfo = true;
		}
		if (dataRow2 != null)
		{
			BtnStartText = (dataRow2.IsMulti ? "多人挑战" : "单人挑战");
		}
	}

	private void OpenBuffInfoPanel(string name, string desc)
	{
		BuffInfoName = name;
		BuffInfoDesc = desc;
		ShowBuffInfo = true;
	}

	public async void OnStartClick()
	{
		if (isOpeningRoom)
		{
			return;
		}
		CampaignAreaData campaignAreaData = null;
		if (_monsterData != null)
		{
			campaignAreaData = _monsterData;
		}
		else if (_taskData != null)
		{
			campaignAreaData = _taskData;
		}
		if (campaignAreaData == null)
		{
			Toast.ShowInfo("副本数据异常，请稍后重试");
			return;
		}
		isOpeningRoom = true;
		Loading loading = null;
		try
		{
			CopyData copyData = GetCopyData(campaignAreaData.CopyId);
			CampaignTeamRoomContext context = CampaignTeamRoomContext.Create(campaignAreaData, copyData);
			CampaignTeamRoomCheckResult campaignTeamRoomCheckResult = await Singleton<ServiceSystem>.Instance.GetService<ICampaignService>().CheckCampaignTeamRoom(context, CampaignTeamRoomCheckScene.CreateRoom);
			if (!campaignTeamRoomCheckResult.Success)
			{
				Toast.ShowInfo(campaignTeamRoomCheckResult.ToastText);
				return;
			}
			loading = await Loading.Show();
			if (await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().CreateCampaignMultiRoom(context) == ProtocolRequestResult.Exception)
			{
				Toast.ShowInfo("打开多人房间失败，请稍后重试");
			}
		}
		finally
		{
			loading?.Dispose();
			isOpeningRoom = false;
		}
	}

	private CopyData GetCopyData(int copyId)
	{
		CopyData copyData = Singleton<ServiceSystem>.Instance.GetService<ICopyService>()?.GetCopyVM()?.GetCopyById(copyId);
		if (copyData != null)
		{
			return copyData;
		}
		DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(copyId);
		if (dataRow != null)
		{
			return CopyData.CreateTemp(dataRow);
		}
		return null;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is KnapsackItemViewModel obj2)
		{
			parent.ItemOnClick(obj2);
		}
		else if (obj is BaseItemData { Arg: DREnvironmentModifier arg })
		{
			OpenBuffInfoPanel(arg.ParadoxName, arg.Desc);
		}
	}
}
