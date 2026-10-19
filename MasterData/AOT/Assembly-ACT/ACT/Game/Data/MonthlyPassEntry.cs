using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class MonthlyPassEntry : IMessage<MonthlyPassEntry>, IMessage, IEquatable<MonthlyPassEntry>, IDeepCloneable<MonthlyPassEntry>, IBufferMessage
{
	private static readonly MessageParser<MonthlyPassEntry> _parser = new MessageParser<MonthlyPassEntry>(() => new MonthlyPassEntry());

	private UnknownFieldSet _unknownFields;

	public const int PassIdFieldNumber = 1;

	private int passId_;

	public const int ExpireTimeUnixFieldNumber = 2;

	private long expireTimeUnix_;

	public const int LastDailyRewardUnixFieldNumber = 3;

	private long lastDailyRewardUnix_;

	public const int LastPopTimeUnixFieldNumber = 4;

	private long lastPopTimeUnix_;

	public const int CheckedDaysFieldNumber = 5;

	private int checkedDays_;

	public const int TotalCycleDaysFieldNumber = 6;

	private int totalCycleDays_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MonthlyPassEntry> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[23];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PassId
	{
		get
		{
			return passId_;
		}
		set
		{
			passId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long ExpireTimeUnix
	{
		get
		{
			return expireTimeUnix_;
		}
		set
		{
			expireTimeUnix_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long LastDailyRewardUnix
	{
		get
		{
			return lastDailyRewardUnix_;
		}
		set
		{
			lastDailyRewardUnix_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long LastPopTimeUnix
	{
		get
		{
			return lastPopTimeUnix_;
		}
		set
		{
			lastPopTimeUnix_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CheckedDays
	{
		get
		{
			return checkedDays_;
		}
		set
		{
			checkedDays_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TotalCycleDays
	{
		get
		{
			return totalCycleDays_;
		}
		set
		{
			totalCycleDays_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MonthlyPassEntry()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MonthlyPassEntry(MonthlyPassEntry other)
		: this()
	{
		passId_ = other.passId_;
		expireTimeUnix_ = other.expireTimeUnix_;
		lastDailyRewardUnix_ = other.lastDailyRewardUnix_;
		lastPopTimeUnix_ = other.lastPopTimeUnix_;
		checkedDays_ = other.checkedDays_;
		totalCycleDays_ = other.totalCycleDays_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MonthlyPassEntry Clone()
	{
		return new MonthlyPassEntry(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MonthlyPassEntry);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MonthlyPassEntry other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (PassId != other.PassId)
		{
			return false;
		}
		if (ExpireTimeUnix != other.ExpireTimeUnix)
		{
			return false;
		}
		if (LastDailyRewardUnix != other.LastDailyRewardUnix)
		{
			return false;
		}
		if (LastPopTimeUnix != other.LastPopTimeUnix)
		{
			return false;
		}
		if (CheckedDays != other.CheckedDays)
		{
			return false;
		}
		if (TotalCycleDays != other.TotalCycleDays)
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
		if (PassId != 0)
		{
			num ^= PassId.GetHashCode();
		}
		if (ExpireTimeUnix != 0L)
		{
			num ^= ExpireTimeUnix.GetHashCode();
		}
		if (LastDailyRewardUnix != 0L)
		{
			num ^= LastDailyRewardUnix.GetHashCode();
		}
		if (LastPopTimeUnix != 0L)
		{
			num ^= LastPopTimeUnix.GetHashCode();
		}
		if (CheckedDays != 0)
		{
			num ^= CheckedDays.GetHashCode();
		}
		if (TotalCycleDays != 0)
		{
			num ^= TotalCycleDays.GetHashCode();
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
		if (PassId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(PassId);
		}
		if (ExpireTimeUnix != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(ExpireTimeUnix);
		}
		if (LastDailyRewardUnix != 0L)
		{
			output.WriteRawTag(24);
			output.WriteInt64(LastDailyRewardUnix);
		}
		if (LastPopTimeUnix != 0L)
		{
			output.WriteRawTag(32);
			output.WriteInt64(LastPopTimeUnix);
		}
		if (CheckedDays != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(CheckedDays);
		}
		if (TotalCycleDays != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(TotalCycleDays);
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
		if (PassId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PassId);
		}
		if (ExpireTimeUnix != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(ExpireTimeUnix);
		}
		if (LastDailyRewardUnix != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(LastDailyRewardUnix);
		}
		if (LastPopTimeUnix != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(LastPopTimeUnix);
		}
		if (CheckedDays != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CheckedDays);
		}
		if (TotalCycleDays != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TotalCycleDays);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MonthlyPassEntry other)
	{
		if (other != null)
		{
			if (other.PassId != 0)
			{
				PassId = other.PassId;
			}
			if (other.ExpireTimeUnix != 0L)
			{
				ExpireTimeUnix = other.ExpireTimeUnix;
			}
			if (other.LastDailyRewardUnix != 0L)
			{
				LastDailyRewardUnix = other.LastDailyRewardUnix;
			}
			if (other.LastPopTimeUnix != 0L)
			{
				LastPopTimeUnix = other.LastPopTimeUnix;
			}
			if (other.CheckedDays != 0)
			{
				CheckedDays = other.CheckedDays;
			}
			if (other.TotalCycleDays != 0)
			{
				TotalCycleDays = other.TotalCycleDays;
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
				PassId = input.ReadInt32();
				break;
			case 16u:
				ExpireTimeUnix = input.ReadInt64();
				break;
			case 24u:
				LastDailyRewardUnix = input.ReadInt64();
				break;
			case 32u:
				LastPopTimeUnix = input.ReadInt64();
				break;
			case 40u:
				CheckedDays = input.ReadInt32();
				break;
			case 48u:
				TotalCycleDays = input.ReadInt32();
				break;
			}
		}
	}
}
