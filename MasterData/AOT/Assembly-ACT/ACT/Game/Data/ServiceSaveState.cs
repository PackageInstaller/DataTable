using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ServiceSaveState : IMessage<ServiceSaveState>, IMessage, IEquatable<ServiceSaveState>, IDeepCloneable<ServiceSaveState>, IBufferMessage
{
	private static readonly MessageParser<ServiceSaveState> _parser = new MessageParser<ServiceSaveState>(() => new ServiceSaveState());

	private UnknownFieldSet _unknownFields;

	public const int UidFieldNumber = 1;

	private int uid_;

	public const int StateIdFieldNumber = 2;

	private int stateId_;

	public const int BehaveIdFieldNumber = 3;

	private int behaveId_;

	public const int CleanedTsFieldNumber = 4;

	private int cleanedTs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ServiceSaveState> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[96];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Uid
	{
		get
		{
			return uid_;
		}
		set
		{
			uid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int StateId
	{
		get
		{
			return stateId_;
		}
		set
		{
			stateId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int BehaveId
	{
		get
		{
			return behaveId_;
		}
		set
		{
			behaveId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CleanedTs
	{
		get
		{
			return cleanedTs_;
		}
		set
		{
			cleanedTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ServiceSaveState()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ServiceSaveState(ServiceSaveState other)
		: this()
	{
		uid_ = other.uid_;
		stateId_ = other.stateId_;
		behaveId_ = other.behaveId_;
		cleanedTs_ = other.cleanedTs_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ServiceSaveState Clone()
	{
		return new ServiceSaveState(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ServiceSaveState);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ServiceSaveState other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Uid != other.Uid)
		{
			return false;
		}
		if (StateId != other.StateId)
		{
			return false;
		}
		if (BehaveId != other.BehaveId)
		{
			return false;
		}
		if (CleanedTs != other.CleanedTs)
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
		if (Uid != 0)
		{
			num ^= Uid.GetHashCode();
		}
		if (StateId != 0)
		{
			num ^= StateId.GetHashCode();
		}
		if (BehaveId != 0)
		{
			num ^= BehaveId.GetHashCode();
		}
		if (CleanedTs != 0)
		{
			num ^= CleanedTs.GetHashCode();
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
		if (Uid != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Uid);
		}
		if (StateId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(StateId);
		}
		if (BehaveId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(BehaveId);
		}
		if (CleanedTs != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CleanedTs);
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
		if (Uid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Uid);
		}
		if (StateId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StateId);
		}
		if (BehaveId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BehaveId);
		}
		if (CleanedTs != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CleanedTs);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ServiceSaveState other)
	{
		if (other != null)
		{
			if (other.Uid != 0)
			{
				Uid = other.Uid;
			}
			if (other.StateId != 0)
			{
				StateId = other.StateId;
			}
			if (other.BehaveId != 0)
			{
				BehaveId = other.BehaveId;
			}
			if (other.CleanedTs != 0)
			{
				CleanedTs = other.CleanedTs;
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
				Uid = input.ReadInt32();
				break;
			case 16u:
				StateId = input.ReadInt32();
				break;
			case 24u:
				BehaveId = input.ReadInt32();
				break;
			case 32u:
				CleanedTs = input.ReadInt32();
				break;
			}
		}
	}
}
