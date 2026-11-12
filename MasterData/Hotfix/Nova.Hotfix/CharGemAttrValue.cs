using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharGemAttrValue : IMessage<CharGemAttrValue>, IMessage, IEquatable<CharGemAttrValue>, IDeepCloneable<CharGemAttrValue>
{
	private static readonly MessageParser<CharGemAttrValue> _parser = new MessageParser<CharGemAttrValue>(() => new CharGemAttrValue());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TypeIdFieldNumber = 2;

	private int typeId_;

	public const int AttrTypeFieldNumber = 3;

	private int attrType_;

	public const int AttrTypeFirstSubtypeFieldNumber = 4;

	private int attrTypeFirstSubtype_;

	public const int AttrTypeSecondSubtypeFieldNumber = 5;

	private int attrTypeSecondSubtype_;

	public const int ValueFieldNumber = 6;

	private string value_ = "";

	public const int RarityFieldNumber = 7;

	private int rarity_;

	public const int TagFieldNumber = 8;

	private int tag_;

	public const int EffectIdFieldNumber = 9;

	private int effectId_;

	public const int RareFieldNumber = 10;

	private bool rare_;

	public const int OverlockCountFieldNumber = 11;

	private int overlockCount_;

	public const int LevelFieldNumber = 12;

	private int level_;

	[DebuggerNonUserCode]
	public static MessageParser<CharGemAttrValue> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(188);

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
	public int TypeId
	{
		get
		{
			return typeId_;
		}
		set
		{
			typeId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AttrType
	{
		get
		{
			return attrType_;
		}
		set
		{
			attrType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AttrTypeFirstSubtype
	{
		get
		{
			return attrTypeFirstSubtype_;
		}
		set
		{
			attrTypeFirstSubtype_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AttrTypeSecondSubtype
	{
		get
		{
			return attrTypeSecondSubtype_;
		}
		set
		{
			attrTypeSecondSubtype_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Value
	{
		get
		{
			return value_;
		}
		set
		{
			value_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int Tag
	{
		get
		{
			return tag_;
		}
		set
		{
			tag_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EffectId
	{
		get
		{
			return effectId_;
		}
		set
		{
			effectId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Rare
	{
		get
		{
			return rare_;
		}
		set
		{
			rare_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int OverlockCount
	{
		get
		{
			return overlockCount_;
		}
		set
		{
			overlockCount_ = value;
		}
	}

	[DebuggerNonUserCode]
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
	public CharGemAttrValue()
	{
	}

	[DebuggerNonUserCode]
	public CharGemAttrValue(CharGemAttrValue other)
		: this()
	{
		id_ = other.id_;
		typeId_ = other.typeId_;
		attrType_ = other.attrType_;
		attrTypeFirstSubtype_ = other.attrTypeFirstSubtype_;
		attrTypeSecondSubtype_ = other.attrTypeSecondSubtype_;
		value_ = other.value_;
		rarity_ = other.rarity_;
		tag_ = other.tag_;
		effectId_ = other.effectId_;
		rare_ = other.rare_;
		overlockCount_ = other.overlockCount_;
		level_ = other.level_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharGemAttrValue Clone()
	{
		return new CharGemAttrValue(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharGemAttrValue);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharGemAttrValue other)
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
		if (TypeId != other.TypeId)
		{
			return false;
		}
		if (AttrType != other.AttrType)
		{
			return false;
		}
		if (AttrTypeFirstSubtype != other.AttrTypeFirstSubtype)
		{
			return false;
		}
		if (AttrTypeSecondSubtype != other.AttrTypeSecondSubtype)
		{
			return false;
		}
		if (Value != other.Value)
		{
			return false;
		}
		if (Rarity != other.Rarity)
		{
			return false;
		}
		if (Tag != other.Tag)
		{
			return false;
		}
		if (EffectId != other.EffectId)
		{
			return false;
		}
		if (Rare != other.Rare)
		{
			return false;
		}
		if (OverlockCount != other.OverlockCount)
		{
			return false;
		}
		if (Level != other.Level)
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
		if (TypeId != 0)
		{
			num ^= TypeId.GetHashCode();
		}
		if (AttrType != 0)
		{
			num ^= AttrType.GetHashCode();
		}
		if (AttrTypeFirstSubtype != 0)
		{
			num ^= AttrTypeFirstSubtype.GetHashCode();
		}
		if (AttrTypeSecondSubtype != 0)
		{
			num ^= AttrTypeSecondSubtype.GetHashCode();
		}
		if (Value.Length != 0)
		{
			num ^= Value.GetHashCode();
		}
		if (Rarity != 0)
		{
			num ^= Rarity.GetHashCode();
		}
		if (Tag != 0)
		{
			num ^= Tag.GetHashCode();
		}
		if (EffectId != 0)
		{
			num ^= EffectId.GetHashCode();
		}
		if (Rare)
		{
			num ^= Rare.GetHashCode();
		}
		if (OverlockCount != 0)
		{
			num ^= OverlockCount.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
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
		if (TypeId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(TypeId);
		}
		if (AttrType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(AttrType);
		}
		if (AttrTypeFirstSubtype != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(AttrTypeFirstSubtype);
		}
		if (AttrTypeSecondSubtype != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(AttrTypeSecondSubtype);
		}
		if (Value.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Value);
		}
		if (Rarity != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Rarity);
		}
		if (Tag != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Tag);
		}
		if (EffectId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(EffectId);
		}
		if (Rare)
		{
			output.WriteRawTag(80);
			output.WriteBool(Rare);
		}
		if (OverlockCount != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(OverlockCount);
		}
		if (Level != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(Level);
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
		if (TypeId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TypeId);
		}
		if (AttrType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AttrType);
		}
		if (AttrTypeFirstSubtype != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AttrTypeFirstSubtype);
		}
		if (AttrTypeSecondSubtype != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AttrTypeSecondSubtype);
		}
		if (Value.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Value);
		}
		if (Rarity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rarity);
		}
		if (Tag != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tag);
		}
		if (EffectId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectId);
		}
		if (Rare)
		{
			num += 2;
		}
		if (OverlockCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OverlockCount);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharGemAttrValue other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.TypeId != 0)
			{
				TypeId = other.TypeId;
			}
			if (other.AttrType != 0)
			{
				AttrType = other.AttrType;
			}
			if (other.AttrTypeFirstSubtype != 0)
			{
				AttrTypeFirstSubtype = other.AttrTypeFirstSubtype;
			}
			if (other.AttrTypeSecondSubtype != 0)
			{
				AttrTypeSecondSubtype = other.AttrTypeSecondSubtype;
			}
			if (other.Value.Length != 0)
			{
				Value = other.Value;
			}
			if (other.Rarity != 0)
			{
				Rarity = other.Rarity;
			}
			if (other.Tag != 0)
			{
				Tag = other.Tag;
			}
			if (other.EffectId != 0)
			{
				EffectId = other.EffectId;
			}
			if (other.Rare)
			{
				Rare = other.Rare;
			}
			if (other.OverlockCount != 0)
			{
				OverlockCount = other.OverlockCount;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
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
				TypeId = input.ReadInt32();
				break;
			case 24u:
				AttrType = input.ReadInt32();
				break;
			case 32u:
				AttrTypeFirstSubtype = input.ReadInt32();
				break;
			case 40u:
				AttrTypeSecondSubtype = input.ReadInt32();
				break;
			case 50u:
				Value = input.ReadString();
				break;
			case 56u:
				Rarity = input.ReadInt32();
				break;
			case 64u:
				Tag = input.ReadInt32();
				break;
			case 72u:
				EffectId = input.ReadInt32();
				break;
			case 80u:
				Rare = input.ReadBool();
				break;
			case 88u:
				OverlockCount = input.ReadInt32();
				break;
			case 96u:
				Level = input.ReadInt32();
				break;
			}
		}
	}
}
