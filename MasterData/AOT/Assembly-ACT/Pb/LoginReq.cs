using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class LoginReq : IMessage<LoginReq>, IMessage, IEquatable<LoginReq>, IDeepCloneable<LoginReq>, IBufferMessage
{
	private static readonly MessageParser<LoginReq> _parser = new MessageParser<LoginReq>(() => new LoginReq());

	private UnknownFieldSet _unknownFields;

	public const int LoginTicketFieldNumber = 1;

	private string loginTicket_ = "";

	public const int OpenIdFieldNumber = 2;

	private string openId_ = "";

	public const int AppVersionFieldNumber = 3;

	private string appVersion_ = "";

	public const int AccountIdFieldNumber = 4;

	private long accountId_;

	public const int OperationalInfoFieldNumber = 5;

	private OperationalInfo operationalInfo_;

	public const int DistinctIDFieldNumber = 6;

	private string distinctID_ = "";

	public const int TdDataFieldNumber = 7;

	private TDClientData tdData_;

	public const int IsEditorFieldNumber = 8;

	private bool isEditor_;

	public const int EnvFieldNumber = 9;

	private string env_ = "";

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<LoginReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => LoginReflection.Descriptor.MessageTypes[0];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string LoginTicket
	{
		get
		{
			return loginTicket_;
		}
		set
		{
			loginTicket_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

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
	public string AppVersion
	{
		get
		{
			return appVersion_;
		}
		set
		{
			appVersion_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public OperationalInfo OperationalInfo
	{
		get
		{
			return operationalInfo_;
		}
		set
		{
			operationalInfo_ = value;
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
	public string Env
	{
		get
		{
			return env_;
		}
		set
		{
			env_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoginReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoginReq(LoginReq other)
		: this()
	{
		loginTicket_ = other.loginTicket_;
		openId_ = other.openId_;
		appVersion_ = other.appVersion_;
		accountId_ = other.accountId_;
		operationalInfo_ = ((other.operationalInfo_ != null) ? other.operationalInfo_.Clone() : null);
		distinctID_ = other.distinctID_;
		tdData_ = ((other.tdData_ != null) ? other.tdData_.Clone() : null);
		isEditor_ = other.isEditor_;
		env_ = other.env_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoginReq Clone()
	{
		return new LoginReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as LoginReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(LoginReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (LoginTicket != other.LoginTicket)
		{
			return false;
		}
		if (OpenId != other.OpenId)
		{
			return false;
		}
		if (AppVersion != other.AppVersion)
		{
			return false;
		}
		if (AccountId != other.AccountId)
		{
			return false;
		}
		if (!object.Equals(OperationalInfo, other.OperationalInfo))
		{
			return false;
		}
		if (DistinctID != other.DistinctID)
		{
			return false;
		}
		if (!object.Equals(TdData, other.TdData))
		{
			return false;
		}
		if (IsEditor != other.IsEditor)
		{
			return false;
		}
		if (Env != other.Env)
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
		if (LoginTicket.Length != 0)
		{
			num ^= LoginTicket.GetHashCode();
		}
		if (OpenId.Length != 0)
		{
			num ^= OpenId.GetHashCode();
		}
		if (AppVersion.Length != 0)
		{
			num ^= AppVersion.GetHashCode();
		}
		if (AccountId != 0L)
		{
			num ^= AccountId.GetHashCode();
		}
		if (operationalInfo_ != null)
		{
			num ^= OperationalInfo.GetHashCode();
		}
		if (DistinctID.Length != 0)
		{
			num ^= DistinctID.GetHashCode();
		}
		if (tdData_ != null)
		{
			num ^= TdData.GetHashCode();
		}
		if (IsEditor)
		{
			num ^= IsEditor.GetHashCode();
		}
		if (Env.Length != 0)
		{
			num ^= Env.GetHashCode();
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
		if (LoginTicket.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(LoginTicket);
		}
		if (OpenId.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(OpenId);
		}
		if (AppVersion.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(AppVersion);
		}
		if (AccountId != 0L)
		{
			output.WriteRawTag(32);
			output.WriteInt64(AccountId);
		}
		if (operationalInfo_ != null)
		{
			output.WriteRawTag(42);
			output.WriteMessage(OperationalInfo);
		}
		if (DistinctID.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(DistinctID);
		}
		if (tdData_ != null)
		{
			output.WriteRawTag(58);
			output.WriteMessage(TdData);
		}
		if (IsEditor)
		{
			output.WriteRawTag(64);
			output.WriteBool(IsEditor);
		}
		if (Env.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Env);
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
		if (LoginTicket.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LoginTicket);
		}
		if (OpenId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OpenId);
		}
		if (AppVersion.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AppVersion);
		}
		if (AccountId != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(AccountId);
		}
		if (operationalInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(OperationalInfo);
		}
		if (DistinctID.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DistinctID);
		}
		if (tdData_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(TdData);
		}
		if (IsEditor)
		{
			num += 2;
		}
		if (Env.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Env);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(LoginReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.LoginTicket.Length != 0)
		{
			LoginTicket = other.LoginTicket;
		}
		if (other.OpenId.Length != 0)
		{
			OpenId = other.OpenId;
		}
		if (other.AppVersion.Length != 0)
		{
			AppVersion = other.AppVersion;
		}
		if (other.AccountId != 0L)
		{
			AccountId = other.AccountId;
		}
		if (other.operationalInfo_ != null)
		{
			if (operationalInfo_ == null)
			{
				OperationalInfo = new OperationalInfo();
			}
			OperationalInfo.MergeFrom(other.OperationalInfo);
		}
		if (other.DistinctID.Length != 0)
		{
			DistinctID = other.DistinctID;
		}
		if (other.tdData_ != null)
		{
			if (tdData_ == null)
			{
				TdData = new TDClientData();
			}
			TdData.MergeFrom(other.TdData);
		}
		if (other.IsEditor)
		{
			IsEditor = other.IsEditor;
		}
		if (other.Env.Length != 0)
		{
			Env = other.Env;
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
				LoginTicket = input.ReadString();
				break;
			case 18u:
				OpenId = input.ReadString();
				break;
			case 26u:
				AppVersion = input.ReadString();
				break;
			case 32u:
				AccountId = input.ReadInt64();
				break;
			case 42u:
				if (operationalInfo_ == null)
				{
					OperationalInfo = new OperationalInfo();
				}
				input.ReadMessage(OperationalInfo);
				break;
			case 50u:
				DistinctID = input.ReadString();
				break;
			case 58u:
				if (tdData_ == null)
				{
					TdData = new TDClientData();
				}
				input.ReadMessage(TdData);
				break;
			case 64u:
				IsEditor = input.ReadBool();
				break;
			case 74u:
				Env = input.ReadString();
				break;
			}
		}
	}
}
