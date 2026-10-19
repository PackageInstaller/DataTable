using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ActivityCombinationNtf : IMessage<ActivityCombinationNtf>, IMessage, IEquatable<ActivityCombinationNtf>, IDeepCloneable<ActivityCombinationNtf>, IBufferMessage
{
	private static readonly MessageParser<ActivityCombinationNtf> _parser = new MessageParser<ActivityCombinationNtf>(() => new ActivityCombinationNtf());

	private UnknownFieldSet _unknownFields;

	public const int ActivitCombinationInfoFieldNumber = 1;

	private ActivitCombinationInfo activitCombinationInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityCombinationNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ActivityReflection.Descriptor.MessageTypes[16];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitCombinationInfo ActivitCombinationInfo
	{
		get
		{
			return activitCombinationInfo_;
		}
		set
		{
			activitCombinationInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityCombinationNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityCombinationNtf(ActivityCombinationNtf other)
		: this()
	{
		activitCombinationInfo_ = ((other.activitCombinationInfo_ != null) ? other.activitCombinationInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityCombinationNtf Clone()
	{
		return new ActivityCombinationNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityCombinationNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityCombinationNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(ActivitCombinationInfo, other.ActivitCombinationInfo))
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
		if (activitCombinationInfo_ != null)
		{
			num ^= ActivitCombinationInfo.GetHashCode();
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
		if (activitCombinationInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(ActivitCombinationInfo);
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
		if (activitCombinationInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ActivitCombinationInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityCombinationNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.activitCombinationInfo_ != null)
		{
			if (activitCombinationInfo_ == null)
			{
				ActivitCombinationInfo = new ActivitCombinationInfo();
			}
			ActivitCombinationInfo.MergeFrom(other.ActivitCombinationInfo);
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
			if (activitCombinationInfo_ == null)
			{
				ActivitCombinationInfo = new ActivitCombinationInfo();
			}
			input.ReadMessage(ActivitCombinationInfo);
		}
	}
}
