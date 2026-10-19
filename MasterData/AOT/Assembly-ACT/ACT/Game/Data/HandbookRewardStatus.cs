using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class HandbookRewardStatus : IMessage<HandbookRewardStatus>, IMessage, IEquatable<HandbookRewardStatus>, IDeepCloneable<HandbookRewardStatus>, IBufferMessage
{
	private static readonly MessageParser<HandbookRewardStatus> _parser = new MessageParser<HandbookRewardStatus>(() => new HandbookRewardStatus());

	private UnknownFieldSet _unknownFields;

	public const int DailyPointRewardFieldNumber = 1;

	private static readonly MapField<int, bool>.Codec _map_dailyPointReward_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 10u);

	private readonly MapField<int, bool> dailyPointReward_ = new MapField<int, bool>();

	public const int DailyConditionTaskRewardFieldNumber = 2;

	private static readonly MapField<int, bool>.Codec _map_dailyConditionTaskReward_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 18u);

	private readonly MapField<int, bool> dailyConditionTaskReward_ = new MapField<int, bool>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<HandbookRewardStatus> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[147];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> DailyPointReward => dailyPointReward_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> DailyConditionTaskReward => dailyConditionTaskReward_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookRewardStatus()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookRewardStatus(HandbookRewardStatus other)
		: this()
	{
		dailyPointReward_ = other.dailyPointReward_.Clone();
		dailyConditionTaskReward_ = other.dailyConditionTaskReward_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookRewardStatus Clone()
	{
		return new HandbookRewardStatus(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as HandbookRewardStatus);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(HandbookRewardStatus other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!DailyPointReward.Equals(other.DailyPointReward))
		{
			return false;
		}
		if (!DailyConditionTaskReward.Equals(other.DailyConditionTaskReward))
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
		num ^= DailyPointReward.GetHashCode();
		num ^= DailyConditionTaskReward.GetHashCode();
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
		dailyPointReward_.WriteTo(ref output, _map_dailyPointReward_codec);
		dailyConditionTaskReward_.WriteTo(ref output, _map_dailyConditionTaskReward_codec);
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
		num += dailyPointReward_.CalculateSize(_map_dailyPointReward_codec);
		num += dailyConditionTaskReward_.CalculateSize(_map_dailyConditionTaskReward_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(HandbookRewardStatus other)
	{
		if (other != null)
		{
			dailyPointReward_.Add(other.dailyPointReward_);
			dailyConditionTaskReward_.Add(other.dailyConditionTaskReward_);
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
			case 10u:
				dailyPointReward_.AddEntriesFrom(ref input, _map_dailyPointReward_codec);
				break;
			case 18u:
				dailyConditionTaskReward_.AddEntriesFrom(ref input, _map_dailyConditionTaskReward_codec);
				break;
			}
		}
	}
}
