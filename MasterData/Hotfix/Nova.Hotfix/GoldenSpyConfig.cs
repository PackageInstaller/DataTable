using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GoldenSpyConfig : IMessage<GoldenSpyConfig>, IMessage, IEquatable<GoldenSpyConfig>, IDeepCloneable<GoldenSpyConfig>
{
	private static readonly MessageParser<GoldenSpyConfig> _parser = new MessageParser<GoldenSpyConfig>(() => new GoldenSpyConfig());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int MaxAngleFieldNumber = 2;

	private int maxAngle_;

	public const int AngleTimeFieldNumber = 3;

	private float angleTime_;

	public const int BaseSpeedFieldNumber = 4;

	private int baseSpeed_;

	public const int BaseRadiusFieldNumber = 5;

	private int baseRadius_;

	public const int BaseFactorFieldNumber = 6;

	private float baseFactor_;

	public const int PullSlowWeightFieldNumber = 7;

	private int pullSlowWeight_;

	public const int GetHighValueFieldNumber = 8;

	private int getHighValue_;

	public const int HighValueEffectFieldNumber = 9;

	private int highValueEffect_;

	public const int MinSpeedFieldNumber = 10;

	private int minSpeed_;

	[DebuggerNonUserCode]
	public static MessageParser<GoldenSpyConfig> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(392);

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
	public int MaxAngle
	{
		get
		{
			return maxAngle_;
		}
		set
		{
			maxAngle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float AngleTime
	{
		get
		{
			return angleTime_;
		}
		set
		{
			angleTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BaseSpeed
	{
		get
		{
			return baseSpeed_;
		}
		set
		{
			baseSpeed_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BaseRadius
	{
		get
		{
			return baseRadius_;
		}
		set
		{
			baseRadius_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float BaseFactor
	{
		get
		{
			return baseFactor_;
		}
		set
		{
			baseFactor_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PullSlowWeight
	{
		get
		{
			return pullSlowWeight_;
		}
		set
		{
			pullSlowWeight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GetHighValue
	{
		get
		{
			return getHighValue_;
		}
		set
		{
			getHighValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HighValueEffect
	{
		get
		{
			return highValueEffect_;
		}
		set
		{
			highValueEffect_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MinSpeed
	{
		get
		{
			return minSpeed_;
		}
		set
		{
			minSpeed_ = value;
		}
	}

	[DebuggerNonUserCode]
	public GoldenSpyConfig()
	{
	}

	[DebuggerNonUserCode]
	public GoldenSpyConfig(GoldenSpyConfig other)
		: this()
	{
		id_ = other.id_;
		maxAngle_ = other.maxAngle_;
		angleTime_ = other.angleTime_;
		baseSpeed_ = other.baseSpeed_;
		baseRadius_ = other.baseRadius_;
		baseFactor_ = other.baseFactor_;
		pullSlowWeight_ = other.pullSlowWeight_;
		getHighValue_ = other.getHighValue_;
		highValueEffect_ = other.highValueEffect_;
		minSpeed_ = other.minSpeed_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GoldenSpyConfig Clone()
	{
		return new GoldenSpyConfig(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GoldenSpyConfig);
	}

	[DebuggerNonUserCode]
	public bool Equals(GoldenSpyConfig other)
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
		if (MaxAngle != other.MaxAngle)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(AngleTime, other.AngleTime))
		{
			return false;
		}
		if (BaseSpeed != other.BaseSpeed)
		{
			return false;
		}
		if (BaseRadius != other.BaseRadius)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(BaseFactor, other.BaseFactor))
		{
			return false;
		}
		if (PullSlowWeight != other.PullSlowWeight)
		{
			return false;
		}
		if (GetHighValue != other.GetHighValue)
		{
			return false;
		}
		if (HighValueEffect != other.HighValueEffect)
		{
			return false;
		}
		if (MinSpeed != other.MinSpeed)
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
		if (MaxAngle != 0)
		{
			num ^= MaxAngle.GetHashCode();
		}
		if (AngleTime != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(AngleTime);
		}
		if (BaseSpeed != 0)
		{
			num ^= BaseSpeed.GetHashCode();
		}
		if (BaseRadius != 0)
		{
			num ^= BaseRadius.GetHashCode();
		}
		if (BaseFactor != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(BaseFactor);
		}
		if (PullSlowWeight != 0)
		{
			num ^= PullSlowWeight.GetHashCode();
		}
		if (GetHighValue != 0)
		{
			num ^= GetHighValue.GetHashCode();
		}
		if (HighValueEffect != 0)
		{
			num ^= HighValueEffect.GetHashCode();
		}
		if (MinSpeed != 0)
		{
			num ^= MinSpeed.GetHashCode();
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
		if (MaxAngle != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(MaxAngle);
		}
		if (AngleTime != 0f)
		{
			output.WriteRawTag(29);
			output.WriteFloat(AngleTime);
		}
		if (BaseSpeed != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(BaseSpeed);
		}
		if (BaseRadius != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(BaseRadius);
		}
		if (BaseFactor != 0f)
		{
			output.WriteRawTag(53);
			output.WriteFloat(BaseFactor);
		}
		if (PullSlowWeight != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(PullSlowWeight);
		}
		if (GetHighValue != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(GetHighValue);
		}
		if (HighValueEffect != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(HighValueEffect);
		}
		if (MinSpeed != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(MinSpeed);
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
		if (MaxAngle != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxAngle);
		}
		if (AngleTime != 0f)
		{
			num += 5;
		}
		if (BaseSpeed != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BaseSpeed);
		}
		if (BaseRadius != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BaseRadius);
		}
		if (BaseFactor != 0f)
		{
			num += 5;
		}
		if (PullSlowWeight != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PullSlowWeight);
		}
		if (GetHighValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GetHighValue);
		}
		if (HighValueEffect != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HighValueEffect);
		}
		if (MinSpeed != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MinSpeed);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(GoldenSpyConfig other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.MaxAngle != 0)
			{
				MaxAngle = other.MaxAngle;
			}
			if (other.AngleTime != 0f)
			{
				AngleTime = other.AngleTime;
			}
			if (other.BaseSpeed != 0)
			{
				BaseSpeed = other.BaseSpeed;
			}
			if (other.BaseRadius != 0)
			{
				BaseRadius = other.BaseRadius;
			}
			if (other.BaseFactor != 0f)
			{
				BaseFactor = other.BaseFactor;
			}
			if (other.PullSlowWeight != 0)
			{
				PullSlowWeight = other.PullSlowWeight;
			}
			if (other.GetHighValue != 0)
			{
				GetHighValue = other.GetHighValue;
			}
			if (other.HighValueEffect != 0)
			{
				HighValueEffect = other.HighValueEffect;
			}
			if (other.MinSpeed != 0)
			{
				MinSpeed = other.MinSpeed;
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
				MaxAngle = input.ReadInt32();
				break;
			case 29u:
				AngleTime = input.ReadFloat();
				break;
			case 32u:
				BaseSpeed = input.ReadInt32();
				break;
			case 40u:
				BaseRadius = input.ReadInt32();
				break;
			case 53u:
				BaseFactor = input.ReadFloat();
				break;
			case 56u:
				PullSlowWeight = input.ReadInt32();
				break;
			case 64u:
				GetHighValue = input.ReadInt32();
				break;
			case 72u:
				HighValueEffect = input.ReadInt32();
				break;
			case 80u:
				MinSpeed = input.ReadInt32();
				break;
			}
		}
	}
}
