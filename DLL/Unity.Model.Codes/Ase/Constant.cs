using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public static class Constant
{
	public enum LaunchType
	{
		Normal,
		RepairRes
	}

	public static class ResourceVersion
	{
		public const string Default = "DefaultPackage";

		public const string Code = "HotCode";

		public const string DataTable = "DataTables";

		public const string Audio = "Audio";

		public const string Paradoxs = "Paradoxs";

		public const string Story = "Story";

		public const string Scenes = "Scenes";
	}

	public static class Define
	{
		public const string PlayerContet = "PlayerContet";
	}

	public static class NetWork
	{
		public const string PlatformChannel = "PlatformChannel";

		public const string MainChannel = "MainChannel";

		public const string RoomChannel = "RoomChannel";

		public const string KcpChannel = "KcpChannel";

		public static string IPAddress = "192.168.130.56";

		public static string IPAddressMain = "192.168.0.129";

		public static int TcpPort = 10002;

		public static int TcpPortMain = 10002;

		public static int HttpPort = 3165;

		public const int KcpPort = 10003;
	}

	public static class RoleState
	{
		public static string DayFirstLogin = "DayFirstLogin";
	}

	public static class Icon
	{
		public const string Empty = "empty";
	}

	public static class Sprite
	{
		public const int GEM_SLOT_COUNT = 9;
	}

	public static class Quality
	{
		public const int GOLD = 5;

		public const int DIAMOND = 5;

		public const int FOOD = 5;
	}

	public static class IconSpriteConverter
	{
		public static Dictionary<string, string> bundleConfig = new Dictionary<string, string> { { "textures/itemicons", "Assets/Art/Texutres/ItemIcons" } };

		public const string CommIconConverter = "Assets/Art/Texutres/ItemIcons";

		public const string LevelIconConverter = "LevelIconConverter";
	}

	public static class PropType
	{
		public const int PROP_TYPE_NONE = 0;

		public const int PROP_TYPE_GOLD = 1;

		public const int PROP_TYPE_DIAMOND = 2;

		public const int PROP_TYPE_FOOD = 3;

		public const int PROP_TYPE_ITEM = 4;

		public const int PROP_TYPE_EGG = 5;
	}

	public static class PetType
	{
		public const int PET_TYPE_WATER = 1;

		public const int PET_TYPE_FIRE = 2;

		public const int PET_TYPE_SOIL = 3;

		public const int PET_TYPE_GRESS = 4;

		public const int PET_TYPE_DARK = 5;

		public const int PET_TYPE_DRAGON = 6;

		public const int PET_TYPE_PSYCHIC = 7;

		public const int PET_TYPE_THUNDER = 8;

		public const int PET_TYPE_NORMAL = 9;

		public const int PET_TYPE_ICE = 10;
	}

	public static class Layer
	{
		public const string DefaultLayerName = "Default";

		public static readonly int DefaultLayerId = LayerMask.NameToLayer("Default");

		public const string UILayerName = "UI";

		public static readonly int UILayerId = LayerMask.NameToLayer("UI");

		public const string TargetableObjectLayerName = "Targetable Object";

		public static readonly int TargetableObjectLayerId = LayerMask.NameToLayer("Targetable Object");
	}

	public static class Money
	{
		public const int MONEY_UNIT = 1;
	}

	public static class ProcedureData
	{
		public const string NextSceneId = "NextSceneId";

		public const string GameMode = "GameMode";
	}

	public static class Setting
	{
		public const string Language = "Setting.Language";

		public const string QualityLevel = "Setting.QualityLevel";

		public const string SoundGroupMuted = "Setting.{0}Muted";

		public const string SoundGroupVolume = "Setting.{0}Volume";

		public const string MusicMuted = "Setting.MusicMuted";

		public const string MusicVolume = "Setting.MusicVolume";

		public const string SoundMuted = "Setting.SoundMuted";

		public const string SoundVolume = "Setting.SoundVolume";

		public const string UISoundMuted = "Setting.UISoundMuted";

		public const string UISoundVolume = "Setting.UISoundVolume";
	}

	public static class UI
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
}
