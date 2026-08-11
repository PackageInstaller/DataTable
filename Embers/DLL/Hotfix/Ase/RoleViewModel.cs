using System;
using System.Collections.Generic;
using System.Globalization;
using UnityEngine;

namespace Ase;

public class RoleViewModel : OptionBase
{
	private long uid;

	private List<int> heroIds;

	private PlayerData playerInfo;

	private MoneyData moneyData;

	private AccountLimitationData _accountLimitationData;

	private Dictionary<RoleDecorateEnum, List<RoleDecorateData>> itemList = new Dictionary<RoleDecorateEnum, List<RoleDecorateData>>();

	private long maxCopyOpenIndex;

	private long serverOpenTime;

	private int userLoginTimes;

	private long acctountCreateTime;

	private bool _everyLoginMark = true;

	private Dictionary<RoleDecorateEnum, RoleDecorateData> roleCurDecorates;

	private UIDViewModel uidVM;

	private Dictionary<RoleDecorateEnum, List<int>> _newItemIdList = new Dictionary<RoleDecorateEnum, List<int>>();

	private BoardHeroData boardHeroData;

	private bool firstFlag;

	private long firstPay;

	private long monthPayTotal;

	public BoardHeroData BoardHeroData => boardHeroData;

	public bool FirstFlag
	{
		get
		{
			return firstFlag;
		}
		private set
		{
			firstFlag = value;
		}
	}

	public long FirstPay => firstPay;

	public long MonthPayTotal => monthPayTotal;

	public long Uid
	{
		get
		{
			return uid;
		}
		private set
		{
			Set(ref uid, value, "Uid");
			uidVM.UID = uid;
		}
	}

	public UIDViewModel UidVM => uidVM;

	public List<int> HeroIds => heroIds;

	public PlayerData PlayerInfo
	{
		get
		{
			return playerInfo;
		}
		private set
		{
			Set(ref playerInfo, value, "PlayerInfo");
		}
	}

	public Dictionary<RoleDecorateEnum, List<RoleDecorateData>> ItemList => itemList;

	public long MaxCopyOpenIndex => maxCopyOpenIndex;

	public long ServerOpenTime => serverOpenTime;

	public long AccountCreateTime => acctountCreateTime;

	public bool EveryLoginMark => _everyLoginMark;

	public override void ItemOnClick(object obj)
	{
		parent?.ItemOnClick(obj);
	}

	public RoleViewModel(long uid, UserBaseInfo userBaseInfo, long serverOpenTime)
	{
		this.uid = uid;
		uidVM = new UIDViewModel(uid);
		this.serverOpenTime = serverOpenTime;
		_accountLimitationData = new AccountLimitationData(this);
		UpdateUserBaseInfo(userBaseInfo);
		UpdateFirstLoginFlag();
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.AddDailyUpdateAction(OnDailyUpdated);
	}

	public void UpdateUserBaseInfo(UserBaseInfo userBaseInfo)
	{
		if (userBaseInfo == null)
		{
			playerInfo = new PlayerData();
			return;
		}
		playerInfo = new PlayerData(userBaseInfo);
		AddRoleDecorateItemExpireTimeInfo(userBaseInfo);
		if (moneyData == null)
		{
			moneyData = new MoneyData(this, userBaseInfo);
		}
		else
		{
			moneyData.UpdateBaseInfo(userBaseInfo);
		}
		maxCopyOpenIndex = userBaseInfo.MaxCopyOpenIdx;
		acctountCreateTime = userBaseInfo.CreateTime;
		heroIds = userBaseInfo.ShowHeroes.ToList();
		boardHeroData = new BoardHeroData(userBaseInfo.PosterGirl, userBaseInfo.Background);
		firstPay = userBaseInfo.FirstCharge;
		monthPayTotal = userBaseInfo.TotalCharge;
	}

	protected override void Dispose(bool disposing)
	{
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.RemoveDailyUpdateAction(OnDailyUpdated);
		base.Dispose(disposing);
	}

	public PlayerData GetPlayerData()
	{
		return playerInfo;
	}

	public void CreateUser(long uid, UserBaseInfo userBaseInfo, long serverOpenTime)
	{
		playerInfo.AddUserInfo(userBaseInfo);
		moneyData = new MoneyData(this, userBaseInfo);
		_accountLimitationData = new AccountLimitationData(this);
		Uid = uid;
		maxCopyOpenIndex = userBaseInfo.MaxCopyOpenIdx;
		this.serverOpenTime = serverOpenTime;
		acctountCreateTime = userBaseInfo.CreateTime;
		heroIds = userBaseInfo.ShowHeroes.ToList();
		boardHeroData = new BoardHeroData(userBaseInfo.PosterGirl, userBaseInfo.Background);
		FirstFlag = true;
		firstPay = userBaseInfo.FirstCharge;
		monthPayTotal = userBaseInfo.TotalCharge;
	}

