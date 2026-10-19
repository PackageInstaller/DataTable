using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ActivityTotalRechargeInfo : IMessage<ActivityTotalRechargeInfo>, IMessage, IEquatable<ActivityTotalRechargeInfo>, IDeepCloneable<ActivityTotalRechargeInfo>, IBufferMessage
{
	private static readonly MessageParser<ActivityTotalRechargeInfo> _parser = new MessageParser<ActivityTotalRechargeInfo>(() => new ActivityTotalRechargeInfo());

	private UnknownFieldSet _unknownFields;

	public const int ActivityIdFieldNumber = 1;

	private int activityId_;

	public const int ActivityBaseInfoFieldNumber = 2;

	private ActivityBaseInfo activityBaseInfo_;

	public const int TotalRechargeFieldNumber = 3;

	private long totalRecharge_;

	public const int GainedActivityGroupFieldNumber = 4;

	private static readonly FieldCodec<ActivityGroup> _repeated_gainedActivityGroup_codec = FieldCodec.ForMessage(34u, ActivityGroup.Parser);

	private readonly RepeatedField<ActivityGroup> gainedActivityGroup_ = new RepeatedField<ActivityGroup>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityTotalRechargeInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[266];

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
	public long TotalRecharge
	{
		get
		{
			return totalRecharge_;
		}
		set
		{
			totalRecharge_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<ActivityGroup> GainedActivityGroup => gainedActivityGroup_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityTotalRechargeInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityTotalRechargeInfo(ActivityTotalRechargeInfo other)
		: this()
	{
		activityId_ = other.activityId_;
		activityBaseInfo_ = ((other.activityBaseInfo_ != null) ? other.activityBaseInfo_.Clone() : null);
		totalRecharge_ = other.totalRecharge_;
		gainedActivityGroup_ = other.gainedActivityGroup_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityTotalRechargeInfo Clone()
	{
		return new ActivityTotalRechargeInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityTotalRechargeInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityTotalRechargeInfo other)
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
		if (!object.Equals(ActivityBaseInfo, other.ActivityBaseInfo))
		{
			return false;
		}
		if (TotalRecharge != other.TotalRecharge)
		{
			return false;
		}
		if (!gainedActivityGroup_.Equals(other.gainedActivityGroup_))
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
		if (activityBaseInfo_ != null)
		{
			num ^= ActivityBaseInfo.GetHashCode();
		}
		if (TotalRecharge != 0L)
		{
			num ^= TotalRecharge.GetHashCode();
		}
		num ^= gainedActivityGroup_.GetHashCode();
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
		if (activityBaseInfo_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(ActivityBaseInfo);
		}
		if (TotalRecharge != 0L)
		{
			output.WriteRawTag(24);
			output.WriteInt64(TotalRecharge);
		}
		gainedActivityGroup_.WriteTo(ref output, _repeated_gainedActivityGroup_codec);
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
		if (activityBaseInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ActivityBaseInfo);
		}
		if (TotalRecharge != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(TotalRecharge);
		}
		num += gainedActivityGroup_.CalculateSize(_repeated_gainedActivityGroup_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityTotalRechargeInfo other)
	{
		if (other == null)
		{
			return;
		}
		if (other.ActivityId != 0)
		{
			ActivityId = other.ActivityId;
		}
		if (other.activityBaseInfo_ != null)
		{
			if (activityBaseInfo_ == null)
			{
				ActivityBaseInfo = new ActivityBaseInfo();
			}
			ActivityBaseInfo.MergeFrom(other.ActivityBaseInfo);
		}
		if (other.TotalRecharge != 0L)
		{
			TotalRecharge = other.TotalRecharge;
		}
		gainedActivityGroup_.Add(other.gainedActivityGroup_);
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
				if (activityBaseInfo_ == null)
				{
					ActivityBaseInfo = new ActivityBaseInfo();
				}
				input.ReadMessage(ActivityBaseInfo);
				break;
			case 24u:
				TotalRecharge = input.ReadInt64();
				break;
			case 34u:
				gainedActivityGroup_.AddEntriesFrom(ref input, _repeated_gainedActivityGroup_codec);
				break;
			}
		}
	}
}
