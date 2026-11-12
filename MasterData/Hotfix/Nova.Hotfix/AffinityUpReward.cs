using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class AffinityUpReward : IMessage<AffinityUpReward>, IMessage, IEquatable<AffinityUpReward>, IDeepCloneable<AffinityUpReward>
{
	private static readonly MessageParser<AffinityUpReward> _parser = new MessageParser<AffinityUpReward>(() => new AffinityUpReward());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CharIdFieldNumber = 2;

	private int charId_;

	public const int RewardLevelFieldNumber = 3;

	private int rewardLevel_;

	public const int Reward1FieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_reward1_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> reward1_ = new RepeatedField<int>();

	public const int Reward2FieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_reward2_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> reward2_ = new RepeatedField<int>();

	public const int Reward3FieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_reward3_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> reward3_ = new RepeatedField<int>();

	public const int DescFront1FieldNumber = 7;

	private string descFront1_ = "";

	public const int DescFront2FieldNumber = 8;

	private string descFront2_ = "";

	public const int DescFront3FieldNumber = 9;

	private string descFront3_ = "";

	public const int DescAfter1FieldNumber = 10;

	private string descAfter1_ = "";

	public const int DescAfter2FieldNumber = 11;

	private string descAfter2_ = "";

	public const int DescAfter3FieldNumber = 12;

	private string descAfter3_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<AffinityUpReward> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(84);

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
	public int CharId
	{
		get
		{
			return charId_;
		}
		set
		{
			charId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardLevel
	{
		get
		{
			return rewardLevel_;
		}
		set
		{
			rewardLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Reward1 => reward1_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Reward2 => reward2_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Reward3 => reward3_;

	[DebuggerNonUserCode]
	public string DescFront1
	{
		get
		{
			return descFront1_;
		}
		set
		{
			descFront1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string DescFront2
	{
		get
		{
			return descFront2_;
		}
		set
		{
			descFront2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string DescFront3
	{
		get
		{
			return descFront3_;
		}
		set
		{
			descFront3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string DescAfter1
	{
		get
		{
			return descAfter1_;
		}
		set
		{
			descAfter1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string DescAfter2
	{
		get
		{
			return descAfter2_;
		}
		set
		{
			descAfter2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string DescAfter3
	{
		get
		{
			return descAfter3_;
		}
		set
		{
			descAfter3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public AffinityUpReward()
	{
	}

	[DebuggerNonUserCode]
	public AffinityUpReward(AffinityUpReward other)
		: this()
	{
		id_ = other.id_;
		charId_ = other.charId_;
		rewardLevel_ = other.rewardLevel_;
		reward1_ = other.reward1_.Clone();
		reward2_ = other.reward2_.Clone();
		reward3_ = other.reward3_.Clone();
		descFront1_ = other.descFront1_;
		descFront2_ = other.descFront2_;
		descFront3_ = other.descFront3_;
		descAfter1_ = other.descAfter1_;
		descAfter2_ = other.descAfter2_;
		descAfter3_ = other.descAfter3_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public AffinityUpReward Clone()
	{
		return new AffinityUpReward(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as AffinityUpReward);
	}

	[DebuggerNonUserCode]
	public bool Equals(AffinityUpReward other)
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
		if (CharId != other.CharId)
		{
			return false;
		}
		if (RewardLevel != other.RewardLevel)
		{
			return false;
		}
		if (!reward1_.Equals(other.reward1_))
		{
			return false;
		}
		if (!reward2_.Equals(other.reward2_))
		{
			return false;
		}
		if (!reward3_.Equals(other.reward3_))
		{
			return false;
		}
		if (DescFront1 != other.DescFront1)
		{
			return false;
		}
		if (DescFront2 != other.DescFront2)
		{
			return false;
		}
		if (DescFront3 != other.DescFront3)
		{
			return false;
		}
		if (DescAfter1 != other.DescAfter1)
		{
			return false;
		}
		if (DescAfter2 != other.DescAfter2)
		{
			return false;
		}
		if (DescAfter3 != other.DescAfter3)
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
		if (CharId != 0)
		{
			num ^= CharId.GetHashCode();
		}
		if (RewardLevel != 0)
		{
			num ^= RewardLevel.GetHashCode();
		}
		num ^= reward1_.GetHashCode();
		num ^= reward2_.GetHashCode();
		num ^= reward3_.GetHashCode();
		if (DescFront1.Length != 0)
		{
			num ^= DescFront1.GetHashCode();
		}
		if (DescFront2.Length != 0)
		{
			num ^= DescFront2.GetHashCode();
		}
		if (DescFront3.Length != 0)
		{
			num ^= DescFront3.GetHashCode();
		}
		if (DescAfter1.Length != 0)
		{
			num ^= DescAfter1.GetHashCode();
		}
		if (DescAfter2.Length != 0)
		{
			num ^= DescAfter2.GetHashCode();
		}
		if (DescAfter3.Length != 0)
		{
			num ^= DescAfter3.GetHashCode();
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
		if (CharId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CharId);
		}
		if (RewardLevel != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(RewardLevel);
		}
		reward1_.WriteTo(output, _repeated_reward1_codec);
		reward2_.WriteTo(output, _repeated_reward2_codec);
		reward3_.WriteTo(output, _repeated_reward3_codec);
		if (DescFront1.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(DescFront1);
		}
		if (DescFront2.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(DescFront2);
		}
		if (DescFront3.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(DescFront3);
		}
		if (DescAfter1.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(DescAfter1);
		}
		if (DescAfter2.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(DescAfter2);
		}
		if (DescAfter3.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(DescAfter3);
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
		if (CharId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharId);
		}
		if (RewardLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardLevel);
		}
		num += reward1_.CalculateSize(_repeated_reward1_codec);
		num += reward2_.CalculateSize(_repeated_reward2_codec);
		num += reward3_.CalculateSize(_repeated_reward3_codec);
		if (DescFront1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DescFront1);
		}
		if (DescFront2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DescFront2);
		}
		if (DescFront3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DescFront3);
		}
		if (DescAfter1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DescAfter1);
		}
		if (DescAfter2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DescAfter2);
		}
		if (DescAfter3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DescAfter3);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(AffinityUpReward other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.CharId != 0)
			{
				CharId = other.CharId;
			}
			if (other.RewardLevel != 0)
			{
				RewardLevel = other.RewardLevel;
			}
			reward1_.Add(other.reward1_);
			reward2_.Add(other.reward2_);
			reward3_.Add(other.reward3_);
			if (other.DescFront1.Length != 0)
			{
				DescFront1 = other.DescFront1;
			}
			if (other.DescFront2.Length != 0)
			{
				DescFront2 = other.DescFront2;
			}
			if (other.DescFront3.Length != 0)
			{
				DescFront3 = other.DescFront3;
			}
			if (other.DescAfter1.Length != 0)
			{
				DescAfter1 = other.DescAfter1;
			}
			if (other.DescAfter2.Length != 0)
			{
				DescAfter2 = other.DescAfter2;
			}
			if (other.DescAfter3.Length != 0)
			{
				DescAfter3 = other.DescAfter3;
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
				CharId = input.ReadInt32();
				break;
			case 24u:
				RewardLevel = input.ReadInt32();
				break;
			case 32u:
			case 34u:
				reward1_.AddEntriesFrom(input, _repeated_reward1_codec);
				break;
			case 40u:
			case 42u:
				reward2_.AddEntriesFrom(input, _repeated_reward2_codec);
				break;
			case 48u:
			case 50u:
				reward3_.AddEntriesFrom(input, _repeated_reward3_codec);
				break;
			case 58u:
				DescFront1 = input.ReadString();
				break;
			case 66u:
				DescFront2 = input.ReadString();
				break;
			case 74u:
				DescFront3 = input.ReadString();
				break;
			case 82u:
				DescAfter1 = input.ReadString();
				break;
			case 90u:
				DescAfter2 = input.ReadString();
				break;
			case 98u:
				DescAfter3 = input.ReadString();
				break;
			}
		}
	}
}
