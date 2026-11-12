using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PenguinCardCost : IMessage<PenguinCardCost>, IMessage, IEquatable<PenguinCardCost>, IDeepCloneable<PenguinCardCost>
{
	private static readonly MessageParser<PenguinCardCost> _parser = new MessageParser<PenguinCardCost>(() => new PenguinCardCost());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CountFieldNumber = 2;

	private int count_;

	public const int TurnFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_turn_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> turn_ = new RepeatedField<int>();

	public const int CostFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_cost_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> cost_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<PenguinCardCost> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(626);

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
	public int Count
	{
		get
		{
			return count_;
		}
		set
		{
			count_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Turn => turn_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Cost => cost_;

	[DebuggerNonUserCode]
	public PenguinCardCost()
	{
	}

	[DebuggerNonUserCode]
	public PenguinCardCost(PenguinCardCost other)
		: this()
	{
		id_ = other.id_;
		count_ = other.count_;
		turn_ = other.turn_.Clone();
		cost_ = other.cost_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PenguinCardCost Clone()
	{
		return new PenguinCardCost(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PenguinCardCost);
	}

	[DebuggerNonUserCode]
	public bool Equals(PenguinCardCost other)
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
		if (Count != other.Count)
		{
			return false;
		}
		if (!turn_.Equals(other.turn_))
		{
			return false;
		}
		if (!cost_.Equals(other.cost_))
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
		if (Count != 0)
		{
			num ^= Count.GetHashCode();
		}
		num ^= turn_.GetHashCode();
		num ^= cost_.GetHashCode();
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
		if (Count != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Count);
		}
		turn_.WriteTo(output, _repeated_turn_codec);
		cost_.WriteTo(output, _repeated_cost_codec);
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
		if (Count != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Count);
		}
		num += turn_.CalculateSize(_repeated_turn_codec);
		num += cost_.CalculateSize(_repeated_cost_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PenguinCardCost other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Count != 0)
			{
				Count = other.Count;
			}
			turn_.Add(other.turn_);
			cost_.Add(other.cost_);
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
				Count = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				turn_.AddEntriesFrom(input, _repeated_turn_codec);
				break;
			case 32u:
			case 34u:
				cost_.AddEntriesFrom(input, _repeated_cost_codec);
				break;
			}
		}
	}
}
