using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class EffectValue : IMessage<EffectValue>, IMessage, IEquatable<EffectValue>, IDeepCloneable<EffectValue>
{
	private static readonly MessageParser<EffectValue> _parser = new MessageParser<EffectValue>(() => new EffectValue());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int TagFieldNumber = 3;

	private string tag_ = "";

	public const int TakeEffectLimitFieldNumber = 4;

	private int takeEffectLimit_;

	public const int RemoveFieldNumber = 5;

	private bool remove_;

	public const int CDFieldNumber = 6;

	private int cD_;

	public const int EffectRateFieldNumber = 7;

	private int effectRate_;

	public const int EffectTypeFieldNumber = 8;

	private int effectType_;

	public const int EffectTypeFirstSubtypeFieldNumber = 9;

	private int effectTypeFirstSubtype_;

	public const int EffectTypeSecondSubtypeFieldNumber = 10;

	private int effectTypeSecondSubtype_;

	public const int EffectTypeParam1FieldNumber = 11;

	private string effectTypeParam1_ = "";

	public const int EffectTypeParam2FieldNumber = 12;

	private string effectTypeParam2_ = "";

	public const int EffectTypeParam3FieldNumber = 13;

	private string effectTypeParam3_ = "";

	public const int EffectTypeParam4FieldNumber = 14;

	private string effectTypeParam4_ = "";

	public const int EffectTypeParam5FieldNumber = 15;

	private string effectTypeParam5_ = "";

	public const int EffectTypeParam6FieldNumber = 16;

	private string effectTypeParam6_ = "";

	public const int EffectTypeParam7FieldNumber = 17;

	private string effectTypeParam7_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<EffectValue> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(330);

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
	public string Tag
	{
		get
		{
			return tag_;
		}
		set
		{
			tag_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int TakeEffectLimit
	{
		get
		{
			return takeEffectLimit_;
		}
		set
		{
			takeEffectLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Remove
	{
		get
		{
			return remove_;
		}
		set
		{
			remove_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CD
	{
		get
		{
			return cD_;
		}
		set
		{
			cD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EffectRate
	{
		get
		{
			return effectRate_;
		}
		set
		{
			effectRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EffectType
	{
		get
		{
			return effectType_;
		}
		set
		{
			effectType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EffectTypeFirstSubtype
	{
		get
		{
			return effectTypeFirstSubtype_;
		}
		set
		{
			effectTypeFirstSubtype_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EffectTypeSecondSubtype
	{
		get
		{
			return effectTypeSecondSubtype_;
		}
		set
		{
			effectTypeSecondSubtype_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string EffectTypeParam1
	{
		get
		{
			return effectTypeParam1_;
		}
		set
		{
			effectTypeParam1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string EffectTypeParam2
	{
		get
		{
			return effectTypeParam2_;
		}
		set
		{
			effectTypeParam2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string EffectTypeParam3
	{
		get
		{
			return effectTypeParam3_;
		}
		set
		{
			effectTypeParam3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string EffectTypeParam4
	{
		get
		{
			return effectTypeParam4_;
		}
		set
		{
			effectTypeParam4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string EffectTypeParam5
	{
		get
		{
			return effectTypeParam5_;
		}
		set
		{
			effectTypeParam5_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string EffectTypeParam6
	{
		get
		{
			return effectTypeParam6_;
		}
		set
		{
			effectTypeParam6_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string EffectTypeParam7
	{
		get
		{
			return effectTypeParam7_;
		}
		set
		{
			effectTypeParam7_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public EffectValue()
	{
	}

	[DebuggerNonUserCode]
	public EffectValue(EffectValue other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		tag_ = other.tag_;
		takeEffectLimit_ = other.takeEffectLimit_;
		remove_ = other.remove_;
		cD_ = other.cD_;
		effectRate_ = other.effectRate_;
		effectType_ = other.effectType_;
		effectTypeFirstSubtype_ = other.effectTypeFirstSubtype_;
		effectTypeSecondSubtype_ = other.effectTypeSecondSubtype_;
		effectTypeParam1_ = other.effectTypeParam1_;
		effectTypeParam2_ = other.effectTypeParam2_;
		effectTypeParam3_ = other.effectTypeParam3_;
		effectTypeParam4_ = other.effectTypeParam4_;
		effectTypeParam5_ = other.effectTypeParam5_;
		effectTypeParam6_ = other.effectTypeParam6_;
		effectTypeParam7_ = other.effectTypeParam7_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public EffectValue Clone()
	{
		return new EffectValue(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as EffectValue);
	}

	[DebuggerNonUserCode]
	public bool Equals(EffectValue other)
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
		if (Tag != other.Tag)
		{
			return false;
		}
		if (TakeEffectLimit != other.TakeEffectLimit)
		{
			return false;
		}
		if (Remove != other.Remove)
		{
			return false;
		}
		if (CD != other.CD)
		{
			return false;
		}
		if (EffectRate != other.EffectRate)
		{
			return false;
		}
		if (EffectType != other.EffectType)
		{
			return false;
		}
		if (EffectTypeFirstSubtype != other.EffectTypeFirstSubtype)
		{
			return false;
		}
		if (EffectTypeSecondSubtype != other.EffectTypeSecondSubtype)
		{
			return false;
		}
		if (EffectTypeParam1 != other.EffectTypeParam1)
		{
			return false;
		}
		if (EffectTypeParam2 != other.EffectTypeParam2)
		{
			return false;
		}
		if (EffectTypeParam3 != other.EffectTypeParam3)
		{
			return false;
		}
		if (EffectTypeParam4 != other.EffectTypeParam4)
		{
			return false;
		}
		if (EffectTypeParam5 != other.EffectTypeParam5)
		{
			return false;
		}
		if (EffectTypeParam6 != other.EffectTypeParam6)
		{
			return false;
		}
		if (EffectTypeParam7 != other.EffectTypeParam7)
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
		if (Tag.Length != 0)
		{
			num ^= Tag.GetHashCode();
		}
		if (TakeEffectLimit != 0)
		{
			num ^= TakeEffectLimit.GetHashCode();
		}
		if (Remove)
		{
			num ^= Remove.GetHashCode();
		}
		if (CD != 0)
		{
			num ^= CD.GetHashCode();
		}
		if (EffectRate != 0)
		{
			num ^= EffectRate.GetHashCode();
		}
		if (EffectType != 0)
		{
			num ^= EffectType.GetHashCode();
		}
		if (EffectTypeFirstSubtype != 0)
		{
			num ^= EffectTypeFirstSubtype.GetHashCode();
		}
		if (EffectTypeSecondSubtype != 0)
		{
			num ^= EffectTypeSecondSubtype.GetHashCode();
		}
		if (EffectTypeParam1.Length != 0)
		{
			num ^= EffectTypeParam1.GetHashCode();
		}
		if (EffectTypeParam2.Length != 0)
		{
			num ^= EffectTypeParam2.GetHashCode();
		}
		if (EffectTypeParam3.Length != 0)
		{
			num ^= EffectTypeParam3.GetHashCode();
		}
		if (EffectTypeParam4.Length != 0)
		{
			num ^= EffectTypeParam4.GetHashCode();
		}
		if (EffectTypeParam5.Length != 0)
		{
			num ^= EffectTypeParam5.GetHashCode();
		}
		if (EffectTypeParam6.Length != 0)
		{
			num ^= EffectTypeParam6.GetHashCode();
		}
		if (EffectTypeParam7.Length != 0)
		{
			num ^= EffectTypeParam7.GetHashCode();
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
		if (Tag.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Tag);
		}
		if (TakeEffectLimit != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(TakeEffectLimit);
		}
		if (Remove)
		{
			output.WriteRawTag(40);
			output.WriteBool(Remove);
		}
		if (CD != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(CD);
		}
		if (EffectRate != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(EffectRate);
		}
		if (EffectType != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(EffectType);
		}
		if (EffectTypeFirstSubtype != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(EffectTypeFirstSubtype);
		}
		if (EffectTypeSecondSubtype != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(EffectTypeSecondSubtype);
		}
		if (EffectTypeParam1.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(EffectTypeParam1);
		}
		if (EffectTypeParam2.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(EffectTypeParam2);
		}
		if (EffectTypeParam3.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(EffectTypeParam3);
		}
		if (EffectTypeParam4.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(EffectTypeParam4);
		}
		if (EffectTypeParam5.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(EffectTypeParam5);
		}
		if (EffectTypeParam6.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(EffectTypeParam6);
		}
		if (EffectTypeParam7.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(EffectTypeParam7);
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
		if (Tag.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Tag);
		}
		if (TakeEffectLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TakeEffectLimit);
		}
		if (Remove)
		{
			num += 2;
		}
		if (CD != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CD);
		}
		if (EffectRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectRate);
		}
		if (EffectType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectType);
		}
		if (EffectTypeFirstSubtype != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectTypeFirstSubtype);
		}
		if (EffectTypeSecondSubtype != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectTypeSecondSubtype);
		}
		if (EffectTypeParam1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EffectTypeParam1);
		}
		if (EffectTypeParam2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EffectTypeParam2);
		}
		if (EffectTypeParam3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EffectTypeParam3);
		}
		if (EffectTypeParam4.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EffectTypeParam4);
		}
		if (EffectTypeParam5.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EffectTypeParam5);
		}
		if (EffectTypeParam6.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(EffectTypeParam6);
		}
		if (EffectTypeParam7.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(EffectTypeParam7);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(EffectValue other)
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
			if (other.Tag.Length != 0)
			{
				Tag = other.Tag;
			}
			if (other.TakeEffectLimit != 0)
			{
				TakeEffectLimit = other.TakeEffectLimit;
			}
			if (other.Remove)
			{
				Remove = other.Remove;
			}
			if (other.CD != 0)
			{
				CD = other.CD;
			}
			if (other.EffectRate != 0)
			{
				EffectRate = other.EffectRate;
			}
			if (other.EffectType != 0)
			{
				EffectType = other.EffectType;
			}
			if (other.EffectTypeFirstSubtype != 0)
			{
				EffectTypeFirstSubtype = other.EffectTypeFirstSubtype;
			}
			if (other.EffectTypeSecondSubtype != 0)
			{
				EffectTypeSecondSubtype = other.EffectTypeSecondSubtype;
			}
			if (other.EffectTypeParam1.Length != 0)
			{
				EffectTypeParam1 = other.EffectTypeParam1;
			}
			if (other.EffectTypeParam2.Length != 0)
			{
				EffectTypeParam2 = other.EffectTypeParam2;
			}
			if (other.EffectTypeParam3.Length != 0)
			{
				EffectTypeParam3 = other.EffectTypeParam3;
			}
			if (other.EffectTypeParam4.Length != 0)
			{
				EffectTypeParam4 = other.EffectTypeParam4;
			}
			if (other.EffectTypeParam5.Length != 0)
			{
				EffectTypeParam5 = other.EffectTypeParam5;
			}
			if (other.EffectTypeParam6.Length != 0)
			{
				EffectTypeParam6 = other.EffectTypeParam6;
			}
			if (other.EffectTypeParam7.Length != 0)
			{
				EffectTypeParam7 = other.EffectTypeParam7;
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
				Tag = input.ReadString();
				break;
			case 32u:
				TakeEffectLimit = input.ReadInt32();
				break;
			case 40u:
				Remove = input.ReadBool();
				break;
			case 48u:
				CD = input.ReadInt32();
				break;
			case 56u:
				EffectRate = input.ReadInt32();
				break;
			case 64u:
				EffectType = input.ReadInt32();
				break;
			case 72u:
				EffectTypeFirstSubtype = input.ReadInt32();
				break;
			case 80u:
				EffectTypeSecondSubtype = input.ReadInt32();
				break;
			case 90u:
				EffectTypeParam1 = input.ReadString();
				break;
			case 98u:
				EffectTypeParam2 = input.ReadString();
				break;
			case 106u:
				EffectTypeParam3 = input.ReadString();
				break;
			case 114u:
				EffectTypeParam4 = input.ReadString();
				break;
			case 122u:
				EffectTypeParam5 = input.ReadString();
				break;
			case 130u:
				EffectTypeParam6 = input.ReadString();
				break;
			case 138u:
				EffectTypeParam7 = input.ReadString();
				break;
			}
		}
	}
}
