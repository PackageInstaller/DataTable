using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class WeekBossLevel : IMessage<WeekBossLevel>, IMessage, IEquatable<WeekBossLevel>, IDeepCloneable<WeekBossLevel>
{
	private static readonly MessageParser<WeekBossLevel> _parser = new MessageParser<WeekBossLevel>(() => new WeekBossLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TypeFieldNumber = 2;

	private int type_;

	public const int DifficultyFieldNumber = 3;

	private int difficulty_;

	public const int NameFieldNumber = 4;

	private string name_ = "";

	public const int SuggestedBuildFieldNumber = 5;

	private int suggestedBuild_;

	public const int SuggestedPowerFieldNumber = 6;

	private int suggestedPower_;

	public const int PreLevelIdFieldNumber = 7;

	private int preLevelId_;

	public const int BossShowTimeFieldNumber = 8;

	private int bossShowTime_;

	public const int NeedWorldClassFieldNumber = 9;

	private int needWorldClass_;

	public const int NeedRoguelikeFieldNumber = 10;

	private int needRoguelike_;

	public const int FloorIdFieldNumber = 11;

	private int floorId_;

	public const int RoundTableDropIdFieldNumber = 12;

	private int roundTableDropId_;

	public const int RoundTableGuaranteeFieldNumber = 13;

	private string roundTableGuarantee_ = "";

	public const int SequentialDropIdFieldNumber = 14;

	private int sequentialDropId_;

	public const int SequentialGuaranteeFieldNumber = 15;

	private string sequentialGuarantee_ = "";

	public const int BaseAwardPreviewFieldNumber = 16;

	private string baseAwardPreview_ = "";

	public const int EntryGroupId1FieldNumber = 17;

	private int entryGroupId1_;

	public const int EntryGroupLevel1FieldNumber = 18;

	private int entryGroupLevel1_;

	public const int EntryGroupId2FieldNumber = 19;

	private int entryGroupId2_;

	public const int EntryGroupLevel2FieldNumber = 20;

	private int entryGroupLevel2_;

	public const int EntryGroupId3FieldNumber = 21;

	private int entryGroupId3_;

	public const int EntryGroupLevel3FieldNumber = 22;

	private int entryGroupLevel3_;

	public const int EntryGroupId4FieldNumber = 23;

	private int entryGroupId4_;

	public const int EntryGroupLevel4FieldNumber = 24;

	private int entryGroupLevel4_;

	public const int EntryGroupId5FieldNumber = 25;

	private int entryGroupId5_;

	public const int EntryGroupLevel5FieldNumber = 26;

	private int entryGroupLevel5_;

	[DebuggerNonUserCode]
	public static MessageParser<WeekBossLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1078);

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
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
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
	public int SuggestedBuild
	{
		get
		{
			return suggestedBuild_;
		}
		set
		{
			suggestedBuild_ = value;
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
	public WeekBossLevel()
	{
	}

	[DebuggerNonUserCode]
	public WeekBossLevel(WeekBossLevel other)
		: this()
	{
		id_ = other.id_;
		type_ = other.type_;
		difficulty_ = other.difficulty_;
		name_ = other.name_;
		suggestedBuild_ = other.suggestedBuild_;
		suggestedPower_ = other.suggestedPower_;
		preLevelId_ = other.preLevelId_;
		bossShowTime_ = other.bossShowTime_;
		needWorldClass_ = other.needWorldClass_;
		needRoguelike_ = other.needRoguelike_;
		floorId_ = other.floorId_;
		roundTableDropId_ = other.roundTableDropId_;
		roundTableGuarantee_ = other.roundTableGuarantee_;
		sequentialDropId_ = other.sequentialDropId_;
		sequentialGuarantee_ = other.sequentialGuarantee_;
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
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public WeekBossLevel Clone()
	{
		return new WeekBossLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as WeekBossLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(WeekBossLevel other)
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
		if (Type != other.Type)
		{
			return false;
		}
		if (Difficulty != other.Difficulty)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (SuggestedBuild != other.SuggestedBuild)
		{
			return false;
		}
		if (SuggestedPower != other.SuggestedPower)
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
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Difficulty != 0)
		{
			num ^= Difficulty.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (SuggestedBuild != 0)
		{
			num ^= SuggestedBuild.GetHashCode();
		}
		if (SuggestedPower != 0)
		{
			num ^= SuggestedPower.GetHashCode();
		}
		if (PreLevelId != 0)
		{
			num ^= PreLevelId.GetHashCode();
		}
		if (BossShowTime != 0)
		{
			num ^= BossShowTime.GetHashCode();
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
		if (Type != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Type);
		}
		if (Difficulty != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Difficulty);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name);
		}
		if (SuggestedBuild != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(SuggestedBuild);
		}
		if (SuggestedPower != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(SuggestedPower);
		}
		if (PreLevelId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(PreLevelId);
		}
		if (BossShowTime != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(BossShowTime);
		}
		if (NeedWorldClass != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(NeedWorldClass);
		}
		if (NeedRoguelike != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(NeedRoguelike);
		}
		if (FloorId != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(FloorId);
		}
		if (RoundTableDropId != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(RoundTableDropId);
		}
		if (RoundTableGuarantee.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(RoundTableGuarantee);
		}
		if (SequentialDropId != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(SequentialDropId);
		}
		if (SequentialGuarantee.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(SequentialGuarantee);
		}
		if (BaseAwardPreview.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(BaseAwardPreview);
		}
		if (EntryGroupId1 != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(EntryGroupId1);
		}
		if (EntryGroupLevel1 != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(EntryGroupLevel1);
		}
		if (EntryGroupId2 != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(EntryGroupId2);
		}
		if (EntryGroupLevel2 != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(EntryGroupLevel2);
		}
		if (EntryGroupId3 != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(EntryGroupId3);
		}
		if (EntryGroupLevel3 != 0)
		{
			output.WriteRawTag(176, 1);
			output.WriteInt32(EntryGroupLevel3);
		}
		if (EntryGroupId4 != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(EntryGroupId4);
		}
		if (EntryGroupLevel4 != 0)
		{
			output.WriteRawTag(192, 1);
			output.WriteInt32(EntryGroupLevel4);
		}
		if (EntryGroupId5 != 0)
		{
			output.WriteRawTag(200, 1);
			output.WriteInt32(EntryGroupId5);
		}
		if (EntryGroupLevel5 != 0)
		{
			output.WriteRawTag(208, 1);
			output.WriteInt32(EntryGroupLevel5);
		}
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
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Difficulty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Difficulty);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (SuggestedBuild != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SuggestedBuild);
		}
		if (SuggestedPower != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SuggestedPower);
		}
		if (PreLevelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevelId);
		}
		if (BossShowTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BossShowTime);
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
		if (RoundTableDropId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RoundTableDropId);
		}
		if (RoundTableGuarantee.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RoundTableGuarantee);
		}
		if (SequentialDropId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SequentialDropId);
		}
		if (SequentialGuarantee.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SequentialGuarantee);
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
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(WeekBossLevel other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Difficulty != 0)
			{
				Difficulty = other.Difficulty;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.SuggestedBuild != 0)
			{
				SuggestedBuild = other.SuggestedBuild;
			}
			if (other.SuggestedPower != 0)
			{
				SuggestedPower = other.SuggestedPower;
			}
			if (other.PreLevelId != 0)
			{
				PreLevelId = other.PreLevelId;
			}
			if (other.BossShowTime != 0)
			{
				BossShowTime = other.BossShowTime;
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
				Type = input.ReadInt32();
				break;
			case 24u:
				Difficulty = input.ReadInt32();
				break;
			case 34u:
				Name = input.ReadString();
				break;
			case 40u:
				SuggestedBuild = input.ReadInt32();
				break;
			case 48u:
				SuggestedPower = input.ReadInt32();
				break;
			case 56u:
				PreLevelId = input.ReadInt32();
				break;
			case 64u:
				BossShowTime = input.ReadInt32();
				break;
			case 72u:
				NeedWorldClass = input.ReadInt32();
				break;
			case 80u:
				NeedRoguelike = input.ReadInt32();
				break;
			case 88u:
				FloorId = input.ReadInt32();
				break;
			case 96u:
				RoundTableDropId = input.ReadInt32();
				break;
			case 106u:
				RoundTableGuarantee = input.ReadString();
				break;
			case 112u:
				SequentialDropId = input.ReadInt32();
				break;
			case 122u:
				SequentialGuarantee = input.ReadString();
				break;
			case 130u:
				BaseAwardPreview = input.ReadString();
				break;
			case 136u:
				EntryGroupId1 = input.ReadInt32();
				break;
			case 144u:
				EntryGroupLevel1 = input.ReadInt32();
				break;
			case 152u:
				EntryGroupId2 = input.ReadInt32();
				break;
			case 160u:
				EntryGroupLevel2 = input.ReadInt32();
				break;
			case 168u:
				EntryGroupId3 = input.ReadInt32();
				break;
			case 176u:
				EntryGroupLevel3 = input.ReadInt32();
				break;
			case 184u:
				EntryGroupId4 = input.ReadInt32();
				break;
			case 192u:
				EntryGroupLevel4 = input.ReadInt32();
				break;
			case 200u:
				EntryGroupId5 = input.ReadInt32();
				break;
			case 208u:
				EntryGroupLevel5 = input.ReadInt32();
				break;
			}
		}
	}
}
