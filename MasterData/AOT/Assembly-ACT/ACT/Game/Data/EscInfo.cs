using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class EscInfo : IMessage<EscInfo>, IMessage, IEquatable<EscInfo>, IDeepCloneable<EscInfo>, IBufferMessage
{
	private static readonly MessageParser<EscInfo> _parser = new MessageParser<EscInfo>(() => new EscInfo());

	private UnknownFieldSet _unknownFields;

	public const int AccountIdFieldNumber = 1;

	private long accountId_;

	public const int NickNameFieldNumber = 2;

	private string nickName_ = "";

	public const int SignatureFieldNumber = 3;

	private string signature_ = "";

	public const int AvatarIdsFieldNumber = 4;

	private static readonly MapField<int, bool>.Codec _map_avatarIds_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 34u);

	private readonly MapField<int, bool> avatarIds_ = new MapField<int, bool>();

	public const int CurAvatarIdFieldNumber = 5;

	private int curAvatarId_;

	public const int AvatarFrameIdsFieldNumber = 6;

	private static readonly MapField<int, bool>.Codec _map_avatarFrameIds_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 50u);

	private readonly MapField<int, bool> avatarFrameIds_ = new MapField<int, bool>();

	public const int CurAvatarFrameIdFieldNumber = 7;

	private int curAvatarFrameId_;

	public const int TitleIdsFieldNumber = 8;

	private static readonly MapField<int, bool>.Codec _map_titleIds_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 66u);

	private readonly MapField<int, bool> titleIds_ = new MapField<int, bool>();

	public const int CurTitleIdFieldNumber = 9;

	private int curTitleId_;

	public const int ShowCharacterIdsFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_showCharacterIds_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> showCharacterIds_ = new RepeatedField<int>();

	public const int ChangeNameTimeFieldNumber = 11;

	private long changeNameTime_;

	public const int ChangeSignatureTimeFieldNumber = 12;

	private long changeSignatureTime_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<EscInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[58];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public MapField<int, bool> AvatarIds => avatarIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CurAvatarId
	{
		get
		{
			return curAvatarId_;
		}
		set
		{
			curAvatarId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> AvatarFrameIds => avatarFrameIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CurAvatarFrameId
	{
		get
		{
			return curAvatarFrameId_;
		}
		set
		{
			curAvatarFrameId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> TitleIds => titleIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CurTitleId
	{
		get
		{
			return curTitleId_;
		}
		set
		{
			curTitleId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> ShowCharacterIds => showCharacterIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long ChangeNameTime
	{
		get
		{
			return changeNameTime_;
		}
		set
		{
			changeNameTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long ChangeSignatureTime
	{
		get
		{
			return changeSignatureTime_;
		}
		set
		{
			changeSignatureTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EscInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EscInfo(EscInfo other)
		: this()
	{
		accountId_ = other.accountId_;
		nickName_ = other.nickName_;
		signature_ = other.signature_;
		avatarIds_ = other.avatarIds_.Clone();
		curAvatarId_ = other.curAvatarId_;
		avatarFrameIds_ = other.avatarFrameIds_.Clone();
		curAvatarFrameId_ = other.curAvatarFrameId_;
		titleIds_ = other.titleIds_.Clone();
		curTitleId_ = other.curTitleId_;
		showCharacterIds_ = other.showCharacterIds_.Clone();
		changeNameTime_ = other.changeNameTime_;
		changeSignatureTime_ = other.changeSignatureTime_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EscInfo Clone()
	{
		return new EscInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as EscInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(EscInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (AccountId != other.AccountId)
		{
			return false;
		}
		if (NickName != other.NickName)
		{
			return false;
		}
		if (Signature != other.Signature)
		{
			return false;
		}
		if (!AvatarIds.Equals(other.AvatarIds))
		{
			return false;
		}
		if (CurAvatarId != other.CurAvatarId)
		{
			return false;
		}
		if (!AvatarFrameIds.Equals(other.AvatarFrameIds))
		{
			return false;
		}
		if (CurAvatarFrameId != other.CurAvatarFrameId)
		{
			return false;
		}
		if (!TitleIds.Equals(other.TitleIds))
		{
			return false;
		}
		if (CurTitleId != other.CurTitleId)
		{
			return false;
		}
		if (!showCharacterIds_.Equals(other.showCharacterIds_))
		{
			return false;
		}
		if (ChangeNameTime != other.ChangeNameTime)
		{
			return false;
		}
		if (ChangeSignatureTime != other.ChangeSignatureTime)
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
		if (AccountId != 0L)
		{
			num ^= AccountId.GetHashCode();
		}
		if (NickName.Length != 0)
		{
			num ^= NickName.GetHashCode();
		}
		if (Signature.Length != 0)
		{
			num ^= Signature.GetHashCode();
		}
		num ^= AvatarIds.GetHashCode();
		if (CurAvatarId != 0)
		{
			num ^= CurAvatarId.GetHashCode();
		}
		num ^= AvatarFrameIds.GetHashCode();
		if (CurAvatarFrameId != 0)
		{
			num ^= CurAvatarFrameId.GetHashCode();
		}
		num ^= TitleIds.GetHashCode();
		if (CurTitleId != 0)
		{
			num ^= CurTitleId.GetHashCode();
		}
		num ^= showCharacterIds_.GetHashCode();
		if (ChangeNameTime != 0L)
		{
			num ^= ChangeNameTime.GetHashCode();
		}
		if (ChangeSignatureTime != 0L)
		{
			num ^= ChangeSignatureTime.GetHashCode();
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
		if (AccountId != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(AccountId);
		}
		if (NickName.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(NickName);
		}
		if (Signature.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Signature);
		}
		avatarIds_.WriteTo(ref output, _map_avatarIds_codec);
		if (CurAvatarId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(CurAvatarId);
		}
		avatarFrameIds_.WriteTo(ref output, _map_avatarFrameIds_codec);
		if (CurAvatarFrameId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(CurAvatarFrameId);
		}
		titleIds_.WriteTo(ref output, _map_titleIds_codec);
		if (CurTitleId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(CurTitleId);
		}
		showCharacterIds_.WriteTo(ref output, _repeated_showCharacterIds_codec);
		if (ChangeNameTime != 0L)
		{
			output.WriteRawTag(88);
			output.WriteInt64(ChangeNameTime);
		}
		if (ChangeSignatureTime != 0L)
		{
			output.WriteRawTag(96);
			output.WriteInt64(ChangeSignatureTime);
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
		if (AccountId != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(AccountId);
		}
		if (NickName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(NickName);
		}
		if (Signature.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Signature);
		}
		num += avatarIds_.CalculateSize(_map_avatarIds_codec);
		if (CurAvatarId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurAvatarId);
		}
		num += avatarFrameIds_.CalculateSize(_map_avatarFrameIds_codec);
		if (CurAvatarFrameId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurAvatarFrameId);
		}
		num += titleIds_.CalculateSize(_map_titleIds_codec);
		if (CurTitleId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurTitleId);
		}
		num += showCharacterIds_.CalculateSize(_repeated_showCharacterIds_codec);
		if (ChangeNameTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(ChangeNameTime);
		}
		if (ChangeSignatureTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(ChangeSignatureTime);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(EscInfo other)
	{
		if (other != null)
		{
			if (other.AccountId != 0L)
			{
				AccountId = other.AccountId;
			}
			if (other.NickName.Length != 0)
			{
				NickName = other.NickName;
			}
			if (other.Signature.Length != 0)
			{
				Signature = other.Signature;
			}
			avatarIds_.Add(other.avatarIds_);
			if (other.CurAvatarId != 0)
			{
				CurAvatarId = other.CurAvatarId;
			}
			avatarFrameIds_.Add(other.avatarFrameIds_);
			if (other.CurAvatarFrameId != 0)
			{
				CurAvatarFrameId = other.CurAvatarFrameId;
			}
			titleIds_.Add(other.titleIds_);
			if (other.CurTitleId != 0)
			{
				CurTitleId = other.CurTitleId;
			}
			showCharacterIds_.Add(other.showCharacterIds_);
			if (other.ChangeNameTime != 0L)
			{
				ChangeNameTime = other.ChangeNameTime;
			}
			if (other.ChangeSignatureTime != 0L)
			{
				ChangeSignatureTime = other.ChangeSignatureTime;
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
				AccountId = input.ReadInt64();
				break;
			case 18u:
				NickName = input.ReadString();
				break;
			case 26u:
				Signature = input.ReadString();
				break;
			case 34u:
				avatarIds_.AddEntriesFrom(ref input, _map_avatarIds_codec);
				break;
			case 40u:
				CurAvatarId = input.ReadInt32();
				break;
			case 50u:
				avatarFrameIds_.AddEntriesFrom(ref input, _map_avatarFrameIds_codec);
				break;
			case 56u:
				CurAvatarFrameId = input.ReadInt32();
				break;
			case 66u:
				titleIds_.AddEntriesFrom(ref input, _map_titleIds_codec);
				break;
			case 72u:
				CurTitleId = input.ReadInt32();
				break;
			case 80u:
			case 82u:
				showCharacterIds_.AddEntriesFrom(ref input, _repeated_showCharacterIds_codec);
				break;
			case 88u:
				ChangeNameTime = input.ReadInt64();
				break;
			case 96u:
				ChangeSignatureTime = input.ReadInt64();
				break;
			}
		}
	}

	public void UpdateAvatars(RepeatedField<int> getAvatars)
	{
		avatarIds_.Clear();
		foreach (int getAvatar in getAvatars)
		{
			avatarIds_[getAvatar] = true;
		}
	}

	public void UpdateAvatarFrames(RepeatedField<int> getAvatarFrames)
	{
		avatarFrameIds_.Clear();
		foreach (int getAvatarFrame in getAvatarFrames)
		{
			avatarFrameIds_[getAvatarFrame] = true;
		}
	}

	public void UpdateTitles(RepeatedField<int> getTitles)
	{
		titleIds_.Clear();
		foreach (int getTitle in getTitles)
		{
			titleIds_[getTitle] = true;
		}
	}
}