	public void UpdateAccountLimit(List<PbTimedRefreshInfo> infos)
	{
		_accountLimitationData.UpdateAccountLimitationData(infos);
	}

	public void SetItemNew(PropTypeEnum propTypeEnum, int id)
	{
		switch (propTypeEnum)
		{
		case PropTypeEnum.CardFrame:
			SetItemNew(RoleDecorateEnum.CardFrame, id);
			break;
		case PropTypeEnum.ChatBubble:
			SetItemNew(RoleDecorateEnum.ChatBubble, id);
			break;
		}
		if (propTypeEnum == PropTypeEnum.BattleEmoji)
		{
			SetItemNew(RoleDecorateEnum.BattleEmote, id);
		}
		if (propTypeEnum == PropTypeEnum.Indicator)
		{
			SetItemNew(RoleDecorateEnum.Indicator, id);
		}
	}

	public void SetItemNew(RoleDecorateEnum type, int id)
	{
		List<int> list;
		if (_newItemIdList.ContainsKey(type))
		{
			list = _newItemIdList[type];
		}
		else
		{
			list = new List<int>();
			_newItemIdList.Add(type, list);
		}
		if (!list.Contains(id))
		{
			list.Add(id);
		}
	}

	public List<int> GetItemNewList(RoleDecorateEnum type)
	{
		if (_newItemIdList.TryGetValue(type, out var value))
		{
			return value;
		}
		_newItemIdList.Add(type, new List<int>());
		return _newItemIdList[type];
	}

	public void SetItemList(RoleDecorateEnum type, List<RoleDecorateData> list)
	{
		if (!itemList.ContainsKey(type))
		{
			itemList.Add(type, list);
		}
		else
		{
			itemList[type] = list;
		}
		List<int> newIdList = GetItemNewList(type);
		itemList[type].ForEach(delegate(RoleDecorateData p)
		{
			p.isNew = newIdList.Contains(p.id);
		});
	}

	public List<RoleDecorateData> GetItemList(RoleDecorateEnum type)
	{
		if (itemList.ContainsKey(type))
		{
			return itemList[type];
		}
		return new List<RoleDecorateData>();
	}

	public void SetDecorateItemRead(RoleDecorateEnum type, int id)
	{
		if (itemList == null || !itemList.ContainsKey(type) || itemList[type] == null)
		{
			return;
		}
		if (_newItemIdList.TryGetValue(type, out var value))
		{
			value?.RemoveAll((int p) => p == id);
		}
		RoleDecorateData roleDecorateData = itemList[type].Find((RoleDecorateData p) => p.id == id);
		if (roleDecorateData == null)
		{
			return;
		}
		roleDecorateData.isNew = false;
		bool flag = !itemList[type].Exists((RoleDecorateData p) => p.isNew);
		RedPointMessageEnum redPointMessageEnum = ConvertRedMsg(type);
		if (redPointMessageEnum != RedPointMessageEnum.None)
		{
			Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()?.Publish(redPointMessageEnum, flag);
		}
		if (flag)
		{
			ServerRedType serverRedType = ConvertServerRedType(type);
			if (serverRedType != ServerRedType.None)
			{
				Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()?.SetServerRed(serverRedType, red: false);
			}
		}
	}

	private RedPointMessageEnum ConvertRedMsg(RoleDecorateEnum type)
	{
		return type switch
		{
			RoleDecorateEnum.CardFrame => RedPointMessageEnum.HeroCardFrame, 
			RoleDecorateEnum.ChatBubble => RedPointMessageEnum.ChatBubble, 
			RoleDecorateEnum.BattleEmote => RedPointMessageEnum.BattleEmoji, 
			RoleDecorateEnum.Indicator => RedPointMessageEnum.Indicator, 
			_ => RedPointMessageEnum.None, 
		};
	}

	private ServerRedType ConvertServerRedType(RoleDecorateEnum type)
	{
		return type switch
		{
			RoleDecorateEnum.CardFrame => ServerRedType.HeroCardFrame, 
			RoleDecorateEnum.ChatBubble => ServerRedType.ChatBubble, 
			RoleDecorateEnum.BattleEmote => ServerRedType.BattleEmoji, 
			RoleDecorateEnum.Indicator => ServerRedType.Indicator, 
			_ => ServerRedType.None, 
		};
	}

