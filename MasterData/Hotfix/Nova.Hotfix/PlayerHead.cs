using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PlayerHead : IMessage<PlayerHead>, IMessage, IEquatable<PlayerHead>, IDeepCloneable<PlayerHead>
{
	private static readonly MessageParser<PlayerHead> _parser = new MessageParser<PlayerHead>(() => new PlayerHead());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int HeadTypeFieldNumber = 2;

	private int headType_;

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int IsShowFieldNumber = 4;

	private bool isShow_;

	public const int IsLockShowFieldNumber = 5;

	private bool isLockShow_;

	public const int UnlockCharFieldNumber = 6;

	private int unlockChar_;

	public const int UnlockSkinFieldNumber = 7;

	private int unlockSkin_;

	public const int GenderFieldNumber = 8;

	private bool gender_;

	public const int GenderGroupFieldNumber = 9;

	private int genderGroup_;

	public const int TrIdFieldNumber = 10;

	private int trId_;

	public const int TrQtyFieldNumber = 11;

	private int trQty_;

	public const int IconFieldNumber = 12;

	private string icon_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<PlayerHead> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(650);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Id
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
	public int HeadType
	{
		get
		{
			return headType_;
		}
		set
		{
			headType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Desc
	{
		get
		{
			return desc_;
		}
		set
		{
			desc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool IsShow
	{
		get
		{
			return isShow_;
		}
		set
		{
			isShow_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsLockShow
	{
		get
		{
			return isLockShow_;
		}
		set
		{
			isLockShow_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UnlockChar
	{
		get
		{
			return unlockChar_;
		}
		set
		{
			unlockChar_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UnlockSkin
	{
		get
		{
			return unlockSkin_;
		}
		set
		{
			unlockSkin_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Gender
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
	public int GenderGroup
	{
		get
		{
			return genderGroup_;
		}
		set
		{
			genderGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TrId
	{
		get
		{
			return trId_;
		}
		set
		{
			trId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TrQty
	{
		get
		{
			return trQty_;
		}
		set
		{
			trQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public PlayerHead()
	{
	}

	[DebuggerNonUserCode]
	public PlayerHead(PlayerHead other)
		: this()
	{
		id_ = other.id_;
		headType_ = other.headType_;
		desc_ = other.desc_;
		isShow_ = other.isShow_;
		isLockShow_ = other.isLockShow_;
		unlockChar_ = other.unlockChar_;
		unlockSkin_ = other.unlockSkin_;
		gender_ = other.gender_;
		genderGroup_ = other.genderGroup_;
		trId_ = other.trId_;
		trQty_ = other.trQty_;
		icon_ = other.icon_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PlayerHead Clone()
	{
		return new PlayerHead(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PlayerHead);
	}

	[DebuggerNonUserCode]
	public bool Equals(PlayerHead other)
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
		if (HeadType != other.HeadType)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (IsShow != other.IsShow)
		{
			return false;
		}
		if (IsLockShow != other.IsLockShow)
		{
			return false;
		}
		if (UnlockChar != other.UnlockChar)
		{
			return false;
		}
		if (UnlockSkin != other.UnlockSkin)
		{
			return false;
		}
		if (Gender != other.Gender)
		{
			return false;
		}
		if (GenderGroup != other.GenderGroup)
		{
			return false;
		}
		if (TrId != other.TrId)
		{
			return false;
		}
		if (TrQty != other.TrQty)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (HeadType != 0)
		{
			num ^= HeadType.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (IsShow)
		{
			num ^= IsShow.GetHashCode();
		}
		if (IsLockShow)
		{
			num ^= IsLockShow.GetHashCode();
		}
		if (UnlockChar != 0)
		{
			num ^= UnlockChar.GetHashCode();
		}
		if (UnlockSkin != 0)
		{
			num ^= UnlockSkin.GetHashCode();
		}
		if (Gender)
		{
			num ^= Gender.GetHashCode();
		}
		if (GenderGroup != 0)
		{
			num ^= GenderGroup.GetHashCode();
		}
		if (TrId != 0)
		{
			num ^= TrId.GetHashCode();
		}
		if (TrQty != 0)
		{
			num ^= TrQty.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (HeadType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(HeadType);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Desc);
		}
		if (IsShow)
		{
			output.WriteRawTag(32);
			output.WriteBool(IsShow);
		}
		if (IsLockShow)
		{
			output.WriteRawTag(40);
			output.WriteBool(IsLockShow);
		}
		if (UnlockChar != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(UnlockChar);
		}
		if (UnlockSkin != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(UnlockSkin);
		}
		if (Gender)
		{
			output.WriteRawTag(64);
			output.WriteBool(Gender);
		}
		if (GenderGroup != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(GenderGroup);
		}
		if (TrId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(TrId);
		}
		if (TrQty != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(TrQty);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(Icon);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (HeadType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HeadType);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (IsShow)
		{
			num += 2;
		}
		if (IsLockShow)
		{
			num += 2;
		}
		if (UnlockChar != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockChar);
		}
		if (UnlockSkin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockSkin);
		}
		if (Gender)
		{
			num += 2;
		}
		if (GenderGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GenderGroup);
		}
		if (TrId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TrId);
		}
		if (TrQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TrQty);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PlayerHead other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.HeadType != 0)
			{
				HeadType = other.HeadType;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.IsShow)
			{
				IsShow = other.IsShow;
			}
			if (other.IsLockShow)
			{
				IsLockShow = other.IsLockShow;
			}
			if (other.UnlockChar != 0)
			{
				UnlockChar = other.UnlockChar;
			}
			if (other.UnlockSkin != 0)
			{
				UnlockSkin = other.UnlockSkin;
			}
			if (other.Gender)
			{
				Gender = other.Gender;
			}
			if (other.GenderGroup != 0)
			{
				GenderGroup = other.GenderGroup;
			}
			if (other.TrId != 0)
			{
				TrId = other.TrId;
			}
			if (other.TrQty != 0)
			{
				TrQty = other.TrQty;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 16u:
				HeadType = input.ReadInt32();
				break;
			case 26u:
				Desc = input.ReadString();
				break;
			case 32u:
				IsShow = input.ReadBool();
				break;
			case 40u:
				IsLockShow = input.ReadBool();
				break;
			case 48u:
				UnlockChar = input.ReadInt32();
				break;
			case 56u:
				UnlockSkin = input.ReadInt32();
				break;
			case 64u:
				Gender = input.ReadBool();
				break;
			case 72u:
				GenderGroup = input.ReadInt32();
				break;
			case 80u:
				TrId = input.ReadInt32();
				break;
			case 88u:
				TrQty = input.ReadInt32();
				break;
			case 98u:
				Icon = input.ReadString();
				break;
			}
		}
	}
}
