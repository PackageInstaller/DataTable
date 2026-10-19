using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MissionConditionStateNtf : IMessage<MissionConditionStateNtf>, IMessage, IEquatable<MissionConditionStateNtf>, IDeepCloneable<MissionConditionStateNtf>, IBufferMessage
{
	private static readonly MessageParser<MissionConditionStateNtf> _parser = new MessageParser<MissionConditionStateNtf>(() => new MissionConditionStateNtf());

	private UnknownFieldSet _unknownFields;

	public const int MissionIDFieldNumber = 1;

	private long missionID_;

	public const int ConditionIDFieldNumber = 2;

	private int conditionID_;

	public const int ProgressFieldNumber = 3;

	private int progress_;

	public const int SuccessFieldNumber = 4;

	private bool success_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MissionConditionStateNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MissionReflection.Descriptor.MessageTypes[16];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long MissionID
	{
		get
		{
			return missionID_;
		}
		set
		{
			missionID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ConditionID
	{
		get
		{
			return conditionID_;
		}
		set
		{
			conditionID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Progress
	{
		get
		{
			return progress_;
		}
		set
		{
			progress_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Success
	{
		get
		{
			return success_;
		}
		set
		{
			success_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionConditionStateNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionConditionStateNtf(MissionConditionStateNtf other)
		: this()
	{
		missionID_ = other.missionID_;
		conditionID_ = other.conditionID_;
		progress_ = other.progress_;
		success_ = other.success_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionConditionStateNtf Clone()
	{
		return new MissionConditionStateNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MissionConditionStateNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MissionConditionStateNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (MissionID != other.MissionID)
		{
			return false;
		}
		if (ConditionID != other.ConditionID)
		{
			return false;
		}
		if (Progress != other.Progress)
		{
			return false;
		}
		if (Success != other.Success)
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
		if (MissionID != 0L)
		{
			num ^= MissionID.GetHashCode();
		}
		if (ConditionID != 0)
		{
			num ^= ConditionID.GetHashCode();
		}
		if (Progress != 0)
		{
			num ^= Progress.GetHashCode();
		}
		if (Success)
		{
			num ^= Success.GetHashCode();
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
		if (MissionID != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(MissionID);
		}
		if (ConditionID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ConditionID);
		}
		if (Progress != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Progress);
		}
		if (Success)
		{
			output.WriteRawTag(32);
			output.WriteBool(Success);
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
		if (MissionID != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(MissionID);
		}
		if (ConditionID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ConditionID);
		}
		if (Progress != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Progress);
		}
		if (Success)
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
	public void MergeFrom(MissionConditionStateNtf other)
	{
		if (other != null)
		{
			if (other.MissionID != 0L)
			{
				MissionID = other.MissionID;
			}
			if (other.ConditionID != 0)
			{
				ConditionID = other.ConditionID;
			}
			if (other.Progress != 0)
			{
				Progress = other.Progress;
			}
			if (other.Success)
			{
				Success = other.Success;
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
				MissionID = input.ReadInt64();
				break;
			case 16u:
				ConditionID = input.ReadInt32();
				break;
			case 24u:
				Progress = input.ReadInt32();
				break;
			case 32u:
				Success = input.ReadBool();
				break;
			}
		}
	}
}
