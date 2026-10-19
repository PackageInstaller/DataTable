using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class BattlePassClaimTaskReq : IMessage<BattlePassClaimTaskReq>, IMessage, IEquatable<BattlePassClaimTaskReq>, IDeepCloneable<BattlePassClaimTaskReq>, IBufferMessage
{
	private static readonly MessageParser<BattlePassClaimTaskReq> _parser = new MessageParser<BattlePassClaimTaskReq>(() => new BattlePassClaimTaskReq());

	private UnknownFieldSet _unknownFields;

	public const int TaskIdFieldNumber = 1;

	private int taskId_;

	public const int SubTaskIdFieldNumber = 2;

	private int subTaskId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<BattlePassClaimTaskReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => BattlepassReflection.Descriptor.MessageTypes[3];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TaskId
	{
		get
		{
			return taskId_;
		}
		set
		{
			taskId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int SubTaskId
	{
		get
		{
			return subTaskId_;
		}
		set
		{
			subTaskId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BattlePassClaimTaskReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BattlePassClaimTaskReq(BattlePassClaimTaskReq other)
		: this()
	{
		taskId_ = other.taskId_;
		subTaskId_ = other.subTaskId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BattlePassClaimTaskReq Clone()
	{
		return new BattlePassClaimTaskReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as BattlePassClaimTaskReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(BattlePassClaimTaskReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (TaskId != other.TaskId)
		{
			return false;
		}
		if (SubTaskId != other.SubTaskId)
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
		if (TaskId != 0)
		{
			num ^= TaskId.GetHashCode();
		}
		if (SubTaskId != 0)
		{
			num ^= SubTaskId.GetHashCode();
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
		if (TaskId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(TaskId);
		}
		if (SubTaskId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(SubTaskId);
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
		if (TaskId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TaskId);
		}
		if (SubTaskId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SubTaskId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(BattlePassClaimTaskReq other)
	{
		if (other != null)
		{
			if (other.TaskId != 0)
			{
				TaskId = other.TaskId;
			}
			if (other.SubTaskId != 0)
			{
				SubTaskId = other.SubTaskId;
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
				TaskId = input.ReadInt32();
				break;
			case 16u:
				SubTaskId = input.ReadInt32();
				break;
			}
		}
	}
}
