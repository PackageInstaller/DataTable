using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ActivityTempleChallengeNtf : IMessage<ActivityTempleChallengeNtf>, IMessage, IEquatable<ActivityTempleChallengeNtf>, IDeepCloneable<ActivityTempleChallengeNtf>, IBufferMessage
{
	private static readonly MessageParser<ActivityTempleChallengeNtf> _parser = new MessageParser<ActivityTempleChallengeNtf>(() => new ActivityTempleChallengeNtf());

	private UnknownFieldSet _unknownFields;

	public const int ActivitTempleChallengeInfoFieldNumber = 1;

	private ActivitTempleChallengeInfo activitTempleChallengeInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityTempleChallengeNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ActivityReflection.Descriptor.MessageTypes[19];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitTempleChallengeInfo ActivitTempleChallengeInfo
	{
		get
		{
			return activitTempleChallengeInfo_;
		}
		set
		{
			activitTempleChallengeInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityTempleChallengeNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityTempleChallengeNtf(ActivityTempleChallengeNtf other)
		: this()
	{
		activitTempleChallengeInfo_ = ((other.activitTempleChallengeInfo_ != null) ? other.activitTempleChallengeInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityTempleChallengeNtf Clone()
	{
		return new ActivityTempleChallengeNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityTempleChallengeNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityTempleChallengeNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(ActivitTempleChallengeInfo, other.ActivitTempleChallengeInfo))
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
		if (activitTempleChallengeInfo_ != null)
		{
			num ^= ActivitTempleChallengeInfo.GetHashCode();
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
		if (activitTempleChallengeInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(ActivitTempleChallengeInfo);
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
		if (activitTempleChallengeInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ActivitTempleChallengeInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityTempleChallengeNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.activitTempleChallengeInfo_ != null)
		{
			if (activitTempleChallengeInfo_ == null)
			{
				ActivitTempleChallengeInfo = new ActivitTempleChallengeInfo();
			}
			ActivitTempleChallengeInfo.MergeFrom(other.ActivitTempleChallengeInfo);
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
			if (activitTempleChallengeInfo_ == null)
			{
				ActivitTempleChallengeInfo = new ActivitTempleChallengeInfo();
			}
			input.ReadMessage(ActivitTempleChallengeInfo);
		}
	}
}
