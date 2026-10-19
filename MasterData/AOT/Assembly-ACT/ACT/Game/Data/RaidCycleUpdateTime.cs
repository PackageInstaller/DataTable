using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class RaidCycleUpdateTime : IMessage<RaidCycleUpdateTime>, IMessage, IEquatable<RaidCycleUpdateTime>, IDeepCloneable<RaidCycleUpdateTime>, IBufferMessage
{
	private static readonly MessageParser<RaidCycleUpdateTime> _parser = new MessageParser<RaidCycleUpdateTime>(() => new RaidCycleUpdateTime());

	private UnknownFieldSet _unknownFields;

	public const int LastDailyUpdateTSFieldNumber = 1;

	private int lastDailyUpdateTS_;

	public const int LastWeeklyUpdateTSFieldNumber = 2;

	private int lastWeeklyUpdateTS_;

	public const int LastMonthlyUpdateTSFieldNumber = 3;

	private int lastMonthlyUpdateTS_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RaidCycleUpdateTime> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[210];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LastDailyUpdateTS
	{
		get
		{
			return lastDailyUpdateTS_;
		}
		set
		{
			lastDailyUpdateTS_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LastWeeklyUpdateTS
	{
		get
		{
			return lastWeeklyUpdateTS_;
		}
		set
		{
			lastWeeklyUpdateTS_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LastMonthlyUpdateTS
	{
		get
		{
			return lastMonthlyUpdateTS_;
		}
		set
		{
			lastMonthlyUpdateTS_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RaidCycleUpdateTime()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RaidCycleUpdateTime(RaidCycleUpdateTime other)
		: this()
	{
		lastDailyUpdateTS_ = other.lastDailyUpdateTS_;
		lastWeeklyUpdateTS_ = other.lastWeeklyUpdateTS_;
		lastMonthlyUpdateTS_ = other.lastMonthlyUpdateTS_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RaidCycleUpdateTime Clone()
	{
		return new RaidCycleUpdateTime(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RaidCycleUpdateTime);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RaidCycleUpdateTime other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (LastDailyUpdateTS != other.LastDailyUpdateTS)
		{
			return false;
		}
		if (LastWeeklyUpdateTS != other.LastWeeklyUpdateTS)
		{
			return false;
		}
		if (LastMonthlyUpdateTS != other.LastMonthlyUpdateTS)
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
		if (LastDailyUpdateTS != 0)
		{
			num ^= LastDailyUpdateTS.GetHashCode();
		}
		if (LastWeeklyUpdateTS != 0)
		{
			num ^= LastWeeklyUpdateTS.GetHashCode();
		}
		if (LastMonthlyUpdateTS != 0)
		{
			num ^= LastMonthlyUpdateTS.GetHashCode();
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
		if (LastDailyUpdateTS != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(LastDailyUpdateTS);
		}
		if (LastWeeklyUpdateTS != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(LastWeeklyUpdateTS);
		}
		if (LastMonthlyUpdateTS != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(LastMonthlyUpdateTS);
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
		if (LastDailyUpdateTS != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LastDailyUpdateTS);
		}
		if (LastWeeklyUpdateTS != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LastWeeklyUpdateTS);
		}
		if (LastMonthlyUpdateTS != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LastMonthlyUpdateTS);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RaidCycleUpdateTime other)
	{
		if (other != null)
		{
			if (other.LastDailyUpdateTS != 0)
			{
				LastDailyUpdateTS = other.LastDailyUpdateTS;
			}
			if (other.LastWeeklyUpdateTS != 0)
			{
				LastWeeklyUpdateTS = other.LastWeeklyUpdateTS;
			}
			if (other.LastMonthlyUpdateTS != 0)
			{
				LastMonthlyUpdateTS = other.LastMonthlyUpdateTS;
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
				LastDailyUpdateTS = input.ReadInt32();
				break;
			case 16u:
				LastWeeklyUpdateTS = input.ReadInt32();
				break;
			case 24u:
				LastMonthlyUpdateTS = input.ReadInt32();
				break;
			}
		}
	}
}
