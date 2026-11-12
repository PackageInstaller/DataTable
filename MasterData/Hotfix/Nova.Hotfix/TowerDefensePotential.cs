using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TowerDefensePotential : IMessage<TowerDefensePotential>, IMessage, IEquatable<TowerDefensePotential>, IDeepCloneable<TowerDefensePotential>
{
	private static readonly MessageParser<TowerDefensePotential> _parser = new MessageParser<TowerDefensePotential>(() => new TowerDefensePotential());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int IconFieldNumber = 3;

	private string icon_ = "";

	public const int RarityFieldNumber = 4;

	private int rarity_;

	public const int Effect1FieldNumber = 5;

	private int effect1_;

	public const int Effect2FieldNumber = 6;

	private int effect2_;

	public const int Effect3FieldNumber = 7;

	private int effect3_;

	public const int Effect4FieldNumber = 8;

	private int effect4_;

	public const int PotentialDesFieldNumber = 9;

	private string potentialDes_ = "";

	public const int Param1FieldNumber = 10;

	private string param1_ = "";

	public const int Param2FieldNumber = 11;

	private string param2_ = "";

	public const int Param3FieldNumber = 12;

	private string param3_ = "";

	public const int Param4FieldNumber = 13;

	private string param4_ = "";

	public const int Param5FieldNumber = 14;

	private string param5_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<TowerDefensePotential> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(964);

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
	public int Rarity
	{
		get
		{
			return rarity_;
		}
		set
		{
			rarity_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Effect1
	{
		get
		{
			return effect1_;
		}
		set
		{
			effect1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Effect2
	{
		get
		{
			return effect2_;
		}
		set
		{
			effect2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Effect3
	{
		get
		{
			return effect3_;
		}
		set
		{
			effect3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Effect4
	{
		get
		{
			return effect4_;
		}
		set
		{
			effect4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string PotentialDes
	{
		get
		{
			return potentialDes_;
		}
		set
		{
			potentialDes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param1
	{
		get
		{
			return param1_;
		}
		set
		{
			param1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param2
	{
		get
		{
			return param2_;
		}
		set
		{
			param2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param3
	{
		get
		{
			return param3_;
		}
		set
		{
			param3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param4
	{
		get
		{
			return param4_;
		}
		set
		{
			param4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param5
	{
		get
		{
			return param5_;
		}
		set
		{
			param5_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public TowerDefensePotential()
	{
	}

	[DebuggerNonUserCode]
	public TowerDefensePotential(TowerDefensePotential other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		icon_ = other.icon_;
		rarity_ = other.rarity_;
		effect1_ = other.effect1_;
		effect2_ = other.effect2_;
		effect3_ = other.effect3_;
		effect4_ = other.effect4_;
		potentialDes_ = other.potentialDes_;
		param1_ = other.param1_;
		param2_ = other.param2_;
		param3_ = other.param3_;
		param4_ = other.param4_;
		param5_ = other.param5_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TowerDefensePotential Clone()
	{
		return new TowerDefensePotential(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TowerDefensePotential);
	}

	[DebuggerNonUserCode]
	public bool Equals(TowerDefensePotential other)
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
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Rarity != other.Rarity)
		{
			return false;
		}
		if (Effect1 != other.Effect1)
		{
			return false;
		}
		if (Effect2 != other.Effect2)
		{
			return false;
		}
		if (Effect3 != other.Effect3)
		{
			return false;
		}
		if (Effect4 != other.Effect4)
		{
			return false;
		}
		if (PotentialDes != other.PotentialDes)
		{
			return false;
		}
		if (Param1 != other.Param1)
		{
			return false;
		}
		if (Param2 != other.Param2)
		{
			return false;
		}
		if (Param3 != other.Param3)
		{
			return false;
		}
		if (Param4 != other.Param4)
		{
			return false;
		}
		if (Param5 != other.Param5)
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
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Rarity != 0)
		{
			num ^= Rarity.GetHashCode();
		}
		if (Effect1 != 0)
		{
			num ^= Effect1.GetHashCode();
		}
		if (Effect2 != 0)
		{
			num ^= Effect2.GetHashCode();
		}
		if (Effect3 != 0)
		{
			num ^= Effect3.GetHashCode();
		}
		if (Effect4 != 0)
		{
			num ^= Effect4.GetHashCode();
		}
		if (PotentialDes.Length != 0)
		{
			num ^= PotentialDes.GetHashCode();
		}
		if (Param1.Length != 0)
		{
			num ^= Param1.GetHashCode();
		}
		if (Param2.Length != 0)
		{
			num ^= Param2.GetHashCode();
		}
		if (Param3.Length != 0)
		{
			num ^= Param3.GetHashCode();
		}
		if (Param4.Length != 0)
		{
			num ^= Param4.GetHashCode();
		}
		if (Param5.Length != 0)
		{
			num ^= Param5.GetHashCode();
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
		if (Icon.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Icon);
		}
		if (Rarity != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Rarity);
		}
		if (Effect1 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Effect1);
		}
		if (Effect2 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Effect2);
		}
		if (Effect3 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Effect3);
		}
		if (Effect4 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Effect4);
		}
		if (PotentialDes.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(PotentialDes);
		}
		if (Param1.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(Param1);
		}
		if (Param2.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Param2);
		}
		if (Param3.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(Param3);
		}
		if (Param4.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(Param4);
		}
		if (Param5.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(Param5);
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
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Rarity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rarity);
		}
		if (Effect1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Effect1);
		}
		if (Effect2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Effect2);
		}
		if (Effect3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Effect3);
		}
		if (Effect4 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Effect4);
		}
		if (PotentialDes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PotentialDes);
		}
		if (Param1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param1);
		}
		if (Param2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param2);
		}
		if (Param3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param3);
		}
		if (Param4.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param4);
		}
		if (Param5.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param5);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TowerDefensePotential other)
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
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Rarity != 0)
			{
				Rarity = other.Rarity;
			}
			if (other.Effect1 != 0)
			{
				Effect1 = other.Effect1;
			}
			if (other.Effect2 != 0)
			{
				Effect2 = other.Effect2;
			}
			if (other.Effect3 != 0)
			{
				Effect3 = other.Effect3;
			}
			if (other.Effect4 != 0)
			{
				Effect4 = other.Effect4;
			}
			if (other.PotentialDes.Length != 0)
			{
				PotentialDes = other.PotentialDes;
			}
			if (other.Param1.Length != 0)
			{
				Param1 = other.Param1;
			}
			if (other.Param2.Length != 0)
			{
				Param2 = other.Param2;
			}
			if (other.Param3.Length != 0)
			{
				Param3 = other.Param3;
			}
			if (other.Param4.Length != 0)
			{
				Param4 = other.Param4;
			}
			if (other.Param5.Length != 0)
			{
				Param5 = other.Param5;
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
				Icon = input.ReadString();
				break;
			case 32u:
				Rarity = input.ReadInt32();
				break;
			case 40u:
				Effect1 = input.ReadInt32();
				break;
			case 48u:
				Effect2 = input.ReadInt32();
				break;
			case 56u:
				Effect3 = input.ReadInt32();
				break;
			case 64u:
				Effect4 = input.ReadInt32();
				break;
			case 74u:
				PotentialDes = input.ReadString();
				break;
			case 82u:
				Param1 = input.ReadString();
				break;
			case 90u:
				Param2 = input.ReadString();
				break;
			case 98u:
				Param3 = input.ReadString();
				break;
			case 106u:
				Param4 = input.ReadString();
				break;
			case 114u:
				Param5 = input.ReadString();
				break;
			}
		}
	}
}
