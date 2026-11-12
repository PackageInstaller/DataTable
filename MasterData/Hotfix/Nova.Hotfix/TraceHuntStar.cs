using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TraceHuntStar : IMessage<TraceHuntStar>, IMessage, IEquatable<TraceHuntStar>, IDeepCloneable<TraceHuntStar>
{
	private static readonly MessageParser<TraceHuntStar> _parser = new MessageParser<TraceHuntStar>(() => new TraceHuntStar());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int StarFieldNumber = 2;

	private int star_;

	public const int DifficultyFieldNumber = 3;

	private int difficulty_;

	public const int ScoreNeedFieldNumber = 4;

	private int scoreNeed_;

	[DebuggerNonUserCode]
	public static MessageParser<TraceHuntStar> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(996);

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
	public int Star
	{
		get
		{
			return star_;
		}
		set
		{
			star_ = value;
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
	public int ScoreNeed
	{
		get
		{
			return scoreNeed_;
		}
		set
		{
			scoreNeed_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TraceHuntStar()
	{
	}

	[DebuggerNonUserCode]
	public TraceHuntStar(TraceHuntStar other)
		: this()
	{
		id_ = other.id_;
		star_ = other.star_;
		difficulty_ = other.difficulty_;
		scoreNeed_ = other.scoreNeed_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TraceHuntStar Clone()
	{
		return new TraceHuntStar(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TraceHuntStar);
	}

	[DebuggerNonUserCode]
	public bool Equals(TraceHuntStar other)
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
		if (Star != other.Star)
		{
			return false;
		}
		if (Difficulty != other.Difficulty)
		{
			return false;
		}
		if (ScoreNeed != other.ScoreNeed)
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
		if (Star != 0)
		{
			num ^= Star.GetHashCode();
		}
		if (Difficulty != 0)
		{
			num ^= Difficulty.GetHashCode();
		}
		if (ScoreNeed != 0)
		{
			num ^= ScoreNeed.GetHashCode();
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
		if (Star != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Star);
		}
		if (Difficulty != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Difficulty);
		}
		if (ScoreNeed != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ScoreNeed);
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
		if (Star != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Star);
		}
		if (Difficulty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Difficulty);
		}
		if (ScoreNeed != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ScoreNeed);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TraceHuntStar other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Star != 0)
			{
				Star = other.Star;
			}
			if (other.Difficulty != 0)
			{
				Difficulty = other.Difficulty;
			}
			if (other.ScoreNeed != 0)
			{
				ScoreNeed = other.ScoreNeed;
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
				Star = input.ReadInt32();
				break;
			case 24u:
				Difficulty = input.ReadInt32();
				break;
			case 32u:
				ScoreNeed = input.ReadInt32();
				break;
			}
		}
	}
}
