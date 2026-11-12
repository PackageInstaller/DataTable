using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DormQuestGroup : IMessage<DormQuestGroup>, IMessage, IEquatable<DormQuestGroup>, IDeepCloneable<DormQuestGroup>
{
	private static readonly MessageParser<DormQuestGroup> _parser = new MessageParser<DormQuestGroup>(() => new DormQuestGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int PreGroupFieldNumber = 2;

	private int preGroup_;

	public const int TitleFieldNumber = 3;

	private string title_ = "";

	public const int IceFieldNumber = 4;

	private string ice_ = "";

	public const int Item1FieldNumber = 5;

	private int item1_;

	public const int Qty1FieldNumber = 6;

	private int qty1_;

	public const int Item2FieldNumber = 7;

	private int item2_;

	public const int Qty2FieldNumber = 8;

	private int qty2_;

	public const int Item3FieldNumber = 9;

	private int item3_;

	public const int Qty3FieldNumber = 10;

	private int qty3_;

	public const int Item4FieldNumber = 11;

	private int item4_;

	public const int Qty4FieldNumber = 12;

	private int qty4_;

	[DebuggerNonUserCode]
	public static MessageParser<DormQuestGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(300);

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
	public int PreGroup
	{
		get
		{
			return preGroup_;
		}
		set
		{
			preGroup_ = value;
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
	public string Ice
	{
		get
		{
			return ice_;
		}
		set
		{
			ice_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Item1
	{
		get
		{
			return item1_;
		}
		set
		{
			item1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty1
	{
		get
		{
			return qty1_;
		}
		set
		{
			qty1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Item2
	{
		get
		{
			return item2_;
		}
		set
		{
			item2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty2
	{
		get
		{
			return qty2_;
		}
		set
		{
			qty2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Item3
	{
		get
		{
			return item3_;
		}
		set
		{
			item3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty3
	{
		get
		{
			return qty3_;
		}
		set
		{
			qty3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Item4
	{
		get
		{
			return item4_;
		}
		set
		{
			item4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty4
	{
		get
		{
			return qty4_;
		}
		set
		{
			qty4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public DormQuestGroup()
	{
	}

	[DebuggerNonUserCode]
	public DormQuestGroup(DormQuestGroup other)
		: this()
	{
		id_ = other.id_;
		preGroup_ = other.preGroup_;
		title_ = other.title_;
		ice_ = other.ice_;
		item1_ = other.item1_;
		qty1_ = other.qty1_;
		item2_ = other.item2_;
		qty2_ = other.qty2_;
		item3_ = other.item3_;
		qty3_ = other.qty3_;
		item4_ = other.item4_;
		qty4_ = other.qty4_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DormQuestGroup Clone()
	{
		return new DormQuestGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DormQuestGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(DormQuestGroup other)
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
		if (PreGroup != other.PreGroup)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (Ice != other.Ice)
		{
			return false;
		}
		if (Item1 != other.Item1)
		{
			return false;
		}
		if (Qty1 != other.Qty1)
		{
			return false;
		}
		if (Item2 != other.Item2)
		{
			return false;
		}
		if (Qty2 != other.Qty2)
		{
			return false;
		}
		if (Item3 != other.Item3)
		{
			return false;
		}
		if (Qty3 != other.Qty3)
		{
			return false;
		}
		if (Item4 != other.Item4)
		{
			return false;
		}
		if (Qty4 != other.Qty4)
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
		if (PreGroup != 0)
		{
			num ^= PreGroup.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Ice.Length != 0)
		{
			num ^= Ice.GetHashCode();
		}
		if (Item1 != 0)
		{
			num ^= Item1.GetHashCode();
		}
		if (Qty1 != 0)
		{
			num ^= Qty1.GetHashCode();
		}
		if (Item2 != 0)
		{
			num ^= Item2.GetHashCode();
		}
		if (Qty2 != 0)
		{
			num ^= Qty2.GetHashCode();
		}
		if (Item3 != 0)
		{
			num ^= Item3.GetHashCode();
		}
		if (Qty3 != 0)
		{
			num ^= Qty3.GetHashCode();
		}
		if (Item4 != 0)
		{
			num ^= Item4.GetHashCode();
		}
		if (Qty4 != 0)
		{
			num ^= Qty4.GetHashCode();
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
		if (PreGroup != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(PreGroup);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Title);
		}
		if (Ice.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Ice);
		}
		if (Item1 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Item1);
		}
		if (Qty1 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Qty1);
		}
		if (Item2 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Item2);
		}
		if (Qty2 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Qty2);
		}
		if (Item3 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Item3);
		}
		if (Qty3 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Qty3);
		}
		if (Item4 != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(Item4);
		}
		if (Qty4 != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(Qty4);
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
		if (PreGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreGroup);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Ice.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Ice);
		}
		if (Item1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Item1);
		}
		if (Qty1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty1);
		}
		if (Item2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Item2);
		}
		if (Qty2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty2);
		}
		if (Item3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Item3);
		}
		if (Qty3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty3);
		}
		if (Item4 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Item4);
		}
		if (Qty4 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty4);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DormQuestGroup other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.PreGroup != 0)
			{
				PreGroup = other.PreGroup;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Ice.Length != 0)
			{
				Ice = other.Ice;
			}
			if (other.Item1 != 0)
			{
				Item1 = other.Item1;
			}
			if (other.Qty1 != 0)
			{
				Qty1 = other.Qty1;
			}
			if (other.Item2 != 0)
			{
				Item2 = other.Item2;
			}
			if (other.Qty2 != 0)
			{
				Qty2 = other.Qty2;
			}
			if (other.Item3 != 0)
			{
				Item3 = other.Item3;
			}
			if (other.Qty3 != 0)
			{
				Qty3 = other.Qty3;
			}
			if (other.Item4 != 0)
			{
				Item4 = other.Item4;
			}
			if (other.Qty4 != 0)
			{
				Qty4 = other.Qty4;
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
				PreGroup = input.ReadInt32();
				break;
			case 26u:
				Title = input.ReadString();
				break;
			case 34u:
				Ice = input.ReadString();
				break;
			case 40u:
				Item1 = input.ReadInt32();
				break;
			case 48u:
				Qty1 = input.ReadInt32();
				break;
			case 56u:
				Item2 = input.ReadInt32();
				break;
			case 64u:
				Qty2 = input.ReadInt32();
				break;
			case 72u:
				Item3 = input.ReadInt32();
				break;
			case 80u:
				Qty3 = input.ReadInt32();
				break;
			case 88u:
				Item4 = input.ReadInt32();
				break;
			case 96u:
				Qty4 = input.ReadInt32();
				break;
			}
		}
	}
}
