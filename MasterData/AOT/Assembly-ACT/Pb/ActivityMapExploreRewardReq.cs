using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ActivityMapExploreRewardReq : IMessage<ActivityMapExploreRewardReq>, IMessage, IEquatable<ActivityMapExploreRewardReq>, IDeepCloneable<ActivityMapExploreRewardReq>, IBufferMessage
{
	private static readonly MessageParser<ActivityMapExploreRewardReq> _parser = new MessageParser<ActivityMapExploreRewardReq>(() => new ActivityMapExploreRewardReq());

	private UnknownFieldSet _unknownFields;

	public const int ActivityIdFieldNumber = 1;

	private int activityId_;

	public const int ActivityGroupFieldNumber = 2;

	private int activityGroup_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityMapExploreRewardReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ActivityReflection.Descriptor.MessageTypes[41];

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
	public int ActivityGroup
	{
		get
		{
			return activityGroup_;
		}
		set
		{
			activityGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityMapExploreRewardReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityMapExploreRewardReq(ActivityMapExploreRewardReq other)
		: this()
	{
		activityId_ = other.activityId_;
		activityGroup_ = other.activityGroup_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityMapExploreRewardReq Clone()
	{
		return new ActivityMapExploreRewardReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityMapExploreRewardReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityMapExploreRewardReq other)
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
		if (ActivityGroup != other.ActivityGroup)
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
		if (ActivityGroup != 0)
		{
			num ^= ActivityGroup.GetHashCode();
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
		if (ActivityGroup != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ActivityGroup);
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
		if (ActivityGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityGroup);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityMapExploreRewardReq other)
	{
		if (other != null)
		{
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			if (other.ActivityGroup != 0)
			{
				ActivityGroup = other.ActivityGroup;
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
				ActivityGroup = input.ReadInt32();
				break;
			}
		}
	}
}
