using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PenguinCardFixedTurn : IMessage<PenguinCardFixedTurn>, IMessage, IEquatable<PenguinCardFixedTurn>, IDeepCloneable<PenguinCardFixedTurn>
{
	private static readonly MessageParser<PenguinCardFixedTurn> _parser = new MessageParser<PenguinCardFixedTurn>(() => new PenguinCardFixedTurn());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int TurnFieldNumber = 3;

	private int turn_;

	public const int RoundFieldNumber = 4;

	private int round_;

	public const int BaseCardIdFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_baseCardId_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> baseCardId_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<PenguinCardFixedTurn> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(630);

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
	public int Round
	{
		get
		{
			return round_;
		}
		set
		{
			round_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> BaseCardId => baseCardId_;

	[DebuggerNonUserCode]
	public PenguinCardFixedTurn()
	{
	}

	[DebuggerNonUserCode]
	public PenguinCardFixedTurn(PenguinCardFixedTurn other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		turn_ = other.turn_;
		round_ = other.round_;
		baseCardId_ = other.baseCardId_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PenguinCardFixedTurn Clone()
	{
		return new PenguinCardFixedTurn(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PenguinCardFixedTurn);
	}

	[DebuggerNonUserCode]
	public bool Equals(PenguinCardFixedTurn other)
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
		if (Round != other.Round)
		{
			return false;
		}
		if (!baseCardId_.Equals(other.baseCardId_))
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
		if (Round != 0)
		{
			num ^= Round.GetHashCode();
		}
		num ^= baseCardId_.GetHashCode();
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
		if (Round != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Round);
		}
		baseCardId_.WriteTo(output, _repeated_baseCardId_codec);
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
		if (Round != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Round);
		}
		num += baseCardId_.CalculateSize(_repeated_baseCardId_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PenguinCardFixedTurn other)
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
			if (other.Round != 0)
			{
				Round = other.Round;
			}
			baseCardId_.Add(other.baseCardId_);
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
				Round = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				baseCardId_.AddEntriesFrom(input, _repeated_baseCardId_codec);
				break;
			}
		}
	}
}
