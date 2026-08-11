using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class MultiRoomPlayerViewModel : OptionBase
{
	private bool _isSelf;

	private bool _selfCaption;

	private int _seatId;

	private bool _isEmpty;

	private bool _isCaption;

	private string _gamerName;

	private long _gamerUid;

	private int _gamerIcon;

	private HeroModel _heroModel;

	private int levelFix = -1;

	private bool guildTeamBuff;

	private int _state;

	public int Index;

	private string playerIdentity;

	private bool _isMatch;

	private InteractionRequest _refreshHeroRequest;

	private TeamBPConfigViewModel teamBpConfigViewModel;

	private bool showTeamBPConfig;

	private List<TabItemNormalData> functionList;

	public Vector2 FunctionPos;

	private string _cardFrame = "";

	public bool IsEmpty
	{
		get
		{
			return _isEmpty;
		}
		private set
		{
			Set(ref _isEmpty, value, "IsEmpty");
		}
	}

	public bool IsSelf
	{
		get
		{
			return _isSelf;
		}
		private set
		{
			Set(ref _isSelf, value, "IsSelf");
		}
	}

	public int SeatId
	{
		get
		{
			return _seatId;
		}
		private set
		{
			Set(ref _seatId, value, "SeatId");
		}
	}

	public string GamerName
	{
		get
		{
			return _gamerName;
		}
		private set
		{
			Set(ref _gamerName, value, "GamerName");
		}
	}

	public bool SelfCaption
	{
		get
		{
			return _selfCaption;
		}
		private set
		{
			Set(ref _selfCaption, value, "SelfCaption");
		}
	}

	public List<TabItemNormalData> FunctionList
	{
		get
		{
			return functionList;
		}
		private set
		{
			Set(ref functionList, value, "FunctionList");
		}
	}

	public HeroModel HeroModel
	{
		get
		{
			return _heroModel;
		}
		private set
		{
			Set(ref _heroModel, value, "HeroModel");
		}
	}

	public int LevelFix
	{
		get
		{
			return levelFix;
		}
		private set
		{
			Set(ref levelFix, value, "LevelFix");
		}
	}

	public bool GuildTeamBuff
	{
		get
		{
			return guildTeamBuff;
		}
		set
		{
			Set(ref guildTeamBuff, value, "GuildTeamBuff");
		}
	}

	public int State
	{
		get
		{
			return _state;
		}
		private set
		{
			Set(ref _state, value, "State");
		}
	}

	public string PlayerIdentity
	{
		get
		{
			return playerIdentity;
		}
		private set
		{
			Set(ref playerIdentity, value, "PlayerIdentity");
		}
	}

	public bool IsCaption
	{
		get
		{
			return _isCaption;
		}
		private set
		{
			Set(ref _isCaption, value, "IsCaption");
		}
	}

	public bool IsMatch
	{
		get
		{
			return _isMatch;
		}
		private set
		{
			Set(ref _isMatch, value, "IsMatch");
		}
	}

	public bool ShowTeamBPConfig
	{
		get
		{
			return showTeamBPConfig;
		}
		private set
		{
			Set(ref showTeamBPConfig, value, "ShowTeamBPConfig");
		}
	}

	public string CardFrame
	{
		get
		{
			return _cardFrame;
		}
		set
		{
			Set(ref _cardFrame, value, "CardFrame");
		}
	}

	public long GamerUid => _gamerUid;

	public int GamerIcon => _gamerIcon;

	public InteractionRequest RefreshHeroRequest => _refreshHeroRequest;

	public TeamBPConfigViewModel TeamBpConfigViewModel => teamBpConfigViewModel;

	public MultiRoomPlayerViewModel()
	{
	}

	public MultiRoomPlayerViewModel(OptionBase parent, bool isSelf, MatchRoomUserInfo gamerInfo, int index)
	{
		base.parent = parent;
		_refreshHeroRequest = new InteractionRequest();
		Index = index;
		State = 1;
		UpdateView(isSelf, gamerInfo);
		SetPlayerState(1);
		_isMatch = false;
		functionList = new List<TabItemNormalData>();
		FunctionPos = default(Vector2);
		RefreshFunctionList();
		SetPlayerIdentity();
	}

	public void SetLevelFix(int level)
	{
		LevelFix = level;
	}

	private void SetPlayerIdentity()
	{
		PlayerIdentity = (IsCaption ? "队" : $"{Index}P");
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is TabItemNormalData tabItemNormalData)
		{
			switch (tabItemNormalData.ID)
			{
			case 1:
				AddGamer();
				break;
			case 2:
				KickGamer();
				break;
			case 3:
				OpenPlayerInfo();
				break;
			}
		}
		else if (obj is BattlePropConfigViewModel && _isSelf)
		{
			parent.ItemOnClick(obj);
		}
	}

	public void RefreshFunctionList()
	{
		if (!IsSelf)
		{
			FunctionList.Clear();
			bool num = Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel().CheckBlackListExist(_gamerUid);
			bool flag = Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel().CheckFriendExist(_gamerUid);
			if (!(num | flag))
			{
				functionList.Add(new TabItemNormalData(this, "empty", 1, isSelected: false, "添加好友"));
			}
			if (SelfCaption)
			{
				functionList.Add(new TabItemNormalData(this, "empty", 2, isSelected: false, "踢出队伍"));
			}
			functionList.Add(new TabItemNormalData(this, "empty", 3, isSelected: false, "个人信息"));
		}
	}

	public void SetTeamBPViewModel(TeamBPConfigViewModel newViewModel, bool isSelf)
	{
		if (newViewModel == null)
		{
			teamBpConfigViewModel = TeamBPConfigViewModel.CreateMultiTeammate(this, new Dictionary<int, BPData>());
			ShowTeamBPConfig = IsSelf;
		}
		else
		{
			teamBpConfigViewModel = newViewModel;
			ShowTeamBPConfig = !IsEmpty && teamBpConfigViewModel.ShowConfigView;
		}
		teamBpConfigViewModel?.SetCanAdd(isSelf);
	}

	public void OpenFunctionList()
	{
		parent?.ItemOnClick(new OptionArg(this, "OpenRoleFunctionList"));
	}

	public void SetPlayerState(int state)
	{
		State = ((state == 0) ? 1 : state);
	}

	public void SetIsMatch(bool isMatch)
	{
		IsMatch = isMatch;
	}

	public void InviteGamer()
	{
		parent.ItemOnClick(new OptionArg(this, "Invite"));
	}

	private void KickGamer()
	{
		parent.ItemOnClick(new OptionArg(this, "Kick"));
	}

	private void AddGamer()
	{
		if (Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel().CheckFriendExist(_gamerUid))
		{
			Toast.ShowInfo("已是好友");
		}
		else
		{
			parent.ItemOnClick(new OptionArg(this, "AddGamer"));
		}
	}

	private async void OpenPlayerInfo()
	{
		Loading loading = await Loading.Show();
		PlayerData playerData = await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().RequestSearchPlayer(GamerUid);
		loading.Dispose();
		if (playerData == null)
		{
			Toast.ShowInfo("不存在目标玩家");
			return;
		}
		PlayerInfoViewModel userData = new PlayerInfoViewModel(this, playerData, isSelf: false);
		OpenViewArg obj = new OpenViewArg(typeof(PlayerInfoWindow), userData);
		parent?.ItemOnClick(obj);
	}

	public void ChangeHero()
	{
		if (IsSelf)
		{
			parent.ItemOnClick(new OptionArg(this, "ChangeHero"));
		}
	}

	public void UpdateView(bool isSelf, MatchRoomUserInfo gamerInfo)
	{
		IsEmpty = false;
		IsSelf = isSelf;
		if (gamerInfo == null)
		{
			IsEmpty = true;
			LoadDefault();
			SetPlayerIdentity();
			ShowTeamBPConfig = false;
			CardFrame = "";
			return;
		}
		_gamerUid = gamerInfo.UserId;
		_gamerIcon = gamerInfo.Icon;
		SeatId = gamerInfo.SeatId;
		GamerName = gamerInfo.Name;
		int num = 0;
		if (isSelf)
		{
			List<int> list = Singleton<ServiceSystem>.Instance.GetService<IBFBEService>()?.GetCardFrameSet() ?? new List<int>();
			num = ((list.Count > 0) ? list[0] : 0);
		}
		else
		{
			num = gamerInfo.HeroCardFrame;
		}
		CardFrame = GameEntry.DataTable.GetDataRow<DRHeroCardFrame>(num)?.EdgePath ?? "";
		HeroModel = new HeroModel(gamerInfo.SelectRoleId, gamerInfo.SelectRoleSkin, gamerInfo.SelectRoleStar, gamerInfo.SelectRoleLevel, gamerInfo.SeatLevel);
		_refreshHeroRequest.Raise();
		RefreshFunctionList();
	}

	private void LoadDefault()
	{
		GamerName = "";
		SelfCaption = false;
		IsCaption = false;
		_gamerUid = 0L;
		HeroModel = new HeroModel(1104, 110400, 1, 1, 0L, 1, 0L);
	}

	public void UpdateHeroView(HeroModel heroModel)
	{
		HeroModel = heroModel;
		_refreshHeroRequest.Raise();
	}

	public void SetType(bool selfCaptain)
	{
		SelfCaption = selfCaptain;
	}

	public void SetIsCaption(bool isCaption)
	{
		IsCaption = isCaption;
		SetPlayerIdentity();
		ShowTeamBPConfig = true;
	}
}
