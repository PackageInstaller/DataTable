using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GachaType : IMessage<GachaType>, IMessage, IEquatable<GachaType>, IDeepCloneable<GachaType>
{
	private static readonly MessageParser<GachaType> _parser = new MessageParser<GachaType>(() => new GachaType());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int CoinItemFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_coinItem_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> coinItem_ = new RepeatedField<int>();

	public const int Title1FieldNumber = 4;

	private string title1_ = "";

	public const int Desc1FieldNumber = 5;

	private string desc1_ = "";

	public const int Title2FieldNumber = 6;

	private string title2_ = "";

	public const int Desc2FieldNumber = 7;

	private string desc2_ = "";

	public const int Title3FieldNumber = 8;

	private string title3_ = "";

	public const int Desc3FieldNumber = 9;

	private string desc3_ = "";

	public const int Title4FieldNumber = 10;

	private string title4_ = "";

	public const int Desc4FieldNumber = 11;

	private string desc4_ = "";

	public const int Desc5FieldNumber = 12;

	private string desc5_ = "";

	public const int Title5FieldNumber = 13;

	private string title5_ = "";

	public const int Desc6FieldNumber = 14;

	private string desc6_ = "";

	public const int Desc7FieldNumber = 15;

	private string desc7_ = "";

	public const int Desc8FieldNumber = 16;

	private string desc8_ = "";

	public const int Desc9FieldNumber = 17;

	private string desc9_ = "";

	public const int Desc10FieldNumber = 18;

	private string desc10_ = "";

	public const int Desc11FieldNumber = 19;

	private string desc11_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<GachaType> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(374);

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
	public RepeatedField<int> CoinItem => coinItem_;

	[DebuggerNonUserCode]
	public string Title1
	{
		get
		{
			return title1_;
		}
		set
		{
			title1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc1
	{
		get
		{
			return desc1_;
		}
		set
		{
			desc1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Title2
	{
		get
		{
			return title2_;
		}
		set
		{
			title2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc2
	{
		get
		{
			return desc2_;
		}
		set
		{
			desc2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Title3
	{
		get
		{
			return title3_;
		}
		set
		{
			title3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc3
	{
		get
		{
			return desc3_;
		}
		set
		{
			desc3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Title4
	{
		get
		{
			return title4_;
		}
		set
		{
			title4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc4
	{
		get
		{
			return desc4_;
		}
		set
		{
			desc4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc5
	{
		get
		{
			return desc5_;
		}
		set
		{
			desc5_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Title5
	{
		get
		{
			return title5_;
		}
		set
		{
			title5_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc6
	{
		get
		{
			return desc6_;
		}
		set
		{
			desc6_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc7
	{
		get
		{
			return desc7_;
		}
		set
		{
			desc7_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc8
	{
		get
		{
			return desc8_;
		}
		set
		{
			desc8_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc9
	{
		get
		{
			return desc9_;
		}
		set
		{
			desc9_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc10
	{
		get
		{
			return desc10_;
		}
		set
		{
			desc10_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc11
	{
		get
		{
			return desc11_;
		}
		set
		{
			desc11_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public GachaType()
	{
	}

	[DebuggerNonUserCode]
	public GachaType(GachaType other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		coinItem_ = other.coinItem_.Clone();
		title1_ = other.title1_;
		desc1_ = other.desc1_;
		title2_ = other.title2_;
		desc2_ = other.desc2_;
		title3_ = other.title3_;
		desc3_ = other.desc3_;
		title4_ = other.title4_;
		desc4_ = other.desc4_;
		desc5_ = other.desc5_;
		title5_ = other.title5_;
		desc6_ = other.desc6_;
		desc7_ = other.desc7_;
		desc8_ = other.desc8_;
		desc9_ = other.desc9_;
		desc10_ = other.desc10_;
		desc11_ = other.desc11_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GachaType Clone()
	{
		return new GachaType(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GachaType);
	}

	[DebuggerNonUserCode]
	public bool Equals(GachaType other)
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
		if (!coinItem_.Equals(other.coinItem_))
		{
			return false;
		}
		if (Title1 != other.Title1)
		{
			return false;
		}
		if (Desc1 != other.Desc1)
		{
			return false;
		}
		if (Title2 != other.Title2)
		{
			return false;
		}
		if (Desc2 != other.Desc2)
		{
			return false;
		}
		if (Title3 != other.Title3)
		{
			return false;
		}
		if (Desc3 != other.Desc3)
		{
			return false;
		}
		if (Title4 != other.Title4)
		{
			return false;
		}
		if (Desc4 != other.Desc4)
		{
			return false;
		}
		if (Desc5 != other.Desc5)
		{
			return false;
		}
		if (Title5 != other.Title5)
		{
			return false;
		}
		if (Desc6 != other.Desc6)
		{
			return false;
		}
		if (Desc7 != other.Desc7)
		{
			return false;
		}
		if (Desc8 != other.Desc8)
		{
			return false;
		}
		if (Desc9 != other.Desc9)
		{
			return false;
		}
		if (Desc10 != other.Desc10)
		{
			return false;
		}
		if (Desc11 != other.Desc11)
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
		num ^= coinItem_.GetHashCode();
		if (Title1.Length != 0)
		{
			num ^= Title1.GetHashCode();
		}
		if (Desc1.Length != 0)
		{
			num ^= Desc1.GetHashCode();
		}
		if (Title2.Length != 0)
		{
			num ^= Title2.GetHashCode();
		}
		if (Desc2.Length != 0)
		{
			num ^= Desc2.GetHashCode();
		}
		if (Title3.Length != 0)
		{
			num ^= Title3.GetHashCode();
		}
		if (Desc3.Length != 0)
		{
			num ^= Desc3.GetHashCode();
		}
		if (Title4.Length != 0)
		{
			num ^= Title4.GetHashCode();
		}
		if (Desc4.Length != 0)
		{
			num ^= Desc4.GetHashCode();
		}
		if (Desc5.Length != 0)
		{
			num ^= Desc5.GetHashCode();
		}
		if (Title5.Length != 0)
		{
			num ^= Title5.GetHashCode();
		}
		if (Desc6.Length != 0)
		{
			num ^= Desc6.GetHashCode();
		}
		if (Desc7.Length != 0)
		{
			num ^= Desc7.GetHashCode();
		}
		if (Desc8.Length != 0)
		{
			num ^= Desc8.GetHashCode();
		}
		if (Desc9.Length != 0)
		{
			num ^= Desc9.GetHashCode();
		}
		if (Desc10.Length != 0)
		{
			num ^= Desc10.GetHashCode();
		}
		if (Desc11.Length != 0)
		{
			num ^= Desc11.GetHashCode();
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
		coinItem_.WriteTo(output, _repeated_coinItem_codec);
		if (Title1.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Title1);
		}
		if (Desc1.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Desc1);
		}
		if (Title2.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Title2);
		}
		if (Desc2.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Desc2);
		}
		if (Title3.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Title3);
		}
		if (Desc3.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Desc3);
		}
		if (Title4.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(Title4);
		}
		if (Desc4.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Desc4);
		}
		if (Desc5.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(Desc5);
		}
		if (Title5.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(Title5);
		}
		if (Desc6.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(Desc6);
		}
		if (Desc7.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(Desc7);
		}
		if (Desc8.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(Desc8);
		}
		if (Desc9.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(Desc9);
		}
		if (Desc10.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(Desc10);
		}
		if (Desc11.Length != 0)
		{
			output.WriteRawTag(154, 1);
			output.WriteString(Desc11);
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
		num += coinItem_.CalculateSize(_repeated_coinItem_codec);
		if (Title1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title1);
		}
		if (Desc1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc1);
		}
		if (Title2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title2);
		}
		if (Desc2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc2);
		}
		if (Title3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title3);
		}
		if (Desc3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc3);
		}
		if (Title4.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title4);
		}
		if (Desc4.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc4);
		}
		if (Desc5.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc5);
		}
		if (Title5.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title5);
		}
		if (Desc6.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc6);
		}
		if (Desc7.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc7);
		}
		if (Desc8.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Desc8);
		}
		if (Desc9.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Desc9);
		}
		if (Desc10.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Desc10);
		}
		if (Desc11.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Desc11);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(GachaType other)
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
			coinItem_.Add(other.coinItem_);
			if (other.Title1.Length != 0)
			{
				Title1 = other.Title1;
			}
			if (other.Desc1.Length != 0)
			{
				Desc1 = other.Desc1;
			}
			if (other.Title2.Length != 0)
			{
				Title2 = other.Title2;
			}
			if (other.Desc2.Length != 0)
			{
				Desc2 = other.Desc2;
			}
			if (other.Title3.Length != 0)
			{
				Title3 = other.Title3;
			}
			if (other.Desc3.Length != 0)
			{
				Desc3 = other.Desc3;
			}
			if (other.Title4.Length != 0)
			{
				Title4 = other.Title4;
			}
			if (other.Desc4.Length != 0)
			{
				Desc4 = other.Desc4;
			}
			if (other.Desc5.Length != 0)
			{
				Desc5 = other.Desc5;
			}
			if (other.Title5.Length != 0)
			{
				Title5 = other.Title5;
			}
			if (other.Desc6.Length != 0)
			{
				Desc6 = other.Desc6;
			}
			if (other.Desc7.Length != 0)
			{
				Desc7 = other.Desc7;
			}
			if (other.Desc8.Length != 0)
			{
				Desc8 = other.Desc8;
			}
			if (other.Desc9.Length != 0)
			{
				Desc9 = other.Desc9;
			}
			if (other.Desc10.Length != 0)
			{
				Desc10 = other.Desc10;
			}
			if (other.Desc11.Length != 0)
			{
				Desc11 = other.Desc11;
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
			case 26u:
				coinItem_.AddEntriesFrom(input, _repeated_coinItem_codec);
				break;
			case 34u:
				Title1 = input.ReadString();
				break;
			case 42u:
				Desc1 = input.ReadString();
				break;
			case 50u:
				Title2 = input.ReadString();
				break;
			case 58u:
				Desc2 = input.ReadString();
				break;
			case 66u:
				Title3 = input.ReadString();
				break;
			case 74u:
				Desc3 = input.ReadString();
				break;
			case 82u:
				Title4 = input.ReadString();
				break;
			case 90u:
				Desc4 = input.ReadString();
				break;
			case 98u:
				Desc5 = input.ReadString();
				break;
			case 106u:
				Title5 = input.ReadString();
				break;
			case 114u:
				Desc6 = input.ReadString();
				break;
			case 122u:
				Desc7 = input.ReadString();
				break;
			case 130u:
				Desc8 = input.ReadString();
				break;
			case 138u:
				Desc9 = input.ReadString();
				break;
			case 146u:
				Desc10 = input.ReadString();
				break;
			case 154u:
				Desc11 = input.ReadString();
				break;
			}
		}
	}
}
