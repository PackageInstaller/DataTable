using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ScoreBossStar : IMessage<ScoreBossStar>, IMessage, IEquatable<ScoreBossStar>, IDeepCloneable<ScoreBossStar>
{
	private static readonly MessageParser<ScoreBossStar> _parser = new MessageParser<ScoreBossStar>(() => new ScoreBossStar());

	private UnknownFieldSet _unknownFields;

	public const int StarFieldNumber = 1;

	private int star_;

	public const int ScoreNeedFieldNumber = 2;

	private int scoreNeed_;

	[DebuggerNonUserCode]
	public static MessageParser<ScoreBossStar> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(704);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public ScoreBossStar()
	{
	}

	[DebuggerNonUserCode]
	public ScoreBossStar(ScoreBossStar other)
		: this()
	{
		star_ = other.star_;
		scoreNeed_ = other.scoreNeed_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ScoreBossStar Clone()
	{
		return new ScoreBossStar(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ScoreBossStar);
	}

	[DebuggerNonUserCode]
	public bool Equals(ScoreBossStar other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Star != other.Star)
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
		if (Star != 0)
		{
			num ^= Star.GetHashCode();
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
		if (Star != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Star);
		}
		if (ScoreNeed != 0)
		{
			output.WriteRawTag(16);
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
		if (Star != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Star);
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
	public void MergeFrom(ScoreBossStar other)
	{
		if (other != null)
		{
			if (other.Star != 0)
			{
				Star = other.Star;
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
				Star = input.ReadInt32();
				break;
			case 16u:
				ScoreNeed = input.ReadInt32();
				break;
			}
		}
	}
}
