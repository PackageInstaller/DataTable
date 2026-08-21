using System.Collections.Generic;

namespace Ase;

public static class Constant
{
	public static class ResourceVersion
	{
		public const string Default = "DefaultPackage";

		public const string Code = "HotCode";

		public const string DataTable = "DataTables";

		public const string Audio = "Audio";

		public const string Paradoxs = "Paradoxs";

		public const string Story = "Story";
	}

	public static class Define
	{
		public const string PlayerContent = "PlayerContent";

		public const string SceneGoldFingerMonsterPoint = "GoldFinger";

		public const int HERO_COUNT = 3;

		public const int Skill_COUNT = 6;

		public const int Seat_Id_Default = -1;

		public const int CAPTAIN_INDEX = 1;

		public const int Hero_StarRing_MaxLayer = 5;

		public const int Hero_Destiny_MaxLevel = 6;
	}

	public static class Icon
	{
		public const string Empty = "empty";
	}

	public static class PropId
	{
		public const int GOLD = 1;

		public const int DIAMOND = 2;
	}

	public static class PropIcon
	{
		public const string GOLD = "icon_gold";

		public const string DIAMOND = "icon_diamond";

		public const string QUALITY_ICON_GOLD = "item_quality_5";

		public const string QUALITY_ICON_DIAMOND = "item_quality_5";

		public const string QUALITY_ICON_FOOD = "item_quality_5";

		public const string ACTIVE = "Static/UI_Task/DailyTasks/icon_active";
	}

	public static class PropType
	{
		public const int PROP_TYPE_NONE = 0;

		public const int PROP_TYPE_GOLD = 1;

		public const int PROP_TYPE_DIAMOND = 2;

		public const int PROP_TYPE_ITEM = 3;

		public const int PROP_TYPE_CONSUME = 4;

		public const int PROP_TYPE_BASIC = 5;

		public const int PROP_TYPE_CULTIVATE = 6;

		public const int PROP_TYPE_FRAGMENT = 7;

		public const int PROP_TYPE_ACTIVE = 8;
	}

	public static class PropEffectType
	{
		public const int PROP_TYPE_NONE = 0;

		public const int PROP_TYPE_GOLD = 1;

		public const int PROP_TYPE_DIAMOND = 2;

		public const int RECOVERY_STRENGTH = 3;

		public const int RECOVERY_FIGHT_STRENGTH = 4;

		public const int UPGRADE_HERO_EXP = 5;

		public const int UPGRADE_WEAPON_EXP = 6;

		public const int UPGRADE_SACRED_ITEM_EXP = 7;

		public const int WEAPON_BREACH_MATERIAL = 8;

		public const int SACRED_BREACH_MATERIAL = 9;
	}

	public static class DropDefine
	{
		public const string DropMessageInfoChannel = "DropMessageInfoChannel";

		public const int DROP_TYPE_NORMAL = 0;

		public const int DROP_TYPE_REWARDBOX = 1;

		public const int DROP_TYPE_FIRSTPASS = 2;
	}

	public static class Convert
	{
		public const string Item_Icon = "ItemIcon";
	}

	public static class InteractiveConstant
	{
		public static string TRIGGERSHAPE = "TriggerShape";

		public static string INTERACTIVE_TIMELENGTH_KEY = "InteractiveTimeLength";

		public static string INTERACTIVE_RADIUS_KEY = "CheckRadius";

		public static string SHAPELENGTH = "ShapeLength";

		public static string SHAPEHEIGHT = "ShapeHeight";

		public static string INTERACTIVE_CENTEROFFSET_KEY = "CenterOffset";

		public static string INTERACTIVE_ICONTYPE_KEY = "IconType";

		public static string INTERACTIVE_NAME = "INTERANAME";

		public static string INTERACTIVE_STATEID_KEY = "InteractiveStateId";

		public static string INTERACTIVE_DROP_KEY = "DropIdKey";

		public static string INTERACTIVE_HITSWITCH_KEY = "HitSwitch";

		public static string ItemStateKey = "itemState";

		public static string MapItemTriggerId = "MapItemTriggerId";

		public static string BREAKTYPE = "BreakType";

		public static string BASEATTACK = "BaseAttack";

		public static string MAPITEMTYPE = "MapItemType";
	}

	public static class RoleState
	{
		public static string DayFirstLogin = "DayFirstLogin";
	}

	public static class NetworkEventConfig
	{
		public static string Exception = "Exception";

		public static string Closed = "Closed";

		public static string Connected = "Connected";
	}

	public static class ConstantConfig
	{
		public static int UpgradeNeedGoldPerEXPHero = 1;

		public static int MaxLevelHero = 2;

		public static int MaxLevelRole = 3;

		public static int UpgradeNeedGoldPerEXPWeapon = 4;

		public static int EXPSupplyWeaponN = 5;

		public static int EXPSupplyWeaponR = 6;

		public static int EXPSupplyWeaponSR = 7;

		public static int EXPSupplyWeaponSSR = 8;

		public static int UpgradeNeedGoldPerEXPEquipment = 9;

		public static int EXPSupplyEquipmentN = 10;

		public static int EXPSupplyEquipmentR = 11;

		public static int EXPSupplyEquipmentSR = 12;

		public static int EXPSupplyEquipmentSSR = 13;

		public static int MaxLevelWeapon = 14;

		public static int MaxLevelEquipment = 15;

		public static int DrawNeedDiamondOneTimes = 16;

		public static int MaxStarHero = 17;

		public static int MaxStarWeapon = 18;

		public static int MaxEntryLevel = 22;

		public static int CritDamageBase = 100;

