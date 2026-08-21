using System;

namespace Ase;

public class PropDataBase : NumericalBase
{
	private bool empty;

	private bool _new;

	private bool _customTag;

	private long uid;

	private int id;

	private string name;

	protected int amount;

	private int maxCount;

	private int acumCount;

	private string icon = "";

	private string rectIcon = "";

	private string description = "";

	private PropTypeEnum _propTypeEnum = PropTypeEnum.Prop;

	private int propType;

	private int exValue;

	private int quality;

	private PropTimeLimitEnum propTimeLimitEnum;

	private int leftDayConfig;

	private DateTime expireTimeConfig = DateTime.MinValue;

	private long expireTimeStamp;

	private string timelimitText;

	public bool New
	{
		get
		{
			return _new;
		}
		set
		{
			Set(ref _new, value, "New");
		}
	}

	public bool CustomTag
	{
		get
		{
			return _customTag;
		}
		set
		{
			Set(ref _customTag, value, "CustomTag");
		}
	}

	public bool Empty
	{
		get
		{
			return empty;
		}
		set
		{
			Set(ref empty, value, "Empty");
		}
	}

	public long Uid
	{
		get
		{
			return uid;
		}
		protected set
		{
			Set(ref uid, value, "Uid");
		}
	}

	public int Id
	{
		get
		{
			return id;
		}
		set
		{
			Set(ref id, value, "Id");
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		set
		{
			Set(ref name, value, "Name");
		}
	}

	public int Amount
	{
		get
		{
			return amount;
		}
		set
		{
			Set(ref amount, value, "Amount");
		}
	}

	public int MaxCount
	{
		get
		{
			return maxCount;
		}
		set
		{
			Set(ref maxCount, value, "MaxCount");
		}
	}

	public int AcumCount
	{
		get
		{
			return acumCount;
		}
		set
		{
			Set(ref acumCount, value, "AcumCount");
		}
	}

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

	public string RectIcon
	{
		get
		{
			return rectIcon;
		}
		set
		{
			Set(ref rectIcon, value, "RectIcon");
		}
	}

	public int Quality
	{
		get
		{
			return quality;
		}
		set
		{
			Set(ref quality, value, "Quality");
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

	public PropTypeEnum PropTypeEnum
	{
		get
		{
			return _propTypeEnum;
		}
		set
		{
			Set(ref _propTypeEnum, value, "PropTypeEnum");
		}
	}

	public int PropType
	{
		get
		{
			return propType;
		}
		set
		{
			Set(ref propType, value, "PropType");
		}
	}

	public int ExValue
	{
		get
		{
			return exValue;
		}
		set
		{
			Set(ref exValue, value, "ExValue");
		}
	}

	public PropTimeLimitEnum PropTimeLimitEnum
	{
		get
		{
			return propTimeLimitEnum;
		}
		private set
		{
			Set(ref propTimeLimitEnum, value, "PropTimeLimitEnum");
		}
	}

	public int LeftDayConfig
	{
		get
		{
			return leftDayConfig;
		}
		set
		{
			Set(ref leftDayConfig, value, "LeftDayConfig");
		}
	}

	public DateTime ExpireTimeConfig
	{
		get
		{
			return expireTimeConfig;
		}
		set
		{
			Set(ref expireTimeConfig, value, "ExpireTimeConfig");
		}
	}

	public long ExpireTimeStamp
	{
		get
		{
			return expireTimeStamp;
		}
		set
		{
			Set(ref expireTimeStamp, value, "ExpireTimeStamp");
		}
	}

	public string TimeLimitText
	{
		get
		{
			return timelimitText;
		}
		set
		{
			Set(ref timelimitText, value, "TimeLimitText");
		}
	}

	public PropDataBase()
	{
		Empty = true;
	}

	public static PropDataBase CreateByType(int type, int propId, int count = 1)
	{
		if (Enum.IsDefined(typeof(PropTypeEnum), type))
		{
			return CreateByType((PropTypeEnum)type, propId, count);
		}
		return new PropDataBase();
	}

	public static PropDataBase CreateByType(PropTypeEnum propType, int propId, int count = 1)
	{
		if (propType.Equals(PropTypeEnum.Prop) || propType.Equals(PropTypeEnum.Coin) || propType.Equals(PropTypeEnum.Energy) || propType.Equals(PropTypeEnum.AccountExp) || propType.Equals(PropTypeEnum.HeroExp) || propType.Equals(PropTypeEnum.PropTask) || propType.Equals(PropTypeEnum.GiftPack) || propType.Equals(PropTypeEnum.Passport) || propType.Equals(PropTypeEnum.ChatEmoji) || propType.Equals(PropTypeEnum.Indicator) || propType.Equals(PropTypeEnum.HeroSkillSkinProp))
		{
			DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(propId);
			if (dataRow == null)
			{
				Toast.ShowError($"配置表【Prop】，物品类型-{propType}，物品Id-{propId}，不存在！");
				return null;
			}
			return new PropData(dataRow, count)
			{
				PropTypeEnum = propType
			};
		}
		switch (propType)
		{
		case PropTypeEnum.Equipment:
			return ArmourData.CreateArmourData(propId);
		case PropTypeEnum.Weapon:
			return WeaponData.CreateWeaponData(propId);
		case PropTypeEnum.SuitBox:
			return ArmourData.CreateSuitBox(propId);
		case PropTypeEnum.ChatEmoji:
			Singleton<ServiceSystem>.Instance.GetService<IChatService>()?.GetChatViewModel()?.MarkEmojiUnlockListDirty();
			return null;
		case PropTypeEnum.Title:
		{
			DRTitle dataRow11 = GameEntry.DataTable.GetDataRow<DRTitle>(propId);
			if (dataRow11 == null)
			{
				Toast.ShowError($"配置表【Title】，物品类型-{propType}，物品Id-{propId}，不存在！");
				return null;
			}
			return new PropDataBase(dataRow11, count);
		}
		case PropTypeEnum.HeadDecorate:
		{
			DRHeadDecorate dataRow7 = GameEntry.DataTable.GetDataRow<DRHeadDecorate>(propId);
			if (dataRow7 == null)
			{
				Toast.ShowError($"配置表【HeadDecorate】，物品类型-{propType}，物品Id-{propId}，不存在！");
				return null;
			}
			return new PropDataBase(dataRow7, count);
		}
		case PropTypeEnum.Hero:
		{
			DRHeroInfo dataRow12 = GameEntry.DataTable.GetDataRow<DRHeroInfo>(propId);
			if (dataRow12 == null)
			{
				Toast.ShowError($"配置表【HeroInfo】，物品类型-{propType}，物品Id-{propId}，不存在！");
				return null;
			}
			return new PropDataBase(dataRow12);
		}
		case PropTypeEnum.BattlePropDrawing:
		{
			DRBattlePropDrawing dataRow9 = GameEntry.DataTable.GetDataRow<DRBattlePropDrawing>(propId);
			if (dataRow9 == null)
			{
				Toast.ShowError($"配置表【BattlePropDrawing】，物品类型-{propType}，物品Id-{propId}，不存在！");
				return null;
			}
			return new PropDataBase(dataRow9, count);
		}
		case PropTypeEnum.FarmSeed:
		{
			DRFarmSeed dataRow5 = GameEntry.DataTable.GetDataRow<DRFarmSeed>(propId);
			if (dataRow5 == null)
			{
				Toast.ShowError($"配置表【FarmSeed】，物品类型-{propType}，物品Id-{propId}，不存在！");
				return null;
			}
			return new PropDataBase(dataRow5);
		}
		case PropTypeEnum.HeroSkin:
		{
			DRUIHeroSkin dataRow3 = GameEntry.DataTable.GetDataRow<DRUIHeroSkin>(propId);
			if (dataRow3 == null)
			{
				return null;
			}
			return new PropDataBase(dataRow3);
		}
		case PropTypeEnum.Background:
		{
			DRBoardBackGround dataRow10 = GameEntry.DataTable.GetDataRow<DRBoardBackGround>(propId);
			if (dataRow10 == null)
			{
				return null;
			}
			return new PropDataBase(dataRow10);
		}
		case PropTypeEnum.Avatar:
		{
			DRHeadAvatar dataRow8 = GameEntry.DataTable.GetDataRow<DRHeadAvatar>(propId);
			if (dataRow8 == null)
			{
				Toast.ShowError($"配置表【HeadDecorate】，物品类型-{propType}，物品Id-{propId}，不存在！");
				return null;
			}
			return new PropDataBase(dataRow8, count);
		}
		case PropTypeEnum.CardFrame:
		{
			DRHeroCardFrame dataRow6 = GameEntry.DataTable.GetDataRow((DRHeroCardFrame p) => p.PropId == propId);
			if (dataRow6 == null)
			{
				Toast.ShowError($"配置表【HeroCardFrame】，物品类型-{propType}，物品Id-{propId}，不存在！");
				return null;
			}
			return new PropDataBase(dataRow6, count);
		}
		case PropTypeEnum.ChatBubble:
		{
			DRChatBox dataRow4 = GameEntry.DataTable.GetDataRow((DRChatBox p) => p.PropId == propId);
			if (dataRow4 == null)
			{
				Toast.ShowError($"配置表【ChatBox】，物品类型-{propType}，物品Id-{propId}，不存在！");
				return null;
			}
			return new PropDataBase(dataRow4, count);
		}
		case PropTypeEnum.BattleEmoji:
		{
			DRBattleEmoteGroup dataRow2 = GameEntry.DataTable.GetDataRow((DRBattleEmoteGroup p) => p.Id == propId);
			if (dataRow2 == null)
			{
				Toast.ShowError($"配置表【BattleEmoteGroup】，物品类型-{propType}，物品Id-{propId}，不存在！");
				return null;
			}
			return new PropDataBase(dataRow2, count);
		}
		default:
			Toast.ShowError($"配置表 物品类型【{propType}】错误！");
			return null;
		}
	}

	public PropDataBase(DRProp drProp, int count = 1)
	{
		Init(drProp, count);
	}

	protected virtual void Init(DRProp drProp, int count = 1)
	{
		Empty = false;
		Id = drProp.Id;
		Name = drProp.Name;
		Amount = count;
		Icon = drProp.Icon;
		Description = drProp.Function.Replace("\\n", "\n");
		MaxCount = drProp.MaxCount;
		PropTypeEnum = (PropTypeEnum)drProp.Type;
		PropType = drProp.Type;
		ExValue = drProp.EX1;
		Quality = drProp.Quality;
		if (!Enum.IsDefined(typeof(PropTimeLimitEnum), drProp.TimeLimited))
		{
			PropTimeLimitEnum = PropTimeLimitEnum.Permanent;
		}
		else
		{
			PropTimeLimitEnum = (PropTimeLimitEnum)drProp.TimeLimited;
		}
	}

	public PropDataBase(BPData bpData, int count = 1)
	{
		Empty = false;
		Id = bpData.Id;
		Name = bpData.Name;
		Amount = count;
		Icon = bpData.Icon;
		Description = bpData.Desc.Replace("\\n", "\n");
		MaxCount = bpData.Count;
		PropTypeEnum = PropTypeEnum.BattleProp;
		PropType = 19;
		Quality = bpData.Quality;
	}

	public PropDataBase(DRWeapon drWeapon, int count = 1)
	{
		Empty = false;
		Id = drWeapon.Id;
		Name = drWeapon.Name;
		Amount = count;
		Icon = drWeapon.Icon;
		Description = drWeapon.Desc.Replace("\\n", "\n");
		PropTypeEnum = PropTypeEnum.Weapon;
		PropType = 5;
	}

	public PropDataBase(DREquipment drEquipment, int count = 1)
	{
		Empty = false;
		Id = drEquipment.Id;
		Name = drEquipment.Name;
		Amount = count;
		Icon = drEquipment.Icon;
		Description = drEquipment.Desc.Replace("\\n", "\n");
		PropTypeEnum = PropTypeEnum.Equipment;
		PropType = 2;
	}

	public PropDataBase(DRSuitbox drSuitbox, int count = 1)
	{
		Empty = false;
		Id = drSuitbox.Id;
		Amount = count;
		Icon = drSuitbox.PreIcon;
		Description = drSuitbox.Desc.Replace("\\n", "\n");
		PropTypeEnum = PropTypeEnum.SuitBox;
		PropType = 16;
	}

	public PropDataBase(DRTitle drTitle, int count = 1)
	{
		Empty = false;
		Id = drTitle.Id;
		Name = "";
		Amount = count;
		Icon = drTitle.TitleIcon;
		PropTypeEnum = PropTypeEnum.Title;
		PropType = 11;
		Quality = drTitle.Quality;
		InitExpireDataByConfig(drTitle.TimeLimited, drTitle.Time);
	}

	public PropDataBase(DRHeadDecorate drHeadDecorate, int count = 1)
	{
		Empty = false;
		Id = drHeadDecorate.Id;
		Name = drHeadDecorate.Name;
		Amount = count;
		Icon = drHeadDecorate.Icon;
		PropTypeEnum = PropTypeEnum.HeadDecorate;
		PropType = 12;
		Quality = drHeadDecorate.Quality;
		InitExpireDataByConfig(drHeadDecorate.TimeLimited, drHeadDecorate.Time);
	}

	public PropDataBase(DRHeadAvatar dRHeadAvatar, int count = 1)
	{
		Empty = false;
		Id = dRHeadAvatar.Id;
		Name = dRHeadAvatar.Name;
		Amount = count;
		Icon = dRHeadAvatar.Icon;
		PropTypeEnum = PropTypeEnum.HeadDecorate;
		PropType = 12;
		InitExpireDataByConfig(dRHeadAvatar.TimeLimited, dRHeadAvatar.Time);
	}

	public PropDataBase(DRHeroCardFrame drHeroCardFrame, int count = 1)
	{
		Empty = false;
		Id = drHeroCardFrame.PropId;
		Name = drHeroCardFrame.Name;
		Amount = count;
		Icon = drHeroCardFrame.Icon;
		PropTypeEnum = PropTypeEnum.CardFrame;
		PropType = 25;
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(drHeroCardFrame.PropId);
		if (dataRow != null)
		{
			Quality = dataRow.Quality;
		}
		InitExpireDataByConfig(drHeroCardFrame.TimeLimited, drHeroCardFrame.Time);
	}

	public PropDataBase(DRChatBox drChatBox, int count = 1)
	{
		Empty = false;
		Id = drChatBox.PropId;
		Name = drChatBox.Name;
		Amount = count;
		Icon = drChatBox.Icon;
		PropTypeEnum = PropTypeEnum.ChatBubble;
		PropType = 24;
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(drChatBox.PropId);
		if (dataRow != null)
		{
			Quality = dataRow.Quality;
		}
		InitExpireDataByConfig(drChatBox.TimeLimited, drChatBox.Time);
	}

	public PropDataBase(DRBattleEmoteGroup dRBattleEmoteGroup, int count = 1)
	{
		Empty = false;
		Id = dRBattleEmoteGroup.PropId;
		Amount = count;
		PropTypeEnum = PropTypeEnum.BattleEmoji;
		PropType = 26;
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(dRBattleEmoteGroup.PropId);
		if (dataRow != null)
		{
			Quality = dRBattleEmoteGroup.Quality;
			Name = dataRow.Name;
			Icon = dataRow.Icon;
		}
		InitExpireDataByConfig(dRBattleEmoteGroup.TimeLimited, dRBattleEmoteGroup.Time);
	}

	public PropDataBase(DRIndicatorRing dRIndicatorRing, int count = 1)
	{
		Empty = false;
		Id = dRIndicatorRing.Id;
		Amount = count;
		PropTypeEnum = PropTypeEnum.Indicator;
		PropType = 28;
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(dRIndicatorRing.Id);
		if (dataRow != null)
		{
			Quality = dRIndicatorRing.Quality;
			Name = dataRow.Name;
			Icon = dataRow.Icon;
			Description = dataRow.Desc.Replace("\\n", "\n");
		}
	}

	public PropDataBase(DRHeroInfo drHeroInfo, int count = 1)
	{
		Empty = false;
		Id = drHeroInfo.Id;
		Name = drHeroInfo.Name;
		Amount = count;
		DRUIHeroSkin dataRow = GameEntry.DataTable.GetDataRow<DRUIHeroSkin>(drHeroInfo.InitialHeroSkin);
		if (dataRow != null)
		{
			Icon = $"UserHead{drHeroInfo.Id}{dataRow.Suffix}";
		}
		else
		{
			Icon = $"UserHead{drHeroInfo.Id}_0";
		}
		PropTypeEnum = PropTypeEnum.Hero;
		PropType = 4;
		Quality = drHeroInfo.Rarity;
	}

	public PropDataBase(DRBattlePropDrawing drBattlePropDrawing, int count = 1)
	{
		Empty = false;
		Id = drBattlePropDrawing.Id;
		Name = drBattlePropDrawing.Name;
		Amount = count;
		Icon = drBattlePropDrawing.Icon;
		PropTypeEnum = PropTypeEnum.BattlePropDrawing;
		PropType = (int)PropTypeEnum;
		Quality = drBattlePropDrawing.Quality;
		Description = drBattlePropDrawing.Function;
		ExValue = drBattlePropDrawing.TeamId;
	}

	public PropDataBase(DRFarmSeed drFarmSeed)
	{
		Empty = false;
		Id = drFarmSeed.Id;
		Name = drFarmSeed.Name;
		Amount = 1;
		Icon = drFarmSeed.Icon;
		PropTypeEnum = PropTypeEnum.FarmSeed;
		PropType = 15;
	}

	public PropDataBase(DRUIHeroSkin drHeroSkin)
	{
		Empty = false;
		Id = drHeroSkin.Id;
		Name = drHeroSkin.SkinName;
		Amount = 1;
		MaxCount = 1;
		Icon = drHeroSkin.PropIcon;
		Description = drHeroSkin.SkinDesc;
		Quality = drHeroSkin.SkinRarity;
		PropTypeEnum = PropTypeEnum.HeroSkin;
		PropType = 20;
	}

	public PropDataBase(DRBoardBackGround drBg)
	{
		Empty = false;
		Id = drBg.Id;
		Name = drBg.Name;
		Amount = 1;
		MaxCount = 1;
		Icon = drBg.Icon;
		RectIcon = drBg.IconPath;
		Description = drBg.Desc;
		Quality = drBg.Quality;
		PropTypeEnum = PropTypeEnum.Background;
		PropType = 13;
	}

	private void InitExpireDataByConfig(int type, string time)
	{
		if (!Enum.IsDefined(typeof(PropTimeLimitEnum), type))
		{
			PropTimeLimitEnum = PropTimeLimitEnum.Permanent;
			return;
		}
		PropTimeLimitEnum = (PropTimeLimitEnum)type;
		if (PropTimeLimitEnum == PropTimeLimitEnum.PeriodOfTime)
		{
			if (int.TryParse(time, out leftDayConfig))
			{
				TimeLimitText = $"有效时间：{leftDayConfig}天";
			}
			else
			{
				PropTimeLimitEnum = PropTimeLimitEnum.Permanent;
			}
		}
		else if (PropTimeLimitEnum == PropTimeLimitEnum.SpecifiedDate)
		{
			if (TimeHelper.StringToDateTime(time + " 23:59:59", "yyyy.MM.dd HH:mm:ss", out expireTimeConfig))
			{
				TimeLimitText = $"有效时间截止至：{expireTimeConfig.Year}年{expireTimeConfig.Month}月{expireTimeConfig.Day}日";
			}
			else
			{
				PropTimeLimitEnum = PropTimeLimitEnum.Permanent;
			}
		}
	}

	public void InitExpireData(long uid, int expireType, long timeStamp)
	{
		Uid = uid;
		if (!Enum.IsDefined(typeof(PropTimeLimitEnum), expireType))
		{
			PropTimeLimitEnum = PropTimeLimitEnum.Permanent;
			return;
		}
		PropTimeLimitEnum = (PropTimeLimitEnum)expireType;
		ExpireTimeStamp = timeStamp;
	}

	public void UpdateExpireByServerTime(long serverTimeStamp)
	{
		if (serverTimeStamp >= ExpireTimeStamp)
		{
			TimeLimitText = "已超过有效时间";
			return;
		}
		DateTime localDateTime = TimeHelper.GetLocalDateTime(serverTimeStamp);
		DateTime localDateTime2 = TimeHelper.GetLocalDateTime(ExpireTimeStamp);
		TimeSpan timeSpan = localDateTime2 - localDateTime;
		if (PropTimeLimitEnum == PropTimeLimitEnum.PeriodOfTime)
		{
			TimeLimitText = $"有效时间：{timeSpan.Days}天";
		}
		else if (PropTimeLimitEnum == PropTimeLimitEnum.SpecifiedDate)
		{
			TimeLimitText = $"有效时间截止至：{localDateTime2.Year}年{localDateTime2.Month}月{localDateTime2.Day}日";
		}
	}

	public virtual int GetRarity()
	{
		return Quality;
	}

	public virtual bool CanSell()
	{
		return true;
	}

	public virtual bool CanDecompose()
	{
		return false;
	}
}
