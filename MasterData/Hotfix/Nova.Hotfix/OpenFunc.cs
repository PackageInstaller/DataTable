using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class OpenFunc : IMessage<OpenFunc>, IMessage, IEquatable<OpenFunc>, IDeepCloneable<OpenFunc>
{
	private static readonly MessageParser<OpenFunc> _parser = new MessageParser<OpenFunc>(() => new OpenFunc());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int NeedWorldClassFieldNumber = 3;

	private int needWorldClass_;

	public const int NeedConditionsFieldNumber = 4;

	private int needConditions_;

	public const int NeedRoguelikeFieldNumber = 5;

	private int needRoguelike_;

	public const int PopWindowsFieldNumber = 6;

	private bool popWindows_;

	public const int DescFieldNumber = 7;

	private string desc_ = "";

	public const int IconFieldNumber = 8;

	private string icon_ = "";

	public const int TipsFieldNumber = 9;

	private string tips_ = "";

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

	public const int Param6FieldNumber = 15;

	private string param6_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<OpenFunc> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(608);

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
	public int NeedWorldClass
	{
		get
		{
			return needWorldClass_;
		}
		set
		{
			needWorldClass_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NeedConditions
	{
		get
		{
			return needConditions_;
		}
		set
		{
			needConditions_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NeedRoguelike
	{
		get
		{
			return needRoguelike_;
		}
		set
		{
			needRoguelike_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool PopWindows
	{
		get
		{
			return popWindows_;
		}
		set
		{
			popWindows_ = value;
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
	public string Tips
	{
		get
		{
			return tips_;
		}
		set
		{
			tips_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public OpenFunc()
	{
	}

	[DebuggerNonUserCode]
	public OpenFunc(OpenFunc other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		needWorldClass_ = other.needWorldClass_;
		needConditions_ = other.needConditions_;
		needRoguelike_ = other.needRoguelike_;
		popWindows_ = other.popWindows_;
		desc_ = other.desc_;
		icon_ = other.icon_;
		tips_ = other.tips_;
		param1_ = other.param1_;
		param2_ = other.param2_;
		param3_ = other.param3_;
		param4_ = other.param4_;
		param5_ = other.param5_;
		param6_ = other.param6_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public OpenFunc Clone()
	{
		return new OpenFunc(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as OpenFunc);
	}

	[DebuggerNonUserCode]
	public bool Equals(OpenFunc other)
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
		if (NeedWorldClass != other.NeedWorldClass)
		{
			return false;
		}
		if (NeedConditions != other.NeedConditions)
		{
			return false;
		}
		if (NeedRoguelike != other.NeedRoguelike)
		{
			return false;
		}
		if (PopWindows != other.PopWindows)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Tips != other.Tips)
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
		if (NeedWorldClass != 0)
		{
			num ^= NeedWorldClass.GetHashCode();
		}
		if (NeedConditions != 0)
		{
			num ^= NeedConditions.GetHashCode();
		}
		if (NeedRoguelike != 0)
		{
			num ^= NeedRoguelike.GetHashCode();
		}
		if (PopWindows)
		{
			num ^= PopWindows.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Tips.Length != 0)
		{
			num ^= Tips.GetHashCode();
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
		if (NeedWorldClass != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(NeedWorldClass);
		}
		if (NeedConditions != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(NeedConditions);
		}
		if (NeedRoguelike != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(NeedRoguelike);
		}
		if (PopWindows)
		{
			output.WriteRawTag(48);
			output.WriteBool(PopWindows);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Desc);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Icon);
		}
		if (Tips.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Tips);
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
		if (Param6.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(Param6);
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
		if (NeedWorldClass != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NeedWorldClass);
		}
		if (NeedConditions != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NeedConditions);
		}
		if (NeedRoguelike != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NeedRoguelike);
		}
		if (PopWindows)
		{
			num += 2;
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Tips.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Tips);
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
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(OpenFunc other)
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
			if (other.NeedWorldClass != 0)
			{
				NeedWorldClass = other.NeedWorldClass;
			}
			if (other.NeedConditions != 0)
			{
				NeedConditions = other.NeedConditions;
			}
			if (other.NeedRoguelike != 0)
			{
				NeedRoguelike = other.NeedRoguelike;
			}
			if (other.PopWindows)
			{
				PopWindows = other.PopWindows;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Tips.Length != 0)
			{
				Tips = other.Tips;
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
			case 24u:
				NeedWorldClass = input.ReadInt32();
				break;
			case 32u:
				NeedConditions = input.ReadInt32();
				break;
			case 40u:
				NeedRoguelike = input.ReadInt32();
				break;
			case 48u:
				PopWindows = input.ReadBool();
				break;
			case 58u:
				Desc = input.ReadString();
				break;
			case 66u:
				Icon = input.ReadString();
				break;
			case 74u:
				Tips = input.ReadString();
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
			case 122u:
				Param6 = input.ReadString();
				break;
			}
		}
	}
}
