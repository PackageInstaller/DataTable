using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierPotential : IMessage<SoldierPotential>, IMessage, IEquatable<SoldierPotential>, IDeepCloneable<SoldierPotential>
{
	private static readonly MessageParser<SoldierPotential> _parser = new MessageParser<SoldierPotential>(() => new SoldierPotential());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DesFieldNumber = 3;

	private string des_ = "";

	public const int IconFieldNumber = 4;

	private string icon_ = "";

	public const int CharacterIDFieldNumber = 5;

	private int characterID_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierPotential> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(782);

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
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Des
	{
		get
		{
			return des_;
		}
		set
		{
			des_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int CharacterID
	{
		get
		{
			return characterID_;
		}
		set
		{
			characterID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierPotential()
	{
	}

	[DebuggerNonUserCode]
	public SoldierPotential(SoldierPotential other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		des_ = other.des_;
		icon_ = other.icon_;
		characterID_ = other.characterID_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierPotential Clone()
	{
		return new SoldierPotential(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierPotential);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierPotential other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (Des != other.Des)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (CharacterID != other.CharacterID)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Des.Length != 0)
		{
			num ^= Des.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (CharacterID != 0)
		{
			num ^= CharacterID.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (Des.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Des);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Icon);
		}
		if (CharacterID != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(CharacterID);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Des.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Des);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (CharacterID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharacterID);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierPotential other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Des.Length != 0)
			{
				Des = other.Des;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.CharacterID != 0)
			{
				CharacterID = other.CharacterID;
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
			case 18u:
				Name = input.ReadString();
				break;
			case 26u:
				Des = input.ReadString();
				break;
			case 34u:
				Icon = input.ReadString();
				break;
			case 40u:
				CharacterID = input.ReadInt32();
				break;
			}
		}
	}
}
