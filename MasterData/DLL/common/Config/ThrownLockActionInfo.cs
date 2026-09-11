using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class ThrownLockActionInfo : IMessage<ThrownLockActionInfo>, IMessage, IEquatable<ThrownLockActionInfo>, IDeepCloneable<ThrownLockActionInfo>
{
	private static readonly MessageParser<ThrownLockActionInfo> _parser = new MessageParser<ThrownLockActionInfo>(() => new ThrownLockActionInfo());

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

	public const int HeightFieldNumber = 9;

	private int height_;

	public const int CenterOffsetFieldNumber = 10;

	private VectorInt3 centerOffset_;

	public const int ThrownBehaviourOnCollisionFieldNumber = 11;

	private int thrownBehaviourOnCollision_;

	public const int SpawnThrownTimelineIDFieldNumber = 12;

	private int spawnThrownTimelineID_;

	public const int ChangeTargetCountLimitFieldNumber = 13;

	private int changeTargetCountLimit_;

	public const int TurnRateFieldNumber = 14;

	private int turnRate_;

	public const int LockEndOperationFieldNumber = 15;

	private int lockEndOperation_;

	public const int RandomRadiusFieldNumber = 16;

	private int randomRadius_;

	public const int RandomStartAngleFieldNumber = 17;

	private int randomStartAngle_;

	public const int RandomEndAngleFieldNumber = 18;

	private int randomEndAngle_;

	public const int UseReverseFieldNumber = 19;

	private bool useReverse_;

	public const int NeedInGraphFieldNumber = 20;

	private bool needInGraph_;

	public const int TargetCampTypeFieldNumber = 21;

	private TargetCampType targetCampType_;

	public const int FollowThresholdFieldNumber = 22;

	private int followThreshold_;

	public const int StartChangeHeightTimeFieldNumber = 23;

	private int startChangeHeightTime_;

	public const int LockTargetPointFieldNumber = 24;

	private bool lockTargetPoint_;

	public const int AngleSpeedCurveFrameFieldNumber = 25;

	private static readonly FieldCodec<int> _repeated_angleSpeedCurveFrame_codec = FieldCodec.ForInt32(202u);

	private readonly RepeatedField<int> angleSpeedCurveFrame_ = new RepeatedField<int>();

	public const int AngleSpeedCurveValFieldNumber = 26;

	private static readonly FieldCodec<int> _repeated_angleSpeedCurveVal_codec = FieldCodec.ForInt32(210u);

	private readonly RepeatedField<int> angleSpeedCurveVal_ = new RepeatedField<int>();

	public const int ChangeAngleSpeedAngleFieldNumber = 27;

	private int changeAngleSpeedAngle_;

	public const int ChangeAngleSpeedFactorFieldNumber = 28;

	private int changeAngleSpeedFactor_;

	public const int TargetChangeWhenDeadFieldNumber = 29;

	private bool targetChangeWhenDead_;

	[DebuggerNonUserCode]
	public static MessageParser<ThrownLockActionInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[63];

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
	public int Height
	{
		get
		{
			return height_;
		}
		set
		{
			height_ = value;
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
	public int ThrownBehaviourOnCollision
	{
		get
		{
			return thrownBehaviourOnCollision_;
		}
		set
		{
			thrownBehaviourOnCollision_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SpawnThrownTimelineID
	{
		get
		{
			return spawnThrownTimelineID_;
		}
		set
		{
			spawnThrownTimelineID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ChangeTargetCountLimit
	{
		get
		{
			return changeTargetCountLimit_;
		}
		set
		{
			changeTargetCountLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TurnRate
	{
		get
		{
			return turnRate_;
		}
		set
		{
			turnRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LockEndOperation
	{
		get
		{
			return lockEndOperation_;
		}
		set
		{
			lockEndOperation_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RandomRadius
	{
		get
		{
			return randomRadius_;
		}
		set
		{
			randomRadius_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RandomStartAngle
	{
		get
		{
			return randomStartAngle_;
		}
		set
		{
			randomStartAngle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RandomEndAngle
	{
		get
		{
			return randomEndAngle_;
		}
		set
		{
			randomEndAngle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool UseReverse
	{
		get
		{
			return useReverse_;
		}
		set
		{
			useReverse_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool NeedInGraph
	{
		get
		{
			return needInGraph_;
		}
		set
		{
			needInGraph_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TargetCampType TargetCampType
	{
		get
		{
			return targetCampType_;
		}
		set
		{
			targetCampType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FollowThreshold
	{
		get
		{
			return followThreshold_;
		}
		set
		{
			followThreshold_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int StartChangeHeightTime
	{
		get
		{
			return startChangeHeightTime_;
		}
		set
		{
			startChangeHeightTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool LockTargetPoint
	{
		get
		{
			return lockTargetPoint_;
		}
		set
		{
			lockTargetPoint_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> AngleSpeedCurveFrame => angleSpeedCurveFrame_;

	[DebuggerNonUserCode]
	public RepeatedField<int> AngleSpeedCurveVal => angleSpeedCurveVal_;

	[DebuggerNonUserCode]
	public int ChangeAngleSpeedAngle
	{
		get
		{
			return changeAngleSpeedAngle_;
		}
		set
		{
			changeAngleSpeedAngle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ChangeAngleSpeedFactor
	{
		get
		{
			return changeAngleSpeedFactor_;
		}
		set
		{
			changeAngleSpeedFactor_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool TargetChangeWhenDead
	{
		get
		{
			return targetChangeWhenDead_;
		}
		set
		{
			targetChangeWhenDead_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ThrownLockActionInfo()
	{
	}

	[DebuggerNonUserCode]
	public ThrownLockActionInfo(ThrownLockActionInfo other)
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
		height_ = other.height_;
		CenterOffset = ((other.centerOffset_ != null) ? other.CenterOffset.Clone() : null);
		thrownBehaviourOnCollision_ = other.thrownBehaviourOnCollision_;
		spawnThrownTimelineID_ = other.spawnThrownTimelineID_;
		changeTargetCountLimit_ = other.changeTargetCountLimit_;
		turnRate_ = other.turnRate_;
		lockEndOperation_ = other.lockEndOperation_;
		randomRadius_ = other.randomRadius_;
		randomStartAngle_ = other.randomStartAngle_;
		randomEndAngle_ = other.randomEndAngle_;
		useReverse_ = other.useReverse_;
		needInGraph_ = other.needInGraph_;
		targetCampType_ = other.targetCampType_;
		followThreshold_ = other.followThreshold_;
		startChangeHeightTime_ = other.startChangeHeightTime_;
		lockTargetPoint_ = other.lockTargetPoint_;
		angleSpeedCurveFrame_ = other.angleSpeedCurveFrame_.Clone();
		angleSpeedCurveVal_ = other.angleSpeedCurveVal_.Clone();
		changeAngleSpeedAngle_ = other.changeAngleSpeedAngle_;
		changeAngleSpeedFactor_ = other.changeAngleSpeedFactor_;
		targetChangeWhenDead_ = other.targetChangeWhenDead_;
	}

	[DebuggerNonUserCode]
	public ThrownLockActionInfo Clone()
	{
		return new ThrownLockActionInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ThrownLockActionInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(ThrownLockActionInfo other)
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
		if (Height != other.Height)
		{
			return false;
		}
		if (!object.Equals(CenterOffset, other.CenterOffset))
		{
			return false;
		}
		if (ThrownBehaviourOnCollision != other.ThrownBehaviourOnCollision)
		{
			return false;
		}
		if (SpawnThrownTimelineID != other.SpawnThrownTimelineID)
		{
			return false;
		}
		if (ChangeTargetCountLimit != other.ChangeTargetCountLimit)
		{
			return false;
		}
		if (TurnRate != other.TurnRate)
		{
			return false;
		}
		if (LockEndOperation != other.LockEndOperation)
		{
			return false;
		}
		if (RandomRadius != other.RandomRadius)
		{
			return false;
		}
		if (RandomStartAngle != other.RandomStartAngle)
		{
			return false;
		}
		if (RandomEndAngle != other.RandomEndAngle)
		{
			return false;
		}
		if (UseReverse != other.UseReverse)
		{
			return false;
		}
		if (NeedInGraph != other.NeedInGraph)
		{
			return false;
		}
		if (TargetCampType != other.TargetCampType)
		{
			return false;
		}
		if (FollowThreshold != other.FollowThreshold)
		{
			return false;
		}
		if (StartChangeHeightTime != other.StartChangeHeightTime)
		{
			return false;
		}
		if (LockTargetPoint != other.LockTargetPoint)
		{
			return false;
		}
		if (!angleSpeedCurveFrame_.Equals(other.angleSpeedCurveFrame_))
		{
			return false;
		}
		if (!angleSpeedCurveVal_.Equals(other.angleSpeedCurveVal_))
		{
			return false;
		}
		if (ChangeAngleSpeedAngle != other.ChangeAngleSpeedAngle)
		{
			return false;
		}
		if (ChangeAngleSpeedFactor != other.ChangeAngleSpeedFactor)
		{
			return false;
		}
		if (TargetChangeWhenDead != other.TargetChangeWhenDead)
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
		if (Height != 0)
		{
			num ^= Height.GetHashCode();
		}
		if (centerOffset_ != null)
		{
			num ^= CenterOffset.GetHashCode();
		}
		if (ThrownBehaviourOnCollision != 0)
		{
			num ^= ThrownBehaviourOnCollision.GetHashCode();
		}
		if (SpawnThrownTimelineID != 0)
		{
			num ^= SpawnThrownTimelineID.GetHashCode();
		}
		if (ChangeTargetCountLimit != 0)
		{
			num ^= ChangeTargetCountLimit.GetHashCode();
		}
		if (TurnRate != 0)
		{
			num ^= TurnRate.GetHashCode();
		}
		if (LockEndOperation != 0)
		{
			num ^= LockEndOperation.GetHashCode();
		}
		if (RandomRadius != 0)
		{
			num ^= RandomRadius.GetHashCode();
		}
		if (RandomStartAngle != 0)
		{
			num ^= RandomStartAngle.GetHashCode();
		}
		if (RandomEndAngle != 0)
		{
			num ^= RandomEndAngle.GetHashCode();
		}
		if (UseReverse)
		{
			num ^= UseReverse.GetHashCode();
		}
		if (NeedInGraph)
		{
			num ^= NeedInGraph.GetHashCode();
		}
		if (TargetCampType != TargetCampType.None)
		{
			num ^= TargetCampType.GetHashCode();
		}
		if (FollowThreshold != 0)
		{
			num ^= FollowThreshold.GetHashCode();
		}
		if (StartChangeHeightTime != 0)
		{
			num ^= StartChangeHeightTime.GetHashCode();
		}
		if (LockTargetPoint)
		{
			num ^= LockTargetPoint.GetHashCode();
		}
		num ^= angleSpeedCurveFrame_.GetHashCode();
		num ^= angleSpeedCurveVal_.GetHashCode();
		if (ChangeAngleSpeedAngle != 0)
		{
			num ^= ChangeAngleSpeedAngle.GetHashCode();
		}
		if (ChangeAngleSpeedFactor != 0)
		{
			num ^= ChangeAngleSpeedFactor.GetHashCode();
		}
		if (TargetChangeWhenDead)
		{
			num ^= TargetChangeWhenDead.GetHashCode();
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
		if (Height != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Height);
		}
		if (centerOffset_ != null)
		{
			output.WriteRawTag(82);
			output.WriteMessage(CenterOffset);
		}
		if (ThrownBehaviourOnCollision != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(ThrownBehaviourOnCollision);
		}
		if (SpawnThrownTimelineID != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(SpawnThrownTimelineID);
		}
		if (ChangeTargetCountLimit != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(ChangeTargetCountLimit);
		}
		if (TurnRate != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(TurnRate);
		}
		if (LockEndOperation != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(LockEndOperation);
		}
		if (RandomRadius != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(RandomRadius);
		}
		if (RandomStartAngle != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(RandomStartAngle);
		}
		if (RandomEndAngle != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(RandomEndAngle);
		}
		if (UseReverse)
		{
			output.WriteRawTag(152, 1);
			output.WriteBool(UseReverse);
		}
		if (NeedInGraph)
		{
			output.WriteRawTag(160, 1);
			output.WriteBool(NeedInGraph);
		}
		if (TargetCampType != TargetCampType.None)
		{
			output.WriteRawTag(168, 1);
			output.WriteEnum((int)TargetCampType);
		}
		if (FollowThreshold != 0)
		{
			output.WriteRawTag(176, 1);
			output.WriteInt32(FollowThreshold);
		}
		if (StartChangeHeightTime != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(StartChangeHeightTime);
		}
		if (LockTargetPoint)
		{
			output.WriteRawTag(192, 1);
			output.WriteBool(LockTargetPoint);
		}
		angleSpeedCurveFrame_.WriteTo(output, _repeated_angleSpeedCurveFrame_codec);
		angleSpeedCurveVal_.WriteTo(output, _repeated_angleSpeedCurveVal_codec);
		if (ChangeAngleSpeedAngle != 0)
		{
			output.WriteRawTag(216, 1);
			output.WriteInt32(ChangeAngleSpeedAngle);
		}
		if (ChangeAngleSpeedFactor != 0)
		{
			output.WriteRawTag(224, 1);
			output.WriteInt32(ChangeAngleSpeedFactor);
		}
		if (TargetChangeWhenDead)
		{
			output.WriteRawTag(232, 1);
			output.WriteBool(TargetChangeWhenDead);
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
		if (Height != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Height);
		}
		if (centerOffset_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(CenterOffset);
		}
		if (ThrownBehaviourOnCollision != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ThrownBehaviourOnCollision);
		}
		if (SpawnThrownTimelineID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SpawnThrownTimelineID);
		}
		if (ChangeTargetCountLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChangeTargetCountLimit);
		}
		if (TurnRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TurnRate);
		}
		if (LockEndOperation != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LockEndOperation);
		}
		if (RandomRadius != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RandomRadius);
		}
		if (RandomStartAngle != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RandomStartAngle);
		}
		if (RandomEndAngle != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RandomEndAngle);
		}
		if (UseReverse)
		{
			num += 3;
		}
		if (NeedInGraph)
		{
			num += 3;
		}
		if (TargetCampType != TargetCampType.None)
		{
			num += 2 + CodedOutputStream.ComputeEnumSize((int)TargetCampType);
		}
		if (FollowThreshold != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FollowThreshold);
		}
		if (StartChangeHeightTime != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(StartChangeHeightTime);
		}
		if (LockTargetPoint)
		{
			num += 3;
		}
		num += angleSpeedCurveFrame_.CalculateSize(_repeated_angleSpeedCurveFrame_codec);
		num += angleSpeedCurveVal_.CalculateSize(_repeated_angleSpeedCurveVal_codec);
		if (ChangeAngleSpeedAngle != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ChangeAngleSpeedAngle);
		}
		if (ChangeAngleSpeedFactor != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ChangeAngleSpeedFactor);
		}
		if (TargetChangeWhenDead)
		{
			num += 3;
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ThrownLockActionInfo other)
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
		if (other.Height != 0)
		{
			Height = other.Height;
		}
		if (other.centerOffset_ != null)
		{
			if (centerOffset_ == null)
			{
				centerOffset_ = new VectorInt3();
			}
			CenterOffset.MergeFrom(other.CenterOffset);
		}
		if (other.ThrownBehaviourOnCollision != 0)
		{
			ThrownBehaviourOnCollision = other.ThrownBehaviourOnCollision;
		}
		if (other.SpawnThrownTimelineID != 0)
		{
			SpawnThrownTimelineID = other.SpawnThrownTimelineID;
		}
		if (other.ChangeTargetCountLimit != 0)
		{
			ChangeTargetCountLimit = other.ChangeTargetCountLimit;
		}
		if (other.TurnRate != 0)
		{
			TurnRate = other.TurnRate;
		}
		if (other.LockEndOperation != 0)
		{
			LockEndOperation = other.LockEndOperation;
		}
		if (other.RandomRadius != 0)
		{
			RandomRadius = other.RandomRadius;
		}
		if (other.RandomStartAngle != 0)
		{
			RandomStartAngle = other.RandomStartAngle;
		}
		if (other.RandomEndAngle != 0)
		{
			RandomEndAngle = other.RandomEndAngle;
		}
		if (other.UseReverse)
		{
			UseReverse = other.UseReverse;
		}
		if (other.NeedInGraph)
		{
			NeedInGraph = other.NeedInGraph;
		}
		if (other.TargetCampType != TargetCampType.None)
		{
			TargetCampType = other.TargetCampType;
		}
		if (other.FollowThreshold != 0)
		{
			FollowThreshold = other.FollowThreshold;
		}
		if (other.StartChangeHeightTime != 0)
		{
			StartChangeHeightTime = other.StartChangeHeightTime;
		}
		if (other.LockTargetPoint)
		{
			LockTargetPoint = other.LockTargetPoint;
		}
		angleSpeedCurveFrame_.Add(other.angleSpeedCurveFrame_);
		angleSpeedCurveVal_.Add(other.angleSpeedCurveVal_);
		if (other.ChangeAngleSpeedAngle != 0)
		{
			ChangeAngleSpeedAngle = other.ChangeAngleSpeedAngle;
		}
		if (other.ChangeAngleSpeedFactor != 0)
		{
			ChangeAngleSpeedFactor = other.ChangeAngleSpeedFactor;
		}
		if (other.TargetChangeWhenDead)
		{
			TargetChangeWhenDead = other.TargetChangeWhenDead;
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
			case 72u:
				Height = input.ReadInt32();
				break;
			case 82u:
				if (centerOffset_ == null)
				{
					centerOffset_ = new VectorInt3();
				}
				input.ReadMessage(centerOffset_);
				break;
			case 88u:
				ThrownBehaviourOnCollision = input.ReadInt32();
				break;
			case 96u:
				SpawnThrownTimelineID = input.ReadInt32();
				break;
			case 104u:
				ChangeTargetCountLimit = input.ReadInt32();
				break;
			case 112u:
				TurnRate = input.ReadInt32();
				break;
			case 120u:
				LockEndOperation = input.ReadInt32();
				break;
			case 128u:
				RandomRadius = input.ReadInt32();
				break;
			case 136u:
				RandomStartAngle = input.ReadInt32();
				break;
			case 144u:
				RandomEndAngle = input.ReadInt32();
				break;
			case 152u:
				UseReverse = input.ReadBool();
				break;
			case 160u:
				NeedInGraph = input.ReadBool();
				break;
			case 168u:
				targetCampType_ = (TargetCampType)input.ReadEnum();
				break;
			case 176u:
				FollowThreshold = input.ReadInt32();
				break;
			case 184u:
				StartChangeHeightTime = input.ReadInt32();
				break;
			case 192u:
				LockTargetPoint = input.ReadBool();
				break;
			case 200u:
			case 202u:
				angleSpeedCurveFrame_.AddEntriesFrom(input, _repeated_angleSpeedCurveFrame_codec);
				break;
			case 208u:
			case 210u:
				angleSpeedCurveVal_.AddEntriesFrom(input, _repeated_angleSpeedCurveVal_codec);
				break;
			case 216u:
				ChangeAngleSpeedAngle = input.ReadInt32();
				break;
			case 224u:
				ChangeAngleSpeedFactor = input.ReadInt32();
				break;
			case 232u:
				TargetChangeWhenDead = input.ReadBool();
				break;
			}
		}
	}
}
