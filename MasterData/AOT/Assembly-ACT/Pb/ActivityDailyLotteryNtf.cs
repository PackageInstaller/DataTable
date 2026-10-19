using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ActivityDailyLotteryNtf : IMessage<ActivityDailyLotteryNtf>, IMessage, IEquatable<ActivityDailyLotteryNtf>, IDeepCloneable<ActivityDailyLotteryNtf>, IBufferMessage
{
	private static readonly MessageParser<ActivityDailyLotteryNtf> _parser = new MessageParser<ActivityDailyLotteryNtf>(() => new ActivityDailyLotteryNtf());

	private UnknownFieldSet _unknownFields;

	public const int ActivityDailyLotteryInfoFieldNumber = 1;

	private ActivityDailyLotteryInfo activityDailyLotteryInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityDailyLotteryNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ActivityReflection.Descriptor.MessageTypes[26];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityDailyLotteryInfo ActivityDailyLotteryInfo
	{
		get
		{
			return activityDailyLotteryInfo_;
		}
		set
		{
			activityDailyLotteryInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityDailyLotteryNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityDailyLotteryNtf(ActivityDailyLotteryNtf other)
		: this()
	{
		activityDailyLotteryInfo_ = ((other.activityDailyLotteryInfo_ != null) ? other.activityDailyLotteryInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityDailyLotteryNtf Clone()
	{
		return new ActivityDailyLotteryNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityDailyLotteryNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityDailyLotteryNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(ActivityDailyLotteryInfo, other.ActivityDailyLotteryInfo))
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
		if (activityDailyLotteryInfo_ != null)
		{
			num ^= ActivityDailyLotteryInfo.GetHashCode();
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
		if (activityDailyLotteryInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(ActivityDailyLotteryInfo);
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
		if (activityDailyLotteryInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ActivityDailyLotteryInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityDailyLotteryNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.activityDailyLotteryInfo_ != null)
		{
			if (activityDailyLotteryInfo_ == null)
			{
				ActivityDailyLotteryInfo = new ActivityDailyLotteryInfo();
			}
			ActivityDailyLotteryInfo.MergeFrom(other.ActivityDailyLotteryInfo);
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
			if (activityDailyLotteryInfo_ == null)
			{
				ActivityDailyLotteryInfo = new ActivityDailyLotteryInfo();
			}
			input.ReadMessage(ActivityDailyLotteryInfo);
		}
	}
}
