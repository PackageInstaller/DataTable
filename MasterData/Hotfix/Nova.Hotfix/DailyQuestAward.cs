using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DailyQuestAward : IMessage<DailyQuestAward>, IMessage, IEquatable<DailyQuestAward>, IDeepCloneable<DailyQuestAward>
{
	private static readonly MessageParser<DailyQuestAward> _parser = new MessageParser<DailyQuestAward>(() => new DailyQuestAward());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TitleFieldNumber = 2;

	private string title_ = "";

	public const int NeedPointFieldNumber = 3;

	private int needPoint_;

	public const int NumShowFieldNumber = 4;

	private int numShow_;

	public const int ItemTid1FieldNumber = 5;

	private int itemTid1_;

	public const int Number1FieldNumber = 6;

	private int number1_;

	public const int ItemTid2FieldNumber = 7;

	private int itemTid2_;

	public const int Number2FieldNumber = 8;

	private int number2_;

	[DebuggerNonUserCode]
	public static MessageParser<DailyQuestAward> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(240);

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
	public int NeedPoint
	{
		get
		{
			return needPoint_;
		}
		set
		{
			needPoint_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NumShow
	{
		get
		{
			return numShow_;
		}
		set
		{
			numShow_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ItemTid1
	{
		get
		{
			return itemTid1_;
		}
		set
		{
			itemTid1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Number1
	{
		get
		{
			return number1_;
		}
		set
		{
			number1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ItemTid2
	{
		get
		{
			return itemTid2_;
		}
		set
		{
			itemTid2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Number2
	{
		get
		{
			return number2_;
		}
		set
		{
			number2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public DailyQuestAward()
	{
	}

	[DebuggerNonUserCode]
	public DailyQuestAward(DailyQuestAward other)
		: this()
	{
		id_ = other.id_;
		title_ = other.title_;
		needPoint_ = other.needPoint_;
		numShow_ = other.numShow_;
		itemTid1_ = other.itemTid1_;
		number1_ = other.number1_;
		itemTid2_ = other.itemTid2_;
		number2_ = other.number2_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DailyQuestAward Clone()
	{
		return new DailyQuestAward(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DailyQuestAward);
	}

	[DebuggerNonUserCode]
	public bool Equals(DailyQuestAward other)
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
		if (NeedPoint != other.NeedPoint)
		{
			return false;
		}
		if (NumShow != other.NumShow)
		{
			return false;
		}
		if (ItemTid1 != other.ItemTid1)
		{
			return false;
		}
		if (Number1 != other.Number1)
		{
			return false;
		}
		if (ItemTid2 != other.ItemTid2)
		{
			return false;
		}
		if (Number2 != other.Number2)
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
		if (NeedPoint != 0)
		{
			num ^= NeedPoint.GetHashCode();
		}
		if (NumShow != 0)
		{
			num ^= NumShow.GetHashCode();
		}
		if (ItemTid1 != 0)
		{
			num ^= ItemTid1.GetHashCode();
		}
		if (Number1 != 0)
		{
			num ^= Number1.GetHashCode();
		}
		if (ItemTid2 != 0)
		{
			num ^= ItemTid2.GetHashCode();
		}
		if (Number2 != 0)
		{
			num ^= Number2.GetHashCode();
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
		if (NeedPoint != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(NeedPoint);
		}
		if (NumShow != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(NumShow);
		}
		if (ItemTid1 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ItemTid1);
		}
		if (Number1 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Number1);
		}
		if (ItemTid2 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ItemTid2);
		}
		if (Number2 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Number2);
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
		if (NeedPoint != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NeedPoint);
		}
		if (NumShow != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NumShow);
		}
		if (ItemTid1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemTid1);
		}
		if (Number1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Number1);
		}
		if (ItemTid2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemTid2);
		}
		if (Number2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Number2);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DailyQuestAward other)
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
			if (other.NeedPoint != 0)
			{
				NeedPoint = other.NeedPoint;
			}
			if (other.NumShow != 0)
			{
				NumShow = other.NumShow;
			}
			if (other.ItemTid1 != 0)
			{
				ItemTid1 = other.ItemTid1;
			}
			if (other.Number1 != 0)
			{
				Number1 = other.Number1;
			}
			if (other.ItemTid2 != 0)
			{
				ItemTid2 = other.ItemTid2;
			}
			if (other.Number2 != 0)
			{
				Number2 = other.Number2;
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
				NeedPoint = input.ReadInt32();
				break;
			case 32u:
				NumShow = input.ReadInt32();
				break;
			case 40u:
				ItemTid1 = input.ReadInt32();
				break;
			case 48u:
				Number1 = input.ReadInt32();
				break;
			case 56u:
				ItemTid2 = input.ReadInt32();
				break;
			case 64u:
				Number2 = input.ReadInt32();
				break;
			}
		}
	}
}
