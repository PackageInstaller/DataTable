using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Word : IMessage<Word>, IMessage, IEquatable<Word>, IDeepCloneable<Word>
{
	private static readonly MessageParser<Word> _parser = new MessageParser<Word>(() => new Word());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TitleFieldNumber = 2;

	private string title_ = "";

	public const int TitleIconFieldNumber = 3;

	private string titleIcon_ = "";

	public const int TypeFieldNumber = 4;

	private int type_;

	public const int DescFieldNumber = 5;

	private string desc_ = "";

	public const int ColorFieldNumber = 6;

	private string color_ = "";

	public const int IconFieldNumber = 7;

	private string icon_ = "";

	public const int Param1FieldNumber = 8;

	private string param1_ = "";

	public const int Param2FieldNumber = 9;

	private string param2_ = "";

	public const int Param3FieldNumber = 10;

	private string param3_ = "";

	public const int Param4FieldNumber = 11;

	private string param4_ = "";

	public const int Param5FieldNumber = 12;

	private string param5_ = "";

	public const int Param6FieldNumber = 13;

	private string param6_ = "";

	public const int Param7FieldNumber = 14;

	private string param7_ = "";

	public const int Param8FieldNumber = 15;

	private string param8_ = "";

	public const int Param9FieldNumber = 16;

	private string param9_ = "";

	public const int Param10FieldNumber = 17;

	private string param10_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<Word> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1088);

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
	public string Title
	{
		get
		{
			return title_;
		}
		set
		{
			title_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TitleIcon
	{
		get
		{
			return titleIcon_;
		}
		set
		{
			titleIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
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
	public string Color
	{
		get
		{
			return color_;
		}
		set
		{
			color_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string Param6
	{
		get
		{
			return param6_;
		}
		set
		{
			param6_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param7
	{
		get
		{
			return param7_;
		}
		set
		{
			param7_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param8
	{
		get
		{
			return param8_;
		}
		set
		{
			param8_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param9
	{
		get
		{
			return param9_;
		}
		set
		{
			param9_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param10
	{
		get
		{
			return param10_;
		}
		set
		{
			param10_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public Word()
	{
	}

	[DebuggerNonUserCode]
	public Word(Word other)
		: this()
	{
		id_ = other.id_;
		title_ = other.title_;
		titleIcon_ = other.titleIcon_;
		type_ = other.type_;
		desc_ = other.desc_;
		color_ = other.color_;
		icon_ = other.icon_;
		param1_ = other.param1_;
		param2_ = other.param2_;
		param3_ = other.param3_;
		param4_ = other.param4_;
		param5_ = other.param5_;
		param6_ = other.param6_;
		param7_ = other.param7_;
		param8_ = other.param8_;
		param9_ = other.param9_;
		param10_ = other.param10_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Word Clone()
	{
		return new Word(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Word);
	}

	[DebuggerNonUserCode]
	public bool Equals(Word other)
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
		if (Title != other.Title)
		{
			return false;
		}
		if (TitleIcon != other.TitleIcon)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Color != other.Color)
		{
			return false;
		}
		if (Icon != other.Icon)
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
		if (Param6 != other.Param6)
		{
			return false;
		}
		if (Param7 != other.Param7)
		{
			return false;
		}
		if (Param8 != other.Param8)
		{
			return false;
		}
		if (Param9 != other.Param9)
		{
			return false;
		}
		if (Param10 != other.Param10)
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
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (TitleIcon.Length != 0)
		{
			num ^= TitleIcon.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Color.Length != 0)
		{
			num ^= Color.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
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
		if (Param6.Length != 0)
		{
			num ^= Param6.GetHashCode();
		}
		if (Param7.Length != 0)
		{
			num ^= Param7.GetHashCode();
		}
		if (Param8.Length != 0)
		{
			num ^= Param8.GetHashCode();
		}
		if (Param9.Length != 0)
		{
			num ^= Param9.GetHashCode();
		}
		if (Param10.Length != 0)
		{
			num ^= Param10.GetHashCode();
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
		if (Title.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Title);
		}
		if (TitleIcon.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(TitleIcon);
		}
		if (Type != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Type);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Desc);
		}
		if (Color.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Color);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Icon);
		}
		if (Param1.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Param1);
		}
		if (Param2.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Param2);
		}
		if (Param3.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(Param3);
		}
		if (Param4.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Param4);
		}
		if (Param5.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(Param5);
		}
		if (Param6.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(Param6);
		}
		if (Param7.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(Param7);
		}
		if (Param8.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(Param8);
		}
		if (Param9.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(Param9);
		}
		if (Param10.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(Param10);
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
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (TitleIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TitleIcon);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Color.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Color);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
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
		if (Param6.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param6);
		}
		if (Param7.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param7);
		}
		if (Param8.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param8);
		}
		if (Param9.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param9);
		}
		if (Param10.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param10);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Word other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.TitleIcon.Length != 0)
			{
				TitleIcon = other.TitleIcon;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Color.Length != 0)
			{
				Color = other.Color;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
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
			if (other.Param6.Length != 0)
			{
				Param6 = other.Param6;
			}
			if (other.Param7.Length != 0)
			{
				Param7 = other.Param7;
			}
			if (other.Param8.Length != 0)
			{
				Param8 = other.Param8;
			}
			if (other.Param9.Length != 0)
			{
				Param9 = other.Param9;
			}
			if (other.Param10.Length != 0)
			{
				Param10 = other.Param10;
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
				Title = input.ReadString();
				break;
			case 26u:
				TitleIcon = input.ReadString();
				break;
			case 32u:
				Type = input.ReadInt32();
				break;
			case 42u:
				Desc = input.ReadString();
				break;
			case 50u:
				Color = input.ReadString();
				break;
			case 58u:
				Icon = input.ReadString();
				break;
			case 66u:
				Param1 = input.ReadString();
				break;
			case 74u:
				Param2 = input.ReadString();
				break;
			case 82u:
				Param3 = input.ReadString();
				break;
			case 90u:
				Param4 = input.ReadString();
				break;
			case 98u:
				Param5 = input.ReadString();
				break;
			case 106u:
				Param6 = input.ReadString();
				break;
			case 114u:
				Param7 = input.ReadString();
				break;
			case 122u:
				Param8 = input.ReadString();
				break;
			case 130u:
				Param9 = input.ReadString();
				break;
			case 138u:
				Param10 = input.ReadString();
				break;
			}
		}
	}
}
