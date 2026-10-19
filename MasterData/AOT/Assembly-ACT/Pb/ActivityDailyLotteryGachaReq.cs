using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ActivityDailyLotteryGachaReq : IMessage<ActivityDailyLotteryGachaReq>, IMessage, IEquatable<ActivityDailyLotteryGachaReq>, IDeepCloneable<ActivityDailyLotteryGachaReq>, IBufferMessage
{
	private static readonly MessageParser<ActivityDailyLotteryGachaReq> _parser = new MessageParser<ActivityDailyLotteryGachaReq>(() => new ActivityDailyLotteryGachaReq());

	private UnknownFieldSet _unknownFields;

	public const int ActivityIdFieldNumber = 1;

	private int activityId_;

	public const int LotteryPoolIdFieldNumber = 2;

	private int lotteryPoolId_;

	public const int GachaConutFieldNumber = 3;

	private int gachaConut_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityDailyLotteryGachaReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ActivityReflection.Descriptor.MessageTypes[27];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ActivityId
	{
		get
		{
			return activityId_;
		}
		set
		{
			activityId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LotteryPoolId
	{
		get
		{
			return lotteryPoolId_;
		}
		set
		{
			lotteryPoolId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int GachaConut
	{
		get
		{
			return gachaConut_;
		}
		set
		{
			gachaConut_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityDailyLotteryGachaReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityDailyLotteryGachaReq(ActivityDailyLotteryGachaReq other)
		: this()
	{
		activityId_ = other.activityId_;
		lotteryPoolId_ = other.lotteryPoolId_;
		gachaConut_ = other.gachaConut_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityDailyLotteryGachaReq Clone()
	{
		return new ActivityDailyLotteryGachaReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityDailyLotteryGachaReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityDailyLotteryGachaReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ActivityId != other.ActivityId)
		{
			return false;
		}
		if (LotteryPoolId != other.LotteryPoolId)
		{
			return false;
		}
		if (GachaConut != other.GachaConut)
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
		if (ActivityId != 0)
		{
			num ^= ActivityId.GetHashCode();
		}
		if (LotteryPoolId != 0)
		{
			num ^= LotteryPoolId.GetHashCode();
		}
		if (GachaConut != 0)
		{
			num ^= GachaConut.GetHashCode();
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
		if (ActivityId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ActivityId);
		}
		if (LotteryPoolId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(LotteryPoolId);
		}
		if (GachaConut != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(GachaConut);
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
		if (ActivityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityId);
		}
		if (LotteryPoolId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LotteryPoolId);
		}
		if (GachaConut != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GachaConut);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityDailyLotteryGachaReq other)
	{
		if (other != null)
		{
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			if (other.LotteryPoolId != 0)
			{
				LotteryPoolId = other.LotteryPoolId;
			}
			if (other.GachaConut != 0)
			{
				GachaConut = other.GachaConut;
			}
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
				ActivityId = input.ReadInt32();
				break;
			case 16u:
				LotteryPoolId = input.ReadInt32();
				break;
			case 24u:
				GachaConut = input.ReadInt32();
				break;
			}
		}
	}
}
