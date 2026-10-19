using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ErrorAck : IMessage<ErrorAck>, IMessage, IEquatable<ErrorAck>, IDeepCloneable<ErrorAck>, IBufferMessage
{
	private static readonly MessageParser<ErrorAck> _parser = new MessageParser<ErrorAck>(() => new ErrorAck());

	private UnknownFieldSet _unknownFields;

	public const int CodeFieldNumber = 1;

	private int code_;

	public const int MessageFieldNumber = 2;

	private string message_ = "";

	public const int ErrCodeFieldNumber = 3;

	private string errCode_ = "";

	public const int CodeTypeFieldNumber = 4;

	private int codeType_;

	public const int CodeModuleFieldNumber = 5;

	private int codeModule_;

	public const int SubCodeFieldNumber = 6;

	private int subCode_;

	public const int ParamFieldNumber = 7;

	private ErrorParam param_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ErrorAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[1];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Code
	{
		get
		{
			return code_;
		}
		set
		{
			code_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Message
	{
		get
		{
			return message_;
		}
		set
		{
			message_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string ErrCode
	{
		get
		{
			return errCode_;
		}
		set
		{
			errCode_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CodeType
	{
		get
		{
			return codeType_;
		}
		set
		{
			codeType_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CodeModule
	{
		get
		{
			return codeModule_;
		}
		set
		{
			codeModule_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int SubCode
	{
		get
		{
			return subCode_;
		}
		set
		{
			subCode_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ErrorParam Param
	{
		get
		{
			return param_;
		}
		set
		{
			param_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ErrorAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ErrorAck(ErrorAck other)
		: this()
	{
		code_ = other.code_;
		message_ = other.message_;
		errCode_ = other.errCode_;
		codeType_ = other.codeType_;
		codeModule_ = other.codeModule_;
		subCode_ = other.subCode_;
		param_ = ((other.param_ != null) ? other.param_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ErrorAck Clone()
	{
		return new ErrorAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ErrorAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ErrorAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Code != other.Code)
		{
			return false;
		}
		if (Message != other.Message)
		{
			return false;
		}
		if (ErrCode != other.ErrCode)
		{
			return false;
		}
		if (CodeType != other.CodeType)
		{
			return false;
		}
		if (CodeModule != other.CodeModule)
		{
			return false;
		}
		if (SubCode != other.SubCode)
		{
			return false;
		}
		if (!object.Equals(Param, other.Param))
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
		if (Code != 0)
		{
			num ^= Code.GetHashCode();
		}
		if (Message.Length != 0)
		{
			num ^= Message.GetHashCode();
		}
		if (ErrCode.Length != 0)
		{
			num ^= ErrCode.GetHashCode();
		}
		if (CodeType != 0)
		{
			num ^= CodeType.GetHashCode();
		}
		if (CodeModule != 0)
		{
			num ^= CodeModule.GetHashCode();
		}
		if (SubCode != 0)
		{
			num ^= SubCode.GetHashCode();
		}
		if (param_ != null)
		{
			num ^= Param.GetHashCode();
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
		if (Code != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Code);
		}
		if (Message.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Message);
		}
		if (ErrCode.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(ErrCode);
		}
		if (CodeType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CodeType);
		}
		if (CodeModule != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(CodeModule);
		}
		if (SubCode != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(SubCode);
		}
		if (param_ != null)
		{
			output.WriteRawTag(58);
			output.WriteMessage(Param);
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
		if (Code != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Code);
		}
		if (Message.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Message);
		}
		if (ErrCode.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ErrCode);
		}
		if (CodeType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CodeType);
		}
		if (CodeModule != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CodeModule);
		}
		if (SubCode != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SubCode);
		}
		if (param_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Param);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ErrorAck other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Code != 0)
		{
			Code = other.Code;
		}
		if (other.Message.Length != 0)
		{
			Message = other.Message;
		}
		if (other.ErrCode.Length != 0)
		{
			ErrCode = other.ErrCode;
		}
		if (other.CodeType != 0)
		{
			CodeType = other.CodeType;
		}
		if (other.CodeModule != 0)
		{
			CodeModule = other.CodeModule;
		}
		if (other.SubCode != 0)
		{
			SubCode = other.SubCode;
		}
		if (other.param_ != null)
		{
			if (param_ == null)
			{
				Param = new ErrorParam();
			}
			Param.MergeFrom(other.Param);
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
				Code = input.ReadInt32();
				break;
			case 18u:
				Message = input.ReadString();
				break;
			case 26u:
				ErrCode = input.ReadString();
				break;
			case 32u:
				CodeType = input.ReadInt32();
				break;
			case 40u:
				CodeModule = input.ReadInt32();
				break;
			case 48u:
				SubCode = input.ReadInt32();
				break;
			case 58u:
				if (param_ == null)
				{
					Param = new ErrorParam();
				}
				input.ReadMessage(Param);
				break;
			}
		}
	}
}
