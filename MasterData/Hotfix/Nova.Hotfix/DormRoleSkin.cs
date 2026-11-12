using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DormRoleSkin : IMessage<DormRoleSkin>, IMessage, IEquatable<DormRoleSkin>, IDeepCloneable<DormRoleSkin>
{
	private static readonly MessageParser<DormRoleSkin> _parser = new MessageParser<DormRoleSkin>(() => new DormRoleSkin());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int RoleTypeFieldNumber = 2;

	private int roleType_;

	public const int ModelSDFieldNumber = 3;

	private string modelSD_ = "";

	public const int UnlockCharFieldNumber = 4;

	private int unlockChar_;

	public const int TrIdFieldNumber = 5;

	private int trId_;

	public const int TrQtyFieldNumber = 6;

	private int trQty_;

	public const int IconFieldNumber = 7;

	private string icon_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<DormRoleSkin> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(306);

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
	public int RoleType
	{
		get
		{
			return roleType_;
		}
		set
		{
			roleType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ModelSD
	{
		get
		{
			return modelSD_;
		}
		set
		{
			modelSD_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public DormRoleSkin()
	{
	}

	[DebuggerNonUserCode]
	public DormRoleSkin(DormRoleSkin other)
		: this()
	{
		id_ = other.id_;
		roleType_ = other.roleType_;
		modelSD_ = other.modelSD_;
		unlockChar_ = other.unlockChar_;
		trId_ = other.trId_;
		trQty_ = other.trQty_;
		icon_ = other.icon_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DormRoleSkin Clone()
	{
		return new DormRoleSkin(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DormRoleSkin);
	}

	[DebuggerNonUserCode]
	public bool Equals(DormRoleSkin other)
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
		if (RoleType != other.RoleType)
		{
			return false;
		}
		if (ModelSD != other.ModelSD)
		{
			return false;
		}
		if (UnlockChar != other.UnlockChar)
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
		if (RoleType != 0)
		{
			num ^= RoleType.GetHashCode();
		}
		if (ModelSD.Length != 0)
		{
			num ^= ModelSD.GetHashCode();
		}
		if (UnlockChar != 0)
		{
			num ^= UnlockChar.GetHashCode();
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
		if (RoleType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(RoleType);
		}
		if (ModelSD.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(ModelSD);
		}
		if (UnlockChar != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(UnlockChar);
		}
		if (TrId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(TrId);
		}
		if (TrQty != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(TrQty);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(58);
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
		if (RoleType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RoleType);
		}
		if (ModelSD.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ModelSD);
		}
		if (UnlockChar != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockChar);
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
	public void MergeFrom(DormRoleSkin other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.RoleType != 0)
			{
				RoleType = other.RoleType;
			}
			if (other.ModelSD.Length != 0)
			{
				ModelSD = other.ModelSD;
			}
			if (other.UnlockChar != 0)
			{
				UnlockChar = other.UnlockChar;
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
				RoleType = input.ReadInt32();
				break;
			case 26u:
				ModelSD = input.ReadString();
				break;
			case 32u:
				UnlockChar = input.ReadInt32();
				break;
			case 40u:
				TrId = input.ReadInt32();
				break;
			case 48u:
				TrQty = input.ReadInt32();
				break;
			case 58u:
				Icon = input.ReadString();
				break;
			}
		}
	}
}
