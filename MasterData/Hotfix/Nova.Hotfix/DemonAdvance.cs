using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DemonAdvance : IMessage<DemonAdvance>, IMessage, IEquatable<DemonAdvance>, IDeepCloneable<DemonAdvance>
{
	private static readonly MessageParser<DemonAdvance> _parser = new MessageParser<DemonAdvance>(() => new DemonAdvance());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int AdvanceNameFieldNumber = 2;

	private string advanceName_ = "";

	public const int LevelRangeFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_levelRange_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> levelRange_ = new RepeatedField<int>();

	public const int AdvanceQuestGroupFieldNumber = 4;

	private int advanceQuestGroup_;

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
	public static MessageParser<DemonAdvance> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(256);

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
	public string AdvanceName
	{
		get
		{
			return advanceName_;
		}
		set
		{
			advanceName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> LevelRange => levelRange_;

	[DebuggerNonUserCode]
	public int AdvanceQuestGroup
	{
		get
		{
			return advanceQuestGroup_;
		}
		set
		{
			advanceQuestGroup_ = value;
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
	public DemonAdvance()
	{
	}

	[DebuggerNonUserCode]
	public DemonAdvance(DemonAdvance other)
		: this()
	{
		id_ = other.id_;
		advanceName_ = other.advanceName_;
		levelRange_ = other.levelRange_.Clone();
		advanceQuestGroup_ = other.advanceQuestGroup_;
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
	public DemonAdvance Clone()
	{
		return new DemonAdvance(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DemonAdvance);
	}

	[DebuggerNonUserCode]
	public bool Equals(DemonAdvance other)
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
		if (AdvanceName != other.AdvanceName)
		{
			return false;
		}
		if (!levelRange_.Equals(other.levelRange_))
		{
			return false;
		}
		if (AdvanceQuestGroup != other.AdvanceQuestGroup)
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
		if (AdvanceName.Length != 0)
		{
			num ^= AdvanceName.GetHashCode();
		}
		num ^= levelRange_.GetHashCode();
		if (AdvanceQuestGroup != 0)
		{
			num ^= AdvanceQuestGroup.GetHashCode();
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
		if (AdvanceName.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(AdvanceName);
		}
		levelRange_.WriteTo(output, _repeated_levelRange_codec);
		if (AdvanceQuestGroup != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(AdvanceQuestGroup);
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
		if (AdvanceName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AdvanceName);
		}
		num += levelRange_.CalculateSize(_repeated_levelRange_codec);
		if (AdvanceQuestGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AdvanceQuestGroup);
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
	public void MergeFrom(DemonAdvance other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.AdvanceName.Length != 0)
			{
				AdvanceName = other.AdvanceName;
			}
			levelRange_.Add(other.levelRange_);
			if (other.AdvanceQuestGroup != 0)
			{
				AdvanceQuestGroup = other.AdvanceQuestGroup;
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
			case 18u:
				AdvanceName = input.ReadString();
				break;
			case 24u:
			case 26u:
				levelRange_.AddEntriesFrom(input, _repeated_levelRange_codec);
				break;
			case 32u:
				AdvanceQuestGroup = input.ReadInt32();
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
