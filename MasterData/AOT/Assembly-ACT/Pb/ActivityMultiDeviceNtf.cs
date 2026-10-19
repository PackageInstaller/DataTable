using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ActivityMultiDeviceNtf : IMessage<ActivityMultiDeviceNtf>, IMessage, IEquatable<ActivityMultiDeviceNtf>, IDeepCloneable<ActivityMultiDeviceNtf>, IBufferMessage
{
	private static readonly MessageParser<ActivityMultiDeviceNtf> _parser = new MessageParser<ActivityMultiDeviceNtf>(() => new ActivityMultiDeviceNtf());

	private UnknownFieldSet _unknownFields;

	public const int ActivityMultiDeviceInfoFieldNumber = 1;

	private ActivityMultiDeviceInfo activityMultiDeviceInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityMultiDeviceNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ActivityReflection.Descriptor.MessageTypes[43];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityMultiDeviceInfo ActivityMultiDeviceInfo
	{
		get
		{
			return activityMultiDeviceInfo_;
		}
		set
		{
			activityMultiDeviceInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityMultiDeviceNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityMultiDeviceNtf(ActivityMultiDeviceNtf other)
		: this()
	{
		activityMultiDeviceInfo_ = ((other.activityMultiDeviceInfo_ != null) ? other.activityMultiDeviceInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityMultiDeviceNtf Clone()
	{
		return new ActivityMultiDeviceNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityMultiDeviceNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityMultiDeviceNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(ActivityMultiDeviceInfo, other.ActivityMultiDeviceInfo))
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
		if (activityMultiDeviceInfo_ != null)
		{
			num ^= ActivityMultiDeviceInfo.GetHashCode();
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
		if (activityMultiDeviceInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(ActivityMultiDeviceInfo);
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
		if (activityMultiDeviceInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ActivityMultiDeviceInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityMultiDeviceNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.activityMultiDeviceInfo_ != null)
		{
			if (activityMultiDeviceInfo_ == null)
			{
				ActivityMultiDeviceInfo = new ActivityMultiDeviceInfo();
			}
			ActivityMultiDeviceInfo.MergeFrom(other.ActivityMultiDeviceInfo);
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
			if (activityMultiDeviceInfo_ == null)
			{
				ActivityMultiDeviceInfo = new ActivityMultiDeviceInfo();
			}
			input.ReadMessage(ActivityMultiDeviceInfo);
		}
	}
}
