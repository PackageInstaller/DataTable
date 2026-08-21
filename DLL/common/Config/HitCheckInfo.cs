using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class HitCheckInfo : IMessage<HitCheckInfo>, IMessage, IEquatable<HitCheckInfo>, IDeepCloneable<HitCheckInfo>
{
	private static readonly MessageParser<HitCheckInfo> _parser = new MessageParser<HitCheckInfo>(() => new HitCheckInfo());

	public const int KeyFieldNumber = 1;

	private int key_;

	public const int HitCheckIDFieldNumber = 2;

	private int hitCheckID_;

	public const int StartFieldNumber = 3;

	private int start_;

	public const int DurationFieldNumber = 4;

	private int duration_;

	public const int RangeTypeFieldNumber = 5;

	private RangeType rangeType_;

	public const int RadiusFieldNumber = 6;

	private int radius_;

	public const int AngleFieldNumber = 7;

	private int angle_;

	public const int LengthFieldNumber = 8;

	private int length_;

	public const int WidthFieldNumber = 9;

	private int width_;

	public const int CenterOffsetFieldNumber = 10;

	private VectorInt3 centerOffset_;

	public const int OffsetOfFowardFieldNumber = 11;

	private int offsetOfFoward_;

	public const int ValidHitHeightFieldNumber = 12;

	private int validHitHeight_;

	public const int IsOnlyReduceHPFieldNumber = 13;

	private bool isOnlyReduceHP_;

	public const int HorizontalOffsetFieldNumber = 14;

	private int horizontalOffset_;

	public const int HorizontalSpeedFieldNumber = 15;

	private int horizontalSpeed_;

	public const int HorizontalAcceleratedASpeedFieldNumber = 16;

	private int horizontalAcceleratedASpeed_;

	public const int HitHeightFieldNumber = 17;

	private int hitHeight_;

	public const int VerticalSpeedFieldNumber = 18;

	private int verticalSpeed_;

	public const int VerticalAcceleratedSpeedFieldNumber = 19;

	private int verticalAcceleratedSpeed_;

	public const int HorizontalSpeedOnFloatFieldNumber = 20;

	private int horizontalSpeedOnFloat_;

	public const int HitAirBackDistanceFieldNumber = 21;

	private int hitAirBackDistance_;

	public const int UseHitDownDurationFieldNumber = 22;

	private bool useHitDownDuration_;

	public const int HitDownDurationFieldNumber = 23;

	private int hitDownDuration_;

	public const int AttackerKartunTimeFieldNumber = 24;

	private int attackerKartunTime_;

	public const int HitKartunTimeFieldNumber = 25;

	private int hitKartunTime_;

	public const int NoReoverHitKartunTimeFieldNumber = 26;

	private int noReoverHitKartunTime_;

	public const int IgnoreHitHistoryFieldNumber = 27;

	private bool ignoreHitHistory_;

	public const int IsUseAttackerDirectionFieldNumber = 28;

	private bool isUseAttackerDirection_;

	public const int UseCustomDirectionFieldNumber = 29;

	private bool useCustomDirection_;

	public const int CustomAngleFieldNumber = 30;

	private int customAngle_;

	public const int IsThumpFieldNumber = 31;

	private bool isThump_;

	public const int IsLargeHitBackFieldNumber = 32;

	private bool isLargeHitBack_;

	[DebuggerNonUserCode]
	public static MessageParser<HitCheckInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[29];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Key
	{
		get
		{
			return key_;
		}
		set
		{
			key_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HitCheckID
	{
		get
		{
			return hitCheckID_;
		}
		set
		{
			hitCheckID_ = value;
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
	public int ValidHitHeight
	{
		get
		{
			return validHitHeight_;
		}
		set
		{
			validHitHeight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsOnlyReduceHP
	{
		get
		{
			return isOnlyReduceHP_;
		}
		set
		{
			isOnlyReduceHP_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HorizontalOffset
	{
		get
		{
			return horizontalOffset_;
		}
		set
		{
			horizontalOffset_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HorizontalSpeed
	{
		get
		{
			return horizontalSpeed_;
		}
		set
		{
			horizontalSpeed_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HorizontalAcceleratedASpeed
	{
		get
		{
			return horizontalAcceleratedASpeed_;
		}
		set
		{
			horizontalAcceleratedASpeed_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HitHeight
	{
		get
		{
			return hitHeight_;
		}
		set
		{
			hitHeight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int VerticalSpeed
	{
		get
		{
			return verticalSpeed_;
		}
		set
		{
			verticalSpeed_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int VerticalAcceleratedSpeed
	{
		get
		{
			return verticalAcceleratedSpeed_;
		}
		set
		{
			verticalAcceleratedSpeed_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HorizontalSpeedOnFloat
	{
		get
		{
			return horizontalSpeedOnFloat_;
		}
		set
		{
			horizontalSpeedOnFloat_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HitAirBackDistance
	{
		get
		{
			return hitAirBackDistance_;
		}
		set
		{
			hitAirBackDistance_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool UseHitDownDuration
	{
		get
		{
			return useHitDownDuration_;
		}
		set
		{
			useHitDownDuration_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HitDownDuration
	{
		get
		{
			return hitDownDuration_;
		}
		set
		{
			hitDownDuration_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AttackerKartunTime
	{
		get
		{
			return attackerKartunTime_;
		}
		set
		{
			attackerKartunTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HitKartunTime
	{
		get
		{
			return hitKartunTime_;
		}
		set
		{
			hitKartunTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NoReoverHitKartunTime
	{
		get
		{
			return noReoverHitKartunTime_;
		}
		set
		{
			noReoverHitKartunTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IgnoreHitHistory
	{
		get
		{
			return ignoreHitHistory_;
		}
		set
		{
			ignoreHitHistory_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsUseAttackerDirection
	{
		get
		{
			return isUseAttackerDirection_;
		}
		set
		{
			isUseAttackerDirection_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool UseCustomDirection
	{
		get
		{
			return useCustomDirection_;
		}
		set
		{
			useCustomDirection_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CustomAngle
	{
		get
		{
			return customAngle_;
		}
		set
		{
			customAngle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsThump
	{
		get
		{
			return isThump_;
		}
		set
		{
			isThump_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsLargeHitBack
	{
		get
		{
			return isLargeHitBack_;
		}
		set
		{
			isLargeHitBack_ = value;
		}
	}

	[DebuggerNonUserCode]
	public HitCheckInfo()
	{
	}

	[DebuggerNonUserCode]
	public HitCheckInfo(HitCheckInfo other)
		: this()
	{
		key_ = other.key_;
		hitCheckID_ = other.hitCheckID_;
		start_ = other.start_;
		duration_ = other.duration_;
		rangeType_ = other.rangeType_;
		radius_ = other.radius_;
		angle_ = other.angle_;
		length_ = other.length_;
		width_ = other.width_;
		CenterOffset = ((other.centerOffset_ != null) ? other.CenterOffset.Clone() : null);
		offsetOfFoward_ = other.offsetOfFoward_;
		validHitHeight_ = other.validHitHeight_;
		isOnlyReduceHP_ = other.isOnlyReduceHP_;
		horizontalOffset_ = other.horizontalOffset_;
		horizontalSpeed_ = other.horizontalSpeed_;
		horizontalAcceleratedASpeed_ = other.horizontalAcceleratedASpeed_;
		hitHeight_ = other.hitHeight_;
		verticalSpeed_ = other.verticalSpeed_;
		verticalAcceleratedSpeed_ = other.verticalAcceleratedSpeed_;
		horizontalSpeedOnFloat_ = other.horizontalSpeedOnFloat_;
		hitAirBackDistance_ = other.hitAirBackDistance_;
		useHitDownDuration_ = other.useHitDownDuration_;
		hitDownDuration_ = other.hitDownDuration_;
		attackerKartunTime_ = other.attackerKartunTime_;
		hitKartunTime_ = other.hitKartunTime_;
		noReoverHitKartunTime_ = other.noReoverHitKartunTime_;
		ignoreHitHistory_ = other.ignoreHitHistory_;
		isUseAttackerDirection_ = other.isUseAttackerDirection_;
		useCustomDirection_ = other.useCustomDirection_;
		customAngle_ = other.customAngle_;
		isThump_ = other.isThump_;
		isLargeHitBack_ = other.isLargeHitBack_;
	}

	[DebuggerNonUserCode]
	public HitCheckInfo Clone()
	{
		return new HitCheckInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as HitCheckInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(HitCheckInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Key != other.Key)
		{
			return false;
		}
		if (HitCheckID != other.HitCheckID)
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
		if (ValidHitHeight != other.ValidHitHeight)
		{
			return false;
		}
		if (IsOnlyReduceHP != other.IsOnlyReduceHP)
		{
			return false;
		}
		if (HorizontalOffset != other.HorizontalOffset)
		{
			return false;
		}
		if (HorizontalSpeed != other.HorizontalSpeed)
		{
			return false;
		}
		if (HorizontalAcceleratedASpeed != other.HorizontalAcceleratedASpeed)
		{
			return false;
		}
		if (HitHeight != other.HitHeight)
		{
			return false;
		}
		if (VerticalSpeed != other.VerticalSpeed)
		{
			return false;
		}
		if (VerticalAcceleratedSpeed != other.VerticalAcceleratedSpeed)
		{
			return false;
		}
		if (HorizontalSpeedOnFloat != other.HorizontalSpeedOnFloat)
		{
			return false;
		}
		if (HitAirBackDistance != other.HitAirBackDistance)
		{
			return false;
		}
		if (UseHitDownDuration != other.UseHitDownDuration)
		{
			return false;
		}
		if (HitDownDuration != other.HitDownDuration)
		{
			return false;
		}
		if (AttackerKartunTime != other.AttackerKartunTime)
		{
			return false;
		}
		if (HitKartunTime != other.HitKartunTime)
		{
			return false;
		}
		if (NoReoverHitKartunTime != other.NoReoverHitKartunTime)
		{
			return false;
		}
		if (IgnoreHitHistory != other.IgnoreHitHistory)
		{
			return false;
		}
		if (IsUseAttackerDirection != other.IsUseAttackerDirection)
		{
			return false;
		}
		if (UseCustomDirection != other.UseCustomDirection)
		{
			return false;
		}
		if (CustomAngle != other.CustomAngle)
		{
			return false;
		}
		if (IsThump != other.IsThump)
		{
			return false;
		}
		if (IsLargeHitBack != other.IsLargeHitBack)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Key != 0)
		{
			num ^= Key.GetHashCode();
		}
		if (HitCheckID != 0)
		{
			num ^= HitCheckID.GetHashCode();
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
		if (ValidHitHeight != 0)
		{
			num ^= ValidHitHeight.GetHashCode();
		}
		if (IsOnlyReduceHP)
		{
			num ^= IsOnlyReduceHP.GetHashCode();
		}
		if (HorizontalOffset != 0)
		{
			num ^= HorizontalOffset.GetHashCode();
		}
		if (HorizontalSpeed != 0)
		{
			num ^= HorizontalSpeed.GetHashCode();
		}
		if (HorizontalAcceleratedASpeed != 0)
		{
			num ^= HorizontalAcceleratedASpeed.GetHashCode();
		}
		if (HitHeight != 0)
		{
			num ^= HitHeight.GetHashCode();
		}
		if (VerticalSpeed != 0)
		{
			num ^= VerticalSpeed.GetHashCode();
		}
		if (VerticalAcceleratedSpeed != 0)
		{
			num ^= VerticalAcceleratedSpeed.GetHashCode();
		}
		if (HorizontalSpeedOnFloat != 0)
		{
			num ^= HorizontalSpeedOnFloat.GetHashCode();
		}
		if (HitAirBackDistance != 0)
		{
			num ^= HitAirBackDistance.GetHashCode();
		}
		if (UseHitDownDuration)
		{
			num ^= UseHitDownDuration.GetHashCode();
		}
		if (HitDownDuration != 0)
		{
			num ^= HitDownDuration.GetHashCode();
		}
		if (AttackerKartunTime != 0)
		{
			num ^= AttackerKartunTime.GetHashCode();
		}
		if (HitKartunTime != 0)
		{
			num ^= HitKartunTime.GetHashCode();
		}
		if (NoReoverHitKartunTime != 0)
		{
			num ^= NoReoverHitKartunTime.GetHashCode();
		}
		if (IgnoreHitHistory)
		{
			num ^= IgnoreHitHistory.GetHashCode();
		}
		if (IsUseAttackerDirection)
		{
			num ^= IsUseAttackerDirection.GetHashCode();
		}
		if (UseCustomDirection)
		{
			num ^= UseCustomDirection.GetHashCode();
		}
		if (CustomAngle != 0)
		{
			num ^= CustomAngle.GetHashCode();
		}
		if (IsThump)
		{
			num ^= IsThump.GetHashCode();
		}
		if (IsLargeHitBack)
		{
			num ^= IsLargeHitBack.GetHashCode();
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
		if (Key != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Key);
		}
		if (HitCheckID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(HitCheckID);
		}
		if (Start != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Start);
		}
		if (Duration != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Duration);
		}
		if (RangeType != RangeType.None)
		{
			output.WriteRawTag(40);
			output.WriteEnum((int)RangeType);
		}
		if (Radius != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Radius);
		}
		if (Angle != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Angle);
		}
		if (Length != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Length);
		}
		if (Width != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Width);
		}
		if (centerOffset_ != null)
		{
			output.WriteRawTag(82);
			output.WriteMessage(CenterOffset);
		}
		if (OffsetOfFoward != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(OffsetOfFoward);
		}
		if (ValidHitHeight != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(ValidHitHeight);
		}
		if (IsOnlyReduceHP)
		{
			output.WriteRawTag(104);
			output.WriteBool(IsOnlyReduceHP);
		}
		if (HorizontalOffset != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(HorizontalOffset);
		}
		if (HorizontalSpeed != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(HorizontalSpeed);
		}
		if (HorizontalAcceleratedASpeed != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(HorizontalAcceleratedASpeed);
		}
		if (HitHeight != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(HitHeight);
		}
		if (VerticalSpeed != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(VerticalSpeed);
		}
		if (VerticalAcceleratedSpeed != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(VerticalAcceleratedSpeed);
		}
		if (HorizontalSpeedOnFloat != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(HorizontalSpeedOnFloat);
		}
		if (HitAirBackDistance != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(HitAirBackDistance);
		}
		if (UseHitDownDuration)
		{
			output.WriteRawTag(176, 1);
			output.WriteBool(UseHitDownDuration);
		}
		if (HitDownDuration != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(HitDownDuration);
		}
		if (AttackerKartunTime != 0)
		{
			output.WriteRawTag(192, 1);
			output.WriteInt32(AttackerKartunTime);
		}
		if (HitKartunTime != 0)
		{
			output.WriteRawTag(200, 1);
			output.WriteInt32(HitKartunTime);
		}
		if (NoReoverHitKartunTime != 0)
		{
			output.WriteRawTag(208, 1);
			output.WriteInt32(NoReoverHitKartunTime);
		}
		if (IgnoreHitHistory)
		{
			output.WriteRawTag(216, 1);
			output.WriteBool(IgnoreHitHistory);
		}
		if (IsUseAttackerDirection)
		{
			output.WriteRawTag(224, 1);
			output.WriteBool(IsUseAttackerDirection);
		}
		if (UseCustomDirection)
		{
			output.WriteRawTag(232, 1);
			output.WriteBool(UseCustomDirection);
		}
		if (CustomAngle != 0)
		{
			output.WriteRawTag(240, 1);
			output.WriteInt32(CustomAngle);
		}
		if (IsThump)
		{
			output.WriteRawTag(248, 1);
			output.WriteBool(IsThump);
		}
		if (IsLargeHitBack)
		{
			output.WriteRawTag(128, 2);
			output.WriteBool(IsLargeHitBack);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Key != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Key);
		}
		if (HitCheckID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HitCheckID);
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
		if (ValidHitHeight != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ValidHitHeight);
		}
		if (IsOnlyReduceHP)
		{
			num += 2;
		}
		if (HorizontalOffset != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HorizontalOffset);
		}
		if (HorizontalSpeed != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HorizontalSpeed);
		}
		if (HorizontalAcceleratedASpeed != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(HorizontalAcceleratedASpeed);
		}
		if (HitHeight != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(HitHeight);
		}
		if (VerticalSpeed != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(VerticalSpeed);
		}
		if (VerticalAcceleratedSpeed != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(VerticalAcceleratedSpeed);
		}
		if (HorizontalSpeedOnFloat != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(HorizontalSpeedOnFloat);
		}
		if (HitAirBackDistance != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(HitAirBackDistance);
		}
		if (UseHitDownDuration)
		{
			num += 3;
		}
		if (HitDownDuration != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(HitDownDuration);
		}
		if (AttackerKartunTime != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AttackerKartunTime);
		}
		if (HitKartunTime != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(HitKartunTime);
		}
		if (NoReoverHitKartunTime != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(NoReoverHitKartunTime);
		}
		if (IgnoreHitHistory)
		{
			num += 3;
		}
		if (IsUseAttackerDirection)
		{
			num += 3;
		}
		if (UseCustomDirection)
		{
			num += 3;
		}
		if (CustomAngle != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(CustomAngle);
		}
		if (IsThump)
		{
			num += 3;
		}
		if (IsLargeHitBack)
		{
			num += 3;
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(HitCheckInfo other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Key != 0)
		{
			Key = other.Key;
		}
		if (other.HitCheckID != 0)
		{
			HitCheckID = other.HitCheckID;
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
		if (other.ValidHitHeight != 0)
		{
			ValidHitHeight = other.ValidHitHeight;
		}
		if (other.IsOnlyReduceHP)
		{
			IsOnlyReduceHP = other.IsOnlyReduceHP;
		}
		if (other.HorizontalOffset != 0)
		{
			HorizontalOffset = other.HorizontalOffset;
		}
		if (other.HorizontalSpeed != 0)
		{
			HorizontalSpeed = other.HorizontalSpeed;
		}
		if (other.HorizontalAcceleratedASpeed != 0)
		{
			HorizontalAcceleratedASpeed = other.HorizontalAcceleratedASpeed;
		}
		if (other.HitHeight != 0)
		{
			HitHeight = other.HitHeight;
		}
		if (other.VerticalSpeed != 0)
		{
			VerticalSpeed = other.VerticalSpeed;
		}
		if (other.VerticalAcceleratedSpeed != 0)
		{
			VerticalAcceleratedSpeed = other.VerticalAcceleratedSpeed;
		}
		if (other.HorizontalSpeedOnFloat != 0)
		{
			HorizontalSpeedOnFloat = other.HorizontalSpeedOnFloat;
		}
		if (other.HitAirBackDistance != 0)
		{
			HitAirBackDistance = other.HitAirBackDistance;
		}
		if (other.UseHitDownDuration)
		{
			UseHitDownDuration = other.UseHitDownDuration;
		}
		if (other.HitDownDuration != 0)
		{
			HitDownDuration = other.HitDownDuration;
		}
		if (other.AttackerKartunTime != 0)
		{
			AttackerKartunTime = other.AttackerKartunTime;
		}
		if (other.HitKartunTime != 0)
		{
			HitKartunTime = other.HitKartunTime;
		}
		if (other.NoReoverHitKartunTime != 0)
		{
			NoReoverHitKartunTime = other.NoReoverHitKartunTime;
		}
		if (other.IgnoreHitHistory)
		{
			IgnoreHitHistory = other.IgnoreHitHistory;
		}
		if (other.IsUseAttackerDirection)
		{
			IsUseAttackerDirection = other.IsUseAttackerDirection;
		}
		if (other.UseCustomDirection)
		{
			UseCustomDirection = other.UseCustomDirection;
		}
		if (other.CustomAngle != 0)
		{
			CustomAngle = other.CustomAngle;
		}
		if (other.IsThump)
		{
			IsThump = other.IsThump;
		}
		if (other.IsLargeHitBack)
		{
			IsLargeHitBack = other.IsLargeHitBack;
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
				Key = input.ReadInt32();
				break;
			case 16u:
				HitCheckID = input.ReadInt32();
				break;
			case 24u:
				Start = input.ReadInt32();
				break;
			case 32u:
				Duration = input.ReadInt32();
				break;
			case 40u:
				rangeType_ = (RangeType)input.ReadEnum();
				break;
			case 48u:
				Radius = input.ReadInt32();
				break;
			case 56u:
				Angle = input.ReadInt32();
				break;
			case 64u:
				Length = input.ReadInt32();
				break;
			case 72u:
				Width = input.ReadInt32();
				break;
			case 82u:
				if (centerOffset_ == null)
				{
					centerOffset_ = new VectorInt3();
				}
				input.ReadMessage(centerOffset_);
				break;
			case 88u:
				OffsetOfFoward = input.ReadInt32();
				break;
			case 96u:
				ValidHitHeight = input.ReadInt32();
				break;
			case 104u:
				IsOnlyReduceHP = input.ReadBool();
				break;
			case 112u:
				HorizontalOffset = input.ReadInt32();
				break;
			case 120u:
				HorizontalSpeed = input.ReadInt32();
				break;
			case 128u:
				HorizontalAcceleratedASpeed = input.ReadInt32();
				break;
			case 136u:
				HitHeight = input.ReadInt32();
				break;
			case 144u:
				VerticalSpeed = input.ReadInt32();
				break;
			case 152u:
				VerticalAcceleratedSpeed = input.ReadInt32();
				break;
			case 160u:
				HorizontalSpeedOnFloat = input.ReadInt32();
				break;
			case 168u:
				HitAirBackDistance = input.ReadInt32();
				break;
			case 176u:
				UseHitDownDuration = input.ReadBool();
				break;
			case 184u:
				HitDownDuration = input.ReadInt32();
				break;
			case 192u:
				AttackerKartunTime = input.ReadInt32();
				break;
			case 200u:
				HitKartunTime = input.ReadInt32();
				break;
			case 208u:
				NoReoverHitKartunTime = input.ReadInt32();
				break;
			case 216u:
				IgnoreHitHistory = input.ReadBool();
				break;
			case 224u:
				IsUseAttackerDirection = input.ReadBool();
				break;
			case 232u:
				UseCustomDirection = input.ReadBool();
				break;
			case 240u:
				CustomAngle = input.ReadInt32();
				break;
			case 248u:
				IsThump = input.ReadBool();
				break;
			case 256u:
				IsLargeHitBack = input.ReadBool();
				break;
			}
		}
	}
}
