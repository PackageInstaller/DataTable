using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MathParkourLevel : IMessage<MathParkourLevel>, IMessage, IEquatable<MathParkourLevel>, IDeepCloneable<MathParkourLevel>
{
	private static readonly MessageParser<MathParkourLevel> _parser = new MessageParser<MathParkourLevel>(() => new MathParkourLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ActivityIdFieldNumber = 2;

	private int activityId_;

	public const int AreaListFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_areaList_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> areaList_ = new RepeatedField<int>();

	public const int ConfigIdFieldNumber = 4;

	private int configId_;

	public const int DurationFieldNumber = 5;

	private int duration_;

	public const int PreLevelFieldNumber = 6;

	private int preLevel_;

	public const int TitleFieldNumber = 7;

	private string title_ = "";

	public const int DescFieldNumber = 8;

	private string desc_ = "";

	public const int DropItemListFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_dropItemList_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> dropItemList_ = new RepeatedField<int>();

	public const int Reward1IdFieldNumber = 10;

	private int reward1Id_;

	public const int Reward1CountFieldNumber = 11;

	private int reward1Count_;

	public const int Reward2IdFieldNumber = 12;

	private int reward2Id_;

	public const int Reward2CountFieldNumber = 13;

	private int reward2Count_;

	public const int Reward3IdFieldNumber = 14;

	private int reward3Id_;

	public const int Reward3CountFieldNumber = 15;

	private int reward3Count_;

	public const int Reward1ConditionFieldNumber = 16;

	private int reward1Condition_;

	public const int Reward2ConditionFieldNumber = 17;

	private int reward2Condition_;

	public const int Reward3ConditionFieldNumber = 18;

	private int reward3Condition_;

	public const int DicIdFieldNumber = 19;

	private int dicId_;

	[DebuggerNonUserCode]
	public static MessageParser<MathParkourLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(542);

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
	public int ActivityId
	{
		get
		{
			return activityId_;
		}
		set
		{
			activityId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> AreaList => areaList_;

	[DebuggerNonUserCode]
	public int ConfigId
	{
		get
		{
			return configId_;
		}
		set
		{
			configId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Duration
	{
		get
		{
			return duration_;
		}
		set
		{
			duration_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PreLevel
	{
		get
		{
			return preLevel_;
		}
		set
		{
			preLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Title
	{
		get
		{
			return title_;
		}
		set
		{
			title_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public RepeatedField<int> DropItemList => dropItemList_;

	[DebuggerNonUserCode]
	public int Reward1Id
	{
		get
		{
			return reward1Id_;
		}
		set
		{
			reward1Id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward1Count
	{
		get
		{
			return reward1Count_;
		}
		set
		{
			reward1Count_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward2Id
	{
		get
		{
			return reward2Id_;
		}
		set
		{
			reward2Id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward2Count
	{
		get
		{
			return reward2Count_;
		}
		set
		{
			reward2Count_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward3Id
	{
		get
		{
			return reward3Id_;
		}
		set
		{
			reward3Id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward3Count
	{
		get
		{
			return reward3Count_;
		}
		set
		{
			reward3Count_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward1Condition
	{
		get
		{
			return reward1Condition_;
		}
		set
		{
			reward1Condition_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward2Condition
	{
		get
		{
			return reward2Condition_;
		}
		set
		{
			reward2Condition_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward3Condition
	{
		get
		{
			return reward3Condition_;
		}
		set
		{
			reward3Condition_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DicId
	{
		get
		{
			return dicId_;
		}
		set
		{
			dicId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public MathParkourLevel()
	{
	}

	[DebuggerNonUserCode]
	public MathParkourLevel(MathParkourLevel other)
		: this()
	{
		id_ = other.id_;
		activityId_ = other.activityId_;
		areaList_ = other.areaList_.Clone();
		configId_ = other.configId_;
		duration_ = other.duration_;
		preLevel_ = other.preLevel_;
		title_ = other.title_;
		desc_ = other.desc_;
		dropItemList_ = other.dropItemList_.Clone();
		reward1Id_ = other.reward1Id_;
		reward1Count_ = other.reward1Count_;
		reward2Id_ = other.reward2Id_;
		reward2Count_ = other.reward2Count_;
		reward3Id_ = other.reward3Id_;
		reward3Count_ = other.reward3Count_;
		reward1Condition_ = other.reward1Condition_;
		reward2Condition_ = other.reward2Condition_;
		reward3Condition_ = other.reward3Condition_;
		dicId_ = other.dicId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MathParkourLevel Clone()
	{
		return new MathParkourLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MathParkourLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(MathParkourLevel other)
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
		if (ActivityId != other.ActivityId)
		{
			return false;
		}
		if (!areaList_.Equals(other.areaList_))
		{
			return false;
		}
		if (ConfigId != other.ConfigId)
		{
			return false;
		}
		if (Duration != other.Duration)
		{
			return false;
		}
		if (PreLevel != other.PreLevel)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (!dropItemList_.Equals(other.dropItemList_))
		{
			return false;
		}
		if (Reward1Id != other.Reward1Id)
		{
			return false;
		}
		if (Reward1Count != other.Reward1Count)
		{
			return false;
		}
		if (Reward2Id != other.Reward2Id)
		{
			return false;
		}
		if (Reward2Count != other.Reward2Count)
		{
			return false;
		}
		if (Reward3Id != other.Reward3Id)
		{
			return false;
		}
		if (Reward3Count != other.Reward3Count)
		{
			return false;
		}
		if (Reward1Condition != other.Reward1Condition)
		{
			return false;
		}
		if (Reward2Condition != other.Reward2Condition)
		{
			return false;
		}
		if (Reward3Condition != other.Reward3Condition)
		{
			return false;
		}
		if (DicId != other.DicId)
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
		if (ActivityId != 0)
		{
			num ^= ActivityId.GetHashCode();
		}
		num ^= areaList_.GetHashCode();
		if (ConfigId != 0)
		{
			num ^= ConfigId.GetHashCode();
		}
		if (Duration != 0)
		{
			num ^= Duration.GetHashCode();
		}
		if (PreLevel != 0)
		{
			num ^= PreLevel.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		num ^= dropItemList_.GetHashCode();
		if (Reward1Id != 0)
		{
			num ^= Reward1Id.GetHashCode();
		}
		if (Reward1Count != 0)
		{
			num ^= Reward1Count.GetHashCode();
		}
		if (Reward2Id != 0)
		{
			num ^= Reward2Id.GetHashCode();
		}
		if (Reward2Count != 0)
		{
			num ^= Reward2Count.GetHashCode();
		}
		if (Reward3Id != 0)
		{
			num ^= Reward3Id.GetHashCode();
		}
		if (Reward3Count != 0)
		{
			num ^= Reward3Count.GetHashCode();
		}
		if (Reward1Condition != 0)
		{
			num ^= Reward1Condition.GetHashCode();
		}
		if (Reward2Condition != 0)
		{
			num ^= Reward2Condition.GetHashCode();
		}
		if (Reward3Condition != 0)
		{
			num ^= Reward3Condition.GetHashCode();
		}
		if (DicId != 0)
		{
			num ^= DicId.GetHashCode();
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
		if (ActivityId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ActivityId);
		}
		areaList_.WriteTo(output, _repeated_areaList_codec);
		if (ConfigId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ConfigId);
		}
		if (Duration != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Duration);
		}
		if (PreLevel != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(PreLevel);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Title);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Desc);
		}
		dropItemList_.WriteTo(output, _repeated_dropItemList_codec);
		if (Reward1Id != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Reward1Id);
		}
		if (Reward1Count != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(Reward1Count);
		}
		if (Reward2Id != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(Reward2Id);
		}
		if (Reward2Count != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(Reward2Count);
		}
		if (Reward3Id != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(Reward3Id);
		}
		if (Reward3Count != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(Reward3Count);
		}
		if (Reward1Condition != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(Reward1Condition);
		}
		if (Reward2Condition != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(Reward2Condition);
		}
		if (Reward3Condition != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(Reward3Condition);
		}
		if (DicId != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(DicId);
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
		if (ActivityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityId);
		}
		num += areaList_.CalculateSize(_repeated_areaList_codec);
		if (ConfigId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ConfigId);
		}
		if (Duration != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Duration);
		}
		if (PreLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevel);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		num += dropItemList_.CalculateSize(_repeated_dropItemList_codec);
		if (Reward1Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward1Id);
		}
		if (Reward1Count != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward1Count);
		}
		if (Reward2Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward2Id);
		}
		if (Reward2Count != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward2Count);
		}
		if (Reward3Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward3Id);
		}
		if (Reward3Count != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward3Count);
		}
		if (Reward1Condition != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Reward1Condition);
		}
		if (Reward2Condition != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Reward2Condition);
		}
		if (Reward3Condition != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Reward3Condition);
		}
		if (DicId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DicId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MathParkourLevel other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			areaList_.Add(other.areaList_);
			if (other.ConfigId != 0)
			{
				ConfigId = other.ConfigId;
			}
			if (other.Duration != 0)
			{
				Duration = other.Duration;
			}
			if (other.PreLevel != 0)
			{
				PreLevel = other.PreLevel;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			dropItemList_.Add(other.dropItemList_);
			if (other.Reward1Id != 0)
			{
				Reward1Id = other.Reward1Id;
			}
			if (other.Reward1Count != 0)
			{
				Reward1Count = other.Reward1Count;
			}
			if (other.Reward2Id != 0)
			{
				Reward2Id = other.Reward2Id;
			}
			if (other.Reward2Count != 0)
			{
				Reward2Count = other.Reward2Count;
			}
			if (other.Reward3Id != 0)
			{
				Reward3Id = other.Reward3Id;
			}
			if (other.Reward3Count != 0)
			{
				Reward3Count = other.Reward3Count;
			}
			if (other.Reward1Condition != 0)
			{
				Reward1Condition = other.Reward1Condition;
			}
			if (other.Reward2Condition != 0)
			{
				Reward2Condition = other.Reward2Condition;
			}
			if (other.Reward3Condition != 0)
			{
				Reward3Condition = other.Reward3Condition;
			}
			if (other.DicId != 0)
			{
				DicId = other.DicId;
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
				ActivityId = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				areaList_.AddEntriesFrom(input, _repeated_areaList_codec);
				break;
			case 32u:
				ConfigId = input.ReadInt32();
				break;
			case 40u:
				Duration = input.ReadInt32();
				break;
			case 48u:
				PreLevel = input.ReadInt32();
				break;
			case 58u:
				Title = input.ReadString();
				break;
			case 66u:
				Desc = input.ReadString();
				break;
			case 72u:
			case 74u:
				dropItemList_.AddEntriesFrom(input, _repeated_dropItemList_codec);
				break;
			case 80u:
				Reward1Id = input.ReadInt32();
				break;
			case 88u:
				Reward1Count = input.ReadInt32();
				break;
			case 96u:
				Reward2Id = input.ReadInt32();
				break;
			case 104u:
				Reward2Count = input.ReadInt32();
				break;
			case 112u:
				Reward3Id = input.ReadInt32();
				break;
			case 120u:
				Reward3Count = input.ReadInt32();
				break;
			case 128u:
				Reward1Condition = input.ReadInt32();
				break;
			case 136u:
				Reward2Condition = input.ReadInt32();
				break;
			case 144u:
				Reward3Condition = input.ReadInt32();
				break;
			case 152u:
				DicId = input.ReadInt32();
				break;
			}
		}
	}
}
