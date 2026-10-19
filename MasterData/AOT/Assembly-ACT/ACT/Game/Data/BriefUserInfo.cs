using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class BriefUserInfo : IMessage<BriefUserInfo>, IMessage, IEquatable<BriefUserInfo>, IDeepCloneable<BriefUserInfo>, IBufferMessage
{
	private static readonly MessageParser<BriefUserInfo> _parser = new MessageParser<BriefUserInfo>(() => new BriefUserInfo());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private long id_;

	public const int NicknameFieldNumber = 2;

	private string nickname_ = "";

	public const int CreateTimeFieldNumber = 3;

	private int createTime_;

	public const int ServerIndexFieldNumber = 4;

	private int serverIndex_;

	public const int GenderFieldNumber = 5;

	private int gender_;

	public const int OpenIdFieldNumber = 6;

	private string openId_ = "";

	public const int LevelFieldNumber = 7;

	private int level_;

	public const int CombatFieldNumber = 8;

	private long combat_;

	public const int OfflineTimeFieldNumber = 9;

	private int offlineTime_;

	public const int AccountIdFieldNumber = 10;

	private long accountId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<BriefUserInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[9];

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
	public string Nickname
	{
		get
		{
			return nickname_;
		}
		set
		{
			nickname_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CreateTime
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
	public long Combat
	{
		get
		{
			return combat_;
		}
		set
		{
			combat_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int OfflineTime
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
	public BriefUserInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BriefUserInfo(BriefUserInfo other)
		: this()
	{
		id_ = other.id_;
		nickname_ = other.nickname_;
		createTime_ = other.createTime_;
		serverIndex_ = other.serverIndex_;
		gender_ = other.gender_;
		openId_ = other.openId_;
		level_ = other.level_;
		combat_ = other.combat_;
		offlineTime_ = other.offlineTime_;
		accountId_ = other.accountId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BriefUserInfo Clone()
	{
		return new BriefUserInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as BriefUserInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(BriefUserInfo other)
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
		if (Nickname != other.Nickname)
		{
			return false;
		}
		if (CreateTime != other.CreateTime)
		{
			return false;
		}
		if (ServerIndex != other.ServerIndex)
		{
			return false;
		}
		if (Gender != other.Gender)
		{
			return false;
		}
		if (OpenId != other.OpenId)
		{
			return false;
		}
		if (Level != other.Level)
		{
			return false;
		}
		if (Combat != other.Combat)
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
		if (Nickname.Length != 0)
		{
			num ^= Nickname.GetHashCode();
		}
		if (CreateTime != 0)
		{
			num ^= CreateTime.GetHashCode();
		}
		if (ServerIndex != 0)
		{
			num ^= ServerIndex.GetHashCode();
		}
		if (Gender != 0)
		{
			num ^= Gender.GetHashCode();
		}
		if (OpenId.Length != 0)
		{
			num ^= OpenId.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (Combat != 0L)
		{
			num ^= Combat.GetHashCode();
		}
		if (OfflineTime != 0)
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
		if (Nickname.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Nickname);
		}
		if (CreateTime != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CreateTime);
		}
		if (ServerIndex != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ServerIndex);
		}
		if (Gender != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Gender);
		}
		if (OpenId.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(OpenId);
		}
		if (Level != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Level);
		}
		if (Combat != 0L)
		{
			output.WriteRawTag(64);
			output.WriteInt64(Combat);
		}
		if (OfflineTime != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(OfflineTime);
		}
		if (AccountId != 0L)
		{
			output.WriteRawTag(80);
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
		if (Nickname.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Nickname);
		}
		if (CreateTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CreateTime);
		}
		if (ServerIndex != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ServerIndex);
		}
		if (Gender != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Gender);
		}
		if (OpenId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OpenId);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (Combat != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Combat);
		}
		if (OfflineTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OfflineTime);
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
	public void MergeFrom(BriefUserInfo other)
	{
		if (other != null)
		{
			if (other.Id != 0L)
			{
				Id = other.Id;
			}
			if (other.Nickname.Length != 0)
			{
				Nickname = other.Nickname;
			}
			if (other.CreateTime != 0)
			{
				CreateTime = other.CreateTime;
			}
			if (other.ServerIndex != 0)
			{
				ServerIndex = other.ServerIndex;
			}
			if (other.Gender != 0)
			{
				Gender = other.Gender;
			}
			if (other.OpenId.Length != 0)
			{
				OpenId = other.OpenId;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.Combat != 0L)
			{
				Combat = other.Combat;
			}
			if (other.OfflineTime != 0)
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
			case 18u:
				Nickname = input.ReadString();
				break;
			case 24u:
				CreateTime = input.ReadInt32();
				break;
			case 32u:
				ServerIndex = input.ReadInt32();
				break;
			case 40u:
				Gender = input.ReadInt32();
				break;
			case 50u:
				OpenId = input.ReadString();
				break;
			case 56u:
				Level = input.ReadInt32();
				break;
			case 64u:
				Combat = input.ReadInt64();
				break;
			case 72u:
				OfflineTime = input.ReadInt32();
				break;
			case 80u:
				AccountId = input.ReadInt64();
				break;
			}
		}
	}
}
