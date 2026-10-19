using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class EnterGameAck : IMessage<EnterGameAck>, IMessage, IEquatable<EnterGameAck>, IDeepCloneable<EnterGameAck>, IBufferMessage
{
	private static readonly MessageParser<EnterGameAck> _parser = new MessageParser<EnterGameAck>(() => new EnterGameAck());

	private UnknownFieldSet _unknownFields;

	public const int TsFieldNumber = 1;

	private long ts_;

	public const int VersionFieldNumber = 2;

	private string version_ = "";

	public const int OpenTimeFieldNumber = 3;

	private int openTime_;

	public const int InfoFieldNumber = 4;

	private DetailUserInfo info_;

	public const int DatabaseVersionFieldNumber = 5;

	private string databaseVersion_ = "";

	public const int LastEnterTimeFieldNumber = 6;

	private int lastEnterTime_;

	public const int IsNewUserFieldNumber = 7;

	private bool isNewUser_;

	public const int CodeFieldNumber = 8;

	private int code_;

	public const int BanNoticeFieldNumber = 9;

	private string banNotice_ = "";

	public const int MaintainInfoFieldNumber = 10;

	private MaintainInfo maintainInfo_;

	public const int SessionIDFieldNumber = 11;

	private string sessionID_ = "";

	public const int LastSessionExpiredFieldNumber = 12;

	private bool lastSessionExpired_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<EnterGameAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => EnterReflection.Descriptor.MessageTypes[1];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long Ts
	{
		get
		{
			return ts_;
		}
		set
		{
			ts_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Version
	{
		get
		{
			return version_;
		}
		set
		{
			version_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int OpenTime
	{
		get
		{
			return openTime_;
		}
		set
		{
			openTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DetailUserInfo Info
	{
		get
		{
			return info_;
		}
		set
		{
			info_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string DatabaseVersion
	{
		get
		{
			return databaseVersion_;
		}
		set
		{
			databaseVersion_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LastEnterTime
	{
		get
		{
			return lastEnterTime_;
		}
		set
		{
			lastEnterTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool IsNewUser
	{
		get
		{
			return isNewUser_;
		}
		set
		{
			isNewUser_ = value;
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
	public string BanNotice
	{
		get
		{
			return banNotice_;
		}
		set
		{
			banNotice_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MaintainInfo MaintainInfo
	{
		get
		{
			return maintainInfo_;
		}
		set
		{
			maintainInfo_ = value;
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
	public bool LastSessionExpired
	{
		get
		{
			return lastSessionExpired_;
		}
		set
		{
			lastSessionExpired_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EnterGameAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EnterGameAck(EnterGameAck other)
		: this()
	{
		ts_ = other.ts_;
		version_ = other.version_;
		openTime_ = other.openTime_;
		info_ = ((other.info_ != null) ? other.info_.Clone() : null);
		databaseVersion_ = other.databaseVersion_;
		lastEnterTime_ = other.lastEnterTime_;
		isNewUser_ = other.isNewUser_;
		code_ = other.code_;
		banNotice_ = other.banNotice_;
		maintainInfo_ = ((other.maintainInfo_ != null) ? other.maintainInfo_.Clone() : null);
		sessionID_ = other.sessionID_;
		lastSessionExpired_ = other.lastSessionExpired_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EnterGameAck Clone()
	{
		return new EnterGameAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as EnterGameAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(EnterGameAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Ts != other.Ts)
		{
			return false;
		}
		if (Version != other.Version)
		{
			return false;
		}
		if (OpenTime != other.OpenTime)
		{
			return false;
		}
		if (!object.Equals(Info, other.Info))
		{
			return false;
		}
		if (DatabaseVersion != other.DatabaseVersion)
		{
			return false;
		}
		if (LastEnterTime != other.LastEnterTime)
		{
			return false;
		}
		if (IsNewUser != other.IsNewUser)
		{
			return false;
		}
		if (Code != other.Code)
		{
			return false;
		}
		if (BanNotice != other.BanNotice)
		{
			return false;
		}
		if (!object.Equals(MaintainInfo, other.MaintainInfo))
		{
			return false;
		}
		if (SessionID != other.SessionID)
		{
			return false;
		}
		if (LastSessionExpired != other.LastSessionExpired)
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
		if (Ts != 0L)
		{
			num ^= Ts.GetHashCode();
		}
		if (Version.Length != 0)
		{
			num ^= Version.GetHashCode();
		}
		if (OpenTime != 0)
		{
			num ^= OpenTime.GetHashCode();
		}
		if (info_ != null)
		{
			num ^= Info.GetHashCode();
		}
		if (DatabaseVersion.Length != 0)
		{
			num ^= DatabaseVersion.GetHashCode();
		}
		if (LastEnterTime != 0)
		{
			num ^= LastEnterTime.GetHashCode();
		}
		if (IsNewUser)
		{
			num ^= IsNewUser.GetHashCode();
		}
		if (Code != 0)
		{
			num ^= Code.GetHashCode();
		}
		if (BanNotice.Length != 0)
		{
			num ^= BanNotice.GetHashCode();
		}
		if (maintainInfo_ != null)
		{
			num ^= MaintainInfo.GetHashCode();
		}
		if (SessionID.Length != 0)
		{
			num ^= SessionID.GetHashCode();
		}
		if (LastSessionExpired)
		{
			num ^= LastSessionExpired.GetHashCode();
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
		if (Ts != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(Ts);
		}
		if (Version.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Version);
		}
		if (OpenTime != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(OpenTime);
		}
		if (info_ != null)
		{
			output.WriteRawTag(34);
			output.WriteMessage(Info);
		}
		if (DatabaseVersion.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(DatabaseVersion);
		}
		if (LastEnterTime != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(LastEnterTime);
		}
		if (IsNewUser)
		{
			output.WriteRawTag(56);
			output.WriteBool(IsNewUser);
		}
		if (Code != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Code);
		}
		if (BanNotice.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(BanNotice);
		}
		if (maintainInfo_ != null)
		{
			output.WriteRawTag(82);
			output.WriteMessage(MaintainInfo);
		}
		if (SessionID.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(SessionID);
		}
		if (LastSessionExpired)
		{
			output.WriteRawTag(96);
			output.WriteBool(LastSessionExpired);
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
		if (Ts != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Ts);
		}
		if (Version.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Version);
		}
		if (OpenTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OpenTime);
		}
		if (info_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Info);
		}
		if (DatabaseVersion.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DatabaseVersion);
		}
		if (LastEnterTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LastEnterTime);
		}
		if (IsNewUser)
		{
			num += 2;
		}
		if (Code != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Code);
		}
		if (BanNotice.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BanNotice);
		}
		if (maintainInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(MaintainInfo);
		}
		if (SessionID.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SessionID);
		}
		if (LastSessionExpired)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(EnterGameAck other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Ts != 0L)
		{
			Ts = other.Ts;
		}
		if (other.Version.Length != 0)
		{
			Version = other.Version;
		}
		if (other.OpenTime != 0)
		{
			OpenTime = other.OpenTime;
		}
		if (other.info_ != null)
		{
			if (info_ == null)
			{
				Info = new DetailUserInfo();
			}
			Info.MergeFrom(other.Info);
		}
		if (other.DatabaseVersion.Length != 0)
		{
			DatabaseVersion = other.DatabaseVersion;
		}
		if (other.LastEnterTime != 0)
		{
			LastEnterTime = other.LastEnterTime;
		}
		if (other.IsNewUser)
		{
			IsNewUser = other.IsNewUser;
		}
		if (other.Code != 0)
		{
			Code = other.Code;
		}
		if (other.BanNotice.Length != 0)
		{
			BanNotice = other.BanNotice;
		}
		if (other.maintainInfo_ != null)
		{
			if (maintainInfo_ == null)
			{
				MaintainInfo = new MaintainInfo();
			}
			MaintainInfo.MergeFrom(other.MaintainInfo);
		}
		if (other.SessionID.Length != 0)
		{
			SessionID = other.SessionID;
		}
		if (other.LastSessionExpired)
		{
			LastSessionExpired = other.LastSessionExpired;
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
				Ts = input.ReadInt64();
				break;
			case 18u:
				Version = input.ReadString();
				break;
			case 24u:
				OpenTime = input.ReadInt32();
				break;
			case 34u:
				if (info_ == null)
				{
					Info = new DetailUserInfo();
				}
				input.ReadMessage(Info);
				break;
			case 42u:
				DatabaseVersion = input.ReadString();
				break;
			case 48u:
				LastEnterTime = input.ReadInt32();
				break;
			case 56u:
				IsNewUser = input.ReadBool();
				break;
			case 64u:
				Code = input.ReadInt32();
				break;
			case 74u:
				BanNotice = input.ReadString();
				break;
			case 82u:
				if (maintainInfo_ == null)
				{
					MaintainInfo = new MaintainInfo();
				}
				input.ReadMessage(MaintainInfo);
				break;
			case 90u:
				SessionID = input.ReadString();
				break;
			case 96u:
				LastSessionExpired = input.ReadBool();
				break;
			}
		}
	}
}
