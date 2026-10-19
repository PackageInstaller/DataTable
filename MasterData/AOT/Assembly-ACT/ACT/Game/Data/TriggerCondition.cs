using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class TriggerCondition : IMessage<TriggerCondition>, IMessage, IEquatable<TriggerCondition>, IDeepCloneable<TriggerCondition>, IBufferMessage
{
	private static readonly MessageParser<TriggerCondition> _parser = new MessageParser<TriggerCondition>(() => new TriggerCondition());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TypeFieldNumber = 2;

	private int type_;

	public const int DoneFieldNumber = 3;

	private bool done_;

	public const int ProgressFieldNumber = 4;

	private int progress_;

	public const int StartTsFieldNumber = 5;

	private int startTs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TriggerCondition> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[182];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Done
	{
		get
		{
			return done_;
		}
		set
		{
			done_ = value;
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
	public int StartTs
	{
		get
		{
			return startTs_;
		}
		set
		{
			startTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TriggerCondition()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TriggerCondition(TriggerCondition other)
		: this()
	{
		id_ = other.id_;
		type_ = other.type_;
		done_ = other.done_;
		progress_ = other.progress_;
		startTs_ = other.startTs_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TriggerCondition Clone()
	{
		return new TriggerCondition(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TriggerCondition);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TriggerCondition other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (Done != other.Done)
		{
			return false;
		}
		if (Progress != other.Progress)
		{
			return false;
		}
		if (StartTs != other.StartTs)
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
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Done)
		{
			num ^= Done.GetHashCode();
		}
		if (Progress != 0)
		{
			num ^= Progress.GetHashCode();
		}
		if (StartTs != 0)
		{
			num ^= StartTs.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (Type != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Type);
		}
		if (Done)
		{
			output.WriteRawTag(24);
			output.WriteBool(Done);
		}
		if (Progress != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Progress);
		}
		if (StartTs != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(StartTs);
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
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Done)
		{
			num += 2;
		}
		if (Progress != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Progress);
		}
		if (StartTs != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StartTs);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TriggerCondition other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Done)
			{
				Done = other.Done;
			}
			if (other.Progress != 0)
			{
				Progress = other.Progress;
			}
			if (other.StartTs != 0)
			{
				StartTs = other.StartTs;
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
				Id = input.ReadInt32();
				break;
			case 16u:
				Type = input.ReadInt32();
				break;
			case 24u:
				Done = input.ReadBool();
				break;
			case 32u:
				Progress = input.ReadInt32();
				break;
			case 40u:
				StartTs = input.ReadInt32();
				break;
			}
		}
	}
}
