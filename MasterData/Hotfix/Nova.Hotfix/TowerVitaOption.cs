using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TowerVitaOption : IMessage<TowerVitaOption>, IMessage, IEquatable<TowerVitaOption>, IDeepCloneable<TowerVitaOption>
{
	private static readonly MessageParser<TowerVitaOption> _parser = new MessageParser<TowerVitaOption>(() => new TowerVitaOption());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CategoriesFieldNumber = 2;

	private int categories_;

	public const int SortFieldNumber = 3;

	private int sort_;

	public const int OptionTypeFieldNumber = 4;

	private int optionType_;

	public const int DefaultValueFieldNumber = 5;

	private string defaultValue_ = "";

	public const int OptionGroupFieldNumber = 6;

	private int optionGroup_;

	public const int OptionText1FieldNumber = 7;

	private string optionText1_ = "";

	public const int OptionText2FieldNumber = 8;

	private string optionText2_ = "";

	public const int OptionText3FieldNumber = 9;

	private string optionText3_ = "";

	public const int OptionText4FieldNumber = 10;

	private string optionText4_ = "";

	public const int OptionText5FieldNumber = 11;

	private string optionText5_ = "";

	public const int OptionText6FieldNumber = 12;

	private string optionText6_ = "";

	public const int OptionText7FieldNumber = 13;

	private string optionText7_ = "";

	public const int OptionText8FieldNumber = 14;

	private string optionText8_ = "";

	public const int OptionText9FieldNumber = 15;

	private string optionText9_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<TowerVitaOption> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(976);

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
	public int Categories
	{
		get
		{
			return categories_;
		}
		set
		{
			categories_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Sort
	{
		get
		{
			return sort_;
		}
		set
		{
			sort_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int OptionType
	{
		get
		{
			return optionType_;
		}
		set
		{
			optionType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string DefaultValue
	{
		get
		{
			return defaultValue_;
		}
		set
		{
			defaultValue_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int OptionGroup
	{
		get
		{
			return optionGroup_;
		}
		set
		{
			optionGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string OptionText1
	{
		get
		{
			return optionText1_;
		}
		set
		{
			optionText1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string OptionText2
	{
		get
		{
			return optionText2_;
		}
		set
		{
			optionText2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string OptionText3
	{
		get
		{
			return optionText3_;
		}
		set
		{
			optionText3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string OptionText4
	{
		get
		{
			return optionText4_;
		}
		set
		{
			optionText4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string OptionText5
	{
		get
		{
			return optionText5_;
		}
		set
		{
			optionText5_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string OptionText6
	{
		get
		{
			return optionText6_;
		}
		set
		{
			optionText6_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string OptionText7
	{
		get
		{
			return optionText7_;
		}
		set
		{
			optionText7_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string OptionText8
	{
		get
		{
			return optionText8_;
		}
		set
		{
			optionText8_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string OptionText9
	{
		get
		{
			return optionText9_;
		}
		set
		{
			optionText9_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public TowerVitaOption()
	{
	}

	[DebuggerNonUserCode]
	public TowerVitaOption(TowerVitaOption other)
		: this()
	{
		id_ = other.id_;
		categories_ = other.categories_;
		sort_ = other.sort_;
		optionType_ = other.optionType_;
		defaultValue_ = other.defaultValue_;
		optionGroup_ = other.optionGroup_;
		optionText1_ = other.optionText1_;
		optionText2_ = other.optionText2_;
		optionText3_ = other.optionText3_;
		optionText4_ = other.optionText4_;
		optionText5_ = other.optionText5_;
		optionText6_ = other.optionText6_;
		optionText7_ = other.optionText7_;
		optionText8_ = other.optionText8_;
		optionText9_ = other.optionText9_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TowerVitaOption Clone()
	{
		return new TowerVitaOption(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TowerVitaOption);
	}

	[DebuggerNonUserCode]
	public bool Equals(TowerVitaOption other)
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
		if (Categories != other.Categories)
		{
			return false;
		}
		if (Sort != other.Sort)
		{
			return false;
		}
		if (OptionType != other.OptionType)
		{
			return false;
		}
		if (DefaultValue != other.DefaultValue)
		{
			return false;
		}
		if (OptionGroup != other.OptionGroup)
		{
			return false;
		}
		if (OptionText1 != other.OptionText1)
		{
			return false;
		}
		if (OptionText2 != other.OptionText2)
		{
			return false;
		}
		if (OptionText3 != other.OptionText3)
		{
			return false;
		}
		if (OptionText4 != other.OptionText4)
		{
			return false;
		}
		if (OptionText5 != other.OptionText5)
		{
			return false;
		}
		if (OptionText6 != other.OptionText6)
		{
			return false;
		}
		if (OptionText7 != other.OptionText7)
		{
			return false;
		}
		if (OptionText8 != other.OptionText8)
		{
			return false;
		}
		if (OptionText9 != other.OptionText9)
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
		if (Categories != 0)
		{
			num ^= Categories.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		if (OptionType != 0)
		{
			num ^= OptionType.GetHashCode();
		}
		if (DefaultValue.Length != 0)
		{
			num ^= DefaultValue.GetHashCode();
		}
		if (OptionGroup != 0)
		{
			num ^= OptionGroup.GetHashCode();
		}
		if (OptionText1.Length != 0)
		{
			num ^= OptionText1.GetHashCode();
		}
		if (OptionText2.Length != 0)
		{
			num ^= OptionText2.GetHashCode();
		}
		if (OptionText3.Length != 0)
		{
			num ^= OptionText3.GetHashCode();
		}
		if (OptionText4.Length != 0)
		{
			num ^= OptionText4.GetHashCode();
		}
		if (OptionText5.Length != 0)
		{
			num ^= OptionText5.GetHashCode();
		}
		if (OptionText6.Length != 0)
		{
			num ^= OptionText6.GetHashCode();
		}
		if (OptionText7.Length != 0)
		{
			num ^= OptionText7.GetHashCode();
		}
		if (OptionText8.Length != 0)
		{
			num ^= OptionText8.GetHashCode();
		}
		if (OptionText9.Length != 0)
		{
			num ^= OptionText9.GetHashCode();
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
		if (Categories != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Categories);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Sort);
		}
		if (OptionType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(OptionType);
		}
		if (DefaultValue.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(DefaultValue);
		}
		if (OptionGroup != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(OptionGroup);
		}
		if (OptionText1.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(OptionText1);
		}
		if (OptionText2.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(OptionText2);
		}
		if (OptionText3.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(OptionText3);
		}
		if (OptionText4.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(OptionText4);
		}
		if (OptionText5.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(OptionText5);
		}
		if (OptionText6.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(OptionText6);
		}
		if (OptionText7.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(OptionText7);
		}
		if (OptionText8.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(OptionText8);
		}
		if (OptionText9.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(OptionText9);
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
		if (Categories != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Categories);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		if (OptionType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OptionType);
		}
		if (DefaultValue.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DefaultValue);
		}
		if (OptionGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OptionGroup);
		}
		if (OptionText1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OptionText1);
		}
		if (OptionText2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OptionText2);
		}
		if (OptionText3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OptionText3);
		}
		if (OptionText4.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OptionText4);
		}
		if (OptionText5.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OptionText5);
		}
		if (OptionText6.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OptionText6);
		}
		if (OptionText7.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OptionText7);
		}
		if (OptionText8.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OptionText8);
		}
		if (OptionText9.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OptionText9);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TowerVitaOption other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Categories != 0)
			{
				Categories = other.Categories;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			if (other.OptionType != 0)
			{
				OptionType = other.OptionType;
			}
			if (other.DefaultValue.Length != 0)
			{
				DefaultValue = other.DefaultValue;
			}
			if (other.OptionGroup != 0)
			{
				OptionGroup = other.OptionGroup;
			}
			if (other.OptionText1.Length != 0)
			{
				OptionText1 = other.OptionText1;
			}
			if (other.OptionText2.Length != 0)
			{
				OptionText2 = other.OptionText2;
			}
			if (other.OptionText3.Length != 0)
			{
				OptionText3 = other.OptionText3;
			}
			if (other.OptionText4.Length != 0)
			{
				OptionText4 = other.OptionText4;
			}
			if (other.OptionText5.Length != 0)
			{
				OptionText5 = other.OptionText5;
			}
			if (other.OptionText6.Length != 0)
			{
				OptionText6 = other.OptionText6;
			}
			if (other.OptionText7.Length != 0)
			{
				OptionText7 = other.OptionText7;
			}
			if (other.OptionText8.Length != 0)
			{
				OptionText8 = other.OptionText8;
			}
			if (other.OptionText9.Length != 0)
			{
				OptionText9 = other.OptionText9;
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
				Categories = input.ReadInt32();
				break;
			case 24u:
				Sort = input.ReadInt32();
				break;
			case 32u:
				OptionType = input.ReadInt32();
				break;
			case 42u:
				DefaultValue = input.ReadString();
				break;
			case 48u:
				OptionGroup = input.ReadInt32();
				break;
			case 58u:
				OptionText1 = input.ReadString();
				break;
			case 66u:
				OptionText2 = input.ReadString();
				break;
			case 74u:
				OptionText3 = input.ReadString();
				break;
			case 82u:
				OptionText4 = input.ReadString();
				break;
			case 90u:
				OptionText5 = input.ReadString();
				break;
			case 98u:
				OptionText6 = input.ReadString();
				break;
			case 106u:
				OptionText7 = input.ReadString();
				break;
			case 114u:
				OptionText8 = input.ReadString();
				break;
			case 122u:
				OptionText9 = input.ReadString();
				break;
			}
		}
	}
}
