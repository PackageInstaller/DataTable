using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ActivityBaseInfo : IMessage<ActivityBaseInfo>, IMessage, IEquatable<ActivityBaseInfo>, IDeepCloneable<ActivityBaseInfo>, IBufferMessage
{
	private static readonly MessageParser<ActivityBaseInfo> _parser = new MessageParser<ActivityBaseInfo>(() => new ActivityBaseInfo());

	private UnknownFieldSet _unknownFields;

	public const int StartTimeFieldNumber = 1;

	private long startTime_;

	public const int PeriodStartTimeFieldNumber = 2;

	private long periodStartTime_;

	public const int EndTimeFieldNumber = 3;

	private long endTime_;

	public const int EndHandledFieldNumber = 4;

	private bool endHandled_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityBaseInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[249];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long StartTime
	{
		get
		{
			return startTime_;
		}
		set
		{
			startTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long PeriodStartTime
	{
		get
		{
			return periodStartTime_;
		}
		set
		{
			periodStartTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long EndTime
	{
		get
		{
			return endTime_;
		}
		set
		{
			endTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool EndHandled
	{
		get
		{
			return endHandled_;
		}
		set
		{
			endHandled_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityBaseInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityBaseInfo(ActivityBaseInfo other)
		: this()
	{
		startTime_ = other.startTime_;
		periodStartTime_ = other.periodStartTime_;
		endTime_ = other.endTime_;
		endHandled_ = other.endHandled_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityBaseInfo Clone()
	{
		return new ActivityBaseInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityBaseInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityBaseInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (StartTime != other.StartTime)
		{
			return false;
		}
		if (PeriodStartTime != other.PeriodStartTime)
		{
			return false;
		}
		if (EndTime != other.EndTime)
		{
			return false;
		}
		if (EndHandled != other.EndHandled)
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
		if (StartTime != 0L)
		{
			num ^= StartTime.GetHashCode();
		}
		if (PeriodStartTime != 0L)
		{
			num ^= PeriodStartTime.GetHashCode();
		}
		if (EndTime != 0L)
		{
			num ^= EndTime.GetHashCode();
		}
		if (EndHandled)
		{
			num ^= EndHandled.GetHashCode();
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
		if (StartTime != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(StartTime);
		}
		if (PeriodStartTime != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(PeriodStartTime);
		}
		if (EndTime != 0L)
		{
			output.WriteRawTag(24);
			output.WriteInt64(EndTime);
		}
		if (EndHandled)
		{
			output.WriteRawTag(32);
			output.WriteBool(EndHandled);
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
		if (StartTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(StartTime);
		}
		if (PeriodStartTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(PeriodStartTime);
		}
		if (EndTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(EndTime);
		}
		if (EndHandled)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityBaseInfo other)
	{
		if (other != null)
		{
			if (other.StartTime != 0L)
			{
				StartTime = other.StartTime;
			}
			if (other.PeriodStartTime != 0L)
			{
				PeriodStartTime = other.PeriodStartTime;
			}
			if (other.EndTime != 0L)
			{
				EndTime = other.EndTime;
			}
			if (other.EndHandled)
			{
				EndHandled = other.EndHandled;
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
				StartTime = input.ReadInt64();
				break;
			case 16u:
				PeriodStartTime = input.ReadInt64();
				break;
			case 24u:
				EndTime = input.ReadInt64();
				break;
			case 32u:
				EndHandled = input.ReadBool();
				break;
			}
		}
	}
}
