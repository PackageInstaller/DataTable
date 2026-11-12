using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ThrowGiftGuideLine : IMessage<ThrowGiftGuideLine>, IMessage, IEquatable<ThrowGiftGuideLine>, IDeepCloneable<ThrowGiftGuideLine>
{
	private static readonly MessageParser<ThrowGiftGuideLine> _parser = new MessageParser<ThrowGiftGuideLine>(() => new ThrowGiftGuideLine());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int SpeedFieldNumber = 2;

	private int speed_;

	public const int AngleFieldNumber = 3;

	private int angle_;

	public const int SpeedThresholdFieldNumber = 4;

	private int speedThreshold_;

	public const int AngleThresholdFieldNumber = 5;

	private int angleThreshold_;

	public const int StartPointTimeFieldNumber = 6;

	private int startPointTime_;

	public const int EndPointTimeFieldNumber = 7;

	private int endPointTime_;

	public const int GuideLinePointIntervalFieldNumber = 8;

	private int guideLinePointInterval_;

	[DebuggerNonUserCode]
	public static MessageParser<ThrowGiftGuideLine> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(928);

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
	public int Speed
	{
		get
		{
			return speed_;
		}
		set
		{
			speed_ = value;
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
	public int SpeedThreshold
	{
		get
		{
			return speedThreshold_;
		}
		set
		{
			speedThreshold_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AngleThreshold
	{
		get
		{
			return angleThreshold_;
		}
		set
		{
			angleThreshold_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int StartPointTime
	{
		get
		{
			return startPointTime_;
		}
		set
		{
			startPointTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EndPointTime
	{
		get
		{
			return endPointTime_;
		}
		set
		{
			endPointTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GuideLinePointInterval
	{
		get
		{
			return guideLinePointInterval_;
		}
		set
		{
			guideLinePointInterval_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ThrowGiftGuideLine()
	{
	}

	[DebuggerNonUserCode]
	public ThrowGiftGuideLine(ThrowGiftGuideLine other)
		: this()
	{
		id_ = other.id_;
		speed_ = other.speed_;
		angle_ = other.angle_;
		speedThreshold_ = other.speedThreshold_;
		angleThreshold_ = other.angleThreshold_;
		startPointTime_ = other.startPointTime_;
		endPointTime_ = other.endPointTime_;
		guideLinePointInterval_ = other.guideLinePointInterval_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ThrowGiftGuideLine Clone()
	{
		return new ThrowGiftGuideLine(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ThrowGiftGuideLine);
	}

	[DebuggerNonUserCode]
	public bool Equals(ThrowGiftGuideLine other)
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
		if (Speed != other.Speed)
		{
			return false;
		}
		if (Angle != other.Angle)
		{
			return false;
		}
		if (SpeedThreshold != other.SpeedThreshold)
		{
			return false;
		}
		if (AngleThreshold != other.AngleThreshold)
		{
			return false;
		}
		if (StartPointTime != other.StartPointTime)
		{
			return false;
		}
		if (EndPointTime != other.EndPointTime)
		{
			return false;
		}
		if (GuideLinePointInterval != other.GuideLinePointInterval)
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
		if (Speed != 0)
		{
			num ^= Speed.GetHashCode();
		}
		if (Angle != 0)
		{
			num ^= Angle.GetHashCode();
		}
		if (SpeedThreshold != 0)
		{
			num ^= SpeedThreshold.GetHashCode();
		}
		if (AngleThreshold != 0)
		{
			num ^= AngleThreshold.GetHashCode();
		}
		if (StartPointTime != 0)
		{
			num ^= StartPointTime.GetHashCode();
		}
		if (EndPointTime != 0)
		{
			num ^= EndPointTime.GetHashCode();
		}
		if (GuideLinePointInterval != 0)
		{
			num ^= GuideLinePointInterval.GetHashCode();
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
		if (Speed != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Speed);
		}
		if (Angle != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Angle);
		}
		if (SpeedThreshold != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(SpeedThreshold);
		}
		if (AngleThreshold != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(AngleThreshold);
		}
		if (StartPointTime != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(StartPointTime);
		}
		if (EndPointTime != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(EndPointTime);
		}
		if (GuideLinePointInterval != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(GuideLinePointInterval);
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
		if (Speed != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Speed);
		}
		if (Angle != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Angle);
		}
		if (SpeedThreshold != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SpeedThreshold);
		}
		if (AngleThreshold != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AngleThreshold);
		}
		if (StartPointTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StartPointTime);
		}
		if (EndPointTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EndPointTime);
		}
		if (GuideLinePointInterval != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GuideLinePointInterval);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ThrowGiftGuideLine other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Speed != 0)
			{
				Speed = other.Speed;
			}
			if (other.Angle != 0)
			{
				Angle = other.Angle;
			}
			if (other.SpeedThreshold != 0)
			{
				SpeedThreshold = other.SpeedThreshold;
			}
			if (other.AngleThreshold != 0)
			{
				AngleThreshold = other.AngleThreshold;
			}
			if (other.StartPointTime != 0)
			{
				StartPointTime = other.StartPointTime;
			}
			if (other.EndPointTime != 0)
			{
				EndPointTime = other.EndPointTime;
			}
			if (other.GuideLinePointInterval != 0)
			{
				GuideLinePointInterval = other.GuideLinePointInterval;
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
				Speed = input.ReadInt32();
				break;
			case 24u:
				Angle = input.ReadInt32();
				break;
			case 32u:
				SpeedThreshold = input.ReadInt32();
				break;
			case 40u:
				AngleThreshold = input.ReadInt32();
				break;
			case 48u:
				StartPointTime = input.ReadInt32();
				break;
			case 56u:
				EndPointTime = input.ReadInt32();
				break;
			case 64u:
				GuideLinePointInterval = input.ReadInt32();
				break;
			}
		}
	}
}
