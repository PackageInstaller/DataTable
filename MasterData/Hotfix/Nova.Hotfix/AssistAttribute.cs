using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class AssistAttribute : IMessage<AssistAttribute>, IMessage, IEquatable<AssistAttribute>, IDeepCloneable<AssistAttribute>
{
	private static readonly MessageParser<AssistAttribute> _parser = new MessageParser<AssistAttribute>(() => new AssistAttribute());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int PreFieldNumber = 2;

	private int pre_;

	public const int EETFieldNumber = 3;

	private int eET_;

	public const int DescFieldNumber = 4;

	private string desc_ = "";

	public const int Char1FieldNumber = 5;

	private int char1_;

	public const int CharDesc1FieldNumber = 6;

	private string charDesc1_ = "";

	public const int Char2FieldNumber = 7;

	private int char2_;

	public const int CharDesc2FieldNumber = 8;

	private string charDesc2_ = "";

	public const int Char3FieldNumber = 9;

	private int char3_;

	public const int CharDesc3FieldNumber = 10;

	private string charDesc3_ = "";

	public const int TeamTitleFieldNumber = 11;

	private string teamTitle_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<AssistAttribute> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(96);

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
	public int Pre
	{
		get
		{
			return pre_;
		}
		set
		{
			pre_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EET
	{
		get
		{
			return eET_;
		}
		set
		{
			eET_ = value;
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
	public int Char1
	{
		get
		{
			return char1_;
		}
		set
		{
			char1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string CharDesc1
	{
		get
		{
			return charDesc1_;
		}
		set
		{
			charDesc1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Char2
	{
		get
		{
			return char2_;
		}
		set
		{
			char2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string CharDesc2
	{
		get
		{
			return charDesc2_;
		}
		set
		{
			charDesc2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Char3
	{
		get
		{
			return char3_;
		}
		set
		{
			char3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string CharDesc3
	{
		get
		{
			return charDesc3_;
		}
		set
		{
			charDesc3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TeamTitle
	{
		get
		{
			return teamTitle_;
		}
		set
		{
			teamTitle_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public AssistAttribute()
	{
	}

	[DebuggerNonUserCode]
	public AssistAttribute(AssistAttribute other)
		: this()
	{
		id_ = other.id_;
		pre_ = other.pre_;
		eET_ = other.eET_;
		desc_ = other.desc_;
		char1_ = other.char1_;
		charDesc1_ = other.charDesc1_;
		char2_ = other.char2_;
		charDesc2_ = other.charDesc2_;
		char3_ = other.char3_;
		charDesc3_ = other.charDesc3_;
		teamTitle_ = other.teamTitle_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public AssistAttribute Clone()
	{
		return new AssistAttribute(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as AssistAttribute);
	}

	[DebuggerNonUserCode]
	public bool Equals(AssistAttribute other)
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
		if (Pre != other.Pre)
		{
			return false;
		}
		if (EET != other.EET)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Char1 != other.Char1)
		{
			return false;
		}
		if (CharDesc1 != other.CharDesc1)
		{
			return false;
		}
		if (Char2 != other.Char2)
		{
			return false;
		}
		if (CharDesc2 != other.CharDesc2)
		{
			return false;
		}
		if (Char3 != other.Char3)
		{
			return false;
		}
		if (CharDesc3 != other.CharDesc3)
		{
			return false;
		}
		if (TeamTitle != other.TeamTitle)
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
		if (Pre != 0)
		{
			num ^= Pre.GetHashCode();
		}
		if (EET != 0)
		{
			num ^= EET.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Char1 != 0)
		{
			num ^= Char1.GetHashCode();
		}
		if (CharDesc1.Length != 0)
		{
			num ^= CharDesc1.GetHashCode();
		}
		if (Char2 != 0)
		{
			num ^= Char2.GetHashCode();
		}
		if (CharDesc2.Length != 0)
		{
			num ^= CharDesc2.GetHashCode();
		}
		if (Char3 != 0)
		{
			num ^= Char3.GetHashCode();
		}
		if (CharDesc3.Length != 0)
		{
			num ^= CharDesc3.GetHashCode();
		}
		if (TeamTitle.Length != 0)
		{
			num ^= TeamTitle.GetHashCode();
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
		if (Pre != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Pre);
		}
		if (EET != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(EET);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Desc);
		}
		if (Char1 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Char1);
		}
		if (CharDesc1.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(CharDesc1);
		}
		if (Char2 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Char2);
		}
		if (CharDesc2.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(CharDesc2);
		}
		if (Char3 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Char3);
		}
		if (CharDesc3.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(CharDesc3);
		}
		if (TeamTitle.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(TeamTitle);
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
		if (Pre != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Pre);
		}
		if (EET != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EET);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Char1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Char1);
		}
		if (CharDesc1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CharDesc1);
		}
		if (Char2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Char2);
		}
		if (CharDesc2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CharDesc2);
		}
		if (Char3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Char3);
		}
		if (CharDesc3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CharDesc3);
		}
		if (TeamTitle.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TeamTitle);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(AssistAttribute other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Pre != 0)
			{
				Pre = other.Pre;
			}
			if (other.EET != 0)
			{
				EET = other.EET;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Char1 != 0)
			{
				Char1 = other.Char1;
			}
			if (other.CharDesc1.Length != 0)
			{
				CharDesc1 = other.CharDesc1;
			}
			if (other.Char2 != 0)
			{
				Char2 = other.Char2;
			}
			if (other.CharDesc2.Length != 0)
			{
				CharDesc2 = other.CharDesc2;
			}
			if (other.Char3 != 0)
			{
				Char3 = other.Char3;
			}
			if (other.CharDesc3.Length != 0)
			{
				CharDesc3 = other.CharDesc3;
			}
			if (other.TeamTitle.Length != 0)
			{
				TeamTitle = other.TeamTitle;
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
				Pre = input.ReadInt32();
				break;
			case 24u:
				EET = input.ReadInt32();
				break;
			case 34u:
				Desc = input.ReadString();
				break;
			case 40u:
				Char1 = input.ReadInt32();
				break;
			case 50u:
				CharDesc1 = input.ReadString();
				break;
			case 56u:
				Char2 = input.ReadInt32();
				break;
			case 66u:
				CharDesc2 = input.ReadString();
				break;
			case 72u:
				Char3 = input.ReadInt32();
				break;
			case 82u:
				CharDesc3 = input.ReadString();
				break;
			case 90u:
				TeamTitle = input.ReadString();
				break;
			}
		}
	}
}
