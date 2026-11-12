using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class EffectDesc : IMessage<EffectDesc>, IMessage, IEquatable<EffectDesc>, IDeepCloneable<EffectDesc>
{
	private static readonly MessageParser<EffectDesc> _parser = new MessageParser<EffectDesc>(() => new EffectDesc());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TypeIDFieldNumber = 2;

	private int typeID_;

	public const int Type2IDFieldNumber = 3;

	private int type2ID_;

	public const int DescFieldNumber = 4;

	private string desc_ = "";

	public const int RandomAttrDescFieldNumber = 5;

	private string randomAttrDesc_ = "";

	public const int AttributeFieldNumber = 6;

	private string attribute_ = "";

	public const int WordIDFieldNumber = 7;

	private int wordID_;

	public const int IsPercentFieldNumber = 8;

	private bool isPercent_;

	public const int IconFieldNumber = 9;

	private string icon_ = "";

	public const int FormatFieldNumber = 10;

	private int format_;

	[DebuggerNonUserCode]
	public static MessageParser<EffectDesc> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(328);

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
	public int TypeID
	{
		get
		{
			return typeID_;
		}
		set
		{
			typeID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Type2ID
	{
		get
		{
			return type2ID_;
		}
		set
		{
			type2ID_ = value;
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
	public string RandomAttrDesc
	{
		get
		{
			return randomAttrDesc_;
		}
		set
		{
			randomAttrDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Attribute
	{
		get
		{
			return attribute_;
		}
		set
		{
			attribute_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int WordID
	{
		get
		{
			return wordID_;
		}
		set
		{
			wordID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsPercent
	{
		get
		{
			return isPercent_;
		}
		set
		{
			isPercent_ = value;
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
	public int Format
	{
		get
		{
			return format_;
		}
		set
		{
			format_ = value;
		}
	}

	[DebuggerNonUserCode]
	public EffectDesc()
	{
	}

	[DebuggerNonUserCode]
	public EffectDesc(EffectDesc other)
		: this()
	{
		id_ = other.id_;
		typeID_ = other.typeID_;
		type2ID_ = other.type2ID_;
		desc_ = other.desc_;
		randomAttrDesc_ = other.randomAttrDesc_;
		attribute_ = other.attribute_;
		wordID_ = other.wordID_;
		isPercent_ = other.isPercent_;
		icon_ = other.icon_;
		format_ = other.format_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public EffectDesc Clone()
	{
		return new EffectDesc(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as EffectDesc);
	}

	[DebuggerNonUserCode]
	public bool Equals(EffectDesc other)
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
		if (TypeID != other.TypeID)
		{
			return false;
		}
		if (Type2ID != other.Type2ID)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (RandomAttrDesc != other.RandomAttrDesc)
		{
			return false;
		}
		if (Attribute != other.Attribute)
		{
			return false;
		}
		if (WordID != other.WordID)
		{
			return false;
		}
		if (IsPercent != other.IsPercent)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Format != other.Format)
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
		if (TypeID != 0)
		{
			num ^= TypeID.GetHashCode();
		}
		if (Type2ID != 0)
		{
			num ^= Type2ID.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (RandomAttrDesc.Length != 0)
		{
			num ^= RandomAttrDesc.GetHashCode();
		}
		if (Attribute.Length != 0)
		{
			num ^= Attribute.GetHashCode();
		}
		if (WordID != 0)
		{
			num ^= WordID.GetHashCode();
		}
		if (IsPercent)
		{
			num ^= IsPercent.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Format != 0)
		{
			num ^= Format.GetHashCode();
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
		if (TypeID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(TypeID);
		}
		if (Type2ID != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Type2ID);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Desc);
		}
		if (RandomAttrDesc.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(RandomAttrDesc);
		}
		if (Attribute.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Attribute);
		}
		if (WordID != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(WordID);
		}
		if (IsPercent)
		{
			output.WriteRawTag(64);
			output.WriteBool(IsPercent);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Icon);
		}
		if (Format != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Format);
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
		if (TypeID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TypeID);
		}
		if (Type2ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type2ID);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (RandomAttrDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RandomAttrDesc);
		}
		if (Attribute.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Attribute);
		}
		if (WordID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WordID);
		}
		if (IsPercent)
		{
			num += 2;
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Format != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Format);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(EffectDesc other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.TypeID != 0)
			{
				TypeID = other.TypeID;
			}
			if (other.Type2ID != 0)
			{
				Type2ID = other.Type2ID;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.RandomAttrDesc.Length != 0)
			{
				RandomAttrDesc = other.RandomAttrDesc;
			}
			if (other.Attribute.Length != 0)
			{
				Attribute = other.Attribute;
			}
			if (other.WordID != 0)
			{
				WordID = other.WordID;
			}
			if (other.IsPercent)
			{
				IsPercent = other.IsPercent;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Format != 0)
			{
				Format = other.Format;
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
				TypeID = input.ReadInt32();
				break;
			case 24u:
				Type2ID = input.ReadInt32();
				break;
			case 34u:
				Desc = input.ReadString();
				break;
			case 42u:
				RandomAttrDesc = input.ReadString();
				break;
			case 50u:
				Attribute = input.ReadString();
				break;
			case 56u:
				WordID = input.ReadInt32();
				break;
			case 64u:
				IsPercent = input.ReadBool();
				break;
			case 74u:
				Icon = input.ReadString();
				break;
			case 80u:
				Format = input.ReadInt32();
				break;
			}
		}
	}
}
