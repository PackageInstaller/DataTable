using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ActivityGroup : IMessage<ActivityGroup>, IMessage, IEquatable<ActivityGroup>, IDeepCloneable<ActivityGroup>, IBufferMessage
{
	private static readonly MessageParser<ActivityGroup> _parser = new MessageParser<ActivityGroup>(() => new ActivityGroup());

	private UnknownFieldSet _unknownFields;

	public const int ActivityGroupIdFieldNumber = 1;

	private int activityGroupId_;

	public const int ActivityChallengeIdsFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_activityChallengeIds_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> activityChallengeIds_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityGroup> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[254];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ActivityGroupId
	{
		get
		{
			return activityGroupId_;
		}
		set
		{
			activityGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> ActivityChallengeIds => activityChallengeIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityGroup()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityGroup(ActivityGroup other)
		: this()
	{
		activityGroupId_ = other.activityGroupId_;
		activityChallengeIds_ = other.activityChallengeIds_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityGroup Clone()
	{
		return new ActivityGroup(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityGroup);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityGroup other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ActivityGroupId != other.ActivityGroupId)
		{
			return false;
		}
		if (!activityChallengeIds_.Equals(other.activityChallengeIds_))
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
		if (ActivityGroupId != 0)
		{
			num ^= ActivityGroupId.GetHashCode();
		}
		num ^= activityChallengeIds_.GetHashCode();
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
		if (ActivityGroupId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ActivityGroupId);
		}
		activityChallengeIds_.WriteTo(ref output, _repeated_activityChallengeIds_codec);
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
		if (ActivityGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityGroupId);
		}
		num += activityChallengeIds_.CalculateSize(_repeated_activityChallengeIds_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityGroup other)
	{
		if (other != null)
		{
			if (other.ActivityGroupId != 0)
			{
				ActivityGroupId = other.ActivityGroupId;
			}
			activityChallengeIds_.Add(other.activityChallengeIds_);
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
				ActivityGroupId = input.ReadInt32();
				break;
			case 16u:
			case 18u:
				activityChallengeIds_.AddEntriesFrom(ref input, _repeated_activityChallengeIds_codec);
				break;
			}
		}
	}
}
