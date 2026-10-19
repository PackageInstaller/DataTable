using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class UserServerInfo : IMessage<UserServerInfo>, IMessage, IEquatable<UserServerInfo>, IDeepCloneable<UserServerInfo>, IBufferMessage
{
	private static readonly MessageParser<UserServerInfo> _parser = new MessageParser<UserServerInfo>(() => new UserServerInfo());

	private UnknownFieldSet _unknownFields;

	public const int ServerIndexFieldNumber = 1;

	private int serverIndex_;

	public const int NicknameFieldNumber = 2;

	private string nickname_ = "";

	public const int LvlFieldNumber = 3;

	private int lvl_;

	public const int UserIdFieldNumber = 4;

	private long userId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<UserServerInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[10];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public int Lvl
	{
		get
		{
			return lvl_;
		}
		set
		{
			lvl_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long UserId
	{
		get
		{
			return userId_;
		}
		set
		{
			userId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public UserServerInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public UserServerInfo(UserServerInfo other)
		: this()
	{
		serverIndex_ = other.serverIndex_;
		nickname_ = other.nickname_;
		lvl_ = other.lvl_;
		userId_ = other.userId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public UserServerInfo Clone()
	{
		return new UserServerInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as UserServerInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(UserServerInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ServerIndex != other.ServerIndex)
		{
			return false;
		}
		if (Nickname != other.Nickname)
		{
			return false;
		}
		if (Lvl != other.Lvl)
		{
			return false;
		}
		if (UserId != other.UserId)
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
		if (ServerIndex != 0)
		{
			num ^= ServerIndex.GetHashCode();
		}
		if (Nickname.Length != 0)
		{
			num ^= Nickname.GetHashCode();
		}
		if (Lvl != 0)
		{
			num ^= Lvl.GetHashCode();
		}
		if (UserId != 0L)
		{
			num ^= UserId.GetHashCode();
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
		if (ServerIndex != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ServerIndex);
		}
		if (Nickname.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Nickname);
		}
		if (Lvl != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Lvl);
		}
		if (UserId != 0L)
		{
			output.WriteRawTag(32);
			output.WriteInt64(UserId);
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
		if (ServerIndex != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ServerIndex);
		}
		if (Nickname.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Nickname);
		}
		if (Lvl != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Lvl);
		}
		if (UserId != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(UserId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(UserServerInfo other)
	{
		if (other != null)
		{
			if (other.ServerIndex != 0)
			{
				ServerIndex = other.ServerIndex;
			}
			if (other.Nickname.Length != 0)
			{
				Nickname = other.Nickname;
			}
			if (other.Lvl != 0)
			{
				Lvl = other.Lvl;
			}
			if (other.UserId != 0L)
			{
				UserId = other.UserId;
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
				ServerIndex = input.ReadInt32();
				break;
			case 18u:
				Nickname = input.ReadString();
				break;
			case 24u:
				Lvl = input.ReadInt32();
				break;
			case 32u:
				UserId = input.ReadInt64();
				break;
			}
		}
	}
}
