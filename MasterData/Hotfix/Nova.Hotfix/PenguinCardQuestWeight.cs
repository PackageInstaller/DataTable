using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PenguinCardQuestWeight : IMessage<PenguinCardQuestWeight>, IMessage, IEquatable<PenguinCardQuestWeight>, IDeepCloneable<PenguinCardQuestWeight>
{
	private static readonly MessageParser<PenguinCardQuestWeight> _parser = new MessageParser<PenguinCardQuestWeight>(() => new PenguinCardQuestWeight());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int TurnFieldNumber = 3;

	private int turn_;

	public const int QuestListFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_questList_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> questList_ = new RepeatedField<int>();

	public const int WeightFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_weight_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> weight_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<PenguinCardQuestWeight> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(638);

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
	public RepeatedField<int> QuestList => questList_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Weight => weight_;

	[DebuggerNonUserCode]
	public PenguinCardQuestWeight()
	{
	}

	[DebuggerNonUserCode]
	public PenguinCardQuestWeight(PenguinCardQuestWeight other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		turn_ = other.turn_;
		questList_ = other.questList_.Clone();
		weight_ = other.weight_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PenguinCardQuestWeight Clone()
	{
		return new PenguinCardQuestWeight(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PenguinCardQuestWeight);
	}

	[DebuggerNonUserCode]
	public bool Equals(PenguinCardQuestWeight other)
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
		if (!questList_.Equals(other.questList_))
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
		num ^= questList_.GetHashCode();
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
		questList_.WriteTo(output, _repeated_questList_codec);
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
		num += questList_.CalculateSize(_repeated_questList_codec);
		num += weight_.CalculateSize(_repeated_weight_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PenguinCardQuestWeight other)
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
			questList_.Add(other.questList_);
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
				questList_.AddEntriesFrom(input, _repeated_questList_codec);
				break;
			case 40u:
			case 42u:
				weight_.AddEntriesFrom(input, _repeated_weight_codec);
				break;
			}
		}
	}
}
