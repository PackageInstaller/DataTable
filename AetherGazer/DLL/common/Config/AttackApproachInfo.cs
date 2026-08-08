using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class AttackApproachInfo : IMessage<AttackApproachInfo>, IMessage, IEquatable<AttackApproachInfo>, IDeepCloneable<AttackApproachInfo>
{
	private static readonly MessageParser<AttackApproachInfo> _parser = new MessageParser<AttackApproachInfo>(() => new AttackApproachInfo());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int StartFieldNumber = 2;

	private int start_;

	public const int DurationFieldNumber = 3;

	private int duration_;

	public const int MaxDistanceFieldNumber = 4;

	private int maxDistance_;

	public const int TargetDistanceFieldNumber = 5;

	private int targetDistance_;

	public const int ValidDistanceFieldNumber = 6;

	private int validDistance_;

	[DebuggerNonUserCode]
	public static MessageParser<AttackApproachInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[12];

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
	public int MaxDistance
	{
		get
		{
			return maxDistance_;
		}
		set
		{
			maxDistance_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TargetDistance
	{
		get
		{
			return targetDistance_;
		}
		set
		{
			targetDistance_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ValidDistance
	{
		get
		{
			return validDistance_;
		}
		set
		{
			validDistance_ = value;
		}
	}

	[DebuggerNonUserCode]
	public AttackApproachInfo()
	{
	}

	[DebuggerNonUserCode]
	public AttackApproachInfo(AttackApproachInfo other)
		: this()
	{
		iD_ = other.iD_;
		start_ = other.start_;
		duration_ = other.duration_;
		maxDistance_ = other.maxDistance_;
		targetDistance_ = other.targetDistance_;
		validDistance_ = other.validDistance_;
	}

	[DebuggerNonUserCode]
	public AttackApproachInfo Clone()
	{
		return new AttackApproachInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as AttackApproachInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(AttackApproachInfo other)
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
		if (MaxDistance != other.MaxDistance)
		{
			return false;
		}
		if (TargetDistance != other.TargetDistance)
		{
			return false;
		}
		if (ValidDistance != other.ValidDistance)
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
		if (MaxDistance != 0)
		{
			num ^= MaxDistance.GetHashCode();
		}
		if (TargetDistance != 0)
		{
			num ^= TargetDistance.GetHashCode();
		}
		if (ValidDistance != 0)
		{
			num ^= ValidDistance.GetHashCode();
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
		if (MaxDistance != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(MaxDistance);
		}
		if (TargetDistance != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(TargetDistance);
		}
		if (ValidDistance != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(ValidDistance);
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
		if (MaxDistance != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxDistance);
		}
		if (TargetDistance != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TargetDistance);
		}
		if (ValidDistance != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ValidDistance);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(AttackApproachInfo other)
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
			if (other.MaxDistance != 0)
			{
				MaxDistance = other.MaxDistance;
			}
			if (other.TargetDistance != 0)
			{
				TargetDistance = other.TargetDistance;
			}
			if (other.ValidDistance != 0)
			{
				ValidDistance = other.ValidDistance;
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
				MaxDistance = input.ReadInt32();
				break;
			case 40u:
				TargetDistance = input.ReadInt32();
				break;
			case 48u:
				ValidDistance = input.ReadInt32();
				break;
			}
		}
	}
}
