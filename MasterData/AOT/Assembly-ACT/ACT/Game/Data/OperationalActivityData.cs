using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class OperationalActivityData : IMessage<OperationalActivityData>, IMessage, IEquatable<OperationalActivityData>, IDeepCloneable<OperationalActivityData>, IBufferMessage
{
	private static readonly MessageParser<OperationalActivityData> _parser = new MessageParser<OperationalActivityData>(() => new OperationalActivityData());

	private UnknownFieldSet _unknownFields;

	public const int ActivityIdFieldNumber = 1;

	private int activityId_;

	public const int ActivityTypeFieldNumber = 2;

	private int activityType_;

	public const int PriorityFieldNumber = 3;

	private int priority_;

	public const int StartTimeFieldNumber = 4;

	private long startTime_;

	public const int EndTimeFieldNumber = 5;

	private long endTime_;

	public const int GroupsFieldNumber = 6;

	private static readonly MapField<int, ActivityGroupData>.Codec _map_groups_codec = new MapField<int, ActivityGroupData>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ActivityGroupData.Parser), 50u);

	private readonly MapField<int, ActivityGroupData> groups_ = new MapField<int, ActivityGroupData>();

	public const int IsHideFieldNumber = 7;

	private bool isHide_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<OperationalActivityData> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[247];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ActivityId
	{
		get
		{
			return activityId_;
		}
		set
		{
			activityId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ActivityType
	{
		get
		{
			return activityType_;
		}
		set
		{
			activityType_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Priority
	{
		get
		{
			return priority_;
		}
		set
		{
			priority_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long StartTime
	{
		get
		{
			return startTime_;
		}
		set
		{
			startTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long EndTime
	{
		get
		{
			return endTime_;
		}
		set
		{
			endTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ActivityGroupData> Groups => groups_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool IsHide
	{
		get
		{
			return isHide_;
		}
		set
		{
			isHide_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OperationalActivityData()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OperationalActivityData(OperationalActivityData other)
		: this()
	{
		activityId_ = other.activityId_;
		activityType_ = other.activityType_;
		priority_ = other.priority_;
		startTime_ = other.startTime_;
		endTime_ = other.endTime_;
		groups_ = other.groups_.Clone();
		isHide_ = other.isHide_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OperationalActivityData Clone()
	{
		return new OperationalActivityData(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as OperationalActivityData);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(OperationalActivityData other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ActivityId != other.ActivityId)
		{
			return false;
		}
		if (ActivityType != other.ActivityType)
		{
			return false;
		}
		if (Priority != other.Priority)
		{
			return false;
		}
		if (StartTime != other.StartTime)
		{
			return false;
		}
		if (EndTime != other.EndTime)
		{
			return false;
		}
		if (!Groups.Equals(other.Groups))
		{
			return false;
		}
		if (IsHide != other.IsHide)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		if (ActivityId != 0)
		{
			num ^= ActivityId.GetHashCode();
		}
		if (ActivityType != 0)
		{
			num ^= ActivityType.GetHashCode();
		}
		if (Priority != 0)
		{
			num ^= Priority.GetHashCode();
		}
		if (StartTime != 0L)
		{
			num ^= StartTime.GetHashCode();
		}
		if (EndTime != 0L)
		{
			num ^= EndTime.GetHashCode();
		}
		num ^= Groups.GetHashCode();
		if (IsHide)
		{
			num ^= IsHide.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (ActivityId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ActivityId);
		}
		if (ActivityType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ActivityType);
		}
		if (Priority != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Priority);
		}
		if (StartTime != 0L)
		{
			output.WriteRawTag(32);
			output.WriteInt64(StartTime);
		}
		if (EndTime != 0L)
		{
			output.WriteRawTag(40);
			output.WriteInt64(EndTime);
		}
		groups_.WriteTo(ref output, _map_groups_codec);
		if (IsHide)
		{
			output.WriteRawTag(56);
			output.WriteBool(IsHide);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		if (ActivityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityId);
		}
		if (ActivityType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityType);
		}
		if (Priority != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Priority);
		}
		if (StartTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(StartTime);
		}
		if (EndTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(EndTime);
		}
		num += groups_.CalculateSize(_map_groups_codec);
		if (IsHide)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(OperationalActivityData other)
	{
		if (other != null)
		{
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			if (other.ActivityType != 0)
			{
				ActivityType = other.ActivityType;
			}
			if (other.Priority != 0)
			{
				Priority = other.Priority;
			}
			if (other.StartTime != 0L)
			{
				StartTime = other.StartTime;
			}
			if (other.EndTime != 0L)
			{
				EndTime = other.EndTime;
			}
			groups_.Add(other.groups_);
			if (other.IsHide)
			{
				IsHide = other.IsHide;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				ActivityId = input.ReadInt32();
				break;
			case 16u:
				ActivityType = input.ReadInt32();
				break;
			case 24u:
				Priority = input.ReadInt32();
				break;
			case 32u:
				StartTime = input.ReadInt64();
				break;
			case 40u:
				EndTime = input.ReadInt64();
				break;
			case 50u:
				groups_.AddEntriesFrom(ref input, _map_groups_codec);
				break;
			case 56u:
				IsHide = input.ReadBool();
				break;
			}
		}
	}
}
