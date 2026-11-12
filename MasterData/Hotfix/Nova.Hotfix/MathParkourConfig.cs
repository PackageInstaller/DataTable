using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MathParkourConfig : IMessage<MathParkourConfig>, IMessage, IEquatable<MathParkourConfig>, IDeepCloneable<MathParkourConfig>
{
	private static readonly MessageParser<MathParkourConfig> _parser = new MessageParser<MathParkourConfig>(() => new MathParkourConfig());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int HpFieldNumber = 2;

	private int hp_;

	public const int BaseSpeedFieldNumber = 3;

	private int baseSpeed_;

	public const int FactorFieldNumber = 4;

	private float factor_;

	public const int ThresholdFieldNumber = 5;

	private float threshold_;

	public const int ScoreFactorFieldNumber = 6;

	private float scoreFactor_;

	public const int QteScoreFactorFieldNumber = 7;

	private float qteScoreFactor_;

	public const int ExScoreFieldNumber = 8;

	private int exScore_;

	public const int QteProgressLimitFieldNumber = 9;

	private int qteProgressLimit_;

	public const int QteProgressPerClickFieldNumber = 10;

	private int qteProgressPerClick_;

	public const int QteProgressDeductionFieldNumber = 11;

	private int qteProgressDeduction_;

	public const int QteSpeedFactorFieldNumber = 12;

	private float qteSpeedFactor_;

	[DebuggerNonUserCode]
	public static MessageParser<MathParkourConfig> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(536);

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
	public int Hp
	{
		get
		{
			return hp_;
		}
		set
		{
			hp_ = value;
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
	public float Factor
	{
		get
		{
			return factor_;
		}
		set
		{
			factor_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float Threshold
	{
		get
		{
			return threshold_;
		}
		set
		{
			threshold_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float ScoreFactor
	{
		get
		{
			return scoreFactor_;
		}
		set
		{
			scoreFactor_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float QteScoreFactor
	{
		get
		{
			return qteScoreFactor_;
		}
		set
		{
			qteScoreFactor_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ExScore
	{
		get
		{
			return exScore_;
		}
		set
		{
			exScore_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int QteProgressLimit
	{
		get
		{
			return qteProgressLimit_;
		}
		set
		{
			qteProgressLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int QteProgressPerClick
	{
		get
		{
			return qteProgressPerClick_;
		}
		set
		{
			qteProgressPerClick_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int QteProgressDeduction
	{
		get
		{
			return qteProgressDeduction_;
		}
		set
		{
			qteProgressDeduction_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float QteSpeedFactor
	{
		get
		{
			return qteSpeedFactor_;
		}
		set
		{
			qteSpeedFactor_ = value;
		}
	}

	[DebuggerNonUserCode]
	public MathParkourConfig()
	{
	}

	[DebuggerNonUserCode]
	public MathParkourConfig(MathParkourConfig other)
		: this()
	{
		id_ = other.id_;
		hp_ = other.hp_;
		baseSpeed_ = other.baseSpeed_;
		factor_ = other.factor_;
		threshold_ = other.threshold_;
		scoreFactor_ = other.scoreFactor_;
		qteScoreFactor_ = other.qteScoreFactor_;
		exScore_ = other.exScore_;
		qteProgressLimit_ = other.qteProgressLimit_;
		qteProgressPerClick_ = other.qteProgressPerClick_;
		qteProgressDeduction_ = other.qteProgressDeduction_;
		qteSpeedFactor_ = other.qteSpeedFactor_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MathParkourConfig Clone()
	{
		return new MathParkourConfig(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MathParkourConfig);
	}

	[DebuggerNonUserCode]
	public bool Equals(MathParkourConfig other)
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
		if (Hp != other.Hp)
		{
			return false;
		}
		if (BaseSpeed != other.BaseSpeed)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Factor, other.Factor))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Threshold, other.Threshold))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(ScoreFactor, other.ScoreFactor))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(QteScoreFactor, other.QteScoreFactor))
		{
			return false;
		}
		if (ExScore != other.ExScore)
		{
			return false;
		}
		if (QteProgressLimit != other.QteProgressLimit)
		{
			return false;
		}
		if (QteProgressPerClick != other.QteProgressPerClick)
		{
			return false;
		}
		if (QteProgressDeduction != other.QteProgressDeduction)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(QteSpeedFactor, other.QteSpeedFactor))
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
		if (Hp != 0)
		{
			num ^= Hp.GetHashCode();
		}
		if (BaseSpeed != 0)
		{
			num ^= BaseSpeed.GetHashCode();
		}
		if (Factor != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Factor);
		}
		if (Threshold != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Threshold);
		}
		if (ScoreFactor != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(ScoreFactor);
		}
		if (QteScoreFactor != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(QteScoreFactor);
		}
		if (ExScore != 0)
		{
			num ^= ExScore.GetHashCode();
		}
		if (QteProgressLimit != 0)
		{
			num ^= QteProgressLimit.GetHashCode();
		}
		if (QteProgressPerClick != 0)
		{
			num ^= QteProgressPerClick.GetHashCode();
		}
		if (QteProgressDeduction != 0)
		{
			num ^= QteProgressDeduction.GetHashCode();
		}
		if (QteSpeedFactor != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(QteSpeedFactor);
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
		if (Hp != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Hp);
		}
		if (BaseSpeed != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(BaseSpeed);
		}
		if (Factor != 0f)
		{
			output.WriteRawTag(37);
			output.WriteFloat(Factor);
		}
		if (Threshold != 0f)
		{
			output.WriteRawTag(45);
			output.WriteFloat(Threshold);
		}
		if (ScoreFactor != 0f)
		{
			output.WriteRawTag(53);
			output.WriteFloat(ScoreFactor);
		}
		if (QteScoreFactor != 0f)
		{
			output.WriteRawTag(61);
			output.WriteFloat(QteScoreFactor);
		}
		if (ExScore != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ExScore);
		}
		if (QteProgressLimit != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(QteProgressLimit);
		}
		if (QteProgressPerClick != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(QteProgressPerClick);
		}
		if (QteProgressDeduction != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(QteProgressDeduction);
		}
		if (QteSpeedFactor != 0f)
		{
			output.WriteRawTag(101);
			output.WriteFloat(QteSpeedFactor);
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
		if (Hp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Hp);
		}
		if (BaseSpeed != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BaseSpeed);
		}
		if (Factor != 0f)
		{
			num += 5;
		}
		if (Threshold != 0f)
		{
			num += 5;
		}
		if (ScoreFactor != 0f)
		{
			num += 5;
		}
		if (QteScoreFactor != 0f)
		{
			num += 5;
		}
		if (ExScore != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ExScore);
		}
		if (QteProgressLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(QteProgressLimit);
		}
		if (QteProgressPerClick != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(QteProgressPerClick);
		}
		if (QteProgressDeduction != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(QteProgressDeduction);
		}
		if (QteSpeedFactor != 0f)
		{
			num += 5;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MathParkourConfig other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Hp != 0)
			{
				Hp = other.Hp;
			}
			if (other.BaseSpeed != 0)
			{
				BaseSpeed = other.BaseSpeed;
			}
			if (other.Factor != 0f)
			{
				Factor = other.Factor;
			}
			if (other.Threshold != 0f)
			{
				Threshold = other.Threshold;
			}
			if (other.ScoreFactor != 0f)
			{
				ScoreFactor = other.ScoreFactor;
			}
			if (other.QteScoreFactor != 0f)
			{
				QteScoreFactor = other.QteScoreFactor;
			}
			if (other.ExScore != 0)
			{
				ExScore = other.ExScore;
			}
			if (other.QteProgressLimit != 0)
			{
				QteProgressLimit = other.QteProgressLimit;
			}
			if (other.QteProgressPerClick != 0)
			{
				QteProgressPerClick = other.QteProgressPerClick;
			}
			if (other.QteProgressDeduction != 0)
			{
				QteProgressDeduction = other.QteProgressDeduction;
			}
			if (other.QteSpeedFactor != 0f)
			{
				QteSpeedFactor = other.QteSpeedFactor;
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
				Hp = input.ReadInt32();
				break;
			case 24u:
				BaseSpeed = input.ReadInt32();
				break;
			case 37u:
				Factor = input.ReadFloat();
				break;
			case 45u:
				Threshold = input.ReadFloat();
				break;
			case 53u:
				ScoreFactor = input.ReadFloat();
				break;
			case 61u:
				QteScoreFactor = input.ReadFloat();
				break;
			case 64u:
				ExScore = input.ReadInt32();
				break;
			case 72u:
				QteProgressLimit = input.ReadInt32();
				break;
			case 80u:
				QteProgressPerClick = input.ReadInt32();
				break;
			case 88u:
				QteProgressDeduction = input.ReadInt32();
				break;
			case 101u:
				QteSpeedFactor = input.ReadFloat();
				break;
			}
		}
	}
}
