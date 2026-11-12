using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Agent : IMessage<Agent>, IMessage, IEquatable<Agent>, IDeepCloneable<Agent>
{
	private static readonly MessageParser<Agent> _parser = new MessageParser<Agent>(() => new Agent());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TabFieldNumber = 2;

	private int tab_;

	public const int NoteFieldNumber = 3;

	private string note_ = "";

	public const int NameFieldNumber = 4;

	private string name_ = "";

	public const int DescFieldNumber = 5;

	private string desc_ = "";

	public const int ConsignorFieldNumber = 6;

	private string consignor_ = "";

	public const int RefreshTypeFieldNumber = 7;

	private int refreshType_;

	public const int QualityFieldNumber = 8;

	private int quality_;

	public const int MemberTypeFieldNumber = 9;

	private int memberType_;

	public const int LevelFieldNumber = 10;

	private int level_;

	public const int BuildScoreFieldNumber = 11;

	private int buildScore_;

	public const int MemberLimitFieldNumber = 12;

	private int memberLimit_;

	public const int TagsFieldNumber = 13;

	private static readonly FieldCodec<int> _repeated_tags_codec = FieldCodec.ForInt32(106u);

	private readonly RepeatedField<int> tags_ = new RepeatedField<int>();

	public const int ExtraTagsFieldNumber = 14;

	private static readonly FieldCodec<int> _repeated_extraTags_codec = FieldCodec.ForInt32(114u);

	private readonly RepeatedField<int> extraTags_ = new RepeatedField<int>();

	public const int UnlockConditionsFieldNumber = 15;

	private string unlockConditions_ = "";

	public const int SortFieldNumber = 16;

	private int sort_;

	public const int Time1FieldNumber = 17;

	private int time1_;

	public const int RewardPreview1FieldNumber = 18;

	private string rewardPreview1_ = "";

	public const int BonusPreview1FieldNumber = 19;

	private string bonusPreview1_ = "";

	public const int Time2FieldNumber = 20;

	private int time2_;

	public const int RewardPreview2FieldNumber = 21;

	private string rewardPreview2_ = "";

	public const int BonusPreview2FieldNumber = 22;

	private string bonusPreview2_ = "";

	public const int Time3FieldNumber = 23;

	private int time3_;

	public const int RewardPreview3FieldNumber = 24;

	private string rewardPreview3_ = "";

	public const int BonusPreview3FieldNumber = 25;

	private string bonusPreview3_ = "";

	public const int Time4FieldNumber = 26;

	private int time4_;

	public const int RewardPreview4FieldNumber = 27;

	private string rewardPreview4_ = "";

	public const int BonusPreview4FieldNumber = 28;

	private string bonusPreview4_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<Agent> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(86);

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
	public int Tab
	{
		get
		{
			return tab_;
		}
		set
		{
			tab_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Note
	{
		get
		{
			return note_;
		}
		set
		{
			note_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string Consignor
	{
		get
		{
			return consignor_;
		}
		set
		{
			consignor_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int RefreshType
	{
		get
		{
			return refreshType_;
		}
		set
		{
			refreshType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Quality
	{
		get
		{
			return quality_;
		}
		set
		{
			quality_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MemberType
	{
		get
		{
			return memberType_;
		}
		set
		{
			memberType_ = value;
		}
	}

	[DebuggerNonUserCode]
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
	public int BuildScore
	{
		get
		{
			return buildScore_;
		}
		set
		{
			buildScore_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MemberLimit
	{
		get
		{
			return memberLimit_;
		}
		set
		{
			memberLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Tags => tags_;

	[DebuggerNonUserCode]
	public RepeatedField<int> ExtraTags => extraTags_;

	[DebuggerNonUserCode]
	public string UnlockConditions
	{
		get
		{
			return unlockConditions_;
		}
		set
		{
			unlockConditions_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Sort
	{
		get
		{
			return sort_;
		}
		set
		{
			sort_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Time1
	{
		get
		{
			return time1_;
		}
		set
		{
			time1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string RewardPreview1
	{
		get
		{
			return rewardPreview1_;
		}
		set
		{
			rewardPreview1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BonusPreview1
	{
		get
		{
			return bonusPreview1_;
		}
		set
		{
			bonusPreview1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Time2
	{
		get
		{
			return time2_;
		}
		set
		{
			time2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string RewardPreview2
	{
		get
		{
			return rewardPreview2_;
		}
		set
		{
			rewardPreview2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BonusPreview2
	{
		get
		{
			return bonusPreview2_;
		}
		set
		{
			bonusPreview2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Time3
	{
		get
		{
			return time3_;
		}
		set
		{
			time3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string RewardPreview3
	{
		get
		{
			return rewardPreview3_;
		}
		set
		{
			rewardPreview3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BonusPreview3
	{
		get
		{
			return bonusPreview3_;
		}
		set
		{
			bonusPreview3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Time4
	{
		get
		{
			return time4_;
		}
		set
		{
			time4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string RewardPreview4
	{
		get
		{
			return rewardPreview4_;
		}
		set
		{
			rewardPreview4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BonusPreview4
	{
		get
		{
			return bonusPreview4_;
		}
		set
		{
			bonusPreview4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public Agent()
	{
	}

	[DebuggerNonUserCode]
	public Agent(Agent other)
		: this()
	{
		id_ = other.id_;
		tab_ = other.tab_;
		note_ = other.note_;
		name_ = other.name_;
		desc_ = other.desc_;
		consignor_ = other.consignor_;
		refreshType_ = other.refreshType_;
		quality_ = other.quality_;
		memberType_ = other.memberType_;
		level_ = other.level_;
		buildScore_ = other.buildScore_;
		memberLimit_ = other.memberLimit_;
		tags_ = other.tags_.Clone();
		extraTags_ = other.extraTags_.Clone();
		unlockConditions_ = other.unlockConditions_;
		sort_ = other.sort_;
		time1_ = other.time1_;
		rewardPreview1_ = other.rewardPreview1_;
		bonusPreview1_ = other.bonusPreview1_;
		time2_ = other.time2_;
		rewardPreview2_ = other.rewardPreview2_;
		bonusPreview2_ = other.bonusPreview2_;
		time3_ = other.time3_;
		rewardPreview3_ = other.rewardPreview3_;
		bonusPreview3_ = other.bonusPreview3_;
		time4_ = other.time4_;
		rewardPreview4_ = other.rewardPreview4_;
		bonusPreview4_ = other.bonusPreview4_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Agent Clone()
	{
		return new Agent(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Agent);
	}

	[DebuggerNonUserCode]
	public bool Equals(Agent other)
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
		if (Tab != other.Tab)
		{
			return false;
		}
		if (Note != other.Note)
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
		if (Consignor != other.Consignor)
		{
			return false;
		}
		if (RefreshType != other.RefreshType)
		{
			return false;
		}
		if (Quality != other.Quality)
		{
			return false;
		}
		if (MemberType != other.MemberType)
		{
			return false;
		}
		if (Level != other.Level)
		{
			return false;
		}
		if (BuildScore != other.BuildScore)
		{
			return false;
		}
		if (MemberLimit != other.MemberLimit)
		{
			return false;
		}
		if (!tags_.Equals(other.tags_))
		{
			return false;
		}
		if (!extraTags_.Equals(other.extraTags_))
		{
			return false;
		}
		if (UnlockConditions != other.UnlockConditions)
		{
			return false;
		}
		if (Sort != other.Sort)
		{
			return false;
		}
		if (Time1 != other.Time1)
		{
			return false;
		}
		if (RewardPreview1 != other.RewardPreview1)
		{
			return false;
		}
		if (BonusPreview1 != other.BonusPreview1)
		{
			return false;
		}
		if (Time2 != other.Time2)
		{
			return false;
		}
		if (RewardPreview2 != other.RewardPreview2)
		{
			return false;
		}
		if (BonusPreview2 != other.BonusPreview2)
		{
			return false;
		}
		if (Time3 != other.Time3)
		{
			return false;
		}
		if (RewardPreview3 != other.RewardPreview3)
		{
			return false;
		}
		if (BonusPreview3 != other.BonusPreview3)
		{
			return false;
		}
		if (Time4 != other.Time4)
		{
			return false;
		}
		if (RewardPreview4 != other.RewardPreview4)
		{
			return false;
		}
		if (BonusPreview4 != other.BonusPreview4)
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
		if (Tab != 0)
		{
			num ^= Tab.GetHashCode();
		}
		if (Note.Length != 0)
		{
			num ^= Note.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Consignor.Length != 0)
		{
			num ^= Consignor.GetHashCode();
		}
		if (RefreshType != 0)
		{
			num ^= RefreshType.GetHashCode();
		}
		if (Quality != 0)
		{
			num ^= Quality.GetHashCode();
		}
		if (MemberType != 0)
		{
			num ^= MemberType.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (BuildScore != 0)
		{
			num ^= BuildScore.GetHashCode();
		}
		if (MemberLimit != 0)
		{
			num ^= MemberLimit.GetHashCode();
		}
		num ^= tags_.GetHashCode();
		num ^= extraTags_.GetHashCode();
		if (UnlockConditions.Length != 0)
		{
			num ^= UnlockConditions.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		if (Time1 != 0)
		{
			num ^= Time1.GetHashCode();
		}
		if (RewardPreview1.Length != 0)
		{
			num ^= RewardPreview1.GetHashCode();
		}
		if (BonusPreview1.Length != 0)
		{
			num ^= BonusPreview1.GetHashCode();
		}
		if (Time2 != 0)
		{
			num ^= Time2.GetHashCode();
		}
		if (RewardPreview2.Length != 0)
		{
			num ^= RewardPreview2.GetHashCode();
		}
		if (BonusPreview2.Length != 0)
		{
			num ^= BonusPreview2.GetHashCode();
		}
		if (Time3 != 0)
		{
			num ^= Time3.GetHashCode();
		}
		if (RewardPreview3.Length != 0)
		{
			num ^= RewardPreview3.GetHashCode();
		}
		if (BonusPreview3.Length != 0)
		{
			num ^= BonusPreview3.GetHashCode();
		}
		if (Time4 != 0)
		{
			num ^= Time4.GetHashCode();
		}
		if (RewardPreview4.Length != 0)
		{
			num ^= RewardPreview4.GetHashCode();
		}
		if (BonusPreview4.Length != 0)
		{
			num ^= BonusPreview4.GetHashCode();
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
		if (Tab != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Tab);
		}
		if (Note.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Note);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Desc);
		}
		if (Consignor.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Consignor);
		}
		if (RefreshType != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(RefreshType);
		}
		if (Quality != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Quality);
		}
		if (MemberType != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(MemberType);
		}
		if (Level != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Level);
		}
		if (BuildScore != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(BuildScore);
		}
		if (MemberLimit != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(MemberLimit);
		}
		tags_.WriteTo(output, _repeated_tags_codec);
		extraTags_.WriteTo(output, _repeated_extraTags_codec);
		if (UnlockConditions.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(UnlockConditions);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(Sort);
		}
		if (Time1 != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(Time1);
		}
		if (RewardPreview1.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(RewardPreview1);
		}
		if (BonusPreview1.Length != 0)
		{
			output.WriteRawTag(154, 1);
			output.WriteString(BonusPreview1);
		}
		if (Time2 != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(Time2);
		}
		if (RewardPreview2.Length != 0)
		{
			output.WriteRawTag(170, 1);
			output.WriteString(RewardPreview2);
		}
		if (BonusPreview2.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(BonusPreview2);
		}
		if (Time3 != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(Time3);
		}
		if (RewardPreview3.Length != 0)
		{
			output.WriteRawTag(194, 1);
			output.WriteString(RewardPreview3);
		}
		if (BonusPreview3.Length != 0)
		{
			output.WriteRawTag(202, 1);
			output.WriteString(BonusPreview3);
		}
		if (Time4 != 0)
		{
			output.WriteRawTag(208, 1);
			output.WriteInt32(Time4);
		}
		if (RewardPreview4.Length != 0)
		{
			output.WriteRawTag(218, 1);
			output.WriteString(RewardPreview4);
		}
		if (BonusPreview4.Length != 0)
		{
			output.WriteRawTag(226, 1);
			output.WriteString(BonusPreview4);
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
		if (Tab != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tab);
		}
		if (Note.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Note);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Consignor.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Consignor);
		}
		if (RefreshType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RefreshType);
		}
		if (Quality != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Quality);
		}
		if (MemberType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MemberType);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (BuildScore != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuildScore);
		}
		if (MemberLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MemberLimit);
		}
		num += tags_.CalculateSize(_repeated_tags_codec);
		num += extraTags_.CalculateSize(_repeated_extraTags_codec);
		if (UnlockConditions.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UnlockConditions);
		}
		if (Sort != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		if (Time1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Time1);
		}
		if (RewardPreview1.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(RewardPreview1);
		}
		if (BonusPreview1.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(BonusPreview1);
		}
		if (Time2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Time2);
		}
		if (RewardPreview2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(RewardPreview2);
		}
		if (BonusPreview2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(BonusPreview2);
		}
		if (Time3 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Time3);
		}
		if (RewardPreview3.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(RewardPreview3);
		}
		if (BonusPreview3.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(BonusPreview3);
		}
		if (Time4 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Time4);
		}
		if (RewardPreview4.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(RewardPreview4);
		}
		if (BonusPreview4.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(BonusPreview4);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Agent other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Tab != 0)
			{
				Tab = other.Tab;
			}
			if (other.Note.Length != 0)
			{
				Note = other.Note;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Consignor.Length != 0)
			{
				Consignor = other.Consignor;
			}
			if (other.RefreshType != 0)
			{
				RefreshType = other.RefreshType;
			}
			if (other.Quality != 0)
			{
				Quality = other.Quality;
			}
			if (other.MemberType != 0)
			{
				MemberType = other.MemberType;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.BuildScore != 0)
			{
				BuildScore = other.BuildScore;
			}
			if (other.MemberLimit != 0)
			{
				MemberLimit = other.MemberLimit;
			}
			tags_.Add(other.tags_);
			extraTags_.Add(other.extraTags_);
			if (other.UnlockConditions.Length != 0)
			{
				UnlockConditions = other.UnlockConditions;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			if (other.Time1 != 0)
			{
				Time1 = other.Time1;
			}
			if (other.RewardPreview1.Length != 0)
			{
				RewardPreview1 = other.RewardPreview1;
			}
			if (other.BonusPreview1.Length != 0)
			{
				BonusPreview1 = other.BonusPreview1;
			}
			if (other.Time2 != 0)
			{
				Time2 = other.Time2;
			}
			if (other.RewardPreview2.Length != 0)
			{
				RewardPreview2 = other.RewardPreview2;
			}
			if (other.BonusPreview2.Length != 0)
			{
				BonusPreview2 = other.BonusPreview2;
			}
			if (other.Time3 != 0)
			{
				Time3 = other.Time3;
			}
			if (other.RewardPreview3.Length != 0)
			{
				RewardPreview3 = other.RewardPreview3;
			}
			if (other.BonusPreview3.Length != 0)
			{
				BonusPreview3 = other.BonusPreview3;
			}
			if (other.Time4 != 0)
			{
				Time4 = other.Time4;
			}
			if (other.RewardPreview4.Length != 0)
			{
				RewardPreview4 = other.RewardPreview4;
			}
			if (other.BonusPreview4.Length != 0)
			{
				BonusPreview4 = other.BonusPreview4;
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
				Tab = input.ReadInt32();
				break;
			case 26u:
				Note = input.ReadString();
				break;
			case 34u:
				Name = input.ReadString();
				break;
			case 42u:
				Desc = input.ReadString();
				break;
			case 50u:
				Consignor = input.ReadString();
				break;
			case 56u:
				RefreshType = input.ReadInt32();
				break;
			case 64u:
				Quality = input.ReadInt32();
				break;
			case 72u:
				MemberType = input.ReadInt32();
				break;
			case 80u:
				Level = input.ReadInt32();
				break;
			case 88u:
				BuildScore = input.ReadInt32();
				break;
			case 96u:
				MemberLimit = input.ReadInt32();
				break;
			case 104u:
			case 106u:
				tags_.AddEntriesFrom(input, _repeated_tags_codec);
				break;
			case 112u:
			case 114u:
				extraTags_.AddEntriesFrom(input, _repeated_extraTags_codec);
				break;
			case 122u:
				UnlockConditions = input.ReadString();
				break;
			case 128u:
				Sort = input.ReadInt32();
				break;
			case 136u:
				Time1 = input.ReadInt32();
				break;
			case 146u:
				RewardPreview1 = input.ReadString();
				break;
			case 154u:
				BonusPreview1 = input.ReadString();
				break;
			case 160u:
				Time2 = input.ReadInt32();
				break;
			case 170u:
				RewardPreview2 = input.ReadString();
				break;
			case 178u:
				BonusPreview2 = input.ReadString();
				break;
			case 184u:
				Time3 = input.ReadInt32();
				break;
			case 194u:
				RewardPreview3 = input.ReadString();
				break;
			case 202u:
				BonusPreview3 = input.ReadString();
				break;
			case 208u:
				Time4 = input.ReadInt32();
				break;
			case 218u:
				RewardPreview4 = input.ReadString();
				break;
			case 226u:
				BonusPreview4 = input.ReadString();
				break;
			}
		}
	}
}
