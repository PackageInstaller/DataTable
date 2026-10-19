using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ActivityAbyssRewardReq : IMessage<ActivityAbyssRewardReq>, IMessage, IEquatable<ActivityAbyssRewardReq>, IDeepCloneable<ActivityAbyssRewardReq>, IBufferMessage
{
	private static readonly MessageParser<ActivityAbyssRewardReq> _parser = new MessageParser<ActivityAbyssRewardReq>(() => new ActivityAbyssRewardReq());

	private UnknownFieldSet _unknownFields;

	public const int ActivityIdFieldNumber = 1;

	private int activityId_;

	public const int ActivityGroupFieldNumber = 2;

	private int activityGroup_;

	public const int ActivityChallengeFieldNumber = 3;

	private int activityChallenge_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityAbyssRewardReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ActivityReflection.Descriptor.MessageTypes[14];

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
	public int ActivityChallenge
	{
		get
		{
			return activityChallenge_;
		}
		set
		{
			activityChallenge_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityAbyssRewardReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityAbyssRewardReq(ActivityAbyssRewardReq other)
		: this()
	{
		activityId_ = other.activityId_;
		activityGroup_ = other.activityGroup_;
		activityChallenge_ = other.activityChallenge_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityAbyssRewardReq Clone()
	{
		return new ActivityAbyssRewardReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityAbyssRewardReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityAbyssRewardReq other)
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
		if (ActivityChallenge != other.ActivityChallenge)
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
		if (ActivityChallenge != 0)
		{
			num ^= ActivityChallenge.GetHashCode();
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
		if (ActivityChallenge != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ActivityChallenge);
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
		if (ActivityChallenge != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityChallenge);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityAbyssRewardReq other)
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
			if (other.ActivityChallenge != 0)
			{
				ActivityChallenge = other.ActivityChallenge;
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
			case 24u:
				ActivityChallenge = input.ReadInt32();
				break;
			}
		}
	}
}
