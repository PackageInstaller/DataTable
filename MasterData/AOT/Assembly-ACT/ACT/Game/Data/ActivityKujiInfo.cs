using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ActivityKujiInfo : IMessage<ActivityKujiInfo>, IMessage, IEquatable<ActivityKujiInfo>, IDeepCloneable<ActivityKujiInfo>, IBufferMessage
{
	private static readonly MessageParser<ActivityKujiInfo> _parser = new MessageParser<ActivityKujiInfo>(() => new ActivityKujiInfo());

	private UnknownFieldSet _unknownFields;

	public const int ActivityIdFieldNumber = 1;

	private int activityId_;

	public const int ActivityBaseInfoFieldNumber = 2;

	private ActivityBaseInfo activityBaseInfo_;

	public const int GainedActivityGroupFieldNumber = 3;

	private static readonly FieldCodec<ActivityGroup> _repeated_gainedActivityGroup_codec = FieldCodec.ForMessage(26u, ActivityGroup.Parser);

	private readonly RepeatedField<ActivityGroup> gainedActivityGroup_ = new RepeatedField<ActivityGroup>();

	public const int PrizeInfoFieldNumber = 4;

	private static readonly MapField<int, int>.Codec _map_prizeInfo_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 34u);

	private readonly MapField<int, int> prizeInfo_ = new MapField<int, int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityKujiInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[267];

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
	public RepeatedField<ActivityGroup> GainedActivityGroup => gainedActivityGroup_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> PrizeInfo => prizeInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityKujiInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityKujiInfo(ActivityKujiInfo other)
		: this()
	{
		activityId_ = other.activityId_;
		activityBaseInfo_ = ((other.activityBaseInfo_ != null) ? other.activityBaseInfo_.Clone() : null);
		gainedActivityGroup_ = other.gainedActivityGroup_.Clone();
		prizeInfo_ = other.prizeInfo_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityKujiInfo Clone()
	{
		return new ActivityKujiInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityKujiInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityKujiInfo other)
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
		if (!gainedActivityGroup_.Equals(other.gainedActivityGroup_))
		{
			return false;
		}
		if (!PrizeInfo.Equals(other.PrizeInfo))
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
		num ^= gainedActivityGroup_.GetHashCode();
		num ^= PrizeInfo.GetHashCode();
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
		gainedActivityGroup_.WriteTo(ref output, _repeated_gainedActivityGroup_codec);
		prizeInfo_.WriteTo(ref output, _map_prizeInfo_codec);
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
		num += gainedActivityGroup_.CalculateSize(_repeated_gainedActivityGroup_codec);
		num += prizeInfo_.CalculateSize(_map_prizeInfo_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityKujiInfo other)
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
		gainedActivityGroup_.Add(other.gainedActivityGroup_);
		prizeInfo_.Add(other.prizeInfo_);
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
			case 26u:
				gainedActivityGroup_.AddEntriesFrom(ref input, _repeated_gainedActivityGroup_codec);
				break;
			case 34u:
				prizeInfo_.AddEntriesFrom(ref input, _map_prizeInfo_codec);
				break;
			}
		}
	}
}