		public static int AttributeRestrainAddtion = 101;

		public static int AttributeBeRestrainedAddtion = 102;

		public static int DefencePunish = 103;

		public static int DefenceConst = 104;

		public static int ParryBase = 105;

		public static int HealConst = 106;

		public static int Parry1 = 107;

		public static int Parry2 = 108;

		public static int Parry3 = 109;

		public static int CritBase = 122;

		public static int MaxBagCapacityWeapon = 200;

		public static int MaxBagCapacityEquipment = 201;

		public static int MaxBagCapacityMaterial = 202;

		public static int MaxBagCapacityUse = 203;

		public static int MaxBagCapacityTask = 204;

		public static int HomeLandTodayIncrease = 206;

		public static int HomeLandTodayHarvest = 207;

		public static int MaxCountFriend = 301;

		public static int MaxCountFriendApply = 302;

		public static int MaxCountBlack = 303;

		public static int MaxCountRecentTeam = 304;

		public static int MinionTenacityScale = 901;

		public static int Diamond2EnergyDailyCount = 1001;

		public static int Diamond2EnergyEnergyCount = 1002;

		public static int RatioMoney2Diamond = 1003;

		public static int RatioDiamond2NormalDraw = 1004;

		public static int RatioDiamond2LimitDraw = 1005;

		public static int MaxEnergyRecovery = 1006;

		public static int MaxEnergy = 1007;

		public static int TimeRecoveryPerEnergy = 1008;

		public static int ChatMaxChildChannelCount = 1025;

		public static int MaxEntryCountEquipment = 1009;

		public static int TenacityConst = 1010;

		public static int ArmourGetAttribute = 1015;

		public static int OtherRoleVolumeRate = 1016;

		public static string CopyResultSave = "CopyResultSave";

		public static int GameScoreEveryYear = 1026;

		public static int PropAddEnergy = 9420301;

		public static int ChangeNameCardExchangeRatio = 1033;

		public static int ChangeNameCard = 9420401;

		public static int GuildCopyType = 97;

		public static int ChatEmojiMaxCount = 1034;

		public static int ClimbTowerCopyType = 79000;

		public static int Copy6LevelFix = 80;

		public static int AutoFightUnLockLevel = 1040;

		public static int CampaignActId = 1046;
	}

	public static class HttpErrorCode
	{
		public const int GM_SUCCESS = 200;

		public const int Exception = 999;

		public const int Success = 1000;

		public const int RpcFail = 404;

		public const int ServerClosed = 201;

		public const int AdultFail = 202;

		public const int NotSetPassword = 203;
	}

	public enum GoldenFingerType
	{
		UNKNOW = 0,
		ITEM = 1,
		ARMOUR = 2,
		MAIL = 3,
		HERO = 4,
		WEAPON = 5,
		CURRENCY = 6,
		LEVEL = 7,
		SYS_MAIL = 8,
		NEWS_TICKER = 9,
		TITLE = 10,
		ICON_FRAME = 11,
		BACKGROUND = 12,
		SHOP = 13,
		VIP = 14,
		CHAPTER = 15,
		MULTICOPY = 26
	}

	public static class Setting
	{
		public const string EffectLevel = "Setting.EffectLevel";

		public const string ActionData = "Setting.ActionData";

		public const string SettingMessage = "Setting.SettingMessage";
	}

	public static class UIGroupDefine
	{
		public const string DefaultGroup = "DEFAULT";

		public const string DefaultTempGroup = "DEFAULTTEMP";

		public const string LevelLoadingBlackScreenGroup = "LEVELlLOADBLACKSCREENGROUP";

		public const string PopupGroup = "POPUP";

		public const string GuideGroup = "GUIDE";

		public const string TimeLineGroup = "TIMELINE";

		public const string LoadingGroup = "LOADING";

		public const string Tip = "Tip";

		public const string Top = "Top";
	}

	public static class UIScene
	{
		public const string Outer = "Outer";

		public const string OpenView = "OpenView";

		public const string CloseView = "CloseView";
	}

	public static class TalentDescKey
	{
		public const string keyDamage = "KeyDamage";

		public const string keyFixDamage = "KeyFixDamage";

		public const string keyTenacity = "KeyTenacity";

		public const string keyFixTenacity = "KeyFixTenacity";
	}

	public static class BuffType
	{
		public const int BUFF_TYPE_EFFECT = 1;

		public const int BUFF_TYPE_DAMAGE = 2;
	}

	public static class Property
	{
		public const int PropertyMaxValue = 50000;

		public const int PropertyMinValue = -1;
	}

	public static class State
	{
		public const int STATE_GUARD_BREAK = 70001;

		public const int STATE_BREAK = 70002;

		public const int STATE_VERTIGO = 70003;

		public const int STATE_FLOAT = 70004;

		public const int STATE_SMASH = 70005;

		public const int STATE_BURST = 70001;
	}

	public static List<int> DisabledExchangeShopList = new List<int> { 6, 7, 11 };

	public static List<int> DisabledExchangeShopIds = new List<int> { 10007 };

	public static List<int> DisabledActivityType = new List<int> { 3, 6, 7, 8, 10, 12, 13, 14, 15, 16 };

	public static List<int> DisabledBanner = new List<int> { 1, 2, 7, 8, 10 };

	public static List<int> DisabledHeroInfoTabs = new List<int> { 4 };

	public static int ConvertExcelTypeToClientType(int typeCode)
	{
		return typeCode switch
		{
			1 => 4, 
			2 => 5, 
			3 => 6, 
			4 => 7, 
			_ => 3, 
		};
	}
}
