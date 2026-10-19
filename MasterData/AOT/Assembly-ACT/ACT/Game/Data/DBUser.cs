using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class DBUser : IMessage<DBUser>, IMessage, IEquatable<DBUser>, IDeepCloneable<DBUser>, IBufferMessage
{
	private static readonly MessageParser<DBUser> _parser = new MessageParser<DBUser>(() => new DBUser());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private long id_;

	public const int AccountIdFieldNumber = 2;

	private long accountId_;

	public const int ServerIndexFieldNumber = 3;

	private int serverIndex_;

	public const int OpenIdFieldNumber = 4;

	private string openId_ = "";

	public const int SdkAidFieldNumber = 5;

	private int sdkAid_;

	public const int CreateTimeFieldNumber = 6;

	private long createTime_;

	public const int LastUpdateTimeFieldNumber = 7;

	private long lastUpdateTime_;

	public const int EnterTimeFieldNumber = 8;

	private long enterTime_;

	public const int OfflineTimeFieldNumber = 9;

	private long offlineTime_;

	public const int LevelFieldNumber = 10;

	private int level_;

	public const int ExpFieldNumber = 11;

	private int exp_;

	public const int WorldLevelFieldNumber = 12;

	private int worldLevel_;

	public const int NickNameFieldNumber = 13;

	private string nickName_ = "";

	public const int CoinFieldNumber = 14;

	private long coin_;

	public const int PowerFieldNumber = 15;

	private int power_;

	public const int FreeDiamondFieldNumber = 16;

	private long freeDiamond_;

	public const int CostDiamondFieldNumber = 17;

	private long costDiamond_;

	public const int GenderFieldNumber = 18;

	private uint gender_;

	public const int TookLevelRewardsFieldNumber = 19;

	private TookLevelRewards tookLevelRewards_;

	public const int OpenedSystemsFieldNumber = 20;

	private OpenedSystems openedSystems_;

	public const int ItemsFieldNumber = 21;

	private Items items_;

	public const int AttributesFieldNumber = 22;

	private Attributes attributes_;

	public const int CharactersFieldNumber = 23;

	private Characters characters_;

	public const int WeaponsFieldNumber = 24;

	private Weapons weapons_;

	public const int ChipsFieldNumber = 25;

	private Chips chips_;

	public const int HandbooksFieldNumber = 26;

	private Handbook handbooks_;

	public const int MissionsFieldNumber = 27;

	private Missions missions_;

	public const int AssistsFieldNumber = 28;

	private Assists assists_;

	public const int ScenesFieldNumber = 29;

	private Scenes scenes_;

	public const int ProfileFieldNumber = 30;

	private PlayerProfile profile_;

	public const int EquipsFieldNumber = 31;

	private Equips equips_;

	public const int GemsFieldNumber = 32;

	private Gems gems_;

	public const int ComposeDataFieldNumber = 33;

	private PlayerComposeData composeData_;

	public const int MapInfoFieldNumber = 34;

	private MapDbModel mapInfo_;

	public const int LoungeInfoFieldNumber = 35;

	private LoungeDbModel loungeInfo_;

	public const int BattlePassFieldNumber = 36;

	private BattlePassDbModel battlePass_;

	public const int VocabularyInfoFieldNumber = 37;

	private VocabularyDbModel vocabularyInfo_;

	public const int TdClientDataFieldNumber = 38;

	private TDClientData tdClientData_;

	public const int TimeLimitItemsFieldNumber = 39;

	private TimeLimitItems timeLimitItems_;

	public const int SkinsFieldNumber = 40;

	private static readonly FieldCodec<SkinInfo> _repeated_skins_codec = FieldCodec.ForMessage(322u, SkinInfo.Parser);

	private readonly RepeatedField<SkinInfo> skins_ = new RepeatedField<SkinInfo>();

	public const int DiamondDataFieldNumber = 41;

	private DiamondData diamondData_;

	public const int BundleDataFieldNumber = 42;

	private BundleData bundleData_;

	public const int MonthlyPassesFieldNumber = 43;

	private static readonly FieldCodec<MonthlyPassEntry> _repeated_monthlyPasses_codec = FieldCodec.ForMessage(346u, MonthlyPassEntry.Parser);

	private readonly RepeatedField<MonthlyPassEntry> monthlyPasses_ = new RepeatedField<MonthlyPassEntry>();

	public const int EffectDressesFieldNumber = 44;

	private static readonly FieldCodec<EffectDressInfo> _repeated_effectDresses_codec = FieldCodec.ForMessage(354u, EffectDressInfo.Parser);

	private readonly RepeatedField<EffectDressInfo> effectDresses_ = new RepeatedField<EffectDressInfo>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<DBUser> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => DbuserReflection.Descriptor.MessageTypes[0];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long AccountId
	{
		get
		{
			return accountId_;
		}
		set
		{
			accountId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ServerIndex
	{
		get
		{
			return serverIndex_;
		}
		set
		{
			serverIndex_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string OpenId
	{
		get
		{
			return openId_;
		}
		set
		{
			openId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int SdkAid
	{
		get
		{
			return sdkAid_;
		}
		set
		{
			sdkAid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long CreateTime
	{
		get
		{
			return createTime_;
		}
		set
		{
			createTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long LastUpdateTime
	{
		get
		{
			return lastUpdateTime_;
		}
		set
		{
			lastUpdateTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long EnterTime
	{
		get
		{
			return enterTime_;
		}
		set
		{
			enterTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long OfflineTime
	{
		get
		{
			return offlineTime_;
		}
		set
		{
			offlineTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Level
	{
		get
		{
			return level_;
		}
		set
		{
			level_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Exp
	{
		get
		{
			return exp_;
		}
		set
		{
			exp_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int WorldLevel
	{
		get
		{
			return worldLevel_;
		}
		set
		{
			worldLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string NickName
	{
		get
		{
			return nickName_;
		}
		set
		{
			nickName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long Coin
	{
		get
		{
			return coin_;
		}
		set
		{
			coin_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Power
	{
		get
		{
			return power_;
		}
		set
		{
			power_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long FreeDiamond
	{
		get
		{
			return freeDiamond_;
		}
		set
		{
			freeDiamond_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long CostDiamond
	{
		get
		{
			return costDiamond_;
		}
		set
		{
			costDiamond_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public uint Gender
	{
		get
		{
			return gender_;
		}
		set
		{
			gender_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TookLevelRewards TookLevelRewards
	{
		get
		{
			return tookLevelRewards_;
		}
		set
		{
			tookLevelRewards_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OpenedSystems OpenedSystems
	{
		get
		{
			return openedSystems_;
		}
		set
		{
			openedSystems_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Items Items
	{
		get
		{
			return items_;
		}
		set
		{
			items_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Attributes Attributes
	{
		get
		{
			return attributes_;
		}
		set
		{
			attributes_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Characters Characters
	{
		get
		{
			return characters_;
		}
		set
		{
			characters_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Weapons Weapons
	{
		get
		{
			return weapons_;
		}
		set
		{
			weapons_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Chips Chips
	{
		get
		{
			return chips_;
		}
		set
		{
			chips_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Handbook Handbooks
	{
		get
		{
			return handbooks_;
		}
		set
		{
			handbooks_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Missions Missions
	{
		get
		{
			return missions_;
		}
		set
		{
			missions_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Assists Assists
	{
		get
		{
			return assists_;
		}
		set
		{
			assists_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Scenes Scenes
	{
		get
		{
			return scenes_;
		}
		set
		{
			scenes_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerProfile Profile
	{
		get
		{
			return profile_;
		}
		set
		{
			profile_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Equips Equips
	{
		get
		{
			return equips_;
		}
		set
		{
			equips_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Gems Gems
	{
		get
		{
			return gems_;
		}
		set
		{
			gems_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerComposeData ComposeData
	{
		get
		{
			return composeData_;
		}
		set
		{
			composeData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapDbModel MapInfo
	{
		get
		{
			return mapInfo_;
		}
		set
		{
			mapInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeDbModel LoungeInfo
	{
		get
		{
			return loungeInfo_;
		}
		set
		{
			loungeInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BattlePassDbModel BattlePass
	{
		get
		{
			return battlePass_;
		}
		set
		{
			battlePass_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public VocabularyDbModel VocabularyInfo
	{
		get
		{
			return vocabularyInfo_;
		}
		set
		{
			vocabularyInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TDClientData TdClientData
	{
		get
		{
			return tdClientData_;
		}
		set
		{
			tdClientData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TimeLimitItems TimeLimitItems
	{
		get
		{
			return timeLimitItems_;
		}
		set
		{
			timeLimitItems_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<SkinInfo> Skins => skins_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DiamondData DiamondData
	{
		get
		{
			return diamondData_;
		}
		set
		{
			diamondData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BundleData BundleData
	{
		get
		{
			return bundleData_;
		}
		set
		{
			bundleData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<MonthlyPassEntry> MonthlyPasses => monthlyPasses_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<EffectDressInfo> EffectDresses => effectDresses_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DBUser()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DBUser(DBUser other)
		: this()
	{
		id_ = other.id_;
		accountId_ = other.accountId_;
		serverIndex_ = other.serverIndex_;
		openId_ = other.openId_;
		sdkAid_ = other.sdkAid_;
		createTime_ = other.createTime_;
		lastUpdateTime_ = other.lastUpdateTime_;
		enterTime_ = other.enterTime_;
		offlineTime_ = other.offlineTime_;
		level_ = other.level_;
		exp_ = other.exp_;
		worldLevel_ = other.worldLevel_;
		nickName_ = other.nickName_;
		coin_ = other.coin_;
		power_ = other.power_;
		freeDiamond_ = other.freeDiamond_;
		costDiamond_ = other.costDiamond_;
		gender_ = other.gender_;
		tookLevelRewards_ = ((other.tookLevelRewards_ != null) ? other.tookLevelRewards_.Clone() : null);
		openedSystems_ = ((other.openedSystems_ != null) ? other.openedSystems_.Clone() : null);
		items_ = ((other.items_ != null) ? other.items_.Clone() : null);
		attributes_ = ((other.attributes_ != null) ? other.attributes_.Clone() : null);
		characters_ = ((other.characters_ != null) ? other.characters_.Clone() : null);
		weapons_ = ((other.weapons_ != null) ? other.weapons_.Clone() : null);
		chips_ = ((other.chips_ != null) ? other.chips_.Clone() : null);
		handbooks_ = ((other.handbooks_ != null) ? other.handbooks_.Clone() : null);
		missions_ = ((other.missions_ != null) ? other.missions_.Clone() : null);
		assists_ = ((other.assists_ != null) ? other.assists_.Clone() : null);
		scenes_ = ((other.scenes_ != null) ? other.scenes_.Clone() : null);
		profile_ = ((other.profile_ != null) ? other.profile_.Clone() : null);
		equips_ = ((other.equips_ != null) ? other.equips_.Clone() : null);
		gems_ = ((other.gems_ != null) ? other.gems_.Clone() : null);
		composeData_ = ((other.composeData_ != null) ? other.composeData_.Clone() : null);
		mapInfo_ = ((other.mapInfo_ != null) ? other.mapInfo_.Clone() : null);
		loungeInfo_ = ((other.loungeInfo_ != null) ? other.loungeInfo_.Clone() : null);
		battlePass_ = ((other.battlePass_ != null) ? other.battlePass_.Clone() : null);
		vocabularyInfo_ = ((other.vocabularyInfo_ != null) ? other.vocabularyInfo_.Clone() : null);
		tdClientData_ = ((other.tdClientData_ != null) ? other.tdClientData_.Clone() : null);
		timeLimitItems_ = ((other.timeLimitItems_ != null) ? other.timeLimitItems_.Clone() : null);
		skins_ = other.skins_.Clone();
		diamondData_ = ((other.diamondData_ != null) ? other.diamondData_.Clone() : null);
		bundleData_ = ((other.bundleData_ != null) ? other.bundleData_.Clone() : null);
		monthlyPasses_ = other.monthlyPasses_.Clone();
		effectDresses_ = other.effectDresses_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DBUser Clone()
	{
		return new DBUser(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as DBUser);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(DBUser other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (AccountId != other.AccountId)
		{
			return false;
		}
		if (ServerIndex != other.ServerIndex)
		{
			return false;
		}
		if (OpenId != other.OpenId)
		{
			return false;
		}
		if (SdkAid != other.SdkAid)
		{
			return false;
		}
		if (CreateTime != other.CreateTime)
		{
			return false;
		}
		if (LastUpdateTime != other.LastUpdateTime)
		{
			return false;
		}
		if (EnterTime != other.EnterTime)
		{
			return false;
		}
		if (OfflineTime != other.OfflineTime)
		{
			return false;
		}
		if (Level != other.Level)
		{
			return false;
		}
		if (Exp != other.Exp)
		{
			return false;
		}
		if (WorldLevel != other.WorldLevel)
		{
			return false;
		}
		if (NickName != other.NickName)
		{
			return false;
		}
		if (Coin != other.Coin)
		{
			return false;
		}
		if (Power != other.Power)
		{
			return false;
		}
		if (FreeDiamond != other.FreeDiamond)
		{
			return false;
		}
		if (CostDiamond != other.CostDiamond)
		{
			return false;
		}
		if (Gender != other.Gender)
		{
			return false;
		}
		if (!object.Equals(TookLevelRewards, other.TookLevelRewards))
		{
			return false;
		}
		if (!object.Equals(OpenedSystems, other.OpenedSystems))
		{
			return false;
		}
		if (!object.Equals(Items, other.Items))
		{
			return false;
		}
		if (!object.Equals(Attributes, other.Attributes))
		{
			return false;
		}
		if (!object.Equals(Characters, other.Characters))
		{
			return false;
		}
		if (!object.Equals(Weapons, other.Weapons))
		{
			return false;
		}
		if (!object.Equals(Chips, other.Chips))
		{
			return false;
		}
		if (!object.Equals(Handbooks, other.Handbooks))
		{
			return false;
		}
		if (!object.Equals(Missions, other.Missions))
		{
			return false;
		}
		if (!object.Equals(Assists, other.Assists))
		{
			return false;
		}
		if (!object.Equals(Scenes, other.Scenes))
		{
			return false;
		}
		if (!object.Equals(Profile, other.Profile))
		{
			return false;
		}
		if (!object.Equals(Equips, other.Equips))
		{
			return false;
		}
		if (!object.Equals(Gems, other.Gems))
		{
			return false;
		}
		if (!object.Equals(ComposeData, other.ComposeData))
		{
			return false;
		}
		if (!object.Equals(MapInfo, other.MapInfo))
		{
			return false;
		}
		if (!object.Equals(LoungeInfo, other.LoungeInfo))
		{
			return false;
		}
		if (!object.Equals(BattlePass, other.BattlePass))
		{
			return false;
		}
		if (!object.Equals(VocabularyInfo, other.VocabularyInfo))
		{
			return false;
		}
		if (!object.Equals(TdClientData, other.TdClientData))
		{
			return false;
		}
		if (!object.Equals(TimeLimitItems, other.TimeLimitItems))
		{
			return false;
		}
		if (!skins_.Equals(other.skins_))
		{
			return false;
		}
		if (!object.Equals(DiamondData, other.DiamondData))
		{
			return false;
		}
		if (!object.Equals(BundleData, other.BundleData))
		{
			return false;
		}
		if (!monthlyPasses_.Equals(other.monthlyPasses_))
		{
			return false;
		}
		if (!effectDresses_.Equals(other.effectDresses_))
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0L)
		{
			num ^= Id.GetHashCode();
		}
		if (AccountId != 0L)
		{
			num ^= AccountId.GetHashCode();
		}
		if (ServerIndex != 0)
		{
			num ^= ServerIndex.GetHashCode();
		}
		if (OpenId.Length != 0)
		{
			num ^= OpenId.GetHashCode();
		}
		if (SdkAid != 0)
		{
			num ^= SdkAid.GetHashCode();
		}
		if (CreateTime != 0L)
		{
			num ^= CreateTime.GetHashCode();
		}
		if (LastUpdateTime != 0L)
		{
			num ^= LastUpdateTime.GetHashCode();
		}
		if (EnterTime != 0L)
		{
			num ^= EnterTime.GetHashCode();
		}
		if (OfflineTime != 0L)
		{
			num ^= OfflineTime.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (Exp != 0)
		{
			num ^= Exp.GetHashCode();
		}
		if (WorldLevel != 0)
		{
			num ^= WorldLevel.GetHashCode();
		}
		if (NickName.Length != 0)
		{
			num ^= NickName.GetHashCode();
		}
		if (Coin != 0L)
		{
			num ^= Coin.GetHashCode();
		}
		if (Power != 0)
		{
			num ^= Power.GetHashCode();
		}
		if (FreeDiamond != 0L)
		{
			num ^= FreeDiamond.GetHashCode();
		}
		if (CostDiamond != 0L)
		{
			num ^= CostDiamond.GetHashCode();
		}
		if (Gender != 0)
		{
			num ^= Gender.GetHashCode();
		}
		if (tookLevelRewards_ != null)
		{
			num ^= TookLevelRewards.GetHashCode();
		}
		if (openedSystems_ != null)
		{
			num ^= OpenedSystems.GetHashCode();
		}
		if (items_ != null)
		{
			num ^= Items.GetHashCode();
		}
		if (attributes_ != null)
		{
			num ^= Attributes.GetHashCode();
		}
		if (characters_ != null)
		{
			num ^= Characters.GetHashCode();
		}
		if (weapons_ != null)
		{
			num ^= Weapons.GetHashCode();
		}
		if (chips_ != null)
		{
			num ^= Chips.GetHashCode();
		}
		if (handbooks_ != null)
		{
			num ^= Handbooks.GetHashCode();
		}
		if (missions_ != null)
		{
			num ^= Missions.GetHashCode();
		}
		if (assists_ != null)
		{
			num ^= Assists.GetHashCode();
		}
		if (scenes_ != null)
		{
			num ^= Scenes.GetHashCode();
		}
		if (profile_ != null)
		{
			num ^= Profile.GetHashCode();
		}
		if (equips_ != null)
		{
			num ^= Equips.GetHashCode();
		}
		if (gems_ != null)
		{
			num ^= Gems.GetHashCode();
		}
		if (composeData_ != null)
		{
			num ^= ComposeData.GetHashCode();
		}
		if (mapInfo_ != null)
		{
			num ^= MapInfo.GetHashCode();
		}
		if (loungeInfo_ != null)
		{
			num ^= LoungeInfo.GetHashCode();
		}
		if (battlePass_ != null)
		{
			num ^= BattlePass.GetHashCode();
		}
		if (vocabularyInfo_ != null)
		{
			num ^= VocabularyInfo.GetHashCode();
		}
		if (tdClientData_ != null)
		{
			num ^= TdClientData.GetHashCode();
		}
		if (timeLimitItems_ != null)
		{
			num ^= TimeLimitItems.GetHashCode();
		}
		num ^= skins_.GetHashCode();
		if (diamondData_ != null)
		{
			num ^= DiamondData.GetHashCode();
		}
		if (bundleData_ != null)
		{
			num ^= BundleData.GetHashCode();
		}
		num ^= monthlyPasses_.GetHashCode();
		num ^= effectDresses_.GetHashCode();
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (Id != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(Id);
		}
		if (AccountId != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(AccountId);
		}
		if (ServerIndex != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ServerIndex);
		}
		if (OpenId.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(OpenId);
		}
		if (SdkAid != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(SdkAid);
		}
		if (CreateTime != 0L)
		{
			output.WriteRawTag(48);
			output.WriteInt64(CreateTime);
		}
		if (LastUpdateTime != 0L)
		{
			output.WriteRawTag(56);
			output.WriteInt64(LastUpdateTime);
		}
		if (EnterTime != 0L)
		{
			output.WriteRawTag(64);
			output.WriteInt64(EnterTime);
		}
		if (OfflineTime != 0L)
		{
			output.WriteRawTag(72);
			output.WriteInt64(OfflineTime);
		}
		if (Level != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Level);
		}
		if (Exp != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(Exp);
		}
		if (WorldLevel != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(WorldLevel);
		}
		if (NickName.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(NickName);
		}
		if (Coin != 0L)
		{
			output.WriteRawTag(112);
			output.WriteInt64(Coin);
		}
		if (Power != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(Power);
		}
		if (FreeDiamond != 0L)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt64(FreeDiamond);
		}
		if (CostDiamond != 0L)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt64(CostDiamond);
		}
		if (Gender != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteUInt32(Gender);
		}
		if (tookLevelRewards_ != null)
		{
			output.WriteRawTag(154, 1);
			output.WriteMessage(TookLevelRewards);
		}
		if (openedSystems_ != null)
		{
			output.WriteRawTag(162, 1);
			output.WriteMessage(OpenedSystems);
		}
		if (items_ != null)
		{
			output.WriteRawTag(170, 1);
			output.WriteMessage(Items);
		}
		if (attributes_ != null)
		{
			output.WriteRawTag(178, 1);
			output.WriteMessage(Attributes);
		}
		if (characters_ != null)
		{
			output.WriteRawTag(186, 1);
			output.WriteMessage(Characters);
		}
		if (weapons_ != null)
		{
			output.WriteRawTag(194, 1);
			output.WriteMessage(Weapons);
		}
		if (chips_ != null)
		{
			output.WriteRawTag(202, 1);
			output.WriteMessage(Chips);
		}
		if (handbooks_ != null)
		{
			output.WriteRawTag(210, 1);
			output.WriteMessage(Handbooks);
		}
		if (missions_ != null)
		{
			output.WriteRawTag(218, 1);
			output.WriteMessage(Missions);
		}
		if (assists_ != null)
		{
			output.WriteRawTag(226, 1);
			output.WriteMessage(Assists);
		}
		if (scenes_ != null)
		{
			output.WriteRawTag(234, 1);
			output.WriteMessage(Scenes);
		}
		if (profile_ != null)
		{
			output.WriteRawTag(242, 1);
			output.WriteMessage(Profile);
		}
		if (equips_ != null)
		{
			output.WriteRawTag(250, 1);
			output.WriteMessage(Equips);
		}
		if (gems_ != null)
		{
			output.WriteRawTag(130, 2);
			output.WriteMessage(Gems);
		}
		if (composeData_ != null)
		{
			output.WriteRawTag(138, 2);
			output.WriteMessage(ComposeData);
		}
		if (mapInfo_ != null)
		{
			output.WriteRawTag(146, 2);
			output.WriteMessage(MapInfo);
		}
		if (loungeInfo_ != null)
		{
			output.WriteRawTag(154, 2);
			output.WriteMessage(LoungeInfo);
		}
		if (battlePass_ != null)
		{
			output.WriteRawTag(162, 2);
			output.WriteMessage(BattlePass);
		}
		if (vocabularyInfo_ != null)
		{
			output.WriteRawTag(170, 2);
			output.WriteMessage(VocabularyInfo);
		}
		if (tdClientData_ != null)
		{
			output.WriteRawTag(178, 2);
			output.WriteMessage(TdClientData);
		}
		if (timeLimitItems_ != null)
		{
			output.WriteRawTag(186, 2);
			output.WriteMessage(TimeLimitItems);
		}
		skins_.WriteTo(ref output, _repeated_skins_codec);
		if (diamondData_ != null)
		{
			output.WriteRawTag(202, 2);
			output.WriteMessage(DiamondData);
		}
		if (bundleData_ != null)
		{
			output.WriteRawTag(210, 2);
			output.WriteMessage(BundleData);
		}
		monthlyPasses_.WriteTo(ref output, _repeated_monthlyPasses_codec);
		effectDresses_.WriteTo(ref output, _repeated_effectDresses_codec);
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Id);
		}
		if (AccountId != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(AccountId);
		}
		if (ServerIndex != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ServerIndex);
		}
		if (OpenId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OpenId);
		}
		if (SdkAid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SdkAid);
		}
		if (CreateTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(CreateTime);
		}
		if (LastUpdateTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(LastUpdateTime);
		}
		if (EnterTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(EnterTime);
		}
		if (OfflineTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(OfflineTime);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (Exp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Exp);
		}
		if (WorldLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WorldLevel);
		}
		if (NickName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(NickName);
		}
		if (Coin != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Coin);
		}
		if (Power != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Power);
		}
		if (FreeDiamond != 0L)
		{
			num += 2 + CodedOutputStream.ComputeInt64Size(FreeDiamond);
		}
		if (CostDiamond != 0L)
		{
			num += 2 + CodedOutputStream.ComputeInt64Size(CostDiamond);
		}
		if (Gender != 0)
		{
			num += 2 + CodedOutputStream.ComputeUInt32Size(Gender);
		}
		if (tookLevelRewards_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(TookLevelRewards);
		}
		if (openedSystems_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(OpenedSystems);
		}
		if (items_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Items);
		}
		if (attributes_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Attributes);
		}
		if (characters_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Characters);
		}
		if (weapons_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Weapons);
		}
		if (chips_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Chips);
		}
		if (handbooks_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Handbooks);
		}
		if (missions_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Missions);
		}
		if (assists_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Assists);
		}
		if (scenes_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Scenes);
		}
		if (profile_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Profile);
		}
		if (equips_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Equips);
		}
		if (gems_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Gems);
		}
		if (composeData_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(ComposeData);
		}
		if (mapInfo_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(MapInfo);
		}
		if (loungeInfo_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(LoungeInfo);
		}
		if (battlePass_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(BattlePass);
		}
		if (vocabularyInfo_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(VocabularyInfo);
		}
		if (tdClientData_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(TdClientData);
		}
		if (timeLimitItems_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(TimeLimitItems);
		}
		num += skins_.CalculateSize(_repeated_skins_codec);
		if (diamondData_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(DiamondData);
		}
		if (bundleData_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(BundleData);
		}
		num += monthlyPasses_.CalculateSize(_repeated_monthlyPasses_codec);
		num += effectDresses_.CalculateSize(_repeated_effectDresses_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(DBUser other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Id != 0L)
		{
			Id = other.Id;
		}
		if (other.AccountId != 0L)
		{
			AccountId = other.AccountId;
		}
		if (other.ServerIndex != 0)
		{
			ServerIndex = other.ServerIndex;
		}
		if (other.OpenId.Length != 0)
		{
			OpenId = other.OpenId;
		}
		if (other.SdkAid != 0)
		{
			SdkAid = other.SdkAid;
		}
		if (other.CreateTime != 0L)
		{
			CreateTime = other.CreateTime;
		}
		if (other.LastUpdateTime != 0L)
		{
			LastUpdateTime = other.LastUpdateTime;
		}
		if (other.EnterTime != 0L)
		{
			EnterTime = other.EnterTime;
		}
		if (other.OfflineTime != 0L)
		{
			OfflineTime = other.OfflineTime;
		}
		if (other.Level != 0)
		{
			Level = other.Level;
		}
		if (other.Exp != 0)
		{
			Exp = other.Exp;
		}
		if (other.WorldLevel != 0)
		{
			WorldLevel = other.WorldLevel;
		}
		if (other.NickName.Length != 0)
		{
			NickName = other.NickName;
		}
		if (other.Coin != 0L)
		{
			Coin = other.Coin;
		}
		if (other.Power != 0)
		{
			Power = other.Power;
		}
		if (other.FreeDiamond != 0L)
		{
			FreeDiamond = other.FreeDiamond;
		}
		if (other.CostDiamond != 0L)
		{
			CostDiamond = other.CostDiamond;
		}
		if (other.Gender != 0)
		{
			Gender = other.Gender;
		}
		if (other.tookLevelRewards_ != null)
		{
			if (tookLevelRewards_ == null)
			{
				TookLevelRewards = new TookLevelRewards();
			}
			TookLevelRewards.MergeFrom(other.TookLevelRewards);
		}
		if (other.openedSystems_ != null)
		{
			if (openedSystems_ == null)
			{
				OpenedSystems = new OpenedSystems();
			}
			OpenedSystems.MergeFrom(other.OpenedSystems);
		}
		if (other.items_ != null)
		{
			if (items_ == null)
			{
				Items = new Items();
			}
			Items.MergeFrom(other.Items);
		}
		if (other.attributes_ != null)
		{
			if (attributes_ == null)
			{
				Attributes = new Attributes();
			}
			Attributes.MergeFrom(other.Attributes);
		}
		if (other.characters_ != null)
		{
			if (characters_ == null)
			{
				Characters = new Characters();
			}
			Characters.MergeFrom(other.Characters);
		}
		if (other.weapons_ != null)
		{
			if (weapons_ == null)
			{
				Weapons = new Weapons();
			}
			Weapons.MergeFrom(other.Weapons);
		}
		if (other.chips_ != null)
		{
			if (chips_ == null)
			{
				Chips = new Chips();
			}
			Chips.MergeFrom(other.Chips);
		}
		if (other.handbooks_ != null)
		{
			if (handbooks_ == null)
			{
				Handbooks = new Handbook();
			}
			Handbooks.MergeFrom(other.Handbooks);
		}
		if (other.missions_ != null)
		{
			if (missions_ == null)
			{
				Missions = new Missions();
			}
			Missions.MergeFrom(other.Missions);
		}
		if (other.assists_ != null)
		{
			if (assists_ == null)
			{
				Assists = new Assists();
			}
			Assists.MergeFrom(other.Assists);
		}
		if (other.scenes_ != null)
		{
			if (scenes_ == null)
			{
				Scenes = new Scenes();
			}
			Scenes.MergeFrom(other.Scenes);
		}
		if (other.profile_ != null)
		{
			if (profile_ == null)
			{
				Profile = new PlayerProfile();
			}
			Profile.MergeFrom(other.Profile);
		}
		if (other.equips_ != null)
		{
			if (equips_ == null)
			{
				Equips = new Equips();
			}
			Equips.MergeFrom(other.Equips);
		}
		if (other.gems_ != null)
		{
			if (gems_ == null)
			{
				Gems = new Gems();
			}
			Gems.MergeFrom(other.Gems);
		}
		if (other.composeData_ != null)
		{
			if (composeData_ == null)
			{
				ComposeData = new PlayerComposeData();
			}
			ComposeData.MergeFrom(other.ComposeData);
		}
		if (other.mapInfo_ != null)
		{
			if (mapInfo_ == null)
			{
				MapInfo = new MapDbModel();
			}
			MapInfo.MergeFrom(other.MapInfo);
		}
		if (other.loungeInfo_ != null)
		{
			if (loungeInfo_ == null)
			{
				LoungeInfo = new LoungeDbModel();
			}
			LoungeInfo.MergeFrom(other.LoungeInfo);
		}
		if (other.battlePass_ != null)
		{
			if (battlePass_ == null)
			{
				BattlePass = new BattlePassDbModel();
			}
			BattlePass.MergeFrom(other.BattlePass);
		}
		if (other.vocabularyInfo_ != null)
		{
			if (vocabularyInfo_ == null)
			{
				VocabularyInfo = new VocabularyDbModel();
			}
			VocabularyInfo.MergeFrom(other.VocabularyInfo);
		}
		if (other.tdClientData_ != null)
		{
			if (tdClientData_ == null)
			{
				TdClientData = new TDClientData();
			}
			TdClientData.MergeFrom(other.TdClientData);
		}
		if (other.timeLimitItems_ != null)
		{
			if (timeLimitItems_ == null)
			{
				TimeLimitItems = new TimeLimitItems();
			}
			TimeLimitItems.MergeFrom(other.TimeLimitItems);
		}
		skins_.Add(other.skins_);
		if (other.diamondData_ != null)
		{
			if (diamondData_ == null)
			{
				DiamondData = new DiamondData();
			}
			DiamondData.MergeFrom(other.DiamondData);
		}
		if (other.bundleData_ != null)
		{
			if (bundleData_ == null)
			{
				BundleData = new BundleData();
			}
			BundleData.MergeFrom(other.BundleData);
		}
		monthlyPasses_.Add(other.monthlyPasses_);
		effectDresses_.Add(other.effectDresses_);
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				Id = input.ReadInt64();
				break;
			case 16u:
				AccountId = input.ReadInt64();
				break;
			case 24u:
				ServerIndex = input.ReadInt32();
				break;
			case 34u:
				OpenId = input.ReadString();
				break;
			case 40u:
				SdkAid = input.ReadInt32();
				break;
			case 48u:
				CreateTime = input.ReadInt64();
				break;
			case 56u:
				LastUpdateTime = input.ReadInt64();
				break;
			case 64u:
				EnterTime = input.ReadInt64();
				break;
			case 72u:
				OfflineTime = input.ReadInt64();
				break;
			case 80u:
				Level = input.ReadInt32();
				break;
			case 88u:
				Exp = input.ReadInt32();
				break;
			case 96u:
				WorldLevel = input.ReadInt32();
				break;
			case 106u:
				NickName = input.ReadString();
				break;
			case 112u:
				Coin = input.ReadInt64();
				break;
			case 120u:
				Power = input.ReadInt32();
				break;
			case 128u:
				FreeDiamond = input.ReadInt64();
				break;
			case 136u:
				CostDiamond = input.ReadInt64();
				break;
			case 144u:
				Gender = input.ReadUInt32();
				break;
			case 154u:
				if (tookLevelRewards_ == null)
				{
					TookLevelRewards = new TookLevelRewards();
				}
				input.ReadMessage(TookLevelRewards);
				break;
			case 162u:
				if (openedSystems_ == null)
				{
					OpenedSystems = new OpenedSystems();
				}
				input.ReadMessage(OpenedSystems);
				break;
			case 170u:
				if (items_ == null)
				{
					Items = new Items();
				}
				input.ReadMessage(Items);
				break;
			case 178u:
				if (attributes_ == null)
				{
					Attributes = new Attributes();
				}
				input.ReadMessage(Attributes);
				break;
			case 186u:
				if (characters_ == null)
				{
					Characters = new Characters();
				}
				input.ReadMessage(Characters);
				break;
			case 194u:
				if (weapons_ == null)
				{
					Weapons = new Weapons();
				}
				input.ReadMessage(Weapons);
				break;
			case 202u:
				if (chips_ == null)
				{
					Chips = new Chips();
				}
				input.ReadMessage(Chips);
				break;
			case 210u:
				if (handbooks_ == null)
				{
					Handbooks = new Handbook();
				}
				input.ReadMessage(Handbooks);
				break;
			case 218u:
				if (missions_ == null)
				{
					Missions = new Missions();
				}
				input.ReadMessage(Missions);
				break;
			case 226u:
				if (assists_ == null)
				{
					Assists = new Assists();
				}
				input.ReadMessage(Assists);
				break;
			case 234u:
				if (scenes_ == null)
				{
					Scenes = new Scenes();
				}
				input.ReadMessage(Scenes);
				break;
			case 242u:
				if (profile_ == null)
				{
					Profile = new PlayerProfile();
				}
				input.ReadMessage(Profile);
				break;
			case 250u:
				if (equips_ == null)
				{
					Equips = new Equips();
				}
				input.ReadMessage(Equips);
				break;
			case 258u:
				if (gems_ == null)
				{
					Gems = new Gems();
				}
				input.ReadMessage(Gems);
				break;
			case 266u:
				if (composeData_ == null)
				{
					ComposeData = new PlayerComposeData();
				}
				input.ReadMessage(ComposeData);
				break;
			case 274u:
				if (mapInfo_ == null)
				{
					MapInfo = new MapDbModel();
				}
				input.ReadMessage(MapInfo);
				break;
			case 282u:
				if (loungeInfo_ == null)
				{
					LoungeInfo = new LoungeDbModel();
				}
				input.ReadMessage(LoungeInfo);
				break;
			case 290u:
				if (battlePass_ == null)
				{
					BattlePass = new BattlePassDbModel();
				}
				input.ReadMessage(BattlePass);
				break;
			case 298u:
				if (vocabularyInfo_ == null)
				{
					VocabularyInfo = new VocabularyDbModel();
				}
				input.ReadMessage(VocabularyInfo);
				break;
			case 306u:
				if (tdClientData_ == null)
				{
					TdClientData = new TDClientData();
				}
				input.ReadMessage(TdClientData);
				break;
			case 314u:
				if (timeLimitItems_ == null)
				{
					TimeLimitItems = new TimeLimitItems();
				}
				input.ReadMessage(TimeLimitItems);
				break;
			case 322u:
				skins_.AddEntriesFrom(ref input, _repeated_skins_codec);
				break;
			case 330u:
				if (diamondData_ == null)
				{
					DiamondData = new DiamondData();
				}
				input.ReadMessage(DiamondData);
				break;
			case 338u:
				if (bundleData_ == null)
				{
					BundleData = new BundleData();
				}
				input.ReadMessage(BundleData);
				break;
			case 346u:
				monthlyPasses_.AddEntriesFrom(ref input, _repeated_monthlyPasses_codec);
				break;
			case 354u:
				effectDresses_.AddEntriesFrom(ref input, _repeated_effectDresses_codec);
				break;
			}
		}
	}
}
