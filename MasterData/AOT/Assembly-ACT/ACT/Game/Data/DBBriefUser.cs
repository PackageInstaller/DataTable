using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class DBBriefUser : IMessage<DBBriefUser>, IMessage, IEquatable<DBBriefUser>, IDeepCloneable<DBBriefUser>, IBufferMessage
{
	private static readonly MessageParser<DBBriefUser> _parser = new MessageParser<DBBriefUser>(() => new DBBriefUser());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private long id_;

	public const int ServerIndexFieldNumber = 2;

	private int serverIndex_;

	public const int OpenIdFieldNumber = 3;

	private string openId_ = "";

	public const int CreateTimeFieldNumber = 4;

	private long createTime_;

	public const int NickNameFieldNumber = 5;

	private string nickName_ = "";

	public const int LevelFieldNumber = 6;

	private int level_;

	public const int OfflineTimeFieldNumber = 7;

	private long offlineTime_;

	public const int AccountIdFieldNumber = 8;

	private long accountId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<DBBriefUser> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => UserReflection.Descriptor.MessageTypes[0];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ServerIndex
	{
		get
		{
			return serverIndex_;
		}
		set
		{
			serverIndex_ = value;
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
	public long CreateTime
	{
		get
		{
			return createTime_;
		}
		set
		{
			createTime_ = value;
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
	public int Level
	{
		get
		{
			return level_;
		}
		set
		{
			level_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long OfflineTime
	{
		get
		{
			return offlineTime_;
		}
		set
		{
			offlineTime_ = value;
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
	public DBBriefUser()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DBBriefUser(DBBriefUser other)
		: this()
	{
		id_ = other.id_;
		serverIndex_ = other.serverIndex_;
		openId_ = other.openId_;
		createTime_ = other.createTime_;
		nickName_ = other.nickName_;
		level_ = other.level_;
		offlineTime_ = other.offlineTime_;
		accountId_ = other.accountId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DBBriefUser Clone()
	{
		return new DBBriefUser(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as DBBriefUser);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(DBBriefUser other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (ServerIndex != other.ServerIndex)
		{
			return false;
		}
		if (OpenId != other.OpenId)
		{
			return false;
		}
		if (CreateTime != other.CreateTime)
		{
			return false;
		}
		if (NickName != other.NickName)
		{
			return false;
		}
		if (Level != other.Level)
		{
			return false;
		}
		if (OfflineTime != other.OfflineTime)
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
		if (Id != 0L)
		{
			num ^= Id.GetHashCode();
		}
		if (ServerIndex != 0)
		{
			num ^= ServerIndex.GetHashCode();
		}
		if (OpenId.Length != 0)
		{
			num ^= OpenId.GetHashCode();
		}
		if (CreateTime != 0L)
		{
			num ^= CreateTime.GetHashCode();
		}
		if (NickName.Length != 0)
		{
			num ^= NickName.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (OfflineTime != 0L)
		{
			num ^= OfflineTime.GetHashCode();
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
		if (Id != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(Id);
		}
		if (ServerIndex != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ServerIndex);
		}
		if (OpenId.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(OpenId);
		}
		if (CreateTime != 0L)
		{
			output.WriteRawTag(32);
			output.WriteInt64(CreateTime);
		}
		if (NickName.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(NickName);
		}
		if (Level != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Level);
		}
		if (OfflineTime != 0L)
		{
			output.WriteRawTag(56);
			output.WriteInt64(OfflineTime);
		}
		if (AccountId != 0L)
		{
			output.WriteRawTag(64);
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
		if (Id != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Id);
		}
		if (ServerIndex != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ServerIndex);
		}
		if (OpenId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OpenId);
		}
		if (CreateTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(CreateTime);
		}
		if (NickName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(NickName);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (OfflineTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(OfflineTime);
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
	public void MergeFrom(DBBriefUser other)
	{
		if (other != null)
		{
			if (other.Id != 0L)
			{
				Id = other.Id;
			}
			if (other.ServerIndex != 0)
			{
				ServerIndex = other.ServerIndex;
			}
			if (other.OpenId.Length != 0)
			{
				OpenId = other.OpenId;
			}
			if (other.CreateTime != 0L)
			{
				CreateTime = other.CreateTime;
			}
			if (other.NickName.Length != 0)
			{
				NickName = other.NickName;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.OfflineTime != 0L)
			{
				OfflineTime = other.OfflineTime;
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
			case 8u:
				Id = input.ReadInt64();
				break;
			case 16u:
				ServerIndex = input.ReadInt32();
				break;
			case 26u:
				OpenId = input.ReadString();
				break;
			case 32u:
				CreateTime = input.ReadInt64();
				break;
			case 42u:
				NickName = input.ReadString();
				break;
			case 48u:
				Level = input.ReadInt32();
				break;
			case 56u:
				OfflineTime = input.ReadInt64();
				break;
			case 64u:
				AccountId = input.ReadInt64();
				break;
			}
		}
	}
}
