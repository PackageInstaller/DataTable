using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class RegionBossLevel : IMessage<RegionBossLevel>, IMessage, IEquatable<RegionBossLevel>, IDeepCloneable<RegionBossLevel>
{
	private static readonly MessageParser<RegionBossLevel> _parser = new MessageParser<RegionBossLevel>(() => new RegionBossLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int RegionBossIdFieldNumber = 2;

	private int regionBossId_;

	public const int DifficultyFieldNumber = 3;

	private int difficulty_;

	public const int RegionTypeFieldNumber = 4;

	private int regionType_;

	public const int NameFieldNumber = 5;

	private string name_ = "";

	public const int DescFieldNumber = 6;

	private string desc_ = "";

	public const int IconFieldNumber = 7;

	private string icon_ = "";

	public const int SuggestedPowerFieldNumber = 8;

	private int suggestedPower_;

	public const int RecommendBuildRankFieldNumber = 9;

	private int recommendBuildRank_;

	public const int PreLevelIdFieldNumber = 10;

	private int preLevelId_;

	public const int BossShowTimeFieldNumber = 11;

	private int bossShowTime_;

	public const int PreLevelStarFieldNumber = 12;

	private int preLevelStar_;

	public const int NeedWorldClassFieldNumber = 13;

	private int needWorldClass_;

	public const int NeedRoguelikeFieldNumber = 14;

	private int needRoguelike_;

	public const int FloorIdFieldNumber = 15;

	private int floorId_;

	public const int OneStarConditionFieldNumber = 16;

	private string oneStarCondition_ = "";

	public const int TwoStarConditionFieldNumber = 17;

	private string twoStarCondition_ = "";

	public const int ThreeStarConditionFieldNumber = 18;

	private string threeStarCondition_ = "";

	public const int RoundTableDropIdFieldNumber = 19;

	private int roundTableDropId_;

	public const int RoundTableGuaranteeFieldNumber = 20;

	private string roundTableGuarantee_ = "";

	public const int SequentialDropIdFieldNumber = 21;

	private int sequentialDropId_;

	public const int SequentialGuaranteeFieldNumber = 22;

	private string sequentialGuarantee_ = "";

	public const int EnergyConsumeFieldNumber = 23;

	private int energyConsume_;

	public const int BaseAwardPreviewFieldNumber = 24;

	private string baseAwardPreview_ = "";

	public const int EntryGroupId1FieldNumber = 25;

	private int entryGroupId1_;

	public const int EntryGroupLevel1FieldNumber = 26;

	private int entryGroupLevel1_;

	public const int EntryGroupId2FieldNumber = 27;

	private int entryGroupId2_;

	public const int EntryGroupLevel2FieldNumber = 28;

	private int entryGroupLevel2_;

	public const int EntryGroupId3FieldNumber = 29;

	private int entryGroupId3_;

	public const int EntryGroupLevel3FieldNumber = 30;

	private int entryGroupLevel3_;

	public const int EntryGroupId4FieldNumber = 31;

	private int entryGroupId4_;

	public const int EntryGroupLevel4FieldNumber = 32;

	private int entryGroupLevel4_;

	public const int EntryGroupId5FieldNumber = 33;

	private int entryGroupId5_;

	public const int EntryGroupLevel5FieldNumber = 34;

	private int entryGroupLevel5_;

	public const int ExtraDropPreviewFieldNumber = 35;

	private static readonly FieldCodec<int> _repeated_extraDropPreview_codec = FieldCodec.ForInt32(282u);

	private readonly RepeatedField<int> extraDropPreview_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<RegionBossLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(682);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Id
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
	public int RegionBossId
	{
		get
		{
			return regionBossId_;
		}
		set
		{
			regionBossId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Difficulty
	{
		get
		{
			return difficulty_;
		}
		set
		{
			difficulty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RegionType
	{
		get
		{
			return regionType_;
		}
		set
		{
			regionType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc
	{
		get
		{
			return desc_;
		}
		set
		{
			desc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int SuggestedPower
	{
		get
		{
			return suggestedPower_;
		}
		set
		{
			suggestedPower_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RecommendBuildRank
	{
		get
		{
			return recommendBuildRank_;
		}
		set
		{
			recommendBuildRank_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PreLevelId
	{
		get
		{
			return preLevelId_;
		}
		set
		{
			preLevelId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BossShowTime
	{
		get
		{
			return bossShowTime_;
		}
		set
		{
			bossShowTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PreLevelStar
	{
		get
		{
			return preLevelStar_;
		}
		set
		{
			preLevelStar_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NeedWorldClass
	{
		get
		{
			return needWorldClass_;
		}
		set
		{
			needWorldClass_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NeedRoguelike
	{
		get
		{
			return needRoguelike_;
		}
		set
		{
			needRoguelike_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FloorId
	{
		get
		{
			return floorId_;
		}
		set
		{
			floorId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string OneStarCondition
	{
		get
		{
			return oneStarCondition_;
		}
		set
		{
			oneStarCondition_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TwoStarCondition
	{
		get
		{
			return twoStarCondition_;
		}
		set
		{
			twoStarCondition_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ThreeStarCondition
	{
		get
		{
			return threeStarCondition_;
		}
		set
		{
			threeStarCondition_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int RoundTableDropId
	{
		get
		{
			return roundTableDropId_;
		}
		set
		{
			roundTableDropId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string RoundTableGuarantee
	{
		get
		{
			return roundTableGuarantee_;
		}
		set
		{
			roundTableGuarantee_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int SequentialDropId
	{
		get
		{
			return sequentialDropId_;
		}
		set
		{
			sequentialDropId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string SequentialGuarantee
	{
		get
		{
			return sequentialGuarantee_;
		}
		set
		{
			sequentialGuarantee_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int EnergyConsume
	{
		get
		{
			return energyConsume_;
		}
		set
		{
			energyConsume_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BaseAwardPreview
	{
		get
		{
			return baseAwardPreview_;
		}
		set
		{
			baseAwardPreview_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int EntryGroupId1
	{
		get
		{
			return entryGroupId1_;
		}
		set
		{
			entryGroupId1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EntryGroupLevel1
	{
		get
		{
			return entryGroupLevel1_;
		}
		set
		{
			entryGroupLevel1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EntryGroupId2
	{
		get
		{
			return entryGroupId2_;
		}
		set
		{
			entryGroupId2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EntryGroupLevel2
	{
		get
		{
			return entryGroupLevel2_;
		}
		set
		{
			entryGroupLevel2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EntryGroupId3
	{
		get
		{
			return entryGroupId3_;
		}
		set
		{
			entryGroupId3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EntryGroupLevel3
	{
		get
		{
			return entryGroupLevel3_;
		}
		set
		{
			entryGroupLevel3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EntryGroupId4
	{
		get
		{
			return entryGroupId4_;
		}
		set
		{
			entryGroupId4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EntryGroupLevel4
	{
		get
		{
			return entryGroupLevel4_;
		}
		set
		{
			entryGroupLevel4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EntryGroupId5
	{
		get
		{
			return entryGroupId5_;
		}
		set
		{
			entryGroupId5_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EntryGroupLevel5
	{
		get
		{
			return entryGroupLevel5_;
		}
		set
		{
			entryGroupLevel5_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> ExtraDropPreview => extraDropPreview_;

	[DebuggerNonUserCode]
	public RegionBossLevel()
	{
	}

	[DebuggerNonUserCode]
	public RegionBossLevel(RegionBossLevel other)
		: this()
	{
		id_ = other.id_;
		regionBossId_ = other.regionBossId_;
		difficulty_ = other.difficulty_;
		regionType_ = other.regionType_;
		name_ = other.name_;
		desc_ = other.desc_;
		icon_ = other.icon_;
		suggestedPower_ = other.suggestedPower_;
		recommendBuildRank_ = other.recommendBuildRank_;
		preLevelId_ = other.preLevelId_;
		bossShowTime_ = other.bossShowTime_;
		preLevelStar_ = other.preLevelStar_;
		needWorldClass_ = other.needWorldClass_;
		needRoguelike_ = other.needRoguelike_;
		floorId_ = other.floorId_;
		oneStarCondition_ = other.oneStarCondition_;
		twoStarCondition_ = other.twoStarCondition_;
		threeStarCondition_ = other.threeStarCondition_;
		roundTableDropId_ = other.roundTableDropId_;
		roundTableGuarantee_ = other.roundTableGuarantee_;
		sequentialDropId_ = other.sequentialDropId_;
		sequentialGuarantee_ = other.sequentialGuarantee_;
		energyConsume_ = other.energyConsume_;
		baseAwardPreview_ = other.baseAwardPreview_;
		entryGroupId1_ = other.entryGroupId1_;
		entryGroupLevel1_ = other.entryGroupLevel1_;
		entryGroupId2_ = other.entryGroupId2_;
		entryGroupLevel2_ = other.entryGroupLevel2_;
		entryGroupId3_ = other.entryGroupId3_;
		entryGroupLevel3_ = other.entryGroupLevel3_;
		entryGroupId4_ = other.entryGroupId4_;
		entryGroupLevel4_ = other.entryGroupLevel4_;
		entryGroupId5_ = other.entryGroupId5_;
		entryGroupLevel5_ = other.entryGroupLevel5_;
		extraDropPreview_ = other.extraDropPreview_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public RegionBossLevel Clone()
	{
		return new RegionBossLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as RegionBossLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(RegionBossLevel other)
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
		if (RegionBossId != other.RegionBossId)
		{
			return false;
		}
		if (Difficulty != other.Difficulty)
		{
			return false;
		}
		if (RegionType != other.RegionType)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (SuggestedPower != other.SuggestedPower)
		{
			return false;
		}
		if (RecommendBuildRank != other.RecommendBuildRank)
		{
			return false;
		}
		if (PreLevelId != other.PreLevelId)
		{
			return false;
		}
		if (BossShowTime != other.BossShowTime)
		{
			return false;
		}
		if (PreLevelStar != other.PreLevelStar)
		{
			return false;
		}
		if (NeedWorldClass != other.NeedWorldClass)
		{
			return false;
		}
		if (NeedRoguelike != other.NeedRoguelike)
		{
			return false;
		}
		if (FloorId != other.FloorId)
		{
			return false;
		}
		if (OneStarCondition != other.OneStarCondition)
		{
			return false;
		}
		if (TwoStarCondition != other.TwoStarCondition)
		{
			return false;
		}
		if (ThreeStarCondition != other.ThreeStarCondition)
		{
			return false;
		}
		if (RoundTableDropId != other.RoundTableDropId)
		{
			return false;
		}
		if (RoundTableGuarantee != other.RoundTableGuarantee)
		{
			return false;
		}
		if (SequentialDropId != other.SequentialDropId)
		{
			return false;
		}
		if (SequentialGuarantee != other.SequentialGuarantee)
		{
			return false;
		}
		if (EnergyConsume != other.EnergyConsume)
		{
			return false;
		}
		if (BaseAwardPreview != other.BaseAwardPreview)
		{
			return false;
		}
		if (EntryGroupId1 != other.EntryGroupId1)
		{
			return false;
		}
		if (EntryGroupLevel1 != other.EntryGroupLevel1)
		{
			return false;
		}
		if (EntryGroupId2 != other.EntryGroupId2)
		{
			return false;
		}
		if (EntryGroupLevel2 != other.EntryGroupLevel2)
		{
			return false;
		}
		if (EntryGroupId3 != other.EntryGroupId3)
		{
			return false;
		}
		if (EntryGroupLevel3 != other.EntryGroupLevel3)
		{
			return false;
		}
		if (EntryGroupId4 != other.EntryGroupId4)
		{
			return false;
		}
		if (EntryGroupLevel4 != other.EntryGroupLevel4)
		{
			return false;
		}
		if (EntryGroupId5 != other.EntryGroupId5)
		{
			return false;
		}
		if (EntryGroupLevel5 != other.EntryGroupLevel5)
		{
			return false;
		}
		if (!extraDropPreview_.Equals(other.extraDropPreview_))
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (RegionBossId != 0)
		{
			num ^= RegionBossId.GetHashCode();
		}
		if (Difficulty != 0)
		{
			num ^= Difficulty.GetHashCode();
		}
		if (RegionType != 0)
		{
			num ^= RegionType.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (SuggestedPower != 0)
		{
			num ^= SuggestedPower.GetHashCode();
		}
		if (RecommendBuildRank != 0)
		{
			num ^= RecommendBuildRank.GetHashCode();
		}
		if (PreLevelId != 0)
		{
			num ^= PreLevelId.GetHashCode();
		}
		if (BossShowTime != 0)
		{
			num ^= BossShowTime.GetHashCode();
		}
		if (PreLevelStar != 0)
		{
			num ^= PreLevelStar.GetHashCode();
		}
		if (NeedWorldClass != 0)
		{
			num ^= NeedWorldClass.GetHashCode();
		}
		if (NeedRoguelike != 0)
		{
			num ^= NeedRoguelike.GetHashCode();
		}
		if (FloorId != 0)
		{
			num ^= FloorId.GetHashCode();
		}
		if (OneStarCondition.Length != 0)
		{
			num ^= OneStarCondition.GetHashCode();
		}
		if (TwoStarCondition.Length != 0)
		{
			num ^= TwoStarCondition.GetHashCode();
		}
		if (ThreeStarCondition.Length != 0)
		{
			num ^= ThreeStarCondition.GetHashCode();
		}
		if (RoundTableDropId != 0)
		{
			num ^= RoundTableDropId.GetHashCode();
		}
		if (RoundTableGuarantee.Length != 0)
		{
			num ^= RoundTableGuarantee.GetHashCode();
		}
		if (SequentialDropId != 0)
		{
			num ^= SequentialDropId.GetHashCode();
		}
		if (SequentialGuarantee.Length != 0)
		{
			num ^= SequentialGuarantee.GetHashCode();
		}
		if (EnergyConsume != 0)
		{
			num ^= EnergyConsume.GetHashCode();
		}
		if (BaseAwardPreview.Length != 0)
		{
			num ^= BaseAwardPreview.GetHashCode();
		}
		if (EntryGroupId1 != 0)
		{
			num ^= EntryGroupId1.GetHashCode();
		}
		if (EntryGroupLevel1 != 0)
		{
			num ^= EntryGroupLevel1.GetHashCode();
		}
		if (EntryGroupId2 != 0)
		{
			num ^= EntryGroupId2.GetHashCode();
		}
		if (EntryGroupLevel2 != 0)
		{
			num ^= EntryGroupLevel2.GetHashCode();
		}
		if (EntryGroupId3 != 0)
		{
			num ^= EntryGroupId3.GetHashCode();
		}
		if (EntryGroupLevel3 != 0)
		{
			num ^= EntryGroupLevel3.GetHashCode();
		}
		if (EntryGroupId4 != 0)
		{
			num ^= EntryGroupId4.GetHashCode();
		}
		if (EntryGroupLevel4 != 0)
		{
			num ^= EntryGroupLevel4.GetHashCode();
		}
		if (EntryGroupId5 != 0)
		{
			num ^= EntryGroupId5.GetHashCode();
		}
		if (EntryGroupLevel5 != 0)
		{
			num ^= EntryGroupLevel5.GetHashCode();
		}
		num ^= extraDropPreview_.GetHashCode();
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (RegionBossId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(RegionBossId);
		}
		if (Difficulty != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Difficulty);
		}
		if (RegionType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(RegionType);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Name);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Desc);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Icon);
		}
		if (SuggestedPower != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(SuggestedPower);
		}
		if (RecommendBuildRank != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(RecommendBuildRank);
		}
		if (PreLevelId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(PreLevelId);
		}
		if (BossShowTime != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(BossShowTime);
		}
		if (PreLevelStar != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(PreLevelStar);
		}
		if (NeedWorldClass != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(NeedWorldClass);
		}
		if (NeedRoguelike != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(NeedRoguelike);
		}
		if (FloorId != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(FloorId);
		}
		if (OneStarCondition.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(OneStarCondition);
		}
		if (TwoStarCondition.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(TwoStarCondition);
		}
		if (ThreeStarCondition.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(ThreeStarCondition);
		}
		if (RoundTableDropId != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(RoundTableDropId);
		}
		if (RoundTableGuarantee.Length != 0)
		{
			output.WriteRawTag(162, 1);
			output.WriteString(RoundTableGuarantee);
		}
		if (SequentialDropId != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(SequentialDropId);
		}
		if (SequentialGuarantee.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(SequentialGuarantee);
		}
		if (EnergyConsume != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(EnergyConsume);
		}
		if (BaseAwardPreview.Length != 0)
		{
			output.WriteRawTag(194, 1);
			output.WriteString(BaseAwardPreview);
		}
		if (EntryGroupId1 != 0)
		{
			output.WriteRawTag(200, 1);
			output.WriteInt32(EntryGroupId1);
		}
		if (EntryGroupLevel1 != 0)
		{
			output.WriteRawTag(208, 1);
			output.WriteInt32(EntryGroupLevel1);
		}
		if (EntryGroupId2 != 0)
		{
			output.WriteRawTag(216, 1);
			output.WriteInt32(EntryGroupId2);
		}
		if (EntryGroupLevel2 != 0)
		{
			output.WriteRawTag(224, 1);
			output.WriteInt32(EntryGroupLevel2);
		}
		if (EntryGroupId3 != 0)
		{
			output.WriteRawTag(232, 1);
			output.WriteInt32(EntryGroupId3);
		}
		if (EntryGroupLevel3 != 0)
		{
			output.WriteRawTag(240, 1);
			output.WriteInt32(EntryGroupLevel3);
		}
		if (EntryGroupId4 != 0)
		{
			output.WriteRawTag(248, 1);
			output.WriteInt32(EntryGroupId4);
		}
		if (EntryGroupLevel4 != 0)
		{
			output.WriteRawTag(128, 2);
			output.WriteInt32(EntryGroupLevel4);
		}
		if (EntryGroupId5 != 0)
		{
			output.WriteRawTag(136, 2);
			output.WriteInt32(EntryGroupId5);
		}
		if (EntryGroupLevel5 != 0)
		{
			output.WriteRawTag(144, 2);
			output.WriteInt32(EntryGroupLevel5);
		}
		extraDropPreview_.WriteTo(output, _repeated_extraDropPreview_codec);
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (RegionBossId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RegionBossId);
		}
		if (Difficulty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Difficulty);
		}
		if (RegionType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RegionType);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (SuggestedPower != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SuggestedPower);
		}
		if (RecommendBuildRank != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RecommendBuildRank);
		}
		if (PreLevelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevelId);
		}
		if (BossShowTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BossShowTime);
		}
		if (PreLevelStar != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevelStar);
		}
		if (NeedWorldClass != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NeedWorldClass);
		}
		if (NeedRoguelike != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NeedRoguelike);
		}
		if (FloorId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorId);
		}
		if (OneStarCondition.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(OneStarCondition);
		}
		if (TwoStarCondition.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(TwoStarCondition);
		}
		if (ThreeStarCondition.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(ThreeStarCondition);
		}
		if (RoundTableDropId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RoundTableDropId);
		}
		if (RoundTableGuarantee.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(RoundTableGuarantee);
		}
		if (SequentialDropId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SequentialDropId);
		}
		if (SequentialGuarantee.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(SequentialGuarantee);
		}
		if (EnergyConsume != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EnergyConsume);
		}
		if (BaseAwardPreview.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(BaseAwardPreview);
		}
		if (EntryGroupId1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EntryGroupId1);
		}
		if (EntryGroupLevel1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EntryGroupLevel1);
		}
		if (EntryGroupId2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EntryGroupId2);
		}
		if (EntryGroupLevel2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EntryGroupLevel2);
		}
		if (EntryGroupId3 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EntryGroupId3);
		}
		if (EntryGroupLevel3 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EntryGroupLevel3);
		}
		if (EntryGroupId4 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EntryGroupId4);
		}
		if (EntryGroupLevel4 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EntryGroupLevel4);
		}
		if (EntryGroupId5 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EntryGroupId5);
		}
		if (EntryGroupLevel5 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EntryGroupLevel5);
		}
		num += extraDropPreview_.CalculateSize(_repeated_extraDropPreview_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(RegionBossLevel other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.RegionBossId != 0)
			{
				RegionBossId = other.RegionBossId;
			}
			if (other.Difficulty != 0)
			{
				Difficulty = other.Difficulty;
			}
			if (other.RegionType != 0)
			{
				RegionType = other.RegionType;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.SuggestedPower != 0)
			{
				SuggestedPower = other.SuggestedPower;
			}
			if (other.RecommendBuildRank != 0)
			{
				RecommendBuildRank = other.RecommendBuildRank;
			}
			if (other.PreLevelId != 0)
			{
				PreLevelId = other.PreLevelId;
			}
			if (other.BossShowTime != 0)
			{
				BossShowTime = other.BossShowTime;
			}
			if (other.PreLevelStar != 0)
			{
				PreLevelStar = other.PreLevelStar;
			}
			if (other.NeedWorldClass != 0)
			{
				NeedWorldClass = other.NeedWorldClass;
			}
			if (other.NeedRoguelike != 0)
			{
				NeedRoguelike = other.NeedRoguelike;
			}
			if (other.FloorId != 0)
			{
				FloorId = other.FloorId;
			}
			if (other.OneStarCondition.Length != 0)
			{
				OneStarCondition = other.OneStarCondition;
			}
			if (other.TwoStarCondition.Length != 0)
			{
				TwoStarCondition = other.TwoStarCondition;
			}
			if (other.ThreeStarCondition.Length != 0)
			{
				ThreeStarCondition = other.ThreeStarCondition;
			}
			if (other.RoundTableDropId != 0)
			{
				RoundTableDropId = other.RoundTableDropId;
			}
			if (other.RoundTableGuarantee.Length != 0)
			{
				RoundTableGuarantee = other.RoundTableGuarantee;
			}
			if (other.SequentialDropId != 0)
			{
				SequentialDropId = other.SequentialDropId;
			}
			if (other.SequentialGuarantee.Length != 0)
			{
				SequentialGuarantee = other.SequentialGuarantee;
			}
			if (other.EnergyConsume != 0)
			{
				EnergyConsume = other.EnergyConsume;
			}
			if (other.BaseAwardPreview.Length != 0)
			{
				BaseAwardPreview = other.BaseAwardPreview;
			}
			if (other.EntryGroupId1 != 0)
			{
				EntryGroupId1 = other.EntryGroupId1;
			}
			if (other.EntryGroupLevel1 != 0)
			{
				EntryGroupLevel1 = other.EntryGroupLevel1;
			}
			if (other.EntryGroupId2 != 0)
			{
				EntryGroupId2 = other.EntryGroupId2;
			}
			if (other.EntryGroupLevel2 != 0)
			{
				EntryGroupLevel2 = other.EntryGroupLevel2;
			}
			if (other.EntryGroupId3 != 0)
			{
				EntryGroupId3 = other.EntryGroupId3;
			}
			if (other.EntryGroupLevel3 != 0)
			{
				EntryGroupLevel3 = other.EntryGroupLevel3;
			}
			if (other.EntryGroupId4 != 0)
			{
				EntryGroupId4 = other.EntryGroupId4;
			}
			if (other.EntryGroupLevel4 != 0)
			{
				EntryGroupLevel4 = other.EntryGroupLevel4;
			}
			if (other.EntryGroupId5 != 0)
			{
				EntryGroupId5 = other.EntryGroupId5;
			}
			if (other.EntryGroupLevel5 != 0)
			{
				EntryGroupLevel5 = other.EntryGroupLevel5;
			}
			extraDropPreview_.Add(other.extraDropPreview_);
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 16u:
				RegionBossId = input.ReadInt32();
				break;
			case 24u:
				Difficulty = input.ReadInt32();
				break;
			case 32u:
				RegionType = input.ReadInt32();
				break;
			case 42u:
				Name = input.ReadString();
				break;
			case 50u:
				Desc = input.ReadString();
				break;
			case 58u:
				Icon = input.ReadString();
				break;
			case 64u:
				SuggestedPower = input.ReadInt32();
				break;
			case 72u:
				RecommendBuildRank = input.ReadInt32();
				break;
			case 80u:
				PreLevelId = input.ReadInt32();
				break;
			case 88u:
				BossShowTime = input.ReadInt32();
				break;
			case 96u:
				PreLevelStar = input.ReadInt32();
				break;
			case 104u:
				NeedWorldClass = input.ReadInt32();
				break;
			case 112u:
				NeedRoguelike = input.ReadInt32();
				break;
			case 120u:
				FloorId = input.ReadInt32();
				break;
			case 130u:
				OneStarCondition = input.ReadString();
				break;
			case 138u:
				TwoStarCondition = input.ReadString();
				break;
			case 146u:
				ThreeStarCondition = input.ReadString();
				break;
			case 152u:
				RoundTableDropId = input.ReadInt32();
				break;
			case 162u:
				RoundTableGuarantee = input.ReadString();
				break;
			case 168u:
				SequentialDropId = input.ReadInt32();
				break;
			case 178u:
				SequentialGuarantee = input.ReadString();
				break;
			case 184u:
				EnergyConsume = input.ReadInt32();
				break;
			case 194u:
				BaseAwardPreview = input.ReadString();
				break;
			case 200u:
				EntryGroupId1 = input.ReadInt32();
				break;
			case 208u:
				EntryGroupLevel1 = input.ReadInt32();
				break;
			case 216u:
				EntryGroupId2 = input.ReadInt32();
				break;
			case 224u:
				EntryGroupLevel2 = input.ReadInt32();
				break;
			case 232u:
				EntryGroupId3 = input.ReadInt32();
				break;
			case 240u:
				EntryGroupLevel3 = input.ReadInt32();
				break;
			case 248u:
				EntryGroupId4 = input.ReadInt32();
				break;
			case 256u:
				EntryGroupLevel4 = input.ReadInt32();
				break;
			case 264u:
				EntryGroupId5 = input.ReadInt32();
				break;
			case 272u:
				EntryGroupLevel5 = input.ReadInt32();
				break;
			case 280u:
			case 282u:
				extraDropPreview_.AddEntriesFrom(input, _repeated_extraDropPreview_codec);
				break;
			}
		}
	}
}
