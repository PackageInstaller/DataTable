using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class ThrownCollisionCheckInfo : IMessage<ThrownCollisionCheckInfo>, IMessage, IEquatable<ThrownCollisionCheckInfo>, IDeepCloneable<ThrownCollisionCheckInfo>
{
	private static readonly MessageParser<ThrownCollisionCheckInfo> _parser = new MessageParser<ThrownCollisionCheckInfo>(() => new ThrownCollisionCheckInfo());

	public const int KeyFieldNumber = 1;

	private int key_;

	public const int StartFieldNumber = 2;

	private int start_;

	public const int DurationFieldNumber = 3;

	private int duration_;

	public const int TargetCampTypeFieldNumber = 4;

	private TargetCampType targetCampType_;

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

	public const int HeightFieldNumber = 10;

	private int height_;

	public const int CenterOffsetFieldNumber = 11;

	private VectorInt3 centerOffset_;

	public const int IgnoreHitHistoryFieldNumber = 12;

	private bool ignoreHitHistory_;

	public const int ThrownBehaviourOnCollisionFieldNumber = 13;

	private int thrownBehaviourOnCollision_;

	public const int SpawnThrownTimelineIDFieldNumber = 14;

	private int spawnThrownTimelineID_;

	public const int ChangeTargetCountLimitFieldNumber = 15;

	private int changeTargetCountLimit_;

	public const int UnuseDeltaPositionFieldNumber = 16;

	private bool unuseDeltaPosition_;

	public const int ValidHitHeightFieldNumber = 17;

	private int validHitHeight_;

	[DebuggerNonUserCode]
	public static MessageParser<ThrownCollisionCheckInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[62];

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
	public bool UnuseDeltaPosition
	{
		get
		{
			return unuseDeltaPosition_;
		}
		set
		{
			unuseDeltaPosition_ = value;
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
	public ThrownCollisionCheckInfo()
	{
	}

	[DebuggerNonUserCode]
	public ThrownCollisionCheckInfo(ThrownCollisionCheckInfo other)
		: this()
	{
		key_ = other.key_;
		start_ = other.start_;
		duration_ = other.duration_;
		targetCampType_ = other.targetCampType_;
		rangeType_ = other.rangeType_;
		radius_ = other.radius_;
		angle_ = other.angle_;
		length_ = other.length_;
		width_ = other.width_;
		height_ = other.height_;
		CenterOffset = ((other.centerOffset_ != null) ? other.CenterOffset.Clone() : null);
		ignoreHitHistory_ = other.ignoreHitHistory_;
		thrownBehaviourOnCollision_ = other.thrownBehaviourOnCollision_;
		spawnThrownTimelineID_ = other.spawnThrownTimelineID_;
		changeTargetCountLimit_ = other.changeTargetCountLimit_;
		unuseDeltaPosition_ = other.unuseDeltaPosition_;
		validHitHeight_ = other.validHitHeight_;
	}

	[DebuggerNonUserCode]
	public ThrownCollisionCheckInfo Clone()
	{
		return new ThrownCollisionCheckInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ThrownCollisionCheckInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(ThrownCollisionCheckInfo other)
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
		if (Start != other.Start)
		{
			return false;
		}
		if (Duration != other.Duration)
		{
			return false;
		}
		if (TargetCampType != other.TargetCampType)
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
		if (IgnoreHitHistory != other.IgnoreHitHistory)
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
		if (UnuseDeltaPosition != other.UnuseDeltaPosition)
		{
			return false;
		}
		if (ValidHitHeight != other.ValidHitHeight)
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
		if (Start != 0)
		{
			num ^= Start.GetHashCode();
		}
		if (Duration != 0)
		{
			num ^= Duration.GetHashCode();
		}
		if (TargetCampType != TargetCampType.None)
		{
			num ^= TargetCampType.GetHashCode();
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
		if (IgnoreHitHistory)
		{
			num ^= IgnoreHitHistory.GetHashCode();
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
		if (UnuseDeltaPosition)
		{
			num ^= UnuseDeltaPosition.GetHashCode();
		}
		if (ValidHitHeight != 0)
		{
			num ^= ValidHitHeight.GetHashCode();
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
		if (TargetCampType != TargetCampType.None)
		{
			output.WriteRawTag(32);
			output.WriteEnum((int)TargetCampType);
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
		if (Height != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Height);
		}
		if (centerOffset_ != null)
		{
			output.WriteRawTag(90);
			output.WriteMessage(CenterOffset);
		}
		if (IgnoreHitHistory)
		{
			output.WriteRawTag(96);
			output.WriteBool(IgnoreHitHistory);
		}
		if (ThrownBehaviourOnCollision != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(ThrownBehaviourOnCollision);
		}
		if (SpawnThrownTimelineID != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(SpawnThrownTimelineID);
		}
		if (ChangeTargetCountLimit != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(ChangeTargetCountLimit);
		}
		if (UnuseDeltaPosition)
		{
			output.WriteRawTag(128, 1);
			output.WriteBool(UnuseDeltaPosition);
		}
		if (ValidHitHeight != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(ValidHitHeight);
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
		if (Start != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Start);
		}
		if (Duration != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Duration);
		}
		if (TargetCampType != TargetCampType.None)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)TargetCampType);
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
		if (IgnoreHitHistory)
		{
			num += 2;
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
		if (UnuseDeltaPosition)
		{
			num += 3;
		}
		if (ValidHitHeight != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ValidHitHeight);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ThrownCollisionCheckInfo other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Key != 0)
		{
			Key = other.Key;
		}
		if (other.Start != 0)
		{
			Start = other.Start;
		}
		if (other.Duration != 0)
		{
			Duration = other.Duration;
		}
		if (other.TargetCampType != TargetCampType.None)
		{
			TargetCampType = other.TargetCampType;
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
		if (other.IgnoreHitHistory)
		{
			IgnoreHitHistory = other.IgnoreHitHistory;
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
		if (other.UnuseDeltaPosition)
		{
			UnuseDeltaPosition = other.UnuseDeltaPosition;
		}
		if (other.ValidHitHeight != 0)
		{
			ValidHitHeight = other.ValidHitHeight;
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
				Start = input.ReadInt32();
				break;
			case 24u:
				Duration = input.ReadInt32();
				break;
			case 32u:
				targetCampType_ = (TargetCampType)input.ReadEnum();
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
			case 80u:
				Height = input.ReadInt32();
				break;
			case 90u:
				if (centerOffset_ == null)
				{
					centerOffset_ = new VectorInt3();
				}
				input.ReadMessage(centerOffset_);
				break;
			case 96u:
				IgnoreHitHistory = input.ReadBool();
				break;
			case 104u:
				ThrownBehaviourOnCollision = input.ReadInt32();
				break;
			case 112u:
				SpawnThrownTimelineID = input.ReadInt32();
				break;
			case 120u:
				ChangeTargetCountLimit = input.ReadInt32();
				break;
			case 128u:
				UnuseDeltaPosition = input.ReadBool();
				break;
			case 136u:
				ValidHitHeight = input.ReadInt32();
				break;
			}
		}
	}
}
