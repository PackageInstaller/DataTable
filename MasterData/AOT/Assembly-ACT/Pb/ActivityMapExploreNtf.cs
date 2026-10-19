using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ActivityMapExploreNtf : IMessage<ActivityMapExploreNtf>, IMessage, IEquatable<ActivityMapExploreNtf>, IDeepCloneable<ActivityMapExploreNtf>, IBufferMessage
{
	private static readonly MessageParser<ActivityMapExploreNtf> _parser = new MessageParser<ActivityMapExploreNtf>(() => new ActivityMapExploreNtf());

	private UnknownFieldSet _unknownFields;

	public const int ActivityMapExploreInfoFieldNumber = 1;

	private ActivityMapExploreInfo activityMapExploreInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityMapExploreNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ActivityReflection.Descriptor.MessageTypes[40];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityMapExploreInfo ActivityMapExploreInfo
	{
		get
		{
			return activityMapExploreInfo_;
		}
		set
		{
			activityMapExploreInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityMapExploreNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityMapExploreNtf(ActivityMapExploreNtf other)
		: this()
	{
		activityMapExploreInfo_ = ((other.activityMapExploreInfo_ != null) ? other.activityMapExploreInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityMapExploreNtf Clone()
	{
		return new ActivityMapExploreNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityMapExploreNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityMapExploreNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(ActivityMapExploreInfo, other.ActivityMapExploreInfo))
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
		if (activityMapExploreInfo_ != null)
		{
			num ^= ActivityMapExploreInfo.GetHashCode();
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
		if (activityMapExploreInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(ActivityMapExploreInfo);
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
		if (activityMapExploreInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ActivityMapExploreInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityMapExploreNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.activityMapExploreInfo_ != null)
		{
			if (activityMapExploreInfo_ == null)
			{
				ActivityMapExploreInfo = new ActivityMapExploreInfo();
			}
			ActivityMapExploreInfo.MergeFrom(other.ActivityMapExploreInfo);
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
			if (activityMapExploreInfo_ == null)
			{
				ActivityMapExploreInfo = new ActivityMapExploreInfo();
			}
			input.ReadMessage(ActivityMapExploreInfo);
		}
	}
}
