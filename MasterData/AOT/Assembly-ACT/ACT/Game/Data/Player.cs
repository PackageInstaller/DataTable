using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Diagnostics;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI;
using Fundamental;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;
using Pb;
using UnityEngine;

namespace ACT.Game.Data;

public sealed class Player : IMessage<Player>, IMessage, IEquatable<Player>, IDeepCloneable<Player>, IBufferMessage
{
	public struct PlayerExpData
	{
		public int beforeLevel;

		public int curLevel;

		public int addExp;

		public int beforeExp;

		public int currentExp;

		public int totleExp;
	}

	private static readonly MessageParser<Player> _parser = new MessageParser<Player>(() => new Player());

	private UnknownFieldSet _unknownFields;

	public const int ProfileFieldNumber = 1;

	private PlayerProfile profile_;

	public const int InventoryFieldNumber = 3;

	private Inventory inventory_;

	public const int MissionsFieldNumber = 4;

	private static readonly FieldCodec<MissionState> _repeated_missions_codec = FieldCodec.ForMessage(34u, MissionState.Parser);

	private readonly RepeatedField<MissionState> missions_ = new RepeatedField<MissionState>();

	public const int HandbooksFieldNumber = 5;

	private static readonly FieldCodec<HandbookInfo> _repeated_handbooks_codec = FieldCodec.ForMessage(42u, HandbookInfo.Parser);

	private readonly RepeatedField<HandbookInfo> handbooks_ = new RepeatedField<HandbookInfo>();

	public const int NpcsFieldNumber = 6;

	private static readonly FieldCodec<NPCInfo> _repeated_npcs_codec = FieldCodec.ForMessage(50u, NPCInfo.Parser);

	private readonly RepeatedField<NPCInfo> npcs_ = new RepeatedField<NPCInfo>();

	public const int RobotsFieldNumber = 7;

	private static readonly FieldCodec<Assist> _repeated_robots_codec = FieldCodec.ForMessage(58u, Assist.Parser);

	private readonly RepeatedField<Assist> robots_ = new RepeatedField<Assist>();

	public const int MapsFieldNumber = 8;

