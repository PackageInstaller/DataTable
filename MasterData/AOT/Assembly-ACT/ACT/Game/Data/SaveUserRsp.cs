using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class SaveUserRsp : IMessage<SaveUserRsp>, IMessage, IEquatable<SaveUserRsp>, IDeepCloneable<SaveUserRsp>, IBufferMessage
{
	private static readonly MessageParser<SaveUserRsp> _parser = new MessageParser<SaveUserRsp>(() => new SaveUserRsp());

	private UnknownFieldSet _unknownFields;

	public const int ErrorFieldNumber = 1;

	private ErrorAck error_;

	public const int AffectedRowsFieldNumber = 2;

	private long affectedRows_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SaveUserRsp> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => UserReflection.Descriptor.MessageTypes[7];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ErrorAck Error
	{
		get
		{
			return error_;
		}
		set
		{
			error_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long AffectedRows
	{
		get
		{
			return affectedRows_;
		}
		set
		{
			affectedRows_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SaveUserRsp()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SaveUserRsp(SaveUserRsp other)
		: this()
	{
		error_ = ((other.error_ != null) ? other.error_.Clone() : null);
		affectedRows_ = other.affectedRows_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SaveUserRsp Clone()
	{
		return new SaveUserRsp(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SaveUserRsp);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SaveUserRsp other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(Error, other.Error))
		{
			return false;
		}
		if (AffectedRows != other.AffectedRows)
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
		if (error_ != null)
		{
			num ^= Error.GetHashCode();
		}
		if (AffectedRows != 0L)
		{
			num ^= AffectedRows.GetHashCode();
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
		if (error_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(Error);
		}
		if (AffectedRows != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(AffectedRows);
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
		if (error_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Error);
		}
		if (AffectedRows != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(AffectedRows);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SaveUserRsp other)
	{
		if (other == null)
		{
			return;
		}
		if (other.error_ != null)
		{
			if (error_ == null)
			{
				Error = new ErrorAck();
			}
			Error.MergeFrom(other.Error);
		}
		if (other.AffectedRows != 0L)
		{
			AffectedRows = other.AffectedRows;
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
			case 10u:
				if (error_ == null)
				{
					Error = new ErrorAck();
				}
				input.ReadMessage(Error);
				break;
			case 16u:
				AffectedRows = input.ReadInt64();
				break;
			}
		}
	}
}
