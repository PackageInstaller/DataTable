using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class ParryActionInfo : IMessage<ParryActionInfo>, IMessage, IEquatable<ParryActionInfo>, IDeepCloneable<ParryActionInfo>
{
	private static readonly MessageParser<ParryActionInfo> _parser = new MessageParser<ParryActionInfo>(() => new ParryActionInfo());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int StartFieldNumber = 2;

	private int start_;

	public const int DurationFieldNumber = 3;

	private int duration_;

	public const int AngleOffsetFieldNumber = 4;

	private int angleOffset_;

	public const int AngleFieldNumber = 5;

	private int angle_;

	public const int HitIndexFieldNumber = 6;

	private int hitIndex_;

	[DebuggerNonUserCode]
	public static MessageParser<ParryActionInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[44];

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
	public int Start
	{
		get
		{
			return start_;
		}
		set
		{
			start_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Duration
	{
		get
		{
			return duration_;
		}
		set
		{
			duration_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AngleOffset
	{
		get
		{
			return angleOffset_;
		}
		set
		{
			angleOffset_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Angle
	{
		get
		{
			return angle_;
		}
		set
		{
			angle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HitIndex
	{
		get
		{
			return hitIndex_;
		}
		set
		{
			hitIndex_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ParryActionInfo()
	{
	}

	[DebuggerNonUserCode]
	public ParryActionInfo(ParryActionInfo other)
		: this()
	{
		iD_ = other.iD_;
		start_ = other.start_;
		duration_ = other.duration_;
		angleOffset_ = other.angleOffset_;
		angle_ = other.angle_;
		hitIndex_ = other.hitIndex_;
	}

	[DebuggerNonUserCode]
	public ParryActionInfo Clone()
	{
		return new ParryActionInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ParryActionInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(ParryActionInfo other)
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
		if (Start != other.Start)
		{
			return false;
		}
		if (Duration != other.Duration)
		{
			return false;
		}
		if (AngleOffset != other.AngleOffset)
		{
			return false;
		}
		if (Angle != other.Angle)
		{
			return false;
		}
		if (HitIndex != other.HitIndex)
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
		if (Start != 0)
		{
			num ^= Start.GetHashCode();
		}
		if (Duration != 0)
		{
			num ^= Duration.GetHashCode();
		}
		if (AngleOffset != 0)
		{
			num ^= AngleOffset.GetHashCode();
		}
		if (Angle != 0)
		{
			num ^= Angle.GetHashCode();
		}
		if (HitIndex != 0)
		{
			num ^= HitIndex.GetHashCode();
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
		if (Start != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Start);
		}
		if (Duration != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Duration);
		}
		if (AngleOffset != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(AngleOffset);
		}
		if (Angle != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Angle);
		}
		if (HitIndex != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(HitIndex);
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
		if (Start != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Start);
		}
		if (Duration != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Duration);
		}
		if (AngleOffset != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AngleOffset);
		}
		if (Angle != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Angle);
		}
		if (HitIndex != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HitIndex);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ParryActionInfo other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Start != 0)
			{
				Start = other.Start;
			}
			if (other.Duration != 0)
			{
				Duration = other.Duration;
			}
			if (other.AngleOffset != 0)
			{
				AngleOffset = other.AngleOffset;
			}
			if (other.Angle != 0)
			{
				Angle = other.Angle;
			}
			if (other.HitIndex != 0)
			{
				HitIndex = other.HitIndex;
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
				Start = input.ReadInt32();
				break;
			case 24u:
				Duration = input.ReadInt32();
				break;
			case 32u:
				AngleOffset = input.ReadInt32();
				break;
			case 40u:
				Angle = input.ReadInt32();
				break;
			case 48u:
				HitIndex = input.ReadInt32();
				break;
			}
		}
	}
}
