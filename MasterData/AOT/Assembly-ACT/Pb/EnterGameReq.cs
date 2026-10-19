using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class EnterGameReq : IMessage<EnterGameReq>, IMessage, IEquatable<EnterGameReq>, IDeepCloneable<EnterGameReq>, IBufferMessage
{
	private static readonly MessageParser<EnterGameReq> _parser = new MessageParser<EnterGameReq>(() => new EnterGameReq());

	private UnknownFieldSet _unknownFields;

	public const int OpenIdFieldNumber = 1;

	private string openId_ = "";

	public const int LoginKeyFieldNumber = 2;

	private string loginKey_ = "";

	public const int AccountIdFieldNumber = 3;

	private long accountId_;

	public const int IsEditorFieldNumber = 4;

	private bool isEditor_;

	public const int SdkAidFieldNumber = 5;

	private long sdkAid_;

	public const int DistinctIDFieldNumber = 6;

	private string distinctID_ = "";

	public const int ClientVersionFieldNumber = 7;

	private string clientVersion_ = "";

	public const int TdDataFieldNumber = 8;

	private TDClientData tdData_;

	public const int SessionIDFieldNumber = 9;

	private string sessionID_ = "";

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<EnterGameReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => EnterReflection.Descriptor.MessageTypes[0];

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
	public bool IsEditor
	{
		get
		{
			return isEditor_;
		}
		set
		{
			isEditor_ = value;
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
	public string DistinctID
	{
		get
		{
			return distinctID_;
		}
		set
		{
			distinctID_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string ClientVersion
	{
		get
		{
			return clientVersion_;
		}
		set
		{
			clientVersion_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TDClientData TdData
	{
		get
		{
			return tdData_;
		}
		set
		{
			tdData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string SessionID
	{
		get
		{
			return sessionID_;
		}
		set
		{
			sessionID_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EnterGameReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EnterGameReq(EnterGameReq other)
		: this()
	{
		openId_ = other.openId_;
		loginKey_ = other.loginKey_;
		accountId_ = other.accountId_;
		isEditor_ = other.isEditor_;
		sdkAid_ = other.sdkAid_;
		distinctID_ = other.distinctID_;
		clientVersion_ = other.clientVersion_;
		tdData_ = ((other.tdData_ != null) ? other.tdData_.Clone() : null);
		sessionID_ = other.sessionID_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EnterGameReq Clone()
	{
		return new EnterGameReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as EnterGameReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(EnterGameReq other)
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
		if (IsEditor != other.IsEditor)
		{
			return false;
		}
		if (SdkAid != other.SdkAid)
		{
			return false;
		}
		if (DistinctID != other.DistinctID)
		{
			return false;
		}
		if (ClientVersion != other.ClientVersion)
		{
			return false;
		}
		if (!object.Equals(TdData, other.TdData))
		{
			return false;
		}
		if (SessionID != other.SessionID)
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
		if (IsEditor)
		{
			num ^= IsEditor.GetHashCode();
		}
		if (SdkAid != 0L)
		{
			num ^= SdkAid.GetHashCode();
		}
		if (DistinctID.Length != 0)
		{
			num ^= DistinctID.GetHashCode();
		}
		if (ClientVersion.Length != 0)
		{
			num ^= ClientVersion.GetHashCode();
		}
		if (tdData_ != null)
		{
			num ^= TdData.GetHashCode();
		}
		if (SessionID.Length != 0)
		{
			num ^= SessionID.GetHashCode();
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
		if (IsEditor)
		{
			output.WriteRawTag(32);
			output.WriteBool(IsEditor);
		}
		if (SdkAid != 0L)
		{
			output.WriteRawTag(40);
			output.WriteInt64(SdkAid);
		}
		if (DistinctID.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(DistinctID);
		}
		if (ClientVersion.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(ClientVersion);
		}
		if (tdData_ != null)
		{
			output.WriteRawTag(66);
			output.WriteMessage(TdData);
		}
		if (SessionID.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(SessionID);
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
		if (IsEditor)
		{
			num += 2;
		}
		if (SdkAid != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(SdkAid);
		}
		if (DistinctID.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DistinctID);
		}
		if (ClientVersion.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ClientVersion);
		}
		if (tdData_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(TdData);
		}
		if (SessionID.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SessionID);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(EnterGameReq other)
	{
		if (other == null)
		{
			return;
		}
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
		if (other.IsEditor)
		{
			IsEditor = other.IsEditor;
		}
		if (other.SdkAid != 0L)
		{
			SdkAid = other.SdkAid;
		}
		if (other.DistinctID.Length != 0)
		{
			DistinctID = other.DistinctID;
		}
		if (other.ClientVersion.Length != 0)
		{
			ClientVersion = other.ClientVersion;
		}
		if (other.tdData_ != null)
		{
			if (tdData_ == null)
			{
				TdData = new TDClientData();
			}
			TdData.MergeFrom(other.TdData);
		}
		if (other.SessionID.Length != 0)
		{
			SessionID = other.SessionID;
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
				OpenId = input.ReadString();
				break;
			case 18u:
				LoginKey = input.ReadString();
				break;
			case 24u:
				AccountId = input.ReadInt64();
				break;
			case 32u:
				IsEditor = input.ReadBool();
				break;
			case 40u:
				SdkAid = input.ReadInt64();
				break;
			case 50u:
				DistinctID = input.ReadString();
				break;
			case 58u:
				ClientVersion = input.ReadString();
				break;
			case 66u:
				if (tdData_ == null)
				{
					TdData = new TDClientData();
				}
				input.ReadMessage(TdData);
				break;
			case 74u:
				SessionID = input.ReadString();
				break;
			}
		}
	}
}
