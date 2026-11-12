using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TravelerDuelIdleRewards : IMessage<TravelerDuelIdleRewards>, IMessage, IEquatable<TravelerDuelIdleRewards>, IDeepCloneable<TravelerDuelIdleRewards>
{
	private static readonly MessageParser<TravelerDuelIdleRewards> _parser = new MessageParser<TravelerDuelIdleRewards>(() => new TravelerDuelIdleRewards());

	private UnknownFieldSet _unknownFields;

	public const int DifficultyFieldNumber = 1;

	private int difficulty_;

	public const int TypeAValueFieldNumber = 2;

	private int typeAValue_;

	public const int TypeBValueFieldNumber = 3;

	private int typeBValue_;

	public const int TypeCValueFieldNumber = 4;

	private int typeCValue_;

	[DebuggerNonUserCode]
	public static MessageParser<TravelerDuelIdleRewards> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1022);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public int TypeAValue
	{
		get
		{
			return typeAValue_;
		}
		set
		{
			typeAValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TypeBValue
	{
		get
		{
			return typeBValue_;
		}
		set
		{
			typeBValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TypeCValue
	{
		get
		{
			return typeCValue_;
		}
		set
		{
			typeCValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TravelerDuelIdleRewards()
	{
	}

	[DebuggerNonUserCode]
	public TravelerDuelIdleRewards(TravelerDuelIdleRewards other)
		: this()
	{
		difficulty_ = other.difficulty_;
		typeAValue_ = other.typeAValue_;
		typeBValue_ = other.typeBValue_;
		typeCValue_ = other.typeCValue_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TravelerDuelIdleRewards Clone()
	{
		return new TravelerDuelIdleRewards(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TravelerDuelIdleRewards);
	}

	[DebuggerNonUserCode]
	public bool Equals(TravelerDuelIdleRewards other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Difficulty != other.Difficulty)
		{
			return false;
		}
		if (TypeAValue != other.TypeAValue)
		{
			return false;
		}
		if (TypeBValue != other.TypeBValue)
		{
			return false;
		}
		if (TypeCValue != other.TypeCValue)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Difficulty != 0)
		{
			num ^= Difficulty.GetHashCode();
		}
		if (TypeAValue != 0)
		{
			num ^= TypeAValue.GetHashCode();
		}
		if (TypeBValue != 0)
		{
			num ^= TypeBValue.GetHashCode();
		}
		if (TypeCValue != 0)
		{
			num ^= TypeCValue.GetHashCode();
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
		if (Difficulty != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Difficulty);
		}
		if (TypeAValue != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(TypeAValue);
		}
		if (TypeBValue != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(TypeBValue);
		}
		if (TypeCValue != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(TypeCValue);
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
		if (Difficulty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Difficulty);
		}
		if (TypeAValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TypeAValue);
		}
		if (TypeBValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TypeBValue);
		}
		if (TypeCValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TypeCValue);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TravelerDuelIdleRewards other)
	{
		if (other != null)
		{
			if (other.Difficulty != 0)
			{
				Difficulty = other.Difficulty;
			}
			if (other.TypeAValue != 0)
			{
				TypeAValue = other.TypeAValue;
			}
			if (other.TypeBValue != 0)
			{
				TypeBValue = other.TypeBValue;
			}
			if (other.TypeCValue != 0)
			{
				TypeCValue = other.TypeCValue;
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
				Difficulty = input.ReadInt32();
				break;
			case 16u:
				TypeAValue = input.ReadInt32();
				break;
			case 24u:
				TypeBValue = input.ReadInt32();
				break;
			case 32u:
				TypeCValue = input.ReadInt32();
				break;
			}
		}
	}
}
