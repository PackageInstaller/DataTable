using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class EnterMatchReq : IMessage<EnterMatchReq>, IMessage, IEquatable<EnterMatchReq>, IDeepCloneable<EnterMatchReq>, IBufferMessage
{
	private static readonly MessageParser<EnterMatchReq> _parser = new MessageParser<EnterMatchReq>(() => new EnterMatchReq());

	private UnknownFieldSet _unknownFields;

	public const int OpenIdFieldNumber = 1;

	private string openId_ = "";

	public const int LoginKeyFieldNumber = 2;

	private string loginKey_ = "";

	public const int AccountIdFieldNumber = 3;

	private long accountId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<EnterMatchReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MatchReflection.Descriptor.MessageTypes[0];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string OpenId
	{
		get
		{
			return openId_;
		}
		set
		{
			openId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string LoginKey
	{
		get
		{
			return loginKey_;
		}
		set
		{
			loginKey_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long AccountId
	{
		get
		{
			return accountId_;
		}
		set
		{
			accountId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EnterMatchReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EnterMatchReq(EnterMatchReq other)
		: this()
	{
		openId_ = other.openId_;
		loginKey_ = other.loginKey_;
		accountId_ = other.accountId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EnterMatchReq Clone()
	{
		return new EnterMatchReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as EnterMatchReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(EnterMatchReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (OpenId != other.OpenId)
		{
			return false;
		}
		if (LoginKey != other.LoginKey)
		{
			return false;
		}
		if (AccountId != other.AccountId)
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
		if (OpenId.Length != 0)
		{
			num ^= OpenId.GetHashCode();
		}
		if (LoginKey.Length != 0)
		{
			num ^= LoginKey.GetHashCode();
		}
		if (AccountId != 0L)
		{
			num ^= AccountId.GetHashCode();
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
		if (OpenId.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(OpenId);
		}
		if (LoginKey.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(LoginKey);
		}
		if (AccountId != 0L)
		{
			output.WriteRawTag(24);
			output.WriteInt64(AccountId);
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
		if (OpenId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OpenId);
		}
		if (LoginKey.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LoginKey);
		}
		if (AccountId != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(AccountId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(EnterMatchReq other)
	{
		if (other != null)
		{
			if (other.OpenId.Length != 0)
			{
				OpenId = other.OpenId;
			}
			if (other.LoginKey.Length != 0)
			{
				LoginKey = other.LoginKey;
			}
			if (other.AccountId != 0L)
			{
				AccountId = other.AccountId;
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
			case 10u:
				OpenId = input.ReadString();
				break;
			case 18u:
				LoginKey = input.ReadString();
				break;
			case 24u:
				AccountId = input.ReadInt64();
				break;
			}
		}
	}
}
