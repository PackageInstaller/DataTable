using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ActivityLevelRewardNtf : IMessage<ActivityLevelRewardNtf>, IMessage, IEquatable<ActivityLevelRewardNtf>, IDeepCloneable<ActivityLevelRewardNtf>, IBufferMessage
{
	private static readonly MessageParser<ActivityLevelRewardNtf> _parser = new MessageParser<ActivityLevelRewardNtf>(() => new ActivityLevelRewardNtf());

	private UnknownFieldSet _unknownFields;

	public const int ActivitLevelRewardInfoFieldNumber = 1;

	private ActivitLevelRewardInfo activitLevelRewardInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityLevelRewardNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ActivityReflection.Descriptor.MessageTypes[2];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitLevelRewardInfo ActivitLevelRewardInfo
	{
		get
		{
			return activitLevelRewardInfo_;
		}
		set
		{
			activitLevelRewardInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityLevelRewardNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityLevelRewardNtf(ActivityLevelRewardNtf other)
		: this()
	{
		activitLevelRewardInfo_ = ((other.activitLevelRewardInfo_ != null) ? other.activitLevelRewardInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityLevelRewardNtf Clone()
	{
		return new ActivityLevelRewardNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityLevelRewardNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityLevelRewardNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(ActivitLevelRewardInfo, other.ActivitLevelRewardInfo))
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
		if (activitLevelRewardInfo_ != null)
		{
			num ^= ActivitLevelRewardInfo.GetHashCode();
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
		if (activitLevelRewardInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(ActivitLevelRewardInfo);
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
		if (activitLevelRewardInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ActivitLevelRewardInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityLevelRewardNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.activitLevelRewardInfo_ != null)
		{
			if (activitLevelRewardInfo_ == null)
			{
				ActivitLevelRewardInfo = new ActivitLevelRewardInfo();
			}
			ActivitLevelRewardInfo.MergeFrom(other.ActivitLevelRewardInfo);
		}
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
			if (num != 10)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				continue;
			}
			if (activitLevelRewardInfo_ == null)
			{
				ActivitLevelRewardInfo = new ActivitLevelRewardInfo();
			}
			input.ReadMessage(ActivitLevelRewardInfo);
		}
	}
}
