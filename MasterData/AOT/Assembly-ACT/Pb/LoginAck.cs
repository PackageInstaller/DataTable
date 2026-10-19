using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class LoginAck : IMessage<LoginAck>, IMessage, IEquatable<LoginAck>, IDeepCloneable<LoginAck>, IBufferMessage
{
	private static readonly MessageParser<LoginAck> _parser = new MessageParser<LoginAck>(() => new LoginAck());

	private UnknownFieldSet _unknownFields;

	public const int OpenIdFieldNumber = 1;

	private string openId_ = "";

	public const int LoginKeyFieldNumber = 2;

	private string loginKey_ = "";

	public const int AccountIdFieldNumber = 3;

	private long accountId_;

	public const int GateAddrFieldNumber = 4;

	private string gateAddr_ = "";

	public const int CodeFieldNumber = 5;

	private int code_;

	public const int ServerGroupFieldNumber = 6;

	private string serverGroup_ = "";

	public const int SdkAidFieldNumber = 7;

	private long sdkAid_;

	public const int AesKeyFieldNumber = 8;

	private ByteString aesKey_ = ByteString.Empty;

	public const int IsEncryFieldNumber = 9;

	private bool isEncry_;

	public const int FairTagFieldNumber = 10;

	private int fairTag_;

	public const int GateAddrBackupFieldNumber = 11;

	private string gateAddrBackup_ = "";

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<LoginAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => LoginReflection.Descriptor.MessageTypes[1];

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
	public string GateAddr
	{
		get
		{
			return gateAddr_;
		}
		set
		{
			gateAddr_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

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
	public string ServerGroup
	{
		get
		{
			return serverGroup_;
		}
		set
		{
			serverGroup_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long SdkAid
	{
		get
		{
			return sdkAid_;
		}
		set
		{
			sdkAid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ByteString AesKey
	{
		get
		{
			return aesKey_;
		}
		set
		{
			aesKey_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool IsEncry
	{
		get
		{
			return isEncry_;
		}
		set
		{
			isEncry_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int FairTag
	{
		get
		{
			return fairTag_;
		}
		set
		{
			fairTag_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string GateAddrBackup
	{
		get
		{
			return gateAddrBackup_;
		}
		set
		{
			gateAddrBackup_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoginAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoginAck(LoginAck other)
		: this()
	{
		openId_ = other.openId_;
		loginKey_ = other.loginKey_;
		accountId_ = other.accountId_;
		gateAddr_ = other.gateAddr_;
		code_ = other.code_;
		serverGroup_ = other.serverGroup_;
		sdkAid_ = other.sdkAid_;
		aesKey_ = other.aesKey_;
		isEncry_ = other.isEncry_;
		fairTag_ = other.fairTag_;
		gateAddrBackup_ = other.gateAddrBackup_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoginAck Clone()
	{
		return new LoginAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as LoginAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(LoginAck other)
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
		if (GateAddr != other.GateAddr)
		{
			return false;
		}
		if (Code != other.Code)
		{
			return false;
		}
		if (ServerGroup != other.ServerGroup)
		{
			return false;
		}
		if (SdkAid != other.SdkAid)
		{
			return false;
		}
		if (AesKey != other.AesKey)
		{
			return false;
		}
		if (IsEncry != other.IsEncry)
		{
			return false;
		}
		if (FairTag != other.FairTag)
		{
			return false;
		}
		if (GateAddrBackup != other.GateAddrBackup)
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
		if (GateAddr.Length != 0)
		{
			num ^= GateAddr.GetHashCode();
		}
		if (Code != 0)
		{
			num ^= Code.GetHashCode();
		}
		if (ServerGroup.Length != 0)
		{
			num ^= ServerGroup.GetHashCode();
		}
		if (SdkAid != 0L)
		{
			num ^= SdkAid.GetHashCode();
		}
		if (AesKey.Length != 0)
		{
			num ^= AesKey.GetHashCode();
		}
		if (IsEncry)
		{
			num ^= IsEncry.GetHashCode();
		}
		if (FairTag != 0)
		{
			num ^= FairTag.GetHashCode();
		}
		if (GateAddrBackup.Length != 0)
		{
			num ^= GateAddrBackup.GetHashCode();
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
		if (GateAddr.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(GateAddr);
		}
		if (Code != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Code);
		}
		if (ServerGroup.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(ServerGroup);
		}
		if (SdkAid != 0L)
		{
			output.WriteRawTag(56);
			output.WriteInt64(SdkAid);
		}
		if (AesKey.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteBytes(AesKey);
		}
		if (IsEncry)
		{
			output.WriteRawTag(72);
			output.WriteBool(IsEncry);
		}
		if (FairTag != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(FairTag);
		}
		if (GateAddrBackup.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(GateAddrBackup);
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
		if (GateAddr.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(GateAddr);
		}
		if (Code != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Code);
		}
		if (ServerGroup.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ServerGroup);
		}
		if (SdkAid != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(SdkAid);
		}
		if (AesKey.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeBytesSize(AesKey);
		}
		if (IsEncry)
		{
			num += 2;
		}
		if (FairTag != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FairTag);
		}
		if (GateAddrBackup.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(GateAddrBackup);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(LoginAck other)
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
			if (other.GateAddr.Length != 0)
			{
				GateAddr = other.GateAddr;
			}
			if (other.Code != 0)
			{
				Code = other.Code;
			}
			if (other.ServerGroup.Length != 0)
			{
				ServerGroup = other.ServerGroup;
			}
			if (other.SdkAid != 0L)
			{
				SdkAid = other.SdkAid;
			}
			if (other.AesKey.Length != 0)
			{
				AesKey = other.AesKey;
			}
			if (other.IsEncry)
			{
				IsEncry = other.IsEncry;
			}
			if (other.FairTag != 0)
			{
				FairTag = other.FairTag;
			}
			if (other.GateAddrBackup.Length != 0)
			{
				GateAddrBackup = other.GateAddrBackup;
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
			case 34u:
				GateAddr = input.ReadString();
				break;
			case 40u:
				Code = input.ReadInt32();
				break;
			case 50u:
				ServerGroup = input.ReadString();
				break;
			case 56u:
				SdkAid = input.ReadInt64();
				break;
			case 66u:
				AesKey = input.ReadBytes();
				break;
			case 72u:
				IsEncry = input.ReadBool();
				break;
			case 80u:
				FairTag = input.ReadInt32();
				break;
			case 90u:
				GateAddrBackup = input.ReadString();
				break;
			}
		}
	}
}
