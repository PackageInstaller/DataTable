using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class TempArchiveUpdateReq : IMessage<TempArchiveUpdateReq>, IMessage, IEquatable<TempArchiveUpdateReq>, IDeepCloneable<TempArchiveUpdateReq>, IBufferMessage
{
	private static readonly MessageParser<TempArchiveUpdateReq> _parser = new MessageParser<TempArchiveUpdateReq>(() => new TempArchiveUpdateReq());

	private UnknownFieldSet _unknownFields;

	public const int OperationFieldNumber = 1;

	private TempArchiveOperation operation_;

	public const int SyncDataFieldNumber = 2;

	private SyncGameInfoReq syncData_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TempArchiveUpdateReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[136];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempArchiveOperation Operation
	{
		get
		{
			return operation_;
		}
		set
		{
			operation_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SyncGameInfoReq SyncData
	{
		get
		{
			return syncData_;
		}
		set
		{
			syncData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempArchiveUpdateReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempArchiveUpdateReq(TempArchiveUpdateReq other)
		: this()
	{
		operation_ = other.operation_;
		syncData_ = ((other.syncData_ != null) ? other.syncData_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempArchiveUpdateReq Clone()
	{
		return new TempArchiveUpdateReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TempArchiveUpdateReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TempArchiveUpdateReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Operation != other.Operation)
		{
			return false;
		}
		if (!object.Equals(SyncData, other.SyncData))
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
		if (Operation != TempArchiveOperation.Start)
		{
			num ^= Operation.GetHashCode();
		}
		if (syncData_ != null)
		{
			num ^= SyncData.GetHashCode();
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
		if (Operation != TempArchiveOperation.Start)
		{
			output.WriteRawTag(8);
			output.WriteEnum((int)Operation);
		}
		if (syncData_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(SyncData);
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
		if (Operation != TempArchiveOperation.Start)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)Operation);
		}
		if (syncData_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(SyncData);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TempArchiveUpdateReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Operation != TempArchiveOperation.Start)
		{
			Operation = other.Operation;
		}
		if (other.syncData_ != null)
		{
			if (syncData_ == null)
			{
				SyncData = new SyncGameInfoReq();
			}
			SyncData.MergeFrom(other.SyncData);
		}
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
				Operation = (TempArchiveOperation)input.ReadEnum();
				break;
			case 18u:
				if (syncData_ == null)
				{
					SyncData = new SyncGameInfoReq();
				}
				input.ReadMessage(SyncData);
				break;
			}
		}
	}
}
