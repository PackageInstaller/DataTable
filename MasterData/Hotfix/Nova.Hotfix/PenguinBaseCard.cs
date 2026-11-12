using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PenguinBaseCard : IMessage<PenguinBaseCard>, IMessage, IEquatable<PenguinBaseCard>, IDeepCloneable<PenguinBaseCard>
{
	private static readonly MessageParser<PenguinBaseCard> _parser = new MessageParser<PenguinBaseCard>(() => new PenguinBaseCard());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TitleFieldNumber = 2;

	private string title_ = "";

	public const int Suit1FieldNumber = 3;

	private int suit1_;

	public const int SuitCount1FieldNumber = 4;

	private int suitCount1_;

	public const int Suit2FieldNumber = 5;

	private int suit2_;

	public const int SuitCount2FieldNumber = 6;

	private int suitCount2_;

	public const int Suit3FieldNumber = 7;

	private int suit3_;

	public const int SuitCount3FieldNumber = 8;

	private int suitCount3_;

	public const int IconFieldNumber = 9;

	private string icon_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<PenguinBaseCard> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(610);

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
	public int Suit1
	{
		get
		{
			return suit1_;
		}
		set
		{
			suit1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SuitCount1
	{
		get
		{
			return suitCount1_;
		}
		set
		{
			suitCount1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Suit2
	{
		get
		{
			return suit2_;
		}
		set
		{
			suit2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SuitCount2
	{
		get
		{
			return suitCount2_;
		}
		set
		{
			suitCount2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Suit3
	{
		get
		{
			return suit3_;
		}
		set
		{
			suit3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SuitCount3
	{
		get
		{
			return suitCount3_;
		}
		set
		{
			suitCount3_ = value;
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
	public PenguinBaseCard()
	{
	}

	[DebuggerNonUserCode]
	public PenguinBaseCard(PenguinBaseCard other)
		: this()
	{
		id_ = other.id_;
		title_ = other.title_;
		suit1_ = other.suit1_;
		suitCount1_ = other.suitCount1_;
		suit2_ = other.suit2_;
		suitCount2_ = other.suitCount2_;
		suit3_ = other.suit3_;
		suitCount3_ = other.suitCount3_;
		icon_ = other.icon_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PenguinBaseCard Clone()
	{
		return new PenguinBaseCard(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PenguinBaseCard);
	}

	[DebuggerNonUserCode]
	public bool Equals(PenguinBaseCard other)
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
		if (Suit1 != other.Suit1)
		{
			return false;
		}
		if (SuitCount1 != other.SuitCount1)
		{
			return false;
		}
		if (Suit2 != other.Suit2)
		{
			return false;
		}
		if (SuitCount2 != other.SuitCount2)
		{
			return false;
		}
		if (Suit3 != other.Suit3)
		{
			return false;
		}
		if (SuitCount3 != other.SuitCount3)
		{
			return false;
		}
		if (Icon != other.Icon)
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
		if (Suit1 != 0)
		{
			num ^= Suit1.GetHashCode();
		}
		if (SuitCount1 != 0)
		{
			num ^= SuitCount1.GetHashCode();
		}
		if (Suit2 != 0)
		{
			num ^= Suit2.GetHashCode();
		}
		if (SuitCount2 != 0)
		{
			num ^= SuitCount2.GetHashCode();
		}
		if (Suit3 != 0)
		{
			num ^= Suit3.GetHashCode();
		}
		if (SuitCount3 != 0)
		{
			num ^= SuitCount3.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
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
		if (Suit1 != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Suit1);
		}
		if (SuitCount1 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(SuitCount1);
		}
		if (Suit2 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Suit2);
		}
		if (SuitCount2 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(SuitCount2);
		}
		if (Suit3 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Suit3);
		}
		if (SuitCount3 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(SuitCount3);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Icon);
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
		if (Suit1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Suit1);
		}
		if (SuitCount1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SuitCount1);
		}
		if (Suit2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Suit2);
		}
		if (SuitCount2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SuitCount2);
		}
		if (Suit3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Suit3);
		}
		if (SuitCount3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SuitCount3);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PenguinBaseCard other)
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
			if (other.Suit1 != 0)
			{
				Suit1 = other.Suit1;
			}
			if (other.SuitCount1 != 0)
			{
				SuitCount1 = other.SuitCount1;
			}
			if (other.Suit2 != 0)
			{
				Suit2 = other.Suit2;
			}
			if (other.SuitCount2 != 0)
			{
				SuitCount2 = other.SuitCount2;
			}
			if (other.Suit3 != 0)
			{
				Suit3 = other.Suit3;
			}
			if (other.SuitCount3 != 0)
			{
				SuitCount3 = other.SuitCount3;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
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
			case 24u:
				Suit1 = input.ReadInt32();
				break;
			case 32u:
				SuitCount1 = input.ReadInt32();
				break;
			case 40u:
				Suit2 = input.ReadInt32();
				break;
			case 48u:
				SuitCount2 = input.ReadInt32();
				break;
			case 56u:
				Suit3 = input.ReadInt32();
				break;
			case 64u:
				SuitCount3 = input.ReadInt32();
				break;
			case 74u:
				Icon = input.ReadString();
				break;
			}
		}
	}
}
