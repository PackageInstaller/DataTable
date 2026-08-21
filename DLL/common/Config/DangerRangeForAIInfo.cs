using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class DangerRangeForAIInfo : IMessage<DangerRangeForAIInfo>, IMessage, IEquatable<DangerRangeForAIInfo>, IDeepCloneable<DangerRangeForAIInfo>
{
	private static readonly MessageParser<DangerRangeForAIInfo> _parser = new MessageParser<DangerRangeForAIInfo>(() => new DangerRangeForAIInfo());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int StartFieldNumber = 2;

	private int start_;

	public const int DurationFieldNumber = 3;

	private int duration_;

	public const int RangeTypeFieldNumber = 4;

	private RangeType rangeType_;

	public const int RadiusFieldNumber = 5;

	private int radius_;

	public const int AngleFieldNumber = 6;

	private int angle_;

	public const int LengthFieldNumber = 7;

	private int length_;

	public const int WidthFieldNumber = 8;

	private int width_;

	public const int CenterOffsetFieldNumber = 9;

	private VectorInt3 centerOffset_;

	public const int OffsetOfFowardFieldNumber = 10;

	private int offsetOfFoward_;

	[DebuggerNonUserCode]
	public static MessageParser<DangerRangeForAIInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[27];

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
	public RangeType RangeType
	{
		get
		{
			return rangeType_;
		}
		set
		{
			rangeType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Radius
	{
		get
		{
			return radius_;
		}
		set
		{
			radius_ = value;
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
	public int Length
	{
		get
		{
			return length_;
		}
		set
		{
			length_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Width
	{
		get
		{
			return width_;
		}
		set
		{
			width_ = value;
		}
	}

	[DebuggerNonUserCode]
	public VectorInt3 CenterOffset
	{
		get
		{
			return centerOffset_;
		}
		set
		{
			centerOffset_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int OffsetOfFoward
	{
		get
		{
			return offsetOfFoward_;
		}
		set
		{
			offsetOfFoward_ = value;
		}
	}

	[DebuggerNonUserCode]
	public DangerRangeForAIInfo()
	{
	}

	[DebuggerNonUserCode]
	public DangerRangeForAIInfo(DangerRangeForAIInfo other)
		: this()
	{
		iD_ = other.iD_;
		start_ = other.start_;
		duration_ = other.duration_;
		rangeType_ = other.rangeType_;
		radius_ = other.radius_;
		angle_ = other.angle_;
		length_ = other.length_;
		width_ = other.width_;
		CenterOffset = ((other.centerOffset_ != null) ? other.CenterOffset.Clone() : null);
		offsetOfFoward_ = other.offsetOfFoward_;
	}

	[DebuggerNonUserCode]
	public DangerRangeForAIInfo Clone()
	{
		return new DangerRangeForAIInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DangerRangeForAIInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(DangerRangeForAIInfo other)
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
		if (RangeType != other.RangeType)
		{
			return false;
		}
		if (Radius != other.Radius)
		{
			return false;
		}
		if (Angle != other.Angle)
		{
			return false;
		}
		if (Length != other.Length)
		{
			return false;
		}
		if (Width != other.Width)
		{
			return false;
		}
		if (!object.Equals(CenterOffset, other.CenterOffset))
		{
			return false;
		}
		if (OffsetOfFoward != other.OffsetOfFoward)
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
		if (RangeType != RangeType.None)
		{
			num ^= RangeType.GetHashCode();
		}
		if (Radius != 0)
		{
			num ^= Radius.GetHashCode();
		}
		if (Angle != 0)
		{
			num ^= Angle.GetHashCode();
		}
		if (Length != 0)
		{
			num ^= Length.GetHashCode();
		}
		if (Width != 0)
		{
			num ^= Width.GetHashCode();
		}
		if (centerOffset_ != null)
		{
			num ^= CenterOffset.GetHashCode();
		}
		if (OffsetOfFoward != 0)
		{
			num ^= OffsetOfFoward.GetHashCode();
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
		if (RangeType != RangeType.None)
		{
			output.WriteRawTag(32);
			output.WriteEnum((int)RangeType);
		}
		if (Radius != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Radius);
		}
		if (Angle != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Angle);
		}
		if (Length != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Length);
		}
		if (Width != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Width);
		}
		if (centerOffset_ != null)
		{
			output.WriteRawTag(74);
			output.WriteMessage(CenterOffset);
		}
		if (OffsetOfFoward != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(OffsetOfFoward);
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
		if (RangeType != RangeType.None)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)RangeType);
		}
		if (Radius != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Radius);
		}
		if (Angle != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Angle);
		}
		if (Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Length);
		}
		if (Width != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Width);
		}
		if (centerOffset_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(CenterOffset);
		}
		if (OffsetOfFoward != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OffsetOfFoward);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DangerRangeForAIInfo other)
	{
		if (other == null)
		{
			return;
		}
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
		if (other.RangeType != RangeType.None)
		{
			RangeType = other.RangeType;
		}
		if (other.Radius != 0)
		{
			Radius = other.Radius;
		}
		if (other.Angle != 0)
		{
			Angle = other.Angle;
		}
		if (other.Length != 0)
		{
			Length = other.Length;
		}
		if (other.Width != 0)
		{
			Width = other.Width;
		}
		if (other.centerOffset_ != null)
		{
			if (centerOffset_ == null)
			{
				centerOffset_ = new VectorInt3();
			}
			CenterOffset.MergeFrom(other.CenterOffset);
		}
		if (other.OffsetOfFoward != 0)
		{
			OffsetOfFoward = other.OffsetOfFoward;
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
				rangeType_ = (RangeType)input.ReadEnum();
				break;
			case 40u:
				Radius = input.ReadInt32();
				break;
			case 48u:
				Angle = input.ReadInt32();
				break;
			case 56u:
				Length = input.ReadInt32();
				break;
			case 64u:
				Width = input.ReadInt32();
				break;
			case 74u:
				if (centerOffset_ == null)
				{
					centerOffset_ = new VectorInt3();
				}
				input.ReadMessage(centerOffset_);
				break;
			case 80u:
				OffsetOfFoward = input.ReadInt32();
				break;
			}
		}
	}
}
