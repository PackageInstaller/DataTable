using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class MoveActionTimelineNode : IMessage<MoveActionTimelineNode>, IMessage, IEquatable<MoveActionTimelineNode>, IDeepCloneable<MoveActionTimelineNode>
{
	private static readonly MessageParser<MoveActionTimelineNode> _parser = new MessageParser<MoveActionTimelineNode>(() => new MoveActionTimelineNode());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int EnableFieldNumber = 2;

	private bool enable_;

	public const int StartFieldNumber = 3;

	private int start_;

	public const int DurationFieldNumber = 4;

	private int duration_;

	public const int MoveDistanceFieldNumber = 5;

	private int moveDistance_;

	public const int UseUniformMotionFieldNumber = 6;

	private bool useUniformMotion_;

	public const int AverageSpeedFieldNumber = 7;

	private VectorInt3 averageSpeed_;

	public const int AnimationMoveFieldNumber = 8;

	private static readonly FieldCodec<VectorInt3> _repeated_animationMove_codec = FieldCodec.ForMessage(66u, VectorInt3.Parser);

	private readonly RepeatedField<VectorInt3> animationMove_ = new RepeatedField<VectorInt3>();

	public const int StartAngleOffsetFieldNumber = 9;

	private int startAngleOffset_;

	public const int AngleOffsetListFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_angleOffsetList_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> angleOffsetList_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<MoveActionTimelineNode> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[43];

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
	public bool Enable
	{
		get
		{
			return enable_;
		}
		set
		{
			enable_ = value;
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
	public int MoveDistance
	{
		get
		{
			return moveDistance_;
		}
		set
		{
			moveDistance_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool UseUniformMotion
	{
		get
		{
			return useUniformMotion_;
		}
		set
		{
			useUniformMotion_ = value;
		}
	}

	[DebuggerNonUserCode]
	public VectorInt3 AverageSpeed
	{
		get
		{
			return averageSpeed_;
		}
		set
		{
			averageSpeed_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<VectorInt3> AnimationMove => animationMove_;

	[DebuggerNonUserCode]
	public int StartAngleOffset
	{
		get
		{
			return startAngleOffset_;
		}
		set
		{
			startAngleOffset_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> AngleOffsetList => angleOffsetList_;

	[DebuggerNonUserCode]
	public MoveActionTimelineNode()
	{
	}

	[DebuggerNonUserCode]
	public MoveActionTimelineNode(MoveActionTimelineNode other)
		: this()
	{
		iD_ = other.iD_;
		enable_ = other.enable_;
		start_ = other.start_;
		duration_ = other.duration_;
		moveDistance_ = other.moveDistance_;
		useUniformMotion_ = other.useUniformMotion_;
		AverageSpeed = ((other.averageSpeed_ != null) ? other.AverageSpeed.Clone() : null);
		animationMove_ = other.animationMove_.Clone();
		startAngleOffset_ = other.startAngleOffset_;
		angleOffsetList_ = other.angleOffsetList_.Clone();
	}

	[DebuggerNonUserCode]
	public MoveActionTimelineNode Clone()
	{
		return new MoveActionTimelineNode(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MoveActionTimelineNode);
	}

	[DebuggerNonUserCode]
	public bool Equals(MoveActionTimelineNode other)
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
		if (Enable != other.Enable)
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
		if (MoveDistance != other.MoveDistance)
		{
			return false;
		}
		if (UseUniformMotion != other.UseUniformMotion)
		{
			return false;
		}
		if (!object.Equals(AverageSpeed, other.AverageSpeed))
		{
			return false;
		}
		if (!animationMove_.Equals(other.animationMove_))
		{
			return false;
		}
		if (StartAngleOffset != other.StartAngleOffset)
		{
			return false;
		}
		if (!angleOffsetList_.Equals(other.angleOffsetList_))
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
		if (Enable)
		{
			num ^= Enable.GetHashCode();
		}
		if (Start != 0)
		{
			num ^= Start.GetHashCode();
		}
		if (Duration != 0)
		{
			num ^= Duration.GetHashCode();
		}
		if (MoveDistance != 0)
		{
			num ^= MoveDistance.GetHashCode();
		}
		if (UseUniformMotion)
		{
			num ^= UseUniformMotion.GetHashCode();
		}
		if (averageSpeed_ != null)
		{
			num ^= AverageSpeed.GetHashCode();
		}
		num ^= animationMove_.GetHashCode();
		if (StartAngleOffset != 0)
		{
			num ^= StartAngleOffset.GetHashCode();
		}
		return num ^ angleOffsetList_.GetHashCode();
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
		if (Enable)
		{
			output.WriteRawTag(16);
			output.WriteBool(Enable);
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
		if (MoveDistance != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(MoveDistance);
		}
		if (UseUniformMotion)
		{
			output.WriteRawTag(48);
			output.WriteBool(UseUniformMotion);
		}
		if (averageSpeed_ != null)
		{
			output.WriteRawTag(58);
			output.WriteMessage(AverageSpeed);
		}
		animationMove_.WriteTo(output, _repeated_animationMove_codec);
		if (StartAngleOffset != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(StartAngleOffset);
		}
		angleOffsetList_.WriteTo(output, _repeated_angleOffsetList_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (Enable)
		{
			num += 2;
		}
		if (Start != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Start);
		}
		if (Duration != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Duration);
		}
		if (MoveDistance != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MoveDistance);
		}
		if (UseUniformMotion)
		{
			num += 2;
		}
		if (averageSpeed_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(AverageSpeed);
		}
		num += animationMove_.CalculateSize(_repeated_animationMove_codec);
		if (StartAngleOffset != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StartAngleOffset);
		}
		return num + angleOffsetList_.CalculateSize(_repeated_angleOffsetList_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MoveActionTimelineNode other)
	{
		if (other == null)
		{
			return;
		}
		if (other.ID != 0)
		{
			ID = other.ID;
		}
		if (other.Enable)
		{
			Enable = other.Enable;
		}
		if (other.Start != 0)
		{
			Start = other.Start;
		}
		if (other.Duration != 0)
		{
			Duration = other.Duration;
		}
		if (other.MoveDistance != 0)
		{
			MoveDistance = other.MoveDistance;
		}
		if (other.UseUniformMotion)
		{
			UseUniformMotion = other.UseUniformMotion;
		}
		if (other.averageSpeed_ != null)
		{
			if (averageSpeed_ == null)
			{
				averageSpeed_ = new VectorInt3();
			}
			AverageSpeed.MergeFrom(other.AverageSpeed);
		}
		animationMove_.Add(other.animationMove_);
		if (other.StartAngleOffset != 0)
		{
			StartAngleOffset = other.StartAngleOffset;
		}
		angleOffsetList_.Add(other.angleOffsetList_);
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
				Enable = input.ReadBool();
				break;
			case 24u:
				Start = input.ReadInt32();
				break;
			case 32u:
				Duration = input.ReadInt32();
				break;
			case 40u:
				MoveDistance = input.ReadInt32();
				break;
			case 48u:
				UseUniformMotion = input.ReadBool();
				break;
			case 58u:
				if (averageSpeed_ == null)
				{
					averageSpeed_ = new VectorInt3();
				}
				input.ReadMessage(averageSpeed_);
				break;
			case 66u:
				animationMove_.AddEntriesFrom(input, _repeated_animationMove_codec);
				break;
			case 72u:
				StartAngleOffset = input.ReadInt32();
				break;
			case 80u:
			case 82u:
				angleOffsetList_.AddEntriesFrom(input, _repeated_angleOffsetList_codec);
				break;
			}
		}
	}
}
