using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ActivityDailyLotteryInfo : IMessage<ActivityDailyLotteryInfo>, IMessage, IEquatable<ActivityDailyLotteryInfo>, IDeepCloneable<ActivityDailyLotteryInfo>, IBufferMessage
{
	private static readonly MessageParser<ActivityDailyLotteryInfo> _parser = new MessageParser<ActivityDailyLotteryInfo>(() => new ActivityDailyLotteryInfo());

	private UnknownFieldSet _unknownFields;

	public const int ActivityIdFieldNumber = 1;

	private int activityId_;

	public const int LotteryInfosFieldNumber = 2;

	private static readonly MapField<int, ActivityLotteryInfo>.Codec _map_lotteryInfos_codec = new MapField<int, ActivityLotteryInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ActivityLotteryInfo.Parser), 18u);

	private readonly MapField<int, ActivityLotteryInfo> lotteryInfos_ = new MapField<int, ActivityLotteryInfo>();

	public const int TaskFinishInfoFieldNumber = 3;

	private static readonly MapField<int, int>.Codec _map_taskFinishInfo_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 26u);

	private readonly MapField<int, int> taskFinishInfo_ = new MapField<int, int>();

	public const int ActivityBaseInfoFieldNumber = 4;

	private ActivityBaseInfo activityBaseInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityDailyLotteryInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[265];

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
	public MapField<int, ActivityLotteryInfo> LotteryInfos => lotteryInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> TaskFinishInfo => taskFinishInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityBaseInfo ActivityBaseInfo
	{
		get
		{
			return activityBaseInfo_;
		}
		set
		{
			activityBaseInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityDailyLotteryInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityDailyLotteryInfo(ActivityDailyLotteryInfo other)
		: this()
	{
		activityId_ = other.activityId_;
		lotteryInfos_ = other.lotteryInfos_.Clone();
		taskFinishInfo_ = other.taskFinishInfo_.Clone();
		activityBaseInfo_ = ((other.activityBaseInfo_ != null) ? other.activityBaseInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityDailyLotteryInfo Clone()
	{
		return new ActivityDailyLotteryInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityDailyLotteryInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityDailyLotteryInfo other)
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
		if (!LotteryInfos.Equals(other.LotteryInfos))
		{
			return false;
		}
		if (!TaskFinishInfo.Equals(other.TaskFinishInfo))
		{
			return false;
		}
		if (!object.Equals(ActivityBaseInfo, other.ActivityBaseInfo))
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
		num ^= LotteryInfos.GetHashCode();
		num ^= TaskFinishInfo.GetHashCode();
		if (activityBaseInfo_ != null)
		{
			num ^= ActivityBaseInfo.GetHashCode();
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
		lotteryInfos_.WriteTo(ref output, _map_lotteryInfos_codec);
		taskFinishInfo_.WriteTo(ref output, _map_taskFinishInfo_codec);
		if (activityBaseInfo_ != null)
		{
			output.WriteRawTag(34);
			output.WriteMessage(ActivityBaseInfo);
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
		num += lotteryInfos_.CalculateSize(_map_lotteryInfos_codec);
		num += taskFinishInfo_.CalculateSize(_map_taskFinishInfo_codec);
		if (activityBaseInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ActivityBaseInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityDailyLotteryInfo other)
	{
		if (other == null)
		{
			return;
		}
		if (other.ActivityId != 0)
		{
			ActivityId = other.ActivityId;
		}
		lotteryInfos_.Add(other.lotteryInfos_);
		taskFinishInfo_.Add(other.taskFinishInfo_);
		if (other.activityBaseInfo_ != null)
		{
			if (activityBaseInfo_ == null)
			{
				ActivityBaseInfo = new ActivityBaseInfo();
			}
			ActivityBaseInfo.MergeFrom(other.ActivityBaseInfo);
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
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				ActivityId = input.ReadInt32();
				break;
			case 18u:
				lotteryInfos_.AddEntriesFrom(ref input, _map_lotteryInfos_codec);
				break;
			case 26u:
				taskFinishInfo_.AddEntriesFrom(ref input, _map_taskFinishInfo_codec);
				break;
			case 34u:
				if (activityBaseInfo_ == null)
				{
					ActivityBaseInfo = new ActivityBaseInfo();
				}
				input.ReadMessage(ActivityBaseInfo);
				break;
			}
		}
	}
}
