using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class CreateUserReq : IMessage<CreateUserReq>, IMessage, IEquatable<CreateUserReq>, IDeepCloneable<CreateUserReq>, IBufferMessage
{
	private static readonly MessageParser<CreateUserReq> _parser = new MessageParser<CreateUserReq>(() => new CreateUserReq());

	private UnknownFieldSet _unknownFields;

	public const int GenderFieldNumber = 1;

	private int gender_;

	public const int NickNameFieldNumber = 2;

	private string nickName_ = "";

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CreateUserReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => EnterReflection.Descriptor.MessageTypes[2];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Gender
	{
		get
		{
			return gender_;
		}
		set
		{
			gender_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string NickName
	{
		get
		{
			return nickName_;
		}
		set
		{
			nickName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CreateUserReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CreateUserReq(CreateUserReq other)
		: this()
	{
		gender_ = other.gender_;
		nickName_ = other.nickName_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CreateUserReq Clone()
	{
		return new CreateUserReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CreateUserReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CreateUserReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Gender != other.Gender)
		{
			return false;
		}
		if (NickName != other.NickName)
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
		if (Gender != 0)
		{
			num ^= Gender.GetHashCode();
		}
		if (NickName.Length != 0)
		{
			num ^= NickName.GetHashCode();
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
		if (Gender != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Gender);
		}
		if (NickName.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(NickName);
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
		if (Gender != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Gender);
		}
		if (NickName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(NickName);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CreateUserReq other)
	{
		if (other != null)
		{
			if (other.Gender != 0)
			{
				Gender = other.Gender;
			}
			if (other.NickName.Length != 0)
			{
				NickName = other.NickName;
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
				Gender = input.ReadInt32();
				break;
			case 18u:
				NickName = input.ReadString();
				break;
			}
		}
	}
}
