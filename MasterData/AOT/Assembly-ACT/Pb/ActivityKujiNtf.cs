using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ActivityKujiNtf : IMessage<ActivityKujiNtf>, IMessage, IEquatable<ActivityKujiNtf>, IDeepCloneable<ActivityKujiNtf>, IBufferMessage
{
	private static readonly MessageParser<ActivityKujiNtf> _parser = new MessageParser<ActivityKujiNtf>(() => new ActivityKujiNtf());

	private UnknownFieldSet _unknownFields;

	public const int ActivityKujiInfoFieldNumber = 1;

	private ActivityKujiInfo activityKujiInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityKujiNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ActivityReflection.Descriptor.MessageTypes[32];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityKujiInfo ActivityKujiInfo
	{
		get
		{
			return activityKujiInfo_;
		}
		set
		{
			activityKujiInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityKujiNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityKujiNtf(ActivityKujiNtf other)
		: this()
	{
		activityKujiInfo_ = ((other.activityKujiInfo_ != null) ? other.activityKujiInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityKujiNtf Clone()
	{
		return new ActivityKujiNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityKujiNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityKujiNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(ActivityKujiInfo, other.ActivityKujiInfo))
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
		if (activityKujiInfo_ != null)
		{
			num ^= ActivityKujiInfo.GetHashCode();
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
		if (activityKujiInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(ActivityKujiInfo);
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
		if (activityKujiInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ActivityKujiInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityKujiNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.activityKujiInfo_ != null)
		{
			if (activityKujiInfo_ == null)
			{
				ActivityKujiInfo = new ActivityKujiInfo();
			}
			ActivityKujiInfo.MergeFrom(other.ActivityKujiInfo);
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
			if (activityKujiInfo_ == null)
			{
				ActivityKujiInfo = new ActivityKujiInfo();
			}
			input.ReadMessage(ActivityKujiInfo);
		}
	}
}
