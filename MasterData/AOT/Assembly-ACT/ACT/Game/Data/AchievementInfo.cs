using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class AchievementInfo : IMessage<AchievementInfo>, IMessage, IEquatable<AchievementInfo>, IDeepCloneable<AchievementInfo>, IBufferMessage
{
	private static readonly MessageParser<AchievementInfo> _parser = new MessageParser<AchievementInfo>(() => new AchievementInfo());

	private UnknownFieldSet _unknownFields;

	public const int MaximumWorldLevelFieldNumber = 1;

	private int maximumWorldLevel_;

	public const int CompletedMissionsFieldNumber = 2;

	private static readonly MapField<int, bool>.Codec _map_completedMissions_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 18u);

	private readonly MapField<int, bool> completedMissions_ = new MapField<int, bool>();

	public const int GotItemsFieldNumber = 3;

	private static readonly MapField<int, int>.Codec _map_gotItems_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 26u);

	private readonly MapField<int, int> gotItems_ = new MapField<int, int>();

	public const int GotItemsWithQualityFieldNumber = 4;

	private static readonly MapField<int, ItemQualityCount>.Codec _map_gotItemsWithQuality_codec = new MapField<int, ItemQualityCount>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ItemQualityCount.Parser), 34u);

	private readonly MapField<int, ItemQualityCount> gotItemsWithQuality_ = new MapField<int, ItemQualityCount>();

	public const int LevelWeaponsFieldNumber = 6;

	private static readonly MapField<int, int>.Codec _map_levelWeapons_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 50u);

	private readonly MapField<int, int> levelWeapons_ = new MapField<int, int>();

	public const int FightTypeCountFieldNumber = 7;

	private static readonly MapField<int, int>.Codec _map_fightTypeCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 58u);

	private readonly MapField<int, int> fightTypeCount_ = new MapField<int, int>();

	public const int ConversationKeyPointsFieldNumber = 8;

	private static readonly MapField<int, int>.Codec _map_conversationKeyPoints_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 66u);

	private readonly MapField<int, int> conversationKeyPoints_ = new MapField<int, int>();

	public const int CountDatasFieldNumber = 9;

	private static readonly MapField<int, int>.Codec _map_countDatas_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 74u);

	private readonly MapField<int, int> countDatas_ = new MapField<int, int>();

	public const int CompletedAbyssStagesFieldNumber = 10;

	private static readonly MapField<int, bool>.Codec _map_completedAbyssStages_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 82u);

	private readonly MapField<int, bool> completedAbyssStages_ = new MapField<int, bool>();

	public const int CompletedRaidTypeCountFieldNumber = 11;

	private static readonly MapField<int, int>.Codec _map_completedRaidTypeCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 90u);

	private readonly MapField<int, int> completedRaidTypeCount_ = new MapField<int, int>();

	public const int ConversationOptionInfoFieldNumber = 12;

	private static readonly MapField<int, int>.Codec _map_conversationOptionInfo_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 98u);

	private readonly MapField<int, int> conversationOptionInfo_ = new MapField<int, int>();

	public const int GotWeaponsFieldNumber = 13;

	private static readonly MapField<int, int>.Codec _map_gotWeapons_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 106u);

	private readonly MapField<int, int> gotWeapons_ = new MapField<int, int>();

	public const int OpenedTreasureChestFieldNumber = 14;

	private static readonly MapField<int, int>.Codec _map_openedTreasureChest_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 114u);

	private readonly MapField<int, int> openedTreasureChest_ = new MapField<int, int>();

	public const int BossKillTimeFieldNumber = 15;

	private static readonly MapField<int, int>.Codec _map_bossKillTime_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 122u);

	private readonly MapField<int, int> bossKillTime_ = new MapField<int, int>();

	public const int ActivityLoginDayFieldNumber = 16;

	private static readonly MapField<int, int>.Codec _map_activityLoginDay_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 130u);

	private readonly MapField<int, int> activityLoginDay_ = new MapField<int, int>();

	public const int UseItemsFieldNumber = 17;

	private static readonly MapField<int, int>.Codec _map_useItems_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 138u);

	private readonly MapField<int, int> useItems_ = new MapField<int, int>();

	public const int TiggerInteractionFieldNumber = 18;

	private static readonly MapField<int, int>.Codec _map_tiggerInteraction_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 146u);

	private readonly MapField<int, int> tiggerInteraction_ = new MapField<int, int>();

	public const int PassRaidByIdCountFieldNumber = 19;

	private static readonly MapField<int, int>.Codec _map_passRaidByIdCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 154u);

	private readonly MapField<int, int> passRaidByIdCount_ = new MapField<int, int>();

	public const int PassRaidByMarkCountFieldNumber = 20;

	private static readonly MapField<int, int>.Codec _map_passRaidByMarkCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 162u);

	private readonly MapField<int, int> passRaidByMarkCount_ = new MapField<int, int>();

	public const int PassRaidByEntranceCountFieldNumber = 21;

	private static readonly MapField<int, int>.Codec _map_passRaidByEntranceCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 170u);

	private readonly MapField<int, int> passRaidByEntranceCount_ = new MapField<int, int>();

	public const int CharacterLevelUpSkillCountFieldNumber = 22;

	private static readonly MapField<int, int>.Codec _map_characterLevelUpSkillCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 178u);

	private readonly MapField<int, int> characterLevelUpSkillCount_ = new MapField<int, int>();

	public const int CharacterEliteMaximumHistoryLevelFieldNumber = 23;

	private static readonly MapField<int, int>.Codec _map_characterEliteMaximumHistoryLevel_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 186u);

	private readonly MapField<int, int> characterEliteMaximumHistoryLevel_ = new MapField<int, int>();

	public const int LevelUpCharactersFieldNumber = 24;

	private static readonly MapField<int, int>.Codec _map_levelUpCharacters_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 194u);

	private readonly MapField<int, int> levelUpCharacters_ = new MapField<int, int>();

	public const int ChapterRaidPassCountFieldNumber = 25;

	private static readonly MapField<int, ChapterRaidPassCount>.Codec _map_chapterRaidPassCount_codec = new MapField<int, ChapterRaidPassCount>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ACT.Game.Data.ChapterRaidPassCount.Parser), 202u);

	private readonly MapField<int, ChapterRaidPassCount> chapterRaidPassCount_ = new MapField<int, ChapterRaidPassCount>();

	public const int CompletedAbyssStagesByStarsFieldNumber = 26;

	private static readonly MapField<int, int>.Codec _map_completedAbyssStagesByStars_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 210u);

	private readonly MapField<int, int> completedAbyssStagesByStars_ = new MapField<int, int>();

	public const int ShopBuyCountFieldNumber = 27;

	private static readonly MapField<int, int>.Codec _map_shopBuyCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 218u);

	private readonly MapField<int, int> shopBuyCount_ = new MapField<int, int>();

	public const int UseSkillCountFieldNumber = 28;

	private static readonly MapField<int, int>.Codec _map_useSkillCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 226u);

	private readonly MapField<int, int> useSkillCount_ = new MapField<int, int>();

	public const int KillMonsterIDCountFieldNumber = 29;

	private static readonly MapField<int, int>.Codec _map_killMonsterIDCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 234u);

	private readonly MapField<int, int> killMonsterIDCount_ = new MapField<int, int>();

	public const int OpenSubareaMajorBeaconFieldNumber = 30;

	private static readonly MapField<int, bool>.Codec _map_openSubareaMajorBeacon_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 242u);

	private readonly MapField<int, bool> openSubareaMajorBeacon_ = new MapField<int, bool>();

	public const int OpenWeberCabinFieldNumber = 31;

	private static readonly MapField<int, SubareaMajorBeaconCount>.Codec _map_openWeberCabin_codec = new MapField<int, SubareaMajorBeaconCount>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, SubareaMajorBeaconCount.Parser), 250u);

	private readonly MapField<int, SubareaMajorBeaconCount> openWeberCabin_ = new MapField<int, SubareaMajorBeaconCount>();

	public const int AreaVisitedFieldNumber = 32;

	private static readonly MapField<int, bool>.Codec _map_areaVisited_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 258u);

	private readonly MapField<int, bool> areaVisited_ = new MapField<int, bool>();

	public const int InteractByAreaAndTypeFieldNumber = 33;

	private static readonly MapField<int, InteractByItemType>.Codec _map_interactByAreaAndType_codec = new MapField<int, InteractByItemType>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, InteractByItemType.Parser), 266u);

	private readonly MapField<int, InteractByItemType> interactByAreaAndType_ = new MapField<int, InteractByItemType>();

	public const int CharacterKilledMonsterCountFieldNumber = 34;

	private static readonly MapField<int, CharacterKilledMonsterCount>.Codec _map_characterKilledMonsterCount_codec = new MapField<int, CharacterKilledMonsterCount>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ACT.Game.Data.CharacterKilledMonsterCount.Parser), 274u);

	private readonly MapField<int, CharacterKilledMonsterCount> characterKilledMonsterCount_ = new MapField<int, CharacterKilledMonsterCount>();

	public const int DamageOnceMaximumByTypeFieldNumber = 35;

	private static readonly MapField<int, int>.Codec _map_damageOnceMaximumByType_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 282u);

	private readonly MapField<int, int> damageOnceMaximumByType_ = new MapField<int, int>();

	public const int DamageTotalByTypeFieldNumber = 36;

	private static readonly MapField<int, int>.Codec _map_damageTotalByType_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 290u);

	private readonly MapField<int, int> damageTotalByType_ = new MapField<int, int>();

	public const int GachaTenPullCharacterQualityCountFieldNumber = 37;

	private static readonly MapField<int, GachaCharacterQualityCompleteCount>.Codec _map_gachaTenPullCharacterQualityCount_codec = new MapField<int, GachaCharacterQualityCompleteCount>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, GachaCharacterQualityCompleteCount.Parser), 298u);

	private readonly MapField<int, GachaCharacterQualityCompleteCount> gachaTenPullCharacterQualityCount_ = new MapField<int, GachaCharacterQualityCompleteCount>();

	public const int GachaSinglePullCharacterQualityCountFieldNumber = 38;

	private static readonly MapField<int, int>.Codec _map_gachaSinglePullCharacterQualityCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 306u);

	private readonly MapField<int, int> gachaSinglePullCharacterQualityCount_ = new MapField<int, int>();

	public const int NpcInteractedFieldNumber = 39;

	private static readonly MapField<int, bool>.Codec _map_npcInteracted_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 314u);

	private readonly MapField<int, bool> npcInteracted_ = new MapField<int, bool>();

	public const int InteractByItemIDFieldNumber = 40;

	private static readonly MapField<int, int>.Codec _map_interactByItemID_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 322u);

	private readonly MapField<int, int> interactByItemID_ = new MapField<int, int>();

	public const int RoguelikeDifficultyPassCountFieldNumber = 41;

	private static readonly MapField<int, int>.Codec _map_roguelikeDifficultyPassCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 330u);

	private readonly MapField<int, int> roguelikeDifficultyPassCount_ = new MapField<int, int>();

	public const int OpenStoneTabletFieldNumber = 42;

	private static readonly MapField<int, int>.Codec _map_openStoneTablet_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 338u);

	private readonly MapField<int, int> openStoneTablet_ = new MapField<int, int>();

	public const int CompleteTreasureDecryptCountFieldNumber = 43;

	private static readonly MapField<int, AreaSubAreaCompleteCount>.Codec _map_completeTreasureDecryptCount_codec = new MapField<int, AreaSubAreaCompleteCount>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, AreaSubAreaCompleteCount.Parser), 346u);

	private readonly MapField<int, AreaSubAreaCompleteCount> completeTreasureDecryptCount_ = new MapField<int, AreaSubAreaCompleteCount>();

	public const int CompleteLimitTimeTreasureCountFieldNumber = 44;

	private static readonly MapField<int, AreaSubAreaCompleteCount>.Codec _map_completeLimitTimeTreasureCount_codec = new MapField<int, AreaSubAreaCompleteCount>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, AreaSubAreaCompleteCount.Parser), 354u);

	private readonly MapField<int, AreaSubAreaCompleteCount> completeLimitTimeTreasureCount_ = new MapField<int, AreaSubAreaCompleteCount>();

	public const int CharacterKillMonsterInAirCountFieldNumber = 45;

	private static readonly MapField<int, int>.Codec _map_characterKillMonsterInAirCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 362u);

	private readonly MapField<int, int> characterKillMonsterInAirCount_ = new MapField<int, int>();

	public const int KillMonsterPointCountFieldNumber = 46;

	private static readonly MapField<int, int>.Codec _map_killMonsterPointCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 370u);

	private readonly MapField<int, int> killMonsterPointCount_ = new MapField<int, int>();

	public const int UnlockXinxiangSkillCountFieldNumber = 47;

	private static readonly MapField<int, int>.Codec _map_unlockXinxiangSkillCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 378u);

	private readonly MapField<int, int> unlockXinxiangSkillCount_ = new MapField<int, int>();

	public const int PlayerDeadByMonsterPointIDFieldNumber = 48;

	private static readonly MapField<int, int>.Codec _map_playerDeadByMonsterPointID_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 386u);

	private readonly MapField<int, int> playerDeadByMonsterPointID_ = new MapField<int, int>();

	public const int GiftToCharacterCountFieldNumber = 49;

	private static readonly MapField<int, int>.Codec _map_giftToCharacterCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 394u);

	private readonly MapField<int, int> giftToCharacterCount_ = new MapField<int, int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AchievementInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[222];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int MaximumWorldLevel
	{
		get
		{
			return maximumWorldLevel_;
		}
		set
		{
			maximumWorldLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> CompletedMissions => completedMissions_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> GotItems => gotItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ItemQualityCount> GotItemsWithQuality => gotItemsWithQuality_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> LevelWeapons => levelWeapons_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> FightTypeCount => fightTypeCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> ConversationKeyPoints => conversationKeyPoints_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> CountDatas => countDatas_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> CompletedAbyssStages => completedAbyssStages_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> CompletedRaidTypeCount => completedRaidTypeCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> ConversationOptionInfo => conversationOptionInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> GotWeapons => gotWeapons_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> OpenedTreasureChest => openedTreasureChest_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> BossKillTime => bossKillTime_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> ActivityLoginDay => activityLoginDay_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> UseItems => useItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> TiggerInteraction => tiggerInteraction_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> PassRaidByIdCount => passRaidByIdCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> PassRaidByMarkCount => passRaidByMarkCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> PassRaidByEntranceCount => passRaidByEntranceCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> CharacterLevelUpSkillCount => characterLevelUpSkillCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> CharacterEliteMaximumHistoryLevel => characterEliteMaximumHistoryLevel_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> LevelUpCharacters => levelUpCharacters_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ChapterRaidPassCount> ChapterRaidPassCount => chapterRaidPassCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> CompletedAbyssStagesByStars => completedAbyssStagesByStars_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> ShopBuyCount => shopBuyCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> UseSkillCount => useSkillCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> KillMonsterIDCount => killMonsterIDCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> OpenSubareaMajorBeacon => openSubareaMajorBeacon_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, SubareaMajorBeaconCount> OpenWeberCabin => openWeberCabin_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> AreaVisited => areaVisited_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, InteractByItemType> InteractByAreaAndType => interactByAreaAndType_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, CharacterKilledMonsterCount> CharacterKilledMonsterCount => characterKilledMonsterCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> DamageOnceMaximumByType => damageOnceMaximumByType_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> DamageTotalByType => damageTotalByType_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, GachaCharacterQualityCompleteCount> GachaTenPullCharacterQualityCount => gachaTenPullCharacterQualityCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> GachaSinglePullCharacterQualityCount => gachaSinglePullCharacterQualityCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> NpcInteracted => npcInteracted_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> InteractByItemID => interactByItemID_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> RoguelikeDifficultyPassCount => roguelikeDifficultyPassCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> OpenStoneTablet => openStoneTablet_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, AreaSubAreaCompleteCount> CompleteTreasureDecryptCount => completeTreasureDecryptCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, AreaSubAreaCompleteCount> CompleteLimitTimeTreasureCount => completeLimitTimeTreasureCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> CharacterKillMonsterInAirCount => characterKillMonsterInAirCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> KillMonsterPointCount => killMonsterPointCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> UnlockXinxiangSkillCount => unlockXinxiangSkillCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> PlayerDeadByMonsterPointID => playerDeadByMonsterPointID_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> GiftToCharacterCount => giftToCharacterCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementInfo(AchievementInfo other)
		: this()
	{
		maximumWorldLevel_ = other.maximumWorldLevel_;
		completedMissions_ = other.completedMissions_.Clone();
		gotItems_ = other.gotItems_.Clone();
		gotItemsWithQuality_ = other.gotItemsWithQuality_.Clone();
		levelWeapons_ = other.levelWeapons_.Clone();
		fightTypeCount_ = other.fightTypeCount_.Clone();
		conversationKeyPoints_ = other.conversationKeyPoints_.Clone();
		countDatas_ = other.countDatas_.Clone();
		completedAbyssStages_ = other.completedAbyssStages_.Clone();
		completedRaidTypeCount_ = other.completedRaidTypeCount_.Clone();
		conversationOptionInfo_ = other.conversationOptionInfo_.Clone();
		gotWeapons_ = other.gotWeapons_.Clone();
		openedTreasureChest_ = other.openedTreasureChest_.Clone();
		bossKillTime_ = other.bossKillTime_.Clone();
		activityLoginDay_ = other.activityLoginDay_.Clone();
		useItems_ = other.useItems_.Clone();
		tiggerInteraction_ = other.tiggerInteraction_.Clone();
		passRaidByIdCount_ = other.passRaidByIdCount_.Clone();
		passRaidByMarkCount_ = other.passRaidByMarkCount_.Clone();
		passRaidByEntranceCount_ = other.passRaidByEntranceCount_.Clone();
		characterLevelUpSkillCount_ = other.characterLevelUpSkillCount_.Clone();
		characterEliteMaximumHistoryLevel_ = other.characterEliteMaximumHistoryLevel_.Clone();
		levelUpCharacters_ = other.levelUpCharacters_.Clone();
		chapterRaidPassCount_ = other.chapterRaidPassCount_.Clone();
		completedAbyssStagesByStars_ = other.completedAbyssStagesByStars_.Clone();
		shopBuyCount_ = other.shopBuyCount_.Clone();
		useSkillCount_ = other.useSkillCount_.Clone();
		killMonsterIDCount_ = other.killMonsterIDCount_.Clone();
		openSubareaMajorBeacon_ = other.openSubareaMajorBeacon_.Clone();
		openWeberCabin_ = other.openWeberCabin_.Clone();
		areaVisited_ = other.areaVisited_.Clone();
		interactByAreaAndType_ = other.interactByAreaAndType_.Clone();
		characterKilledMonsterCount_ = other.characterKilledMonsterCount_.Clone();
		damageOnceMaximumByType_ = other.damageOnceMaximumByType_.Clone();
		damageTotalByType_ = other.damageTotalByType_.Clone();
		gachaTenPullCharacterQualityCount_ = other.gachaTenPullCharacterQualityCount_.Clone();
		gachaSinglePullCharacterQualityCount_ = other.gachaSinglePullCharacterQualityCount_.Clone();
		npcInteracted_ = other.npcInteracted_.Clone();
		interactByItemID_ = other.interactByItemID_.Clone();
		roguelikeDifficultyPassCount_ = other.roguelikeDifficultyPassCount_.Clone();
		openStoneTablet_ = other.openStoneTablet_.Clone();
		completeTreasureDecryptCount_ = other.completeTreasureDecryptCount_.Clone();
		completeLimitTimeTreasureCount_ = other.completeLimitTimeTreasureCount_.Clone();
		characterKillMonsterInAirCount_ = other.characterKillMonsterInAirCount_.Clone();
		killMonsterPointCount_ = other.killMonsterPointCount_.Clone();
		unlockXinxiangSkillCount_ = other.unlockXinxiangSkillCount_.Clone();
		playerDeadByMonsterPointID_ = other.playerDeadByMonsterPointID_.Clone();
		giftToCharacterCount_ = other.giftToCharacterCount_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementInfo Clone()
	{
		return new AchievementInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AchievementInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AchievementInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (MaximumWorldLevel != other.MaximumWorldLevel)
		{
			return false;
		}
		if (!CompletedMissions.Equals(other.CompletedMissions))
		{
			return false;
		}
		if (!GotItems.Equals(other.GotItems))
		{
			return false;
		}
		if (!GotItemsWithQuality.Equals(other.GotItemsWithQuality))
		{
			return false;
		}
		if (!LevelWeapons.Equals(other.LevelWeapons))
		{
			return false;
		}
		if (!FightTypeCount.Equals(other.FightTypeCount))
		{
			return false;
		}
		if (!ConversationKeyPoints.Equals(other.ConversationKeyPoints))
		{
			return false;
		}
		if (!CountDatas.Equals(other.CountDatas))
		{
			return false;
		}
		if (!CompletedAbyssStages.Equals(other.CompletedAbyssStages))
		{
			return false;
		}
		if (!CompletedRaidTypeCount.Equals(other.CompletedRaidTypeCount))
		{
			return false;
		}
		if (!ConversationOptionInfo.Equals(other.ConversationOptionInfo))
		{
			return false;
		}
		if (!GotWeapons.Equals(other.GotWeapons))
		{
			return false;
		}
		if (!OpenedTreasureChest.Equals(other.OpenedTreasureChest))
		{
			return false;
		}
		if (!BossKillTime.Equals(other.BossKillTime))
		{
			return false;
		}
		if (!ActivityLoginDay.Equals(other.ActivityLoginDay))
		{
			return false;
		}
		if (!UseItems.Equals(other.UseItems))
		{
			return false;
		}
		if (!TiggerInteraction.Equals(other.TiggerInteraction))
		{
			return false;
		}
		if (!PassRaidByIdCount.Equals(other.PassRaidByIdCount))
		{
			return false;
		}
		if (!PassRaidByMarkCount.Equals(other.PassRaidByMarkCount))
		{
			return false;
		}
		if (!PassRaidByEntranceCount.Equals(other.PassRaidByEntranceCount))
		{
			return false;
		}
		if (!CharacterLevelUpSkillCount.Equals(other.CharacterLevelUpSkillCount))
		{
			return false;
		}
		if (!CharacterEliteMaximumHistoryLevel.Equals(other.CharacterEliteMaximumHistoryLevel))
		{
			return false;
		}
		if (!LevelUpCharacters.Equals(other.LevelUpCharacters))
		{
			return false;
		}
		if (!ChapterRaidPassCount.Equals(other.ChapterRaidPassCount))
		{
			return false;
		}
		if (!CompletedAbyssStagesByStars.Equals(other.CompletedAbyssStagesByStars))
		{
			return false;
		}
		if (!ShopBuyCount.Equals(other.ShopBuyCount))
		{
			return false;
		}
		if (!UseSkillCount.Equals(other.UseSkillCount))
		{
			return false;
		}
		if (!KillMonsterIDCount.Equals(other.KillMonsterIDCount))
		{
			return false;
		}
		if (!OpenSubareaMajorBeacon.Equals(other.OpenSubareaMajorBeacon))
		{
			return false;
		}
		if (!OpenWeberCabin.Equals(other.OpenWeberCabin))
		{
			return false;
		}
		if (!AreaVisited.Equals(other.AreaVisited))
		{
			return false;
		}
		if (!InteractByAreaAndType.Equals(other.InteractByAreaAndType))
		{
			return false;
		}
		if (!CharacterKilledMonsterCount.Equals(other.CharacterKilledMonsterCount))
		{
			return false;
		}
		if (!DamageOnceMaximumByType.Equals(other.DamageOnceMaximumByType))
		{
			return false;
		}
		if (!DamageTotalByType.Equals(other.DamageTotalByType))
		{
			return false;
		}
		if (!GachaTenPullCharacterQualityCount.Equals(other.GachaTenPullCharacterQualityCount))
		{
			return false;
		}
		if (!GachaSinglePullCharacterQualityCount.Equals(other.GachaSinglePullCharacterQualityCount))
		{
			return false;
		}
		if (!NpcInteracted.Equals(other.NpcInteracted))
		{
			return false;
		}
		if (!InteractByItemID.Equals(other.InteractByItemID))
		{
			return false;
		}
		if (!RoguelikeDifficultyPassCount.Equals(other.RoguelikeDifficultyPassCount))
		{
			return false;
		}
		if (!OpenStoneTablet.Equals(other.OpenStoneTablet))
		{
			return false;
		}
		if (!CompleteTreasureDecryptCount.Equals(other.CompleteTreasureDecryptCount))
		{
			return false;
		}
		if (!CompleteLimitTimeTreasureCount.Equals(other.CompleteLimitTimeTreasureCount))
		{
			return false;
		}
		if (!CharacterKillMonsterInAirCount.Equals(other.CharacterKillMonsterInAirCount))
		{
			return false;
		}
		if (!KillMonsterPointCount.Equals(other.KillMonsterPointCount))
		{
			return false;
		}
		if (!UnlockXinxiangSkillCount.Equals(other.UnlockXinxiangSkillCount))
		{
			return false;
		}
		if (!PlayerDeadByMonsterPointID.Equals(other.PlayerDeadByMonsterPointID))
		{
			return false;
		}
		if (!GiftToCharacterCount.Equals(other.GiftToCharacterCount))
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
		if (MaximumWorldLevel != 0)
		{
			num ^= MaximumWorldLevel.GetHashCode();
		}
		num ^= CompletedMissions.GetHashCode();
		num ^= GotItems.GetHashCode();
		num ^= GotItemsWithQuality.GetHashCode();
		num ^= LevelWeapons.GetHashCode();
		num ^= FightTypeCount.GetHashCode();
		num ^= ConversationKeyPoints.GetHashCode();
		num ^= CountDatas.GetHashCode();
		num ^= CompletedAbyssStages.GetHashCode();
		num ^= CompletedRaidTypeCount.GetHashCode();
		num ^= ConversationOptionInfo.GetHashCode();
		num ^= GotWeapons.GetHashCode();
		num ^= OpenedTreasureChest.GetHashCode();
		num ^= BossKillTime.GetHashCode();
		num ^= ActivityLoginDay.GetHashCode();
		num ^= UseItems.GetHashCode();
		num ^= TiggerInteraction.GetHashCode();
		num ^= PassRaidByIdCount.GetHashCode();
		num ^= PassRaidByMarkCount.GetHashCode();
		num ^= PassRaidByEntranceCount.GetHashCode();
		num ^= CharacterLevelUpSkillCount.GetHashCode();
		num ^= CharacterEliteMaximumHistoryLevel.GetHashCode();
		num ^= LevelUpCharacters.GetHashCode();
		num ^= ChapterRaidPassCount.GetHashCode();
		num ^= CompletedAbyssStagesByStars.GetHashCode();
		num ^= ShopBuyCount.GetHashCode();
		num ^= UseSkillCount.GetHashCode();
		num ^= KillMonsterIDCount.GetHashCode();
		num ^= OpenSubareaMajorBeacon.GetHashCode();
		num ^= OpenWeberCabin.GetHashCode();
		num ^= AreaVisited.GetHashCode();
		num ^= InteractByAreaAndType.GetHashCode();
		num ^= CharacterKilledMonsterCount.GetHashCode();
		num ^= DamageOnceMaximumByType.GetHashCode();
		num ^= DamageTotalByType.GetHashCode();
		num ^= GachaTenPullCharacterQualityCount.GetHashCode();
		num ^= GachaSinglePullCharacterQualityCount.GetHashCode();
		num ^= NpcInteracted.GetHashCode();
		num ^= InteractByItemID.GetHashCode();
		num ^= RoguelikeDifficultyPassCount.GetHashCode();
		num ^= OpenStoneTablet.GetHashCode();
		num ^= CompleteTreasureDecryptCount.GetHashCode();
		num ^= CompleteLimitTimeTreasureCount.GetHashCode();
		num ^= CharacterKillMonsterInAirCount.GetHashCode();
		num ^= KillMonsterPointCount.GetHashCode();
		num ^= UnlockXinxiangSkillCount.GetHashCode();
		num ^= PlayerDeadByMonsterPointID.GetHashCode();
		num ^= GiftToCharacterCount.GetHashCode();
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
		if (MaximumWorldLevel != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(MaximumWorldLevel);
		}
		completedMissions_.WriteTo(ref output, _map_completedMissions_codec);
		gotItems_.WriteTo(ref output, _map_gotItems_codec);
		gotItemsWithQuality_.WriteTo(ref output, _map_gotItemsWithQuality_codec);
		levelWeapons_.WriteTo(ref output, _map_levelWeapons_codec);
		fightTypeCount_.WriteTo(ref output, _map_fightTypeCount_codec);
		conversationKeyPoints_.WriteTo(ref output, _map_conversationKeyPoints_codec);
		countDatas_.WriteTo(ref output, _map_countDatas_codec);
		completedAbyssStages_.WriteTo(ref output, _map_completedAbyssStages_codec);
		completedRaidTypeCount_.WriteTo(ref output, _map_completedRaidTypeCount_codec);
		conversationOptionInfo_.WriteTo(ref output, _map_conversationOptionInfo_codec);
		gotWeapons_.WriteTo(ref output, _map_gotWeapons_codec);
		openedTreasureChest_.WriteTo(ref output, _map_openedTreasureChest_codec);
		bossKillTime_.WriteTo(ref output, _map_bossKillTime_codec);
		activityLoginDay_.WriteTo(ref output, _map_activityLoginDay_codec);
		useItems_.WriteTo(ref output, _map_useItems_codec);
		tiggerInteraction_.WriteTo(ref output, _map_tiggerInteraction_codec);
		passRaidByIdCount_.WriteTo(ref output, _map_passRaidByIdCount_codec);
		passRaidByMarkCount_.WriteTo(ref output, _map_passRaidByMarkCount_codec);
		passRaidByEntranceCount_.WriteTo(ref output, _map_passRaidByEntranceCount_codec);
		characterLevelUpSkillCount_.WriteTo(ref output, _map_characterLevelUpSkillCount_codec);
		characterEliteMaximumHistoryLevel_.WriteTo(ref output, _map_characterEliteMaximumHistoryLevel_codec);
		levelUpCharacters_.WriteTo(ref output, _map_levelUpCharacters_codec);
		chapterRaidPassCount_.WriteTo(ref output, _map_chapterRaidPassCount_codec);
		completedAbyssStagesByStars_.WriteTo(ref output, _map_completedAbyssStagesByStars_codec);
		shopBuyCount_.WriteTo(ref output, _map_shopBuyCount_codec);
		useSkillCount_.WriteTo(ref output, _map_useSkillCount_codec);
		killMonsterIDCount_.WriteTo(ref output, _map_killMonsterIDCount_codec);
		openSubareaMajorBeacon_.WriteTo(ref output, _map_openSubareaMajorBeacon_codec);
		openWeberCabin_.WriteTo(ref output, _map_openWeberCabin_codec);
		areaVisited_.WriteTo(ref output, _map_areaVisited_codec);
		interactByAreaAndType_.WriteTo(ref output, _map_interactByAreaAndType_codec);
		characterKilledMonsterCount_.WriteTo(ref output, _map_characterKilledMonsterCount_codec);
		damageOnceMaximumByType_.WriteTo(ref output, _map_damageOnceMaximumByType_codec);
		damageTotalByType_.WriteTo(ref output, _map_damageTotalByType_codec);
		gachaTenPullCharacterQualityCount_.WriteTo(ref output, _map_gachaTenPullCharacterQualityCount_codec);
		gachaSinglePullCharacterQualityCount_.WriteTo(ref output, _map_gachaSinglePullCharacterQualityCount_codec);
		npcInteracted_.WriteTo(ref output, _map_npcInteracted_codec);
		interactByItemID_.WriteTo(ref output, _map_interactByItemID_codec);
		roguelikeDifficultyPassCount_.WriteTo(ref output, _map_roguelikeDifficultyPassCount_codec);
		openStoneTablet_.WriteTo(ref output, _map_openStoneTablet_codec);
		completeTreasureDecryptCount_.WriteTo(ref output, _map_completeTreasureDecryptCount_codec);
		completeLimitTimeTreasureCount_.WriteTo(ref output, _map_completeLimitTimeTreasureCount_codec);
		characterKillMonsterInAirCount_.WriteTo(ref output, _map_characterKillMonsterInAirCount_codec);
		killMonsterPointCount_.WriteTo(ref output, _map_killMonsterPointCount_codec);
		unlockXinxiangSkillCount_.WriteTo(ref output, _map_unlockXinxiangSkillCount_codec);
		playerDeadByMonsterPointID_.WriteTo(ref output, _map_playerDeadByMonsterPointID_codec);
		giftToCharacterCount_.WriteTo(ref output, _map_giftToCharacterCount_codec);
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
		if (MaximumWorldLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaximumWorldLevel);
		}
		num += completedMissions_.CalculateSize(_map_completedMissions_codec);
		num += gotItems_.CalculateSize(_map_gotItems_codec);
		num += gotItemsWithQuality_.CalculateSize(_map_gotItemsWithQuality_codec);
		num += levelWeapons_.CalculateSize(_map_levelWeapons_codec);
		num += fightTypeCount_.CalculateSize(_map_fightTypeCount_codec);
		num += conversationKeyPoints_.CalculateSize(_map_conversationKeyPoints_codec);
		num += countDatas_.CalculateSize(_map_countDatas_codec);
		num += completedAbyssStages_.CalculateSize(_map_completedAbyssStages_codec);
		num += completedRaidTypeCount_.CalculateSize(_map_completedRaidTypeCount_codec);
		num += conversationOptionInfo_.CalculateSize(_map_conversationOptionInfo_codec);
		num += gotWeapons_.CalculateSize(_map_gotWeapons_codec);
		num += openedTreasureChest_.CalculateSize(_map_openedTreasureChest_codec);
		num += bossKillTime_.CalculateSize(_map_bossKillTime_codec);
		num += activityLoginDay_.CalculateSize(_map_activityLoginDay_codec);
		num += useItems_.CalculateSize(_map_useItems_codec);
		num += tiggerInteraction_.CalculateSize(_map_tiggerInteraction_codec);
		num += passRaidByIdCount_.CalculateSize(_map_passRaidByIdCount_codec);
		num += passRaidByMarkCount_.CalculateSize(_map_passRaidByMarkCount_codec);
		num += passRaidByEntranceCount_.CalculateSize(_map_passRaidByEntranceCount_codec);
		num += characterLevelUpSkillCount_.CalculateSize(_map_characterLevelUpSkillCount_codec);
		num += characterEliteMaximumHistoryLevel_.CalculateSize(_map_characterEliteMaximumHistoryLevel_codec);
		num += levelUpCharacters_.CalculateSize(_map_levelUpCharacters_codec);
		num += chapterRaidPassCount_.CalculateSize(_map_chapterRaidPassCount_codec);
		num += completedAbyssStagesByStars_.CalculateSize(_map_completedAbyssStagesByStars_codec);
		num += shopBuyCount_.CalculateSize(_map_shopBuyCount_codec);
		num += useSkillCount_.CalculateSize(_map_useSkillCount_codec);
		num += killMonsterIDCount_.CalculateSize(_map_killMonsterIDCount_codec);
		num += openSubareaMajorBeacon_.CalculateSize(_map_openSubareaMajorBeacon_codec);
		num += openWeberCabin_.CalculateSize(_map_openWeberCabin_codec);
		num += areaVisited_.CalculateSize(_map_areaVisited_codec);
		num += interactByAreaAndType_.CalculateSize(_map_interactByAreaAndType_codec);
		num += characterKilledMonsterCount_.CalculateSize(_map_characterKilledMonsterCount_codec);
		num += damageOnceMaximumByType_.CalculateSize(_map_damageOnceMaximumByType_codec);
		num += damageTotalByType_.CalculateSize(_map_damageTotalByType_codec);
		num += gachaTenPullCharacterQualityCount_.CalculateSize(_map_gachaTenPullCharacterQualityCount_codec);
		num += gachaSinglePullCharacterQualityCount_.CalculateSize(_map_gachaSinglePullCharacterQualityCount_codec);
		num += npcInteracted_.CalculateSize(_map_npcInteracted_codec);
		num += interactByItemID_.CalculateSize(_map_interactByItemID_codec);
		num += roguelikeDifficultyPassCount_.CalculateSize(_map_roguelikeDifficultyPassCount_codec);
		num += openStoneTablet_.CalculateSize(_map_openStoneTablet_codec);
		num += completeTreasureDecryptCount_.CalculateSize(_map_completeTreasureDecryptCount_codec);
		num += completeLimitTimeTreasureCount_.CalculateSize(_map_completeLimitTimeTreasureCount_codec);
		num += characterKillMonsterInAirCount_.CalculateSize(_map_characterKillMonsterInAirCount_codec);
		num += killMonsterPointCount_.CalculateSize(_map_killMonsterPointCount_codec);
		num += unlockXinxiangSkillCount_.CalculateSize(_map_unlockXinxiangSkillCount_codec);
		num += playerDeadByMonsterPointID_.CalculateSize(_map_playerDeadByMonsterPointID_codec);
		num += giftToCharacterCount_.CalculateSize(_map_giftToCharacterCount_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AchievementInfo other)
	{
		if (other != null)
		{
			if (other.MaximumWorldLevel != 0)
			{
				MaximumWorldLevel = other.MaximumWorldLevel;
			}
			completedMissions_.Add(other.completedMissions_);
			gotItems_.Add(other.gotItems_);
			gotItemsWithQuality_.Add(other.gotItemsWithQuality_);
			levelWeapons_.Add(other.levelWeapons_);
			fightTypeCount_.Add(other.fightTypeCount_);
			conversationKeyPoints_.Add(other.conversationKeyPoints_);
			countDatas_.Add(other.countDatas_);
			completedAbyssStages_.Add(other.completedAbyssStages_);
			completedRaidTypeCount_.Add(other.completedRaidTypeCount_);
			conversationOptionInfo_.Add(other.conversationOptionInfo_);
			gotWeapons_.Add(other.gotWeapons_);
			openedTreasureChest_.Add(other.openedTreasureChest_);
			bossKillTime_.Add(other.bossKillTime_);
			activityLoginDay_.Add(other.activityLoginDay_);
			useItems_.Add(other.useItems_);
			tiggerInteraction_.Add(other.tiggerInteraction_);
			passRaidByIdCount_.Add(other.passRaidByIdCount_);
			passRaidByMarkCount_.Add(other.passRaidByMarkCount_);
			passRaidByEntranceCount_.Add(other.passRaidByEntranceCount_);
			characterLevelUpSkillCount_.Add(other.characterLevelUpSkillCount_);
			characterEliteMaximumHistoryLevel_.Add(other.characterEliteMaximumHistoryLevel_);
			levelUpCharacters_.Add(other.levelUpCharacters_);
			chapterRaidPassCount_.Add(other.chapterRaidPassCount_);
			completedAbyssStagesByStars_.Add(other.completedAbyssStagesByStars_);
			shopBuyCount_.Add(other.shopBuyCount_);
			useSkillCount_.Add(other.useSkillCount_);
			killMonsterIDCount_.Add(other.killMonsterIDCount_);
			openSubareaMajorBeacon_.Add(other.openSubareaMajorBeacon_);
			openWeberCabin_.Add(other.openWeberCabin_);
			areaVisited_.Add(other.areaVisited_);
			interactByAreaAndType_.Add(other.interactByAreaAndType_);
			characterKilledMonsterCount_.Add(other.characterKilledMonsterCount_);
			damageOnceMaximumByType_.Add(other.damageOnceMaximumByType_);
			damageTotalByType_.Add(other.damageTotalByType_);
			gachaTenPullCharacterQualityCount_.Add(other.gachaTenPullCharacterQualityCount_);
			gachaSinglePullCharacterQualityCount_.Add(other.gachaSinglePullCharacterQualityCount_);
			npcInteracted_.Add(other.npcInteracted_);
			interactByItemID_.Add(other.interactByItemID_);
			roguelikeDifficultyPassCount_.Add(other.roguelikeDifficultyPassCount_);
			openStoneTablet_.Add(other.openStoneTablet_);
			completeTreasureDecryptCount_.Add(other.completeTreasureDecryptCount_);
			completeLimitTimeTreasureCount_.Add(other.completeLimitTimeTreasureCount_);
			characterKillMonsterInAirCount_.Add(other.characterKillMonsterInAirCount_);
			killMonsterPointCount_.Add(other.killMonsterPointCount_);
			unlockXinxiangSkillCount_.Add(other.unlockXinxiangSkillCount_);
			playerDeadByMonsterPointID_.Add(other.playerDeadByMonsterPointID_);
			giftToCharacterCount_.Add(other.giftToCharacterCount_);
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
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
				MaximumWorldLevel = input.ReadInt32();
				break;
			case 18u:
				completedMissions_.AddEntriesFrom(ref input, _map_completedMissions_codec);
				break;
			case 26u:
				gotItems_.AddEntriesFrom(ref input, _map_gotItems_codec);
				break;
			case 34u:
				gotItemsWithQuality_.AddEntriesFrom(ref input, _map_gotItemsWithQuality_codec);
				break;
			case 50u:
				levelWeapons_.AddEntriesFrom(ref input, _map_levelWeapons_codec);
				break;
			case 58u:
				fightTypeCount_.AddEntriesFrom(ref input, _map_fightTypeCount_codec);
				break;
			case 66u:
				conversationKeyPoints_.AddEntriesFrom(ref input, _map_conversationKeyPoints_codec);
				break;
			case 74u:
				countDatas_.AddEntriesFrom(ref input, _map_countDatas_codec);
				break;
			case 82u:
				completedAbyssStages_.AddEntriesFrom(ref input, _map_completedAbyssStages_codec);
				break;
			case 90u:
				completedRaidTypeCount_.AddEntriesFrom(ref input, _map_completedRaidTypeCount_codec);
				break;
			case 98u:
				conversationOptionInfo_.AddEntriesFrom(ref input, _map_conversationOptionInfo_codec);
				break;
			case 106u:
				gotWeapons_.AddEntriesFrom(ref input, _map_gotWeapons_codec);
				break;
			case 114u:
				openedTreasureChest_.AddEntriesFrom(ref input, _map_openedTreasureChest_codec);
				break;
			case 122u:
				bossKillTime_.AddEntriesFrom(ref input, _map_bossKillTime_codec);
				break;
			case 130u:
				activityLoginDay_.AddEntriesFrom(ref input, _map_activityLoginDay_codec);
				break;
			case 138u:
				useItems_.AddEntriesFrom(ref input, _map_useItems_codec);
				break;
			case 146u:
				tiggerInteraction_.AddEntriesFrom(ref input, _map_tiggerInteraction_codec);
				break;
			case 154u:
				passRaidByIdCount_.AddEntriesFrom(ref input, _map_passRaidByIdCount_codec);
				break;
			case 162u:
				passRaidByMarkCount_.AddEntriesFrom(ref input, _map_passRaidByMarkCount_codec);
				break;
			case 170u:
				passRaidByEntranceCount_.AddEntriesFrom(ref input, _map_passRaidByEntranceCount_codec);
				break;
			case 178u:
				characterLevelUpSkillCount_.AddEntriesFrom(ref input, _map_characterLevelUpSkillCount_codec);
				break;
			case 186u:
				characterEliteMaximumHistoryLevel_.AddEntriesFrom(ref input, _map_characterEliteMaximumHistoryLevel_codec);
				break;
			case 194u:
				levelUpCharacters_.AddEntriesFrom(ref input, _map_levelUpCharacters_codec);
				break;
			case 202u:
				chapterRaidPassCount_.AddEntriesFrom(ref input, _map_chapterRaidPassCount_codec);
				break;
			case 210u:
				completedAbyssStagesByStars_.AddEntriesFrom(ref input, _map_completedAbyssStagesByStars_codec);
				break;
			case 218u:
				shopBuyCount_.AddEntriesFrom(ref input, _map_shopBuyCount_codec);
				break;
			case 226u:
				useSkillCount_.AddEntriesFrom(ref input, _map_useSkillCount_codec);
				break;
			case 234u:
				killMonsterIDCount_.AddEntriesFrom(ref input, _map_killMonsterIDCount_codec);
				break;
			case 242u:
				openSubareaMajorBeacon_.AddEntriesFrom(ref input, _map_openSubareaMajorBeacon_codec);
				break;
			case 250u:
				openWeberCabin_.AddEntriesFrom(ref input, _map_openWeberCabin_codec);
				break;
			case 258u:
				areaVisited_.AddEntriesFrom(ref input, _map_areaVisited_codec);
				break;
			case 266u:
				interactByAreaAndType_.AddEntriesFrom(ref input, _map_interactByAreaAndType_codec);
				break;
			case 274u:
				characterKilledMonsterCount_.AddEntriesFrom(ref input, _map_characterKilledMonsterCount_codec);
				break;
			case 282u:
				damageOnceMaximumByType_.AddEntriesFrom(ref input, _map_damageOnceMaximumByType_codec);
				break;
			case 290u:
				damageTotalByType_.AddEntriesFrom(ref input, _map_damageTotalByType_codec);
				break;
			case 298u:
				gachaTenPullCharacterQualityCount_.AddEntriesFrom(ref input, _map_gachaTenPullCharacterQualityCount_codec);
				break;
			case 306u:
				gachaSinglePullCharacterQualityCount_.AddEntriesFrom(ref input, _map_gachaSinglePullCharacterQualityCount_codec);
				break;
			case 314u:
				npcInteracted_.AddEntriesFrom(ref input, _map_npcInteracted_codec);
				break;
			case 322u:
				interactByItemID_.AddEntriesFrom(ref input, _map_interactByItemID_codec);
				break;
			case 330u:
				roguelikeDifficultyPassCount_.AddEntriesFrom(ref input, _map_roguelikeDifficultyPassCount_codec);
				break;
			case 338u:
				openStoneTablet_.AddEntriesFrom(ref input, _map_openStoneTablet_codec);
				break;
			case 346u:
				completeTreasureDecryptCount_.AddEntriesFrom(ref input, _map_completeTreasureDecryptCount_codec);
				break;
			case 354u:
				completeLimitTimeTreasureCount_.AddEntriesFrom(ref input, _map_completeLimitTimeTreasureCount_codec);
				break;
			case 362u:
				characterKillMonsterInAirCount_.AddEntriesFrom(ref input, _map_characterKillMonsterInAirCount_codec);
				break;
			case 370u:
				killMonsterPointCount_.AddEntriesFrom(ref input, _map_killMonsterPointCount_codec);
				break;
			case 378u:
				unlockXinxiangSkillCount_.AddEntriesFrom(ref input, _map_unlockXinxiangSkillCount_codec);
				break;
			case 386u:
				playerDeadByMonsterPointID_.AddEntriesFrom(ref input, _map_playerDeadByMonsterPointID_codec);
				break;
			case 394u:
				giftToCharacterCount_.AddEntriesFrom(ref input, _map_giftToCharacterCount_codec);
				break;
			}
		}
	}
}
