using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TraceHuntDifficulty : IMessage<TraceHuntDifficulty>, IMessage, IEquatable<TraceHuntDifficulty>, IDeepCloneable<TraceHuntDifficulty>
{
	private static readonly MessageParser<TraceHuntDifficulty> _parser = new MessageParser<TraceHuntDifficulty>(() => new TraceHuntDifficulty());

	private UnknownFieldSet _unknownFields;

	public const int DifficultyFieldNumber = 1;

	private int difficulty_;

	public const int TokenRateFieldNumber = 2;

	private int tokenRate_;

	[DebuggerNonUserCode]
	public static MessageParser<TraceHuntDifficulty> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(982);

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
	public int TokenRate
	{
		get
		{
			return tokenRate_;
		}
		set
		{
			tokenRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TraceHuntDifficulty()
	{
	}

	[DebuggerNonUserCode]
	public TraceHuntDifficulty(TraceHuntDifficulty other)
		: this()
	{
		difficulty_ = other.difficulty_;
		tokenRate_ = other.tokenRate_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TraceHuntDifficulty Clone()
	{
		return new TraceHuntDifficulty(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TraceHuntDifficulty);
	}

	[DebuggerNonUserCode]
	public bool Equals(TraceHuntDifficulty other)
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
		if (TokenRate != other.TokenRate)
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
		if (TokenRate != 0)
		{
			num ^= TokenRate.GetHashCode();
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
		if (TokenRate != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(TokenRate);
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
		if (TokenRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TokenRate);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TraceHuntDifficulty other)
	{
		if (other != null)
		{
			if (other.Difficulty != 0)
			{
				Difficulty = other.Difficulty;
			}
			if (other.TokenRate != 0)
			{
				TokenRate = other.TokenRate;
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
				TokenRate = input.ReadInt32();
				break;
			}
		}
	}
}