	private static readonly MapField<int, Map>.Codec _map_maps_codec = new MapField<int, Map>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Map.Parser), 66u);

	private readonly MapField<int, Map> maps_ = new MapField<int, Map>();

	public const int OpenSystemsFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_openSystems_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> openSystems_ = new RepeatedField<int>();

	public const int TakeRewardLevelsFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_takeRewardLevels_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> takeRewardLevels_ = new RepeatedField<int>();

	public const int RaidInfosFieldNumber = 11;

	private static readonly MapField<int, Raid>.Codec _map_raidInfos_codec = new MapField<int, Raid>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Raid.Parser), 90u);

	private readonly MapField<int, Raid> raidInfos_ = new MapField<int, Raid>();

	public const int ShopInfosFieldNumber = 12;

	private static readonly MapField<int, Shop>.Codec _map_shopInfos_codec = new MapField<int, Shop>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Shop.Parser), 98u);

	private readonly MapField<int, Shop> shopInfos_ = new MapField<int, Shop>();

	public const int AbyssInfoFieldNumber = 13;

	private Abyss abyssInfo_;

	public const int MailInfosFieldNumber = 14;

	private static readonly FieldCodec<Mail> _repeated_mailInfos_codec = FieldCodec.ForMessage(114u, Mail.Parser);

	private readonly RepeatedField<Mail> mailInfos_ = new RepeatedField<Mail>();

	public const int LockMailTemplateIDsFieldNumber = 15;

	private static readonly FieldCodec<int> _repeated_lockMailTemplateIDs_codec = FieldCodec.ForInt32(122u);

	private readonly RepeatedField<int> lockMailTemplateIDs_ = new RepeatedField<int>();

	public const int AchievementsFieldNumber = 16;

	private Achievements achievements_;

	public const int CookFieldNumber = 17;

	private Cook cook_;

	public const int RaidIdFieldNumber = 18;

	private int raidId_;

	public const int GotItemsFieldNumber = 19;

	private static readonly MapField<int, bool>.Codec _map_gotItems_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 154u);

	private readonly MapField<int, bool> gotItems_ = new MapField<int, bool>();

	public const int InterfaceGuideFieldNumber = 20;

	private static readonly MapField<int, int>.Codec _map_interfaceGuide_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 162u);

	private readonly MapField<int, int> interfaceGuide_ = new MapField<int, int>();

	public const int DailyDataFieldNumber = 21;

	private DailyData dailyData_;

	public const int AnswerQuestionsFieldNumber = 22;

	private AnswerQuestions answerQuestions_;

	public const int FriendsFieldNumber = 23;

	private Friends friends_;

	public const int MapViewFieldNumber = 24;

	private MapViewInfo mapView_;

	public const int RaidMultipleFieldNumber = 25;

	private int raidMultiple_;

	public const int AssistantSystemFieldNumber = 26;

	private AssistantSystem assistantSystem_;

	public const int SystemGuideChapterFieldNumber = 27;

	private static readonly MapField<int, bool>.Codec _map_systemGuideChapter_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 218u);

	private readonly MapField<int, bool> systemGuideChapter_ = new MapField<int, bool>();

	public HashSet<int> newItem = new HashSet<int>();

	public LittleItems littleItems = new LittleItems();

	public PotionInfo bloodBottle = new PotionInfo();

	public RedPoints redPoints = new RedPoints();

	public MapField<int, bool> questionNaire = new MapField<int, bool>();

	public MapField<int, RepeatedField<ActivityGroup>> playerLevelActivity = new MapField<int, RepeatedField<ActivityGroup>>();

	public MapField<int, ActivitDoubleDungeonInfo> activitDoubleDungeonInfos = new MapField<int, ActivitDoubleDungeonInfo>();

	public MapField<int, CharacterRepository> characterRepository = new MapField<int, CharacterRepository>();

	public TeamInfo teamInfo = new TeamInfo();

	public MapField<int, DivinePupil> pupils = new MapField<int, DivinePupil>();

	public PlayerGrowthGuide growthGuide = new PlayerGrowthGuide();

	public PlayerExpData playerExpData;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Player> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[79];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public Inventory Inventory
	{
		get
		{
			return inventory_;
		}
		set
		{
			inventory_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<MissionState> Missions => missions_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<HandbookInfo> Handbooks => handbooks_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<NPCInfo> Npcs => npcs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Assist> Robots => robots_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, Map> Maps => maps_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> OpenSystems => openSystems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> TakeRewardLevels => takeRewardLevels_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, Raid> RaidInfos => raidInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, Shop> ShopInfos => shopInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Abyss AbyssInfo
	{
		get
		{
			return abyssInfo_;
		}
		set
		{
			abyssInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Mail> MailInfos => mailInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> LockMailTemplateIDs => lockMailTemplateIDs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Achievements Achievements
	{
		get
		{
			return achievements_;
		}
		set
		{
			achievements_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Cook Cook
	{
		get
		{
			return cook_;
		}
		set
		{
			cook_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int RaidId
	{
		get
		{
			return raidId_;
		}
		set
		{
			raidId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> GotItems => gotItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> InterfaceGuide => interfaceGuide_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DailyData DailyData
	{
		get
		{
			return dailyData_;
		}
		set
		{
			dailyData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AnswerQuestions AnswerQuestions
	{
		get
		{
			return answerQuestions_;
		}
		set
		{
			answerQuestions_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Friends Friends
	{
		get
		{
			return friends_;
		}
		set
		{
			friends_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewInfo MapView
	{
		get
		{
			return mapView_;
		}
		set
		{
			mapView_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int RaidMultiple
	{
		get
		{
			return raidMultiple_;
		}
		set
		{
			raidMultiple_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AssistantSystem AssistantSystem
	{
		get
		{
			return assistantSystem_;
		}
		set
		{
			assistantSystem_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> SystemGuideChapter => systemGuideChapter_;

	public bool hasInitMapView => mapView_ != null;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Player()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Player(Player other)
		: this()
	{
		profile_ = ((other.profile_ != null) ? other.profile_.Clone() : null);
		inventory_ = ((other.inventory_ != null) ? other.inventory_.Clone() : null);
		missions_ = other.missions_.Clone();
		handbooks_ = other.handbooks_.Clone();
		npcs_ = other.npcs_.Clone();
		robots_ = other.robots_.Clone();
		maps_ = other.maps_.Clone();
		openSystems_ = other.openSystems_.Clone();
		takeRewardLevels_ = other.takeRewardLevels_.Clone();
		raidInfos_ = other.raidInfos_.Clone();
		shopInfos_ = other.shopInfos_.Clone();
		abyssInfo_ = ((other.abyssInfo_ != null) ? other.abyssInfo_.Clone() : null);
		mailInfos_ = other.mailInfos_.Clone();
		lockMailTemplateIDs_ = other.lockMailTemplateIDs_.Clone();
		achievements_ = ((other.achievements_ != null) ? other.achievements_.Clone() : null);
		cook_ = ((other.cook_ != null) ? other.cook_.Clone() : null);
		raidId_ = other.raidId_;
		gotItems_ = other.gotItems_.Clone();
		interfaceGuide_ = other.interfaceGuide_.Clone();
		dailyData_ = ((other.dailyData_ != null) ? other.dailyData_.Clone() : null);
		answerQuestions_ = ((other.answerQuestions_ != null) ? other.answerQuestions_.Clone() : null);
		friends_ = ((other.friends_ != null) ? other.friends_.Clone() : null);
		mapView_ = ((other.mapView_ != null) ? other.mapView_.Clone() : null);
		raidMultiple_ = other.raidMultiple_;
		assistantSystem_ = ((other.assistantSystem_ != null) ? other.assistantSystem_.Clone() : null);
		systemGuideChapter_ = other.systemGuideChapter_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Player Clone()
	{
		return new Player(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Player);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Player other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(Profile, other.Profile))
		{
			return false;
		}
		if (!object.Equals(Inventory, other.Inventory))
		{
			return false;
		}
		if (!missions_.Equals(other.missions_))
		{
			return false;
		}
		if (!handbooks_.Equals(other.handbooks_))
		{
			return false;
		}
		if (!npcs_.Equals(other.npcs_))
		{
			return false;
		}
		if (!robots_.Equals(other.robots_))
		{
			return false;
		}
		if (!Maps.Equals(other.Maps))
		{
			return false;
		}
		if (!openSystems_.Equals(other.openSystems_))
		{
			return false;
		}
		if (!takeRewardLevels_.Equals(other.takeRewardLevels_))
		{
			return false;
		}
		if (!RaidInfos.Equals(other.RaidInfos))
		{
			return false;
		}
		if (!ShopInfos.Equals(other.ShopInfos))
		{
			return false;
		}
		if (!object.Equals(AbyssInfo, other.AbyssInfo))
		{
			return false;
		}
		if (!mailInfos_.Equals(other.mailInfos_))
		{
			return false;
		}
		if (!lockMailTemplateIDs_.Equals(other.lockMailTemplateIDs_))
		{
			return false;
		}
		if (!object.Equals(Achievements, other.Achievements))
		{
			return false;
		}
		if (!object.Equals(Cook, other.Cook))
		{
			return false;
		}
		if (RaidId != other.RaidId)
		{
			return false;
		}
		if (!GotItems.Equals(other.GotItems))
		{
			return false;
		}
		if (!InterfaceGuide.Equals(other.InterfaceGuide))
		{
			return false;
		}
		if (!object.Equals(DailyData, other.DailyData))
		{
			return false;
		}
		if (!object.Equals(AnswerQuestions, other.AnswerQuestions))
		{
			return false;
		}
		if (!object.Equals(Friends, other.Friends))
		{
			return false;
		}
		if (!object.Equals(MapView, other.MapView))
		{
			return false;
		}
		if (RaidMultiple != other.RaidMultiple)
		{
			return false;
		}
		if (!object.Equals(AssistantSystem, other.AssistantSystem))
		{
			return false;
		}
		if (!SystemGuideChapter.Equals(other.SystemGuideChapter))
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
		if (profile_ != null)
		{
			num ^= Profile.GetHashCode();
		}
		if (inventory_ != null)
		{
			num ^= Inventory.GetHashCode();
		}
		num ^= missions_.GetHashCode();
		num ^= handbooks_.GetHashCode();
		num ^= npcs_.GetHashCode();
		num ^= robots_.GetHashCode();
		num ^= Maps.GetHashCode();
		num ^= openSystems_.GetHashCode();
		num ^= takeRewardLevels_.GetHashCode();
		num ^= RaidInfos.GetHashCode();
		num ^= ShopInfos.GetHashCode();
		if (abyssInfo_ != null)
		{
			num ^= AbyssInfo.GetHashCode();
		}
		num ^= mailInfos_.GetHashCode();
		num ^= lockMailTemplateIDs_.GetHashCode();
		if (achievements_ != null)
		{
			num ^= Achievements.GetHashCode();
		}
		if (cook_ != null)
		{
			num ^= Cook.GetHashCode();
		}
		if (RaidId != 0)
		{
			num ^= RaidId.GetHashCode();
		}
		num ^= GotItems.GetHashCode();
		num ^= InterfaceGuide.GetHashCode();
		if (dailyData_ != null)
		{
			num ^= DailyData.GetHashCode();
		}
		if (answerQuestions_ != null)
		{
			num ^= AnswerQuestions.GetHashCode();
		}
		if (friends_ != null)
		{
			num ^= Friends.GetHashCode();
		}
		if (mapView_ != null)
		{
			num ^= MapView.GetHashCode();
		}
		if (RaidMultiple != 0)
		{
			num ^= RaidMultiple.GetHashCode();
		}
		if (assistantSystem_ != null)
		{
			num ^= AssistantSystem.GetHashCode();
		}
		num ^= SystemGuideChapter.GetHashCode();
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
		if (profile_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(Profile);
		}
		if (inventory_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(Inventory);
		}
		missions_.WriteTo(ref output, _repeated_missions_codec);
		handbooks_.WriteTo(ref output, _repeated_handbooks_codec);
		npcs_.WriteTo(ref output, _repeated_npcs_codec);
		robots_.WriteTo(ref output, _repeated_robots_codec);
		maps_.WriteTo(ref output, _map_maps_codec);
		openSystems_.WriteTo(ref output, _repeated_openSystems_codec);
		takeRewardLevels_.WriteTo(ref output, _repeated_takeRewardLevels_codec);
		raidInfos_.WriteTo(ref output, _map_raidInfos_codec);
		shopInfos_.WriteTo(ref output, _map_shopInfos_codec);
		if (abyssInfo_ != null)
		{
			output.WriteRawTag(106);
			output.WriteMessage(AbyssInfo);
		}
		mailInfos_.WriteTo(ref output, _repeated_mailInfos_codec);
		lockMailTemplateIDs_.WriteTo(ref output, _repeated_lockMailTemplateIDs_codec);
		if (achievements_ != null)
		{
			output.WriteRawTag(130, 1);
			output.WriteMessage(Achievements);
		}
		if (cook_ != null)
		{
			output.WriteRawTag(138, 1);
			output.WriteMessage(Cook);
		}
		if (RaidId != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(RaidId);
		}
		gotItems_.WriteTo(ref output, _map_gotItems_codec);
		interfaceGuide_.WriteTo(ref output, _map_interfaceGuide_codec);
		if (dailyData_ != null)
		{
			output.WriteRawTag(170, 1);
			output.WriteMessage(DailyData);
		}
		if (answerQuestions_ != null)
		{
			output.WriteRawTag(178, 1);
			output.WriteMessage(AnswerQuestions);
		}
		if (friends_ != null)
		{
			output.WriteRawTag(186, 1);
			output.WriteMessage(Friends);
		}
		if (mapView_ != null)
		{
			output.WriteRawTag(194, 1);
			output.WriteMessage(MapView);
		}
		if (RaidMultiple != 0)
		{
			output.WriteRawTag(200, 1);
			output.WriteInt32(RaidMultiple);
		}
		if (assistantSystem_ != null)
		{
			output.WriteRawTag(210, 1);
			output.WriteMessage(AssistantSystem);
		}
		systemGuideChapter_.WriteTo(ref output, _map_systemGuideChapter_codec);
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
		if (profile_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Profile);
		}
		if (inventory_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Inventory);
		}
		num += missions_.CalculateSize(_repeated_missions_codec);
		num += handbooks_.CalculateSize(_repeated_handbooks_codec);
		num += npcs_.CalculateSize(_repeated_npcs_codec);
		num += robots_.CalculateSize(_repeated_robots_codec);
		num += maps_.CalculateSize(_map_maps_codec);
		num += openSystems_.CalculateSize(_repeated_openSystems_codec);
		num += takeRewardLevels_.CalculateSize(_repeated_takeRewardLevels_codec);
		num += raidInfos_.CalculateSize(_map_raidInfos_codec);
		num += shopInfos_.CalculateSize(_map_shopInfos_codec);
		if (abyssInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(AbyssInfo);
		}
		num += mailInfos_.CalculateSize(_repeated_mailInfos_codec);
		num += lockMailTemplateIDs_.CalculateSize(_repeated_lockMailTemplateIDs_codec);
		if (achievements_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Achievements);
		}
		if (cook_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Cook);
		}
		if (RaidId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RaidId);
		}
		num += gotItems_.CalculateSize(_map_gotItems_codec);
		num += interfaceGuide_.CalculateSize(_map_interfaceGuide_codec);
		if (dailyData_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(DailyData);
		}
		if (answerQuestions_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(AnswerQuestions);
		}
		if (friends_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Friends);
		}
		if (mapView_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(MapView);
		}
		if (RaidMultiple != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RaidMultiple);
		}
		if (assistantSystem_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(AssistantSystem);
		}
		num += systemGuideChapter_.CalculateSize(_map_systemGuideChapter_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Player other)
	{
		if (other == null)
		{
			return;
		}
		if (other.profile_ != null)
		{
			if (profile_ == null)
			{
				Profile = new PlayerProfile();
			}
			Profile.MergeFrom(other.Profile);
		}
		if (other.inventory_ != null)
		{
			if (inventory_ == null)
			{
				Inventory = new Inventory();
			}
			Inventory.MergeFrom(other.Inventory);
		}
		missions_.Add(other.missions_);
		handbooks_.Add(other.handbooks_);
		npcs_.Add(other.npcs_);
		robots_.Add(other.robots_);
		maps_.Add(other.maps_);
		openSystems_.Add(other.openSystems_);
		takeRewardLevels_.Add(other.takeRewardLevels_);
		raidInfos_.Add(other.raidInfos_);
		shopInfos_.Add(other.shopInfos_);
		if (other.abyssInfo_ != null)
		{
			if (abyssInfo_ == null)
			{
				AbyssInfo = new Abyss();
			}
			AbyssInfo.MergeFrom(other.AbyssInfo);
		}
		mailInfos_.Add(other.mailInfos_);
		lockMailTemplateIDs_.Add(other.lockMailTemplateIDs_);
		if (other.achievements_ != null)
		{
			if (achievements_ == null)
			{
				Achievements = new Achievements();
			}
			Achievements.MergeFrom(other.Achievements);
		}
		if (other.cook_ != null)
		{
			if (cook_ == null)
			{
				Cook = new Cook();
			}
			Cook.MergeFrom(other.Cook);
		}
		if (other.RaidId != 0)
		{
			RaidId = other.RaidId;
		}
		gotItems_.Add(other.gotItems_);
		interfaceGuide_.Add(other.interfaceGuide_);
		if (other.dailyData_ != null)
		{
			if (dailyData_ == null)
			{
				DailyData = new DailyData();
			}
			DailyData.MergeFrom(other.DailyData);
		}
		if (other.answerQuestions_ != null)
		{
			if (answerQuestions_ == null)
			{
				AnswerQuestions = new AnswerQuestions();
			}
			AnswerQuestions.MergeFrom(other.AnswerQuestions);
		}
		if (other.friends_ != null)
		{
			if (friends_ == null)
			{
				Friends = new Friends();
			}
			Friends.MergeFrom(other.Friends);
		}
		if (other.mapView_ != null)
		{
			if (mapView_ == null)
			{
				MapView = new MapViewInfo();
			}
			MapView.MergeFrom(other.MapView);
		}
		if (other.RaidMultiple != 0)
		{
			RaidMultiple = other.RaidMultiple;
		}
		if (other.assistantSystem_ != null)
		{
			if (assistantSystem_ == null)
			{
				AssistantSystem = new AssistantSystem();
			}
			AssistantSystem.MergeFrom(other.AssistantSystem);
		}
		systemGuideChapter_.Add(other.systemGuideChapter_);
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
			case 10u:
				if (profile_ == null)
				{
					Profile = new PlayerProfile();
				}
				input.ReadMessage(Profile);
				break;
			case 26u:
				if (inventory_ == null)
				{
					Inventory = new Inventory();
				}
				input.ReadMessage(Inventory);
				break;
			case 34u:
				missions_.AddEntriesFrom(ref input, _repeated_missions_codec);
				break;
			case 42u:
				handbooks_.AddEntriesFrom(ref input, _repeated_handbooks_codec);
				break;
			case 50u:
				npcs_.AddEntriesFrom(ref input, _repeated_npcs_codec);
				break;
			case 58u:
				robots_.AddEntriesFrom(ref input, _repeated_robots_codec);
				break;
			case 66u:
				maps_.AddEntriesFrom(ref input, _map_maps_codec);
				break;
			case 72u:
			case 74u:
				openSystems_.AddEntriesFrom(ref input, _repeated_openSystems_codec);
				break;
			case 80u:
			case 82u:
				takeRewardLevels_.AddEntriesFrom(ref input, _repeated_takeRewardLevels_codec);
				break;
			case 90u:
				raidInfos_.AddEntriesFrom(ref input, _map_raidInfos_codec);
				break;
			case 98u:
				shopInfos_.AddEntriesFrom(ref input, _map_shopInfos_codec);
				break;
			case 106u:
				if (abyssInfo_ == null)
				{
					AbyssInfo = new Abyss();
				}
				input.ReadMessage(AbyssInfo);
				break;
			case 114u:
				mailInfos_.AddEntriesFrom(ref input, _repeated_mailInfos_codec);
				break;
			case 120u:
			case 122u:
				lockMailTemplateIDs_.AddEntriesFrom(ref input, _repeated_lockMailTemplateIDs_codec);
				break;
			case 130u:
				if (achievements_ == null)
				{
					Achievements = new Achievements();
				}
				input.ReadMessage(Achievements);
				break;
			case 138u:
				if (cook_ == null)
				{
					Cook = new Cook();
				}
				input.ReadMessage(Cook);
				break;
			case 144u:
				RaidId = input.ReadInt32();
				break;
			case 154u:
				gotItems_.AddEntriesFrom(ref input, _map_gotItems_codec);
				break;
			case 162u:
				interfaceGuide_.AddEntriesFrom(ref input, _map_interfaceGuide_codec);
				break;
			case 170u:
				if (dailyData_ == null)
				{
					DailyData = new DailyData();
				}
				input.ReadMessage(DailyData);
				break;
			case 178u:
				if (answerQuestions_ == null)
				{
					AnswerQuestions = new AnswerQuestions();
				}
				input.ReadMessage(AnswerQuestions);
				break;
			case 186u:
				if (friends_ == null)
				{
					Friends = new Friends();
				}
				input.ReadMessage(Friends);
				break;
			case 194u:
				if (mapView_ == null)
				{
					MapView = new MapViewInfo();
				}
				input.ReadMessage(MapView);
				break;
			case 200u:
				RaidMultiple = input.ReadInt32();
				break;
			case 210u:
				if (assistantSystem_ == null)
				{
					AssistantSystem = new AssistantSystem();
				}
				input.ReadMessage(AssistantSystem);
				break;
			case 218u:
				systemGuideChapter_.AddEntriesFrom(ref input, _map_systemGuideChapter_codec);
				break;
			}
		}
	}

	public bool TryGetMission(int missionId, out MissionState mission)
	{
		for (int i = 0; i < Missions.Count; i++)
		{
			if (Missions[i].Id == missionId)
			{
				mission = Missions[i];
				return true;
			}
		}
		mission = null;
		return false;
	}

	public bool SubTryGetMission(int missionId, out MissionState mission)
	{
		for (int i = 0; i < Missions.Count; i++)
		{
			if (Missions[i].SubMissionId == missionId)
			{
				mission = Missions[i];
				return true;
			}
		}
		mission = null;
		return false;
	}

	public Vector3 GetLastPos(SceneStatus sceneType = SceneStatus.Main)
	{
		if (!Profile.SceneInfos.ContainsKey((int)sceneType))
		{
			return Vector3.zero;
		}
		return Profile.SceneInfos[(int)sceneType].LastPos?.ToUnity() ?? Vector3.zero;
	}

	public Vector3 GetSpawnPos(SceneStatus sceneType = SceneStatus.Main)
	{
		SceneSpawnInfo spawnInfo = Profile.SceneInfos[(int)sceneType].SpawnInfo;
		if (spawnInfo != null)
		{
			return spawnInfo.Pos?.ToUnity() ?? Vector3.zero;
		}
		return Vector3.zero;
	}

	public int GetSpawnChunkId(SceneStatus sceneType = SceneStatus.Main)
	{
		return Profile.SceneInfos[(int)sceneType].SpawnInfo?.ChunkID ?? Profile.SceneInfos[(int)sceneType].ChunkID;
	}

	public Vector3 GetTmpArchivePos(SceneStatus sceneType = SceneStatus.Main)
	{
		return Profile.SceneInfos[(int)sceneType].TmpArchiveInfo?.Pos.ToUnity() ?? Vector3.zero;
	}

	public NPCInfo GetNPCInfo(int npcId)
	{
		return Npcs.Find((NPCInfo x) => x.NpcId == npcId);
	}

	public int GetCountById(int itemid)
	{
		ItemData data = CoreUtils.GetData(itemid, RuntimeConfigs.data.itemDatas);
		if (data != null)
		{
			if (data.type == 999)
			{
				G.detailUserInfo.Attributes.TryGetValue(itemid, out var value);
				return (int)value;
			}
			return G.localPlayer.Inventory.GetItemCount(itemid);
		}
		return 0;
	}

	public Character GetCharacter(int characterId)
	{
		return CharacterDataHelper.GetCurCharacterByCharacterId(characterId);
	}

	public Character GetBagCharacter(int characterId)
	{
		CharacterDataHelper.TryGetBagCharacterById(characterId, out var character);
		return character;
	}

	public Character GetCharacterByCharacterIndentify(int characterId, CharacterIdentify characterIdentify)
	{
		if (characterId != 0)
		{
			Character character = null;
			character = G.localPlayer.characterRepository[characterIdentify.SceneStatusIndex].Characters[characterId];
			if (character == null)
			{
				character = G.localPlayer.characterRepository[characterIdentify.SceneStatusIndex].ExtraCharacters[characterId];
			}
			return character;
		}
		return null;
	}

	public Assist GetAssist(int assistId)
	{
		return Robots.Find((Assist x) => x.Id == assistId);
	}

	public bool RaidHasFirstCompleted(int raidId)
	{
		if (raidInfos_.TryGetValue(raidId, out var value))
		{
			return value.CleanNum > 0;
		}
		return false;
	}

	public int GuideHasTriggered(int guideId)
	{
		interfaceGuide_.TryGetValue(guideId, out var value);
		return value;
	}

	public void ApplyChanges(TeamInfoNtf team, bool reset)
	{
		if (team == null || team.TeamInfo == null || reset)
		{
			return;
		}
		teamInfo = team.TeamInfo;
		foreach (KeyValuePair<int, CharacterRepository> item in team.TeamInfo.CharacterRepository)
		{
			CharacterRepositoryModel.SetCharacterRepository(item.Key, item.Value);
		}
	}

	public void ApplyChanges(MapCustomFlagNtf mapCustomFlagNtf, bool reset)
	{
	}

	public void ApplyChanges(LightedMapBlocksNtf lightedMapBlocksNtf, bool reset)
	{
		Map orCreateMap = GetOrCreateMap(lightedMapBlocksNtf.Wid, reset);
		foreach (int id in lightedMapBlocksNtf.Ids)
		{
			orCreateMap.LightedMapBlocks.TryAdd(id, value: true);
		}
	}

	private Map GetOrCreateMap(int wid, bool reset)
	{
		if (!G.localPlayer.Maps.TryGetValue(wid, out var value))
		{
			value = new Map();
			value.Wid = wid;
			G.localPlayer.Maps.Add(wid, value);
		}
		return value;
	}

	public void ApplyChanges(ServiceSaveStateNtf serviceSaveStateNtf, bool reset)
	{
		Map orCreateMap = GetOrCreateMap(serviceSaveStateNtf.Wid, reset);
		foreach (ServiceSaveState change in serviceSaveStateNtf.Changes)
		{
			orCreateMap.ServiceSaveStateIds[change.Uid] = change.StateId;
			orCreateMap.ServiceBehaveIds[change.Uid] = change.BehaveId;
			orCreateMap.ServiceCleanedTs[change.Uid] = change.CleanedTs;
		}
	}

	public void ApplyChanges(ServiceBehaveNtf serviceBehaveNtf, bool reset)
	{
		Map orCreateMap = GetOrCreateMap(serviceBehaveNtf.Wid, reset);
		foreach (ServiceBehave change in serviceBehaveNtf.Changes)
		{
			if (!orCreateMap.ServiceBehaveIds.ContainsKey(change.Uid))
			{
				orCreateMap.ServiceBehaveIds.Add(change.Uid, change.BehaveId);
			}
			else
			{
				orCreateMap.ServiceBehaveIds[change.Uid] = change.BehaveId;
			}
		}
	}

	public void ApplyChanges(DropItemAddNtf dropItemAddNtf, bool reset)
	{
		Map orCreateMap = GetOrCreateMap(dropItemAddNtf.Wid, reset);
		foreach (DropItem ditem in dropItemAddNtf.Ditems)
		{
			if (!orCreateMap.DropItems.ContainsKey(ditem.Uid))
			{
				orCreateMap.DropItems.Add(ditem.Uid, ditem);
			}
			else
			{
				orCreateMap.DropItems[ditem.Uid] = ditem;
			}
		}
	}

	public void ApplyChanges(AssistSkinNtf assistSkinNtf, bool reset)
	{
		Robots[assistSkinNtf.Assist].Skins[assistSkinNtf.Skin.Id] = assistSkinNtf.Skin;
	}

	public void ApplyChanges(AssistNtf assistNtf, bool reset)
	{
		if (reset)
		{
			robots_.Clear();
		}
		robots_.MargeFrom(assistNtf.Changes);
	}

	public void ApplyChanges(MissionNtf missionNtf, bool reset)
	{
		if (reset)
		{
			Missions.Clear();
		}
		foreach (MissionState change in missionNtf.Mission)
		{
			int num = Missions.FindIndex((MissionState si) => si.Id == change.Id);
			if (num == -1)
			{
				change.isNew = true;
				Missions.Add(change);
			}
			else
			{
				change.isNew = false;
				Missions[num].CopyFrom(change);
			}
		}
	}

	public void ApplyChanges(HandbookInfoNtf handbook, bool reset)
	{
		if (reset)
		{
			Handbooks.Clear();
		}
		foreach (HandbookInfo change in handbook.Handbooks)
		{
			int num = Handbooks.FindIndex((HandbookInfo si) => si.Id == change.Id);
			if (num == -1)
			{
				Handbooks.Add(change);
			}
			else
			{
				Handbooks[num].CopyFrom(change);
			}
		}
	}

	public void ApplyChanges(SystemOpenNtf systemOpens, bool reset)
	{
		if (reset)
		{
			openSystems_.Clear();
		}
		foreach (int openSystem in systemOpens.OpenSystems)
		{
			if (!openSystems_.Contains(openSystem))
			{
				openSystems_.Add(openSystem);
				Singleton<SystemUnlockManager>.instance.OnSystemOpenAdd(openSystem);
			}
		}
		foreach (int readSystem in systemOpens.ReadSystems)
		{
			Singleton<SystemUnlockManager>.instance.OnSystemReadAdd(readSystem);
		}
	}

	public void ApplyChanges(SystemTakeLevelRewardNtf systemTakeLevelRewardNtf, bool reset)
	{
		if (reset)
		{
			systemGuideChapter_.Clear();
			takeRewardLevels_.Clear();
		}
		foreach (int level in systemTakeLevelRewardNtf.Levels)
		{
			if (!takeRewardLevels_.Contains(level))
			{
				takeRewardLevels_.Add(level);
			}
		}
		foreach (KeyValuePair<int, bool> item in systemTakeLevelRewardNtf.SystemGuideChapter)
		{
			if (!systemGuideChapter_.TryGetValue(item.Key, out var _))
			{
				systemGuideChapter_.Add(item.Key, item.Value);
			}
		}
	}

	public void ApplyChanges(RaidNtf raidNtf, bool reset)
	{
		if (reset)
		{
			raidInfos_.Clear();
		}
		foreach (KeyValuePair<int, Raid> raid in raidNtf.Raids)
		{
			if (!raidInfos_.ContainsKey(raid.Key))
			{
				raidInfos_.Add(raid.Key, raid.Value);
			}
			else
			{
				raidInfos_[raid.Key] = raid.Value;
			}
		}
		raidId_ = raidNtf.ChallengingRaidId;
	}

	public void ApplyChanges(ShopNtf shopNtf, bool reset)
	{
		if (reset)
		{
			ShopInfos.Clear();
		}
		foreach (KeyValuePair<int, Shop> shop in shopNtf.Shops)
		{
			ShopInfos[shop.Key] = shop.Value;
		}
	}

	public void ApplyChanges(DailyDataNtf dailyDataNtf, bool reset)
	{
		dailyData_ = dailyDataNtf.DailyData;
		Player localPlayer = G.localPlayer;
		if (localPlayer != null && localPlayer.Profile != null)
		{
			G.localPlayer.Profile.PowerDailyBuyNum = 0;
		}
	}

	public void ApplyChanges(CookNtf cookNtf, bool reset)
	{
		if (reset)
		{
			cook_ = null;
		}
		if (cook_ == null)
		{
			cook_ = cookNtf.Info.Clone();
		}
		else
		{
			cook_.CopyFrom(cookNtf.Info);
		}
	}

	public void ApplyChanges(EscAvatarNtf avatarNtf, bool reset)
	{
		Profile.EscInfo.UpdateAvatars(avatarNtf.GetAvatarIds);
	}

	public void ApplyChanges(EscAvatarFrameNtf avatarFrameNtf, bool reset)
	{
		Profile.EscInfo.UpdateAvatarFrames(avatarFrameNtf.GetAvatarFrameIds);
	}

	public void ApplyChanges(EscTitleNtf titleNtf, bool reset)
	{
		Profile.EscInfo.UpdateTitles(titleNtf.GetTitleIds);
	}

	public void ApplyChanges(MailNtf mailNtf, bool reset)
	{
		if (reset)
		{
			mailInfos_.Clear();
			lockMailTemplateIDs_.Clear();
		}
		foreach (KeyValuePair<int, Mail> mail in mailNtf.Mails)
		{
			bool flag = true;
			foreach (Mail item in mailInfos_)
			{
				if (item.Id == mail.Value.Id)
				{
					flag = false;
					break;
				}
			}
			if (flag)
			{
				mailInfos_.Add(mail.Value);
			}
			string nodeFullPath = string.Format(RedDotPathDefine.MailUnread, mail.Value.Id);
			if (!Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath))
			{
				Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath, active: false, 7004);
			}
		}
		foreach (int lockTmplId in mailNtf.LockTmplIds)
		{
			bool flag2 = true;
			foreach (int item2 in lockMailTemplateIDs_)
			{
				if (item2 == lockTmplId)
				{
					flag2 = false;
					break;
				}
			}
			if (flag2)
			{
				lockMailTemplateIDs_.Add(lockTmplId);
			}
		}
	}

	public bool ApplyChanges(AchievementNtf achievementNtf, bool reset)
	{
		if (reset)
		{
			achievements_ = null;
		}
		Achievements achievements = achievementNtf.Achievements;
		if (achievements_ == null)
		{
			achievements_ = achievements;
			return true;
		}
		achievements_.Info.CompletedMissions.MergeDictionary(achievements.Info.CompletedMissions);
		achievements_.Info.GotItems.MergeDictionary(achievements.Info.GotItems);
		MergeDictionary(achievements_.Info.GotItemsWithQuality, achievements.Info.GotItemsWithQuality);
		achievements_.Info.LevelWeapons.MergeDictionary(achievements.Info.LevelWeapons);
		achievements_.Info.CompletedRaidTypeCount.MergeDictionary(achievements.Info.CompletedRaidTypeCount);
		achievements_.Info.CountDatas.MergeDictionary(achievements.Info.CountDatas);
		achievements_.Info.CompletedAbyssStages.MergeDictionary(achievements.Info.CompletedAbyssStages);
		achievements_.Info.GotWeapons.MergeDictionary(achievements.Info.GotWeapons);
		achievements_.Info.OpenedTreasureChest.MergeDictionary(achievements.Info.OpenedTreasureChest);
		achievements_.Info.BossKillTime.MergeDictionary(achievements.Info.BossKillTime);
		achievements_.Info.ActivityLoginDay.MergeDictionary(achievements.Info.ActivityLoginDay);
		achievements_.Info.UseItems.MergeDictionary(achievements.Info.UseItems);
		achievements_.Info.TiggerInteraction.MergeDictionary(achievements.Info.TiggerInteraction);
		achievements_.Info.PassRaidByIdCount.MergeDictionary(achievements.Info.PassRaidByIdCount);
		achievements_.Info.PassRaidByMarkCount.MergeDictionary(achievements.Info.PassRaidByMarkCount);
		achievements_.Info.PassRaidByEntranceCount.MergeDictionary(achievements.Info.PassRaidByEntranceCount);
		return false;
	}

	public void ApplyChanges(ItemGotLogsNtf itemGotLogsNtf, bool reset)
	{
		gotItems_.MergeDictionary(itemGotLogsNtf.ItemGotLogs.GotItems);
	}

	public void ApplyChanges(GuideLogsNtf guideLogsNtf, bool reset)
	{
		if (reset)
		{
			interfaceGuide_.Clear();
		}
		interfaceGuide_.MergeDictionary(guideLogsNtf.GuideLogs.InterfaceGuide);
	}

	public void ApplyChanges(MapViewNtf mapViewNtf, bool reset)
	{
		mapView_ = mapViewNtf.MapView;
	}

	public void ApplyChanges(LittleItemsNtf littleItemNtf, bool reset)
	{
		if (reset)
		{
			littleItems = new LittleItems();
		}
		littleItems.MergeFrom(littleItemNtf.LittleItems);
	}

	public void ApplyChanges(PotionInfoNtf bloodBottleNtf, bool reset)
	{
		if (reset)
		{
			bloodBottle = new PotionInfo();
		}
		bloodBottle.MergeFrom(bloodBottleNtf.PotionInfo);
	}

	public void ApplyChanges(RedPointNtf redPointNtf, bool reset)
	{
		if (reset)
		{
			redPoints = new RedPoints();
		}
		redPoints.Missions.MergeDictionary(redPointNtf.Info.Missions);
		redPoints.Items.MergeDictionary(redPointNtf.Info.Items);
		redPoints.CustomerComplaint.MergeDictionary(redPointNtf.Info.CustomerComplaint);
		redPoints.Activitys.MergeDictionary(redPointNtf.Info.Activitys);
		redPoints.Characters.MergeDictionary(redPointNtf.Info.Characters);
		redPoints.ActivityChallenges.MergeDictionary(redPointNtf.Info.ActivityChallenges);
		redPoints.Systems.MergeDictionary(redPointNtf.Info.Systems);
		redPoints.RaidRate.MergeDictionary(redPointNtf.Info.RaidRate);
		redPoints.BattlePass.MergeDictionary(redPointNtf.Info.BattlePass);
		redPoints.AreaExploreRedPoint.MergeDictionary(redPointNtf.Info.AreaExploreRedPoint);
		redPoints.Equips.MergeDictionary(redPointNtf.Info.Equips);
		redPoints.Gems.MergeDictionary(redPointNtf.Info.Gems);
		redPoints.Avatars.MergeDictionary(redPointNtf.Info.Avatars);
		redPoints.AvatarFrames.MergeDictionary(redPointNtf.Info.AvatarFrames);
		redPoints.Titles.MergeDictionary(redPointNtf.Info.Titles);
	}

	public void ApplyChanges(ActivityLevelRewardNtf activityLevelRewardNtf, bool reset)
	{
		if (reset)
		{
			playerLevelActivity.Clear();
		}
		playerLevelActivity[activityLevelRewardNtf.ActivitLevelRewardInfo.ActivityId] = activityLevelRewardNtf.ActivitLevelRewardInfo.GainedActivityGroup;
	}

	public void ApplyChanges(ActivityDoubleDungeonNtf activityDoubleDungeonNtf, bool reset)
	{
		if (reset)
		{
			activitDoubleDungeonInfos.Clear();
		}
		ActivitDoubleDungeonInfo activitDoubleDungeonInfo = activityDoubleDungeonNtf?.ActivitDoubleDungeonInfo;
		if (activitDoubleDungeonInfo != null && activitDoubleDungeonInfo.ActivityId != 0)
		{
			activitDoubleDungeonInfos[activitDoubleDungeonInfo.ActivityId] = activitDoubleDungeonInfo.Clone();
		}
	}

	public void ApplyChanges(MapAreaDivinePupilsNtf areaDivinePupilsNtf, bool reset)
	{
		if (reset)
		{
			pupils.Clear();
		}
		pupils.MergeDictionary(areaDivinePupilsNtf.Pupils);
	}

	public void ApplyChanges(HandbookNtf handBookNtf, bool reset)
	{
		if (reset)
		{
			growthGuide = new PlayerGrowthGuide();
		}
		growthGuide.MergeFrom(handBookNtf.Handbook.GrowthGuide);
	}

	private void MergeDictionary(MapField<int, ItemQualityCount> ori, MapField<int, ItemQualityCount> inofos)
	{
		foreach (KeyValuePair<int, ItemQualityCount> inofo in inofos)
		{
			if (ori.ContainsKey(inofo.Key))
			{
				foreach (KeyValuePair<int, int> item in inofo.Value.QualityCount)
				{
					if (ori[inofo.Key].QualityCount.ContainsKey(item.Key))
					{
						ori[inofo.Key].QualityCount[item.Key] = item.Value;
					}
					else
					{
						ori[inofo.Key].QualityCount.Add(item.Key, item.Value);
					}
				}
			}
			else
			{
				ori.Add(inofo.Key, inofo.Value);
			}
		}
	}
}
