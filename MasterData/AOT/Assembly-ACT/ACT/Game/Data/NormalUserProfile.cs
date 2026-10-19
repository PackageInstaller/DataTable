using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class NormalUserProfile : IMessage<NormalUserProfile>, IMessage, IEquatable<NormalUserProfile>, IDeepCloneable<NormalUserProfile>, IBufferMessage
{
	private static readonly MessageParser<NormalUserProfile> _parser = new MessageParser<NormalUserProfile>(() => new NormalUserProfile());

	private UnknownFieldSet _unknownFields;

	public const int UidFieldNumber = 1;

	private long uid_;

	public const int NicknameFieldNumber = 2;

	private string nickname_ = "";

	public const int GenderFieldNumber = 3;

	private int gender_;

	public const int PlayerLevelFieldNumber = 4;

	private int playerLevel_;

	public const int PlayerWorldLevelFieldNumber = 5;

	private int playerWorldLevel_;

	public const int SignatureFieldNumber = 6;

	private string signature_ = "";

	public const int AvatarIdFieldNumber = 7;

	private int avatarId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<NormalUserProfile> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[227];

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
	public int PlayerWorldLevel
	{
		get
		{
			return playerWorldLevel_;
		}
		set
		{
			playerWorldLevel_ = value;
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
	public NormalUserProfile()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public NormalUserProfile(NormalUserProfile other)
		: this()
	{
		uid_ = other.uid_;
		nickname_ = other.nickname_;
		gender_ = other.gender_;
		playerLevel_ = other.playerLevel_;
		playerWorldLevel_ = other.playerWorldLevel_;
		signature_ = other.signature_;
		avatarId_ = other.avatarId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public NormalUserProfile Clone()
	{
		return new NormalUserProfile(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as NormalUserProfile);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(NormalUserProfile other)
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
		if (Gender != other.Gender)
		{
			return false;
		}
		if (PlayerLevel != other.PlayerLevel)
		{
			return false;
		}
		if (PlayerWorldLevel != other.PlayerWorldLevel)
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
		if (Gender != 0)
		{
			num ^= Gender.GetHashCode();
		}
		if (PlayerLevel != 0)
		{
			num ^= PlayerLevel.GetHashCode();
		}
		if (PlayerWorldLevel != 0)
		{
			num ^= PlayerWorldLevel.GetHashCode();
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
		if (Gender != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Gender);
		}
		if (PlayerLevel != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(PlayerLevel);
		}
		if (PlayerWorldLevel != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(PlayerWorldLevel);
		}
		if (Signature.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Signature);
		}
		if (AvatarId != 0)
		{
			output.WriteRawTag(56);
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
		if (Gender != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Gender);
		}
		if (PlayerLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PlayerLevel);
		}
		if (PlayerWorldLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PlayerWorldLevel);
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
	public void MergeFrom(NormalUserProfile other)
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
			if (other.Gender != 0)
			{
				Gender = other.Gender;
			}
			if (other.PlayerLevel != 0)
			{
				PlayerLevel = other.PlayerLevel;
			}
			if (other.PlayerWorldLevel != 0)
			{
				PlayerWorldLevel = other.PlayerWorldLevel;
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
				Gender = input.ReadInt32();
				break;
			case 32u:
				PlayerLevel = input.ReadInt32();
				break;
			case 40u:
				PlayerWorldLevel = input.ReadInt32();
				break;
			case 50u:
				Signature = input.ReadString();
				break;
			case 56u:
				AvatarId = input.ReadInt32();
				break;
			}
		}
	}
}
