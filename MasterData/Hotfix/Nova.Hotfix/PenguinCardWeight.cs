using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PenguinCardWeight : IMessage<PenguinCardWeight>, IMessage, IEquatable<PenguinCardWeight>, IDeepCloneable<PenguinCardWeight>
{
	private static readonly MessageParser<PenguinCardWeight> _parser = new MessageParser<PenguinCardWeight>(() => new PenguinCardWeight());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int TurnFieldNumber = 3;

	private int turn_;

	public const int CardListFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_cardList_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> cardList_ = new RepeatedField<int>();

	public const int WeightFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_weight_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> weight_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<PenguinCardWeight> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(642);

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
	public int GroupId
	{
		get
		{
			return groupId_;
		}
		set
		{
			groupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Turn
	{
		get
		{
			return turn_;
		}
		set
		{
			turn_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> CardList => cardList_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Weight => weight_;

	[DebuggerNonUserCode]
	public PenguinCardWeight()
	{
	}

	[DebuggerNonUserCode]
	public PenguinCardWeight(PenguinCardWeight other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		turn_ = other.turn_;
		cardList_ = other.cardList_.Clone();
		weight_ = other.weight_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PenguinCardWeight Clone()
	{
		return new PenguinCardWeight(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PenguinCardWeight);
	}

	[DebuggerNonUserCode]
	public bool Equals(PenguinCardWeight other)
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
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (Turn != other.Turn)
		{
			return false;
		}
		if (!cardList_.Equals(other.cardList_))
		{
			return false;
		}
		if (!weight_.Equals(other.weight_))
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
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (Turn != 0)
		{
			num ^= Turn.GetHashCode();
		}
		num ^= cardList_.GetHashCode();
		num ^= weight_.GetHashCode();
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
		if (GroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GroupId);
		}
		if (Turn != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Turn);
		}
		cardList_.WriteTo(output, _repeated_cardList_codec);
		weight_.WriteTo(output, _repeated_weight_codec);
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
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (Turn != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Turn);
		}
		num += cardList_.CalculateSize(_repeated_cardList_codec);
		num += weight_.CalculateSize(_repeated_weight_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PenguinCardWeight other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.Turn != 0)
			{
				Turn = other.Turn;
			}
			cardList_.Add(other.cardList_);
			weight_.Add(other.weight_);
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
				GroupId = input.ReadInt32();
				break;
			case 24u:
				Turn = input.ReadInt32();
				break;
			case 32u:
			case 34u:
				cardList_.AddEntriesFrom(input, _repeated_cardList_codec);
				break;
			case 40u:
			case 42u:
				weight_.AddEntriesFrom(input, _repeated_weight_codec);
				break;
			}
		}
	}
}
