using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class LoungeCharacterGreetInfo : IMessage<LoungeCharacterGreetInfo>, IMessage, IEquatable<LoungeCharacterGreetInfo>, IDeepCloneable<LoungeCharacterGreetInfo>, IBufferMessage
{
	private static readonly MessageParser<LoungeCharacterGreetInfo> _parser = new MessageParser<LoungeCharacterGreetInfo>(() => new LoungeCharacterGreetInfo());

	private UnknownFieldSet _unknownFields;

	public const int TodayConditionGreetCountFieldNumber = 1;

	private int todayConditionGreetCount_;

	public const int TodayNotConditionGreetCountFieldNumber = 2;

	private int todayNotConditionGreetCount_;

	public const int LastNotTriggerGreetIDFieldNumber = 3;

	private int lastNotTriggerGreetID_;

	public const int TriggeredGreetFieldNumber = 4;

	private static readonly MapField<int, bool>.Codec _map_triggeredGreet_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 34u);

	private readonly MapField<int, bool> triggeredGreet_ = new MapField<int, bool>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<LoungeCharacterGreetInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[286];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TodayConditionGreetCount
	{
		get
		{
			return todayConditionGreetCount_;
		}
		set
		{
			todayConditionGreetCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TodayNotConditionGreetCount
	{
		get
		{
			return todayNotConditionGreetCount_;
		}
		set
		{
			todayNotConditionGreetCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LastNotTriggerGreetID
	{
		get
		{
			return lastNotTriggerGreetID_;
		}
		set
		{
			lastNotTriggerGreetID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> TriggeredGreet => triggeredGreet_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeCharacterGreetInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeCharacterGreetInfo(LoungeCharacterGreetInfo other)
		: this()
	{
		todayConditionGreetCount_ = other.todayConditionGreetCount_;
		todayNotConditionGreetCount_ = other.todayNotConditionGreetCount_;
		lastNotTriggerGreetID_ = other.lastNotTriggerGreetID_;
		triggeredGreet_ = other.triggeredGreet_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeCharacterGreetInfo Clone()
	{
		return new LoungeCharacterGreetInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as LoungeCharacterGreetInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(LoungeCharacterGreetInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (TodayConditionGreetCount != other.TodayConditionGreetCount)
		{
			return false;
		}
		if (TodayNotConditionGreetCount != other.TodayNotConditionGreetCount)
		{
			return false;
		}
		if (LastNotTriggerGreetID != other.LastNotTriggerGreetID)
		{
			return false;
		}
		if (!TriggeredGreet.Equals(other.TriggeredGreet))
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
		if (TodayConditionGreetCount != 0)
		{
			num ^= TodayConditionGreetCount.GetHashCode();
		}
		if (TodayNotConditionGreetCount != 0)
		{
			num ^= TodayNotConditionGreetCount.GetHashCode();
		}
		if (LastNotTriggerGreetID != 0)
		{
			num ^= LastNotTriggerGreetID.GetHashCode();
		}
		num ^= TriggeredGreet.GetHashCode();
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
		if (TodayConditionGreetCount != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(TodayConditionGreetCount);
		}
		if (TodayNotConditionGreetCount != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(TodayNotConditionGreetCount);
		}
		if (LastNotTriggerGreetID != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(LastNotTriggerGreetID);
		}
		triggeredGreet_.WriteTo(ref output, _map_triggeredGreet_codec);
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
		if (TodayConditionGreetCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TodayConditionGreetCount);
		}
		if (TodayNotConditionGreetCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TodayNotConditionGreetCount);
		}
		if (LastNotTriggerGreetID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LastNotTriggerGreetID);
		}
		num += triggeredGreet_.CalculateSize(_map_triggeredGreet_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(LoungeCharacterGreetInfo other)
	{
		if (other != null)
		{
			if (other.TodayConditionGreetCount != 0)
			{
				TodayConditionGreetCount = other.TodayConditionGreetCount;
			}
			if (other.TodayNotConditionGreetCount != 0)
			{
				TodayNotConditionGreetCount = other.TodayNotConditionGreetCount;
			}
			if (other.LastNotTriggerGreetID != 0)
			{
				LastNotTriggerGreetID = other.LastNotTriggerGreetID;
			}
			triggeredGreet_.Add(other.triggeredGreet_);
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
				TodayConditionGreetCount = input.ReadInt32();
				break;
			case 16u:
				TodayNotConditionGreetCount = input.ReadInt32();
				break;
			case 24u:
				LastNotTriggerGreetID = input.ReadInt32();
				break;
			case 34u:
				triggeredGreet_.AddEntriesFrom(ref input, _map_triggeredGreet_codec);
				break;
			}
		}
	}
}