	public void ClearItemList(List<RoleDecorateEnum> types)
	{
		if (itemList == null || types == null)
		{
			return;
		}
		foreach (RoleDecorateEnum type in types)
		{
			itemList.Remove(type);
		}
	}

	public void UpdateMoneyData(int gold, int diamond)
	{
		moneyData.SetMoney(MoneyEnum.Coin, gold);
		moneyData.SetMoney(MoneyEnum.Diamond, diamond);
	}

	public MoneyData GetMoneyData()
	{
		return moneyData;
	}

	public AccountLimitationData GetAccountLimitationData()
	{
		return _accountLimitationData;
	}

	public void UpdateMaxCopyIdx(int newMaxCopyIdx)
	{
		if (newMaxCopyIdx > 0)
		{
			maxCopyOpenIndex = newMaxCopyIdx;
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>()?.UpdateMaxCopyIdx(maxCopyOpenIndex);
		}
	}

	public void UpdateServerOpenTime(long serverTime)
	{
		serverOpenTime = serverTime;
	}

	private void AddRoleDecorateItemExpireTimeInfo(UserBaseInfo userBaseInfo)
	{
		roleCurDecorates = new Dictionary<RoleDecorateEnum, RoleDecorateData>();
		roleCurDecorates.Add(RoleDecorateEnum.HeadIcon, new RoleDecorateData
		{
			DecorateType = RoleDecorateEnum.HeadIcon
		});
		roleCurDecorates.Add(RoleDecorateEnum.HeadFrame, new RoleDecorateData
		{
			DecorateType = RoleDecorateEnum.HeadFrame
		});
		roleCurDecorates.Add(RoleDecorateEnum.Title, new RoleDecorateData
		{
			DecorateType = RoleDecorateEnum.Title
		});
		if (userBaseInfo != null)
		{
			if (userBaseInfo.IconInfo != null)
			{
				roleCurDecorates[RoleDecorateEnum.HeadIcon].SetIdAndExpire(userBaseInfo.IconInfo.Id, userBaseInfo.IconInfo.ExpireTime);
			}
			if (userBaseInfo.IconFrameInfo != null)
			{
				roleCurDecorates[RoleDecorateEnum.HeadFrame].SetIdAndExpire(userBaseInfo.IconFrameInfo.Id, userBaseInfo.IconFrameInfo.ExpireTime);
			}
			if (userBaseInfo.TitleInfo != null)
			{
				roleCurDecorates[RoleDecorateEnum.Title].SetIdAndExpire(userBaseInfo.TitleInfo.Id, userBaseInfo.TitleInfo.ExpireTime);
			}
		}
		AddRoleDecorateItemExpireTimeChecker();
	}

	public void AddRoleDecorateItemExpireTimeChecker()
	{
		foreach (KeyValuePair<RoleDecorateEnum, RoleDecorateData> roleCurDecorate in roleCurDecorates)
		{
			if (roleCurDecorate.Value.expireTime > 0)
			{
				Singleton<ServiceSystem>.Instance.GetService<ITimeService>().AddNormalSecondUpdateAction(RoleDecorateItemExpireTimeChecker);
				return;
			}
		}
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>().RemoveNormalSecondUpdateAction(RoleDecorateItemExpireTimeChecker);
	}

	public void RoleDecorateItemExpireTimeChecker(long curServerTime)
	{
		foreach (KeyValuePair<RoleDecorateEnum, RoleDecorateData> roleCurDecorate in roleCurDecorates)
		{
			if (roleCurDecorate.Value.expireTime != 0L && roleCurDecorate.Value.expireTime <= curServerTime)
			{
				if (roleCurDecorate.Key == RoleDecorateEnum.HeadIcon)
				{
					ChangeRoleDecorate(roleCurDecorate.Key, 1104);
				}
				else if (roleCurDecorate.Key == RoleDecorateEnum.HeadFrame)
				{
					ChangeRoleDecorate(roleCurDecorate.Key, 10001);
				}
				else if (roleCurDecorate.Key == RoleDecorateEnum.Title)
				{
					ChangeRoleDecorate(roleCurDecorate.Key, 0);
				}
			}
		}
	}

