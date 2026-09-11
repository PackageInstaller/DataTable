using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class Keyframe : IMessage<Keyframe>, IMessage, IEquatable<Keyframe>, IDeepCloneable<Keyframe>
{
	private static readonly MessageParser<Keyframe> _parser = new MessageParser<Keyframe>(() => new Keyframe());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int TimeFieldNumber = 2;

	private int time_;

	public const int ValueFieldNumber = 3;

	private int value_;

	public const int InSlopeFieldNumber = 4;

	private int inSlope_;

	public const int OutSlopeFieldNumber = 5;

	private int outSlope_;

	[DebuggerNonUserCode]
	public static MessageParser<Keyframe> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[36];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ID
	{
		get
		{
			return iD_;
		}
		set
		{
			iD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Time
	{
		get
		{
			return time_;
		}
		set
		{
			time_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Value
	{
		get
		{
			return value_;
		}
		set
		{
			value_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int InSlope
	{
		get
		{
			return inSlope_;
		}
		set
		{
			inSlope_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int OutSlope
	{
		get
		{
			return outSlope_;
		}
		set
		{
			outSlope_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Keyframe()
	{
	}

	[DebuggerNonUserCode]
	public Keyframe(Keyframe other)
		: this()
	{
		iD_ = other.iD_;
		time_ = other.time_;
		value_ = other.value_;
		inSlope_ = other.inSlope_;
		outSlope_ = other.outSlope_;
	}

	[DebuggerNonUserCode]
	public Keyframe Clone()
	{
		return new Keyframe(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Keyframe);
	}

	[DebuggerNonUserCode]
	public bool Equals(Keyframe other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ID != other.ID)
		{
			return false;
		}
		if (Time != other.Time)
		{
			return false;
		}
		if (Value != other.Value)
		{
			return false;
		}
		if (InSlope != other.InSlope)
		{
			return false;
		}
		if (OutSlope != other.OutSlope)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		if (Time != 0)
		{
			num ^= Time.GetHashCode();
		}
		if (Value != 0)
		{
			num ^= Value.GetHashCode();
		}
		if (InSlope != 0)
		{
			num ^= InSlope.GetHashCode();
		}
		if (OutSlope != 0)
		{
			num ^= OutSlope.GetHashCode();
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
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		if (Time != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Time);
		}
		if (Value != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Value);
		}
		if (InSlope != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(InSlope);
		}
		if (OutSlope != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(OutSlope);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (Time != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Time);
		}
		if (Value != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Value);
		}
		if (InSlope != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(InSlope);
		}
		if (OutSlope != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OutSlope);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Keyframe other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Time != 0)
			{
				Time = other.Time;
			}
			if (other.Value != 0)
			{
				Value = other.Value;
			}
			if (other.InSlope != 0)
			{
				InSlope = other.InSlope;
			}
			if (other.OutSlope != 0)
			{
				OutSlope = other.OutSlope;
			}
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
				input.SkipLastField();
				break;
			case 8u:
				ID = input.ReadInt32();
				break;
			case 16u:
				Time = input.ReadInt32();
				break;
			case 24u:
				Value = input.ReadInt32();
				break;
			case 32u:
				InSlope = input.ReadInt32();
				break;
			case 40u:
				OutSlope = input.ReadInt32();
				break;
			}
		}
	}
}
