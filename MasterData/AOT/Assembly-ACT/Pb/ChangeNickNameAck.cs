using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ChangeNickNameAck : IMessage<ChangeNickNameAck>, IMessage, IEquatable<ChangeNickNameAck>, IDeepCloneable<ChangeNickNameAck>, IBufferMessage
{
	private static readonly MessageParser<ChangeNickNameAck> _parser = new MessageParser<ChangeNickNameAck>(() => new ChangeNickNameAck());

	private UnknownFieldSet _unknownFields;

	public const int OkFieldNumber = 1;

	private bool ok_;

	public const int NickNameFieldNumber = 2;

	private string nickName_ = "";

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ChangeNickNameAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[95];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Ok
	{
		get
		{
			return ok_;
		}
		set
		{
			ok_ = value;
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
	public ChangeNickNameAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ChangeNickNameAck(ChangeNickNameAck other)
		: this()
	{
		ok_ = other.ok_;
		nickName_ = other.nickName_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ChangeNickNameAck Clone()
	{
		return new ChangeNickNameAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ChangeNickNameAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ChangeNickNameAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Ok != other.Ok)
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
		if (Ok)
		{
			num ^= Ok.GetHashCode();
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
		if (Ok)
		{
			output.WriteRawTag(8);
			output.WriteBool(Ok);
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
		if (Ok)
		{
			num += 2;
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
	public void MergeFrom(ChangeNickNameAck other)
	{
		if (other != null)
		{
			if (other.Ok)
			{
				Ok = other.Ok;
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
				Ok = input.ReadBool();
				break;
			case 18u:
				NickName = input.ReadString();
				break;
			}
		}
	}
}
