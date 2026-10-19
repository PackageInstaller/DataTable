using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ActivityMainStoryNtf : IMessage<ActivityMainStoryNtf>, IMessage, IEquatable<ActivityMainStoryNtf>, IDeepCloneable<ActivityMainStoryNtf>, IBufferMessage
{
	private static readonly MessageParser<ActivityMainStoryNtf> _parser = new MessageParser<ActivityMainStoryNtf>(() => new ActivityMainStoryNtf());

	private UnknownFieldSet _unknownFields;

	public const int ActivityMainStoryInfoFieldNumber = 1;

	private ActivityMainStoryInfo activityMainStoryInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityMainStoryNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ActivityReflection.Descriptor.MessageTypes[37];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityMainStoryInfo ActivityMainStoryInfo
	{
		get
		{
			return activityMainStoryInfo_;
		}
		set
		{
			activityMainStoryInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityMainStoryNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityMainStoryNtf(ActivityMainStoryNtf other)
		: this()
	{
		activityMainStoryInfo_ = ((other.activityMainStoryInfo_ != null) ? other.activityMainStoryInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityMainStoryNtf Clone()
	{
		return new ActivityMainStoryNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityMainStoryNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityMainStoryNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(ActivityMainStoryInfo, other.ActivityMainStoryInfo))
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
		if (activityMainStoryInfo_ != null)
		{
			num ^= ActivityMainStoryInfo.GetHashCode();
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
		if (activityMainStoryInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(ActivityMainStoryInfo);
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
		if (activityMainStoryInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ActivityMainStoryInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityMainStoryNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.activityMainStoryInfo_ != null)
		{
			if (activityMainStoryInfo_ == null)
			{
				ActivityMainStoryInfo = new ActivityMainStoryInfo();
			}
			ActivityMainStoryInfo.MergeFrom(other.ActivityMainStoryInfo);
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
			if (activityMainStoryInfo_ == null)
			{
				ActivityMainStoryInfo = new ActivityMainStoryInfo();
			}
			input.ReadMessage(ActivityMainStoryInfo);
		}
	}
}
