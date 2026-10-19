using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class FriendProfile : IMessage<FriendProfile>, IMessage, IEquatable<FriendProfile>, IDeepCloneable<FriendProfile>, IBufferMessage
{
	private static readonly MessageParser<FriendProfile> _parser = new MessageParser<FriendProfile>(() => new FriendProfile());

	private UnknownFieldSet _unknownFields;

	public const int UidFieldNumber = 1;

	private long uid_;

	public const int NicknameFieldNumber = 2;

	private string nickname_ = "";

	public const int WorldLevelFieldNumber = 3;

	private int worldLevel_;

	public const int PlayerLevelFieldNumber = 4;

	private int playerLevel_;

	public const int SignatureFieldNumber = 5;

	private string signature_ = "";

	public const int AvatarIdFieldNumber = 6;

	private int avatarId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<FriendProfile> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[168];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long Uid
	{
		get
		{
			return uid_;
		}
		set
		{
			uid_ = value;
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
	public int WorldLevel
	{
		get
		{
			return worldLevel_;
		}
		set
		{
			worldLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PlayerLevel
	{
		get
		{
			return playerLevel_;
		}
		set
		{
			playerLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Signature
	{
		get
		{
			return signature_;
		}
		set
		{
			signature_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int AvatarId
	{
		get
		{
			return avatarId_;
		}
		set
		{
			avatarId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FriendProfile()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FriendProfile(FriendProfile other)
		: this()
	{
		uid_ = other.uid_;
		nickname_ = other.nickname_;
		worldLevel_ = other.worldLevel_;
		playerLevel_ = other.playerLevel_;
		signature_ = other.signature_;
		avatarId_ = other.avatarId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FriendProfile Clone()
	{
		return new FriendProfile(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as FriendProfile);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(FriendProfile other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Uid != other.Uid)
		{
			return false;
		}
		if (Nickname != other.Nickname)
		{
			return false;
		}
		if (WorldLevel != other.WorldLevel)
		{
			return false;
		}
		if (PlayerLevel != other.PlayerLevel)
		{
			return false;
		}
		if (Signature != other.Signature)
		{
			return false;
		}
		if (AvatarId != other.AvatarId)
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
		if (Uid != 0L)
		{
			num ^= Uid.GetHashCode();
		}
		if (Nickname.Length != 0)
		{
			num ^= Nickname.GetHashCode();
		}
		if (WorldLevel != 0)
		{
			num ^= WorldLevel.GetHashCode();
		}
		if (PlayerLevel != 0)
		{
			num ^= PlayerLevel.GetHashCode();
		}
		if (Signature.Length != 0)
		{
			num ^= Signature.GetHashCode();
		}
		if (AvatarId != 0)
		{
			num ^= AvatarId.GetHashCode();
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
		if (Uid != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(Uid);
		}
		if (Nickname.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Nickname);
		}
		if (WorldLevel != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(WorldLevel);
		}
		if (PlayerLevel != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(PlayerLevel);
		}
		if (Signature.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Signature);
		}
		if (AvatarId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(AvatarId);
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
		if (Uid != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Uid);
		}
		if (Nickname.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Nickname);
		}
		if (WorldLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WorldLevel);
		}
		if (PlayerLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PlayerLevel);
		}
		if (Signature.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Signature);
		}
		if (AvatarId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AvatarId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(FriendProfile other)
	{
		if (other != null)
		{
			if (other.Uid != 0L)
			{
				Uid = other.Uid;
			}
			if (other.Nickname.Length != 0)
			{
				Nickname = other.Nickname;
			}
			if (other.WorldLevel != 0)
			{
				WorldLevel = other.WorldLevel;
			}
			if (other.PlayerLevel != 0)
			{
				PlayerLevel = other.PlayerLevel;
			}
			if (other.Signature.Length != 0)
			{
				Signature = other.Signature;
			}
			if (other.AvatarId != 0)
			{
				AvatarId = other.AvatarId;
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
				Uid = input.ReadInt64();
				break;
			case 18u:
				Nickname = input.ReadString();
				break;
			case 24u:
				WorldLevel = input.ReadInt32();
				break;
			case 32u:
				PlayerLevel = input.ReadInt32();
				break;
			case 42u:
				Signature = input.ReadString();
				break;
			case 48u:
				AvatarId = input.ReadInt32();
				break;
			}
		}
	}
}
