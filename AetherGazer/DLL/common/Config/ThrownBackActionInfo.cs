using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class ThrownBackActionInfo : IMessage<ThrownBackActionInfo>, IMessage, IEquatable<ThrownBackActionInfo>, IDeepCloneable<ThrownBackActionInfo>
{
	private static readonly MessageParser<ThrownBackActionInfo> _parser = new MessageParser<ThrownBackActionInfo>(() => new ThrownBackActionInfo());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int StartFieldNumber = 2;

	private int start_;

	public const int DurationFieldNumber = 3;

	private int duration_;

	public const int OnceCalcFieldNumber = 4;

	private bool onceCalc_;

	public const int OffsetFieldNumber = 5;

	private VectorInt3 offset_;

	public const int MinSpeedFieldNumber = 6;

	private int minSpeed_;

	public const int MaxSpeedFieldNumber = 7;

	private int maxSpeed_;

	public const int MoveRateFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_moveRate_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> moveRate_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<ThrownBackActionInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[61];

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
	public bool OnceCalc
	{
		get
		{
			return onceCalc_;
		}
		set
		{
			onceCalc_ = value;
		}
	}

	[DebuggerNonUserCode]
	public VectorInt3 Offset
	{
		get
		{
			return offset_;
		}
		set
		{
			offset_ = value;
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
	public int MaxSpeed
	{
		get
		{
			return maxSpeed_;
		}
		set
		{
			maxSpeed_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> MoveRate => moveRate_;

	[DebuggerNonUserCode]
	public ThrownBackActionInfo()
	{
	}

	[DebuggerNonUserCode]
	public ThrownBackActionInfo(ThrownBackActionInfo other)
		: this()
	{
		iD_ = other.iD_;
		start_ = other.start_;
		duration_ = other.duration_;
		onceCalc_ = other.onceCalc_;
		Offset = ((other.offset_ != null) ? other.Offset.Clone() : null);
		minSpeed_ = other.minSpeed_;
		maxSpeed_ = other.maxSpeed_;
		moveRate_ = other.moveRate_.Clone();
	}

	[DebuggerNonUserCode]
	public ThrownBackActionInfo Clone()
	{
		return new ThrownBackActionInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ThrownBackActionInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(ThrownBackActionInfo other)
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
		if (OnceCalc != other.OnceCalc)
		{
			return false;
		}
		if (!object.Equals(Offset, other.Offset))
		{
			return false;
		}
		if (MinSpeed != other.MinSpeed)
		{
			return false;
		}
		if (MaxSpeed != other.MaxSpeed)
		{
			return false;
		}
		if (!moveRate_.Equals(other.moveRate_))
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
		if (OnceCalc)
		{
			num ^= OnceCalc.GetHashCode();
		}
		if (offset_ != null)
		{
			num ^= Offset.GetHashCode();
		}
		if (MinSpeed != 0)
		{
			num ^= MinSpeed.GetHashCode();
		}
		if (MaxSpeed != 0)
		{
			num ^= MaxSpeed.GetHashCode();
		}
		return num ^ moveRate_.GetHashCode();
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
		if (OnceCalc)
		{
			output.WriteRawTag(32);
			output.WriteBool(OnceCalc);
		}
		if (offset_ != null)
		{
			output.WriteRawTag(42);
			output.WriteMessage(Offset);
		}
		if (MinSpeed != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(MinSpeed);
		}
		if (MaxSpeed != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(MaxSpeed);
		}
		moveRate_.WriteTo(output, _repeated_moveRate_codec);
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
		if (OnceCalc)
		{
			num += 2;
		}
		if (offset_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Offset);
		}
		if (MinSpeed != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MinSpeed);
		}
		if (MaxSpeed != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxSpeed);
		}
		return num + moveRate_.CalculateSize(_repeated_moveRate_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ThrownBackActionInfo other)
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
		if (other.OnceCalc)
		{
			OnceCalc = other.OnceCalc;
		}
		if (other.offset_ != null)
		{
			if (offset_ == null)
			{
				offset_ = new VectorInt3();
			}
			Offset.MergeFrom(other.Offset);
		}
		if (other.MinSpeed != 0)
		{
			MinSpeed = other.MinSpeed;
		}
		if (other.MaxSpeed != 0)
		{
			MaxSpeed = other.MaxSpeed;
		}
		moveRate_.Add(other.moveRate_);
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
				OnceCalc = input.ReadBool();
				break;
			case 42u:
				if (offset_ == null)
				{
					offset_ = new VectorInt3();
				}
				input.ReadMessage(offset_);
				break;
			case 48u:
				MinSpeed = input.ReadInt32();
				break;
			case 56u:
				MaxSpeed = input.ReadInt32();
				break;
			case 64u:
			case 66u:
				moveRate_.AddEntriesFrom(input, _repeated_moveRate_codec);
				break;
			}
		}
	}
}
