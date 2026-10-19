using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ActivitySignInChooseRewardReq : IMessage<ActivitySignInChooseRewardReq>, IMessage, IEquatable<ActivitySignInChooseRewardReq>, IDeepCloneable<ActivitySignInChooseRewardReq>, IBufferMessage
{
	private static readonly MessageParser<ActivitySignInChooseRewardReq> _parser = new MessageParser<ActivitySignInChooseRewardReq>(() => new ActivitySignInChooseRewardReq());

	private UnknownFieldSet _unknownFields;

	public const int ActivityIdFieldNumber = 1;

	private int activityId_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int ChallengeIdFieldNumber = 3;

	private int challengeId_;

	public const int RewardsFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_rewards_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> rewards_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivitySignInChooseRewardReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ActivityReflection.Descriptor.MessageTypes[9];

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
	public int GroupId
	{
		get
		{
			return groupId_;
		}
		set
		{
			groupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ChallengeId
	{
		get
		{
			return challengeId_;
		}
		set
		{
			challengeId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> Rewards => rewards_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitySignInChooseRewardReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitySignInChooseRewardReq(ActivitySignInChooseRewardReq other)
		: this()
	{
		activityId_ = other.activityId_;
		groupId_ = other.groupId_;
		challengeId_ = other.challengeId_;
		rewards_ = other.rewards_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitySignInChooseRewardReq Clone()
	{
		return new ActivitySignInChooseRewardReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivitySignInChooseRewardReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivitySignInChooseRewardReq other)
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
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (ChallengeId != other.ChallengeId)
		{
			return false;
		}
		if (!rewards_.Equals(other.rewards_))
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
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (ChallengeId != 0)
		{
			num ^= ChallengeId.GetHashCode();
		}
		num ^= rewards_.GetHashCode();
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
		if (GroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GroupId);
		}
		if (ChallengeId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ChallengeId);
		}
		rewards_.WriteTo(ref output, _repeated_rewards_codec);
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
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (ChallengeId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChallengeId);
		}
		num += rewards_.CalculateSize(_repeated_rewards_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivitySignInChooseRewardReq other)
	{
		if (other != null)
		{
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.ChallengeId != 0)
			{
				ChallengeId = other.ChallengeId;
			}
			rewards_.Add(other.rewards_);
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
				GroupId = input.ReadInt32();
				break;
			case 24u:
				ChallengeId = input.ReadInt32();
				break;
			case 32u:
			case 34u:
				rewards_.AddEntriesFrom(ref input, _repeated_rewards_codec);
				break;
			}
		}
	}
}
