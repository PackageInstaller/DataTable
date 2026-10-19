using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ActivityTotalRechargeNtf : IMessage<ActivityTotalRechargeNtf>, IMessage, IEquatable<ActivityTotalRechargeNtf>, IDeepCloneable<ActivityTotalRechargeNtf>, IBufferMessage
{
	private static readonly MessageParser<ActivityTotalRechargeNtf> _parser = new MessageParser<ActivityTotalRechargeNtf>(() => new ActivityTotalRechargeNtf());

	private UnknownFieldSet _unknownFields;

	public const int ActivityTotalRechargeInfoFieldNumber = 1;

	private ActivityTotalRechargeInfo activityTotalRechargeInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityTotalRechargeNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ActivityReflection.Descriptor.MessageTypes[29];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityTotalRechargeInfo ActivityTotalRechargeInfo
	{
		get
		{
			return activityTotalRechargeInfo_;
		}
		set
		{
			activityTotalRechargeInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityTotalRechargeNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityTotalRechargeNtf(ActivityTotalRechargeNtf other)
		: this()
	{
		activityTotalRechargeInfo_ = ((other.activityTotalRechargeInfo_ != null) ? other.activityTotalRechargeInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityTotalRechargeNtf Clone()
	{
		return new ActivityTotalRechargeNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityTotalRechargeNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityTotalRechargeNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(ActivityTotalRechargeInfo, other.ActivityTotalRechargeInfo))
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
		if (activityTotalRechargeInfo_ != null)
		{
			num ^= ActivityTotalRechargeInfo.GetHashCode();
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
		if (activityTotalRechargeInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(ActivityTotalRechargeInfo);
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
		if (activityTotalRechargeInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ActivityTotalRechargeInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityTotalRechargeNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.activityTotalRechargeInfo_ != null)
		{
			if (activityTotalRechargeInfo_ == null)
			{
				ActivityTotalRechargeInfo = new ActivityTotalRechargeInfo();
			}
			ActivityTotalRechargeInfo.MergeFrom(other.ActivityTotalRechargeInfo);
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
			if (activityTotalRechargeInfo_ == null)
			{
				ActivityTotalRechargeInfo = new ActivityTotalRechargeInfo();
			}
			input.ReadMessage(ActivityTotalRechargeInfo);
		}
	}
}