	public void ChangeRoleDecorate(RoleDecorateEnum type, int id)
	{
		if (roleCurDecorates == null)
		{
			AddRoleDecorateItemExpireTimeInfo(null);
		}
		if (!roleCurDecorates.ContainsKey(type))
		{
			roleCurDecorates.Add(type, new RoleDecorateData
			{
				DecorateType = type
			});
		}
		if (id == 0)
		{
			roleCurDecorates[type].SetDefault();
		}
		else
		{
			RoleDecorateData roleDecorateData = null;
			if (itemList.ContainsKey(type))
			{
				for (int i = 0; i < itemList[type].Count; i++)
				{
					if (itemList[type][i].id == id)
					{
						roleDecorateData = itemList[type][i];
					}
				}
			}
			roleDecorateData = new RoleDecorateData
			{
				DecorateType = type,
				expireTime = roleDecorateData.expireTime,
				id = id
			};
			roleCurDecorates[type] = roleDecorateData;
		}
		switch (type)
		{
		case RoleDecorateEnum.HeadIcon:
			playerInfo.ChangeIcon(id);
			break;
		case RoleDecorateEnum.HeadFrame:
			playerInfo.ChangeIconFrame(id);
			break;
		case RoleDecorateEnum.Title:
			playerInfo.ChangeTitle(id);
			break;
		}
	}

	public int GetAccountCreateDay()
	{
		ITimeService service = Singleton<ServiceSystem>.Instance.GetService<ITimeService>();
		if (service == null)
		{
			return 0;
		}
		long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		if (curServerTime <= 0 || acctountCreateTime <= 0 || curServerTime < acctountCreateTime)
		{
			return 0;
		}
		DateTime localDateTime = TimeHelper.GetLocalDateTime(acctountCreateTime);
		DateTime localDateTime2 = TimeHelper.GetLocalDateTime(curServerTime);
		int dailyUpdateHour = service.GetDailyUpdateHour();
		DateTime dateTime = new DateTime(localDateTime.Year, localDateTime.Month, localDateTime.Day, dailyUpdateHour, 0, 0);
		DateTime dateTime2 = new DateTime(localDateTime2.Year, localDateTime2.Month, localDateTime2.Day, dailyUpdateHour, 0, 0);
		int num = (int)(dateTime2 - dateTime).TotalDays + 1;
		if (localDateTime.CompareTo(dateTime) > 0 && localDateTime2.CompareTo(dateTime2) < 0)
		{
			num--;
		}
		else if (localDateTime.CompareTo(dateTime) < 0 && localDateTime2.CompareTo(dateTime2) > 0)
		{
			num++;
		}
		return num;
	}

	public DRBoardBackGround GetBackground(int backgroundId)
	{
		DRBoardBackGround dRBoardBackGround = null;
		dRBoardBackGround = ((backgroundId != BoardHeroData.BgDefaultModeId) ? GameEntry.DataTable.GetDataRow<DRBoardBackGround>(backgroundId) : GameEntry.DataTable.GetDataRow((DRBoardBackGround p) => p.MapId == Singleton<ServiceSystem>.Instance.GetService<IMapService>().GetPlayerMark()));
		if (dRBoardBackGround == null)
		{
			dRBoardBackGround = GameEntry.DataTable.GetDataRow<DRBoardBackGround>(0);
		}
		if (dRBoardBackGround == null)
		{
			dRBoardBackGround = new DRBoardBackGround();
		}
		return dRBoardBackGround;
	}

	public DRBoardBackGround GetBackground()
	{
		return GetBackground(boardHeroData.BackgroundId);
	}

	public void UpdateFirstLoginFlag()
	{
		long num = Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.GetCurServerTime() ?? 0;
		if (num <= 0)
		{
			FirstFlag = false;
			return;
		}
		DateTime localDateTime = TimeHelper.GetLocalDateTime(num);
		string text = PlayerPrefs.GetString($"{Constant.RoleState.DayFirstLogin}_{playerInfo.Uid}", "");
		if (string.IsNullOrEmpty(text) || !DateTime.TryParseExact(text, "yyyy/MM/dd HH:mm:ss", CultureInfo.CurrentCulture, DateTimeStyles.None, out var result))
		{
			FirstFlag = true;
			return;
		}
		DateTime nextUpdateTime = TimeService.GetNextUpdateTime(result);
		FirstFlag = localDateTime.CompareTo(nextUpdateTime) >= 0;
	}

	public void SetFirstFlagUsed()
	{
		long num = Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.GetCurServerTime() ?? 0;
		if (num <= 0)
		{
			FirstFlag = false;
			return;
		}
		DateTime localDateTime = TimeHelper.GetLocalDateTime(num);
		PlayerPrefs.SetString($"{Constant.RoleState.DayFirstLogin}_{playerInfo.Uid}", localDateTime.ToString("yyyy/MM/dd HH:mm:ss"));
		FirstFlag = false;
	}

	private void OnDailyUpdated()
	{
		UpdateFirstLoginFlag();
	}

	public void SetEveryLoginMarkUsed()
	{
		_everyLoginMark = false;
	}

	public void SavePay(long firstCharge, long totalCharge)
	{
		firstPay = firstCharge;
		monthPayTotal = totalCharge;
	}
}
