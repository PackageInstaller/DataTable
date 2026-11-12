using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharacterAdvance : IMessage<CharacterAdvance>, IMessage, IEquatable<CharacterAdvance>, IDeepCloneable<CharacterAdvance>
{
	private static readonly MessageParser<CharacterAdvance> _parser = new MessageParser<CharacterAdvance>(() => new CharacterAdvance());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupFieldNumber = 2;

	private int group_;

	public const int AdvanceLvlFieldNumber = 3;

	private int advanceLvl_;

	public const int Tid1FieldNumber = 4;

	private int tid1_;

	public const int Qty1FieldNumber = 5;

	private int qty1_;

	public const int Tid2FieldNumber = 6;

	private int tid2_;

	public const int Qty2FieldNumber = 7;

	private int qty2_;

	public const int Tid3FieldNumber = 8;

	private int tid3_;

	public const int Qty3FieldNumber = 9;

	private int qty3_;

	public const int Tid4FieldNumber = 10;

	private int tid4_;

	public const int Qty4FieldNumber = 11;

	private int qty4_;

	public const int GoldQtyFieldNumber = 12;

	private int goldQty_;

	public const int AwardTid1FieldNumber = 13;

	private int awardTid1_;

	public const int AwardQty1FieldNumber = 14;

	private int awardQty1_;

	public const int AwardTid2FieldNumber = 15;

	private int awardTid2_;

	public const int AwardQty2FieldNumber = 16;

	private int awardQty2_;

	public const int AwardTid3FieldNumber = 17;

	private int awardTid3_;

	public const int AwardQty3FieldNumber = 18;

	private int awardQty3_;

	[DebuggerNonUserCode]
	public static MessageParser<CharacterAdvance> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(152);

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
	public int Group
	{
		get
		{
			return group_;
		}
		set
		{
			group_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AdvanceLvl
	{
		get
		{
			return advanceLvl_;
		}
		set
		{
			advanceLvl_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Tid1
	{
		get
		{
			return tid1_;
		}
		set
		{
			tid1_ = value;
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
	public int Tid2
	{
		get
		{
			return tid2_;
		}
		set
		{
			tid2_ = value;
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
	public int Tid3
	{
		get
		{
			return tid3_;
		}
		set
		{
			tid3_ = value;
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
	public int Tid4
	{
		get
		{
			return tid4_;
		}
		set
		{
			tid4_ = value;
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
	public int GoldQty
	{
		get
		{
			return goldQty_;
		}
		set
		{
			goldQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AwardTid1
	{
		get
		{
			return awardTid1_;
		}
		set
		{
			awardTid1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AwardQty1
	{
		get
		{
			return awardQty1_;
		}
		set
		{
			awardQty1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AwardTid2
	{
		get
		{
			return awardTid2_;
		}
		set
		{
			awardTid2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AwardQty2
	{
		get
		{
			return awardQty2_;
		}
		set
		{
			awardQty2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AwardTid3
	{
		get
		{
			return awardTid3_;
		}
		set
		{
			awardTid3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AwardQty3
	{
		get
		{
			return awardQty3_;
		}
		set
		{
			awardQty3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public CharacterAdvance()
	{
	}

	[DebuggerNonUserCode]
	public CharacterAdvance(CharacterAdvance other)
		: this()
	{
		id_ = other.id_;
		group_ = other.group_;
		advanceLvl_ = other.advanceLvl_;
		tid1_ = other.tid1_;
		qty1_ = other.qty1_;
		tid2_ = other.tid2_;
		qty2_ = other.qty2_;
		tid3_ = other.tid3_;
		qty3_ = other.qty3_;
		tid4_ = other.tid4_;
		qty4_ = other.qty4_;
		goldQty_ = other.goldQty_;
		awardTid1_ = other.awardTid1_;
		awardQty1_ = other.awardQty1_;
		awardTid2_ = other.awardTid2_;
		awardQty2_ = other.awardQty2_;
		awardTid3_ = other.awardTid3_;
		awardQty3_ = other.awardQty3_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharacterAdvance Clone()
	{
		return new CharacterAdvance(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterAdvance);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharacterAdvance other)
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
		if (Group != other.Group)
		{
			return false;
		}
		if (AdvanceLvl != other.AdvanceLvl)
		{
			return false;
		}
		if (Tid1 != other.Tid1)
		{
			return false;
		}
		if (Qty1 != other.Qty1)
		{
			return false;
		}
		if (Tid2 != other.Tid2)
		{
			return false;
		}
		if (Qty2 != other.Qty2)
		{
			return false;
		}
		if (Tid3 != other.Tid3)
		{
			return false;
		}
		if (Qty3 != other.Qty3)
		{
			return false;
		}
		if (Tid4 != other.Tid4)
		{
			return false;
		}
		if (Qty4 != other.Qty4)
		{
			return false;
		}
		if (GoldQty != other.GoldQty)
		{
			return false;
		}
		if (AwardTid1 != other.AwardTid1)
		{
			return false;
		}
		if (AwardQty1 != other.AwardQty1)
		{
			return false;
		}
		if (AwardTid2 != other.AwardTid2)
		{
			return false;
		}
		if (AwardQty2 != other.AwardQty2)
		{
			return false;
		}
		if (AwardTid3 != other.AwardTid3)
		{
			return false;
		}
		if (AwardQty3 != other.AwardQty3)
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
		if (Group != 0)
		{
			num ^= Group.GetHashCode();
		}
		if (AdvanceLvl != 0)
		{
			num ^= AdvanceLvl.GetHashCode();
		}
		if (Tid1 != 0)
		{
			num ^= Tid1.GetHashCode();
		}
		if (Qty1 != 0)
		{
			num ^= Qty1.GetHashCode();
		}
		if (Tid2 != 0)
		{
			num ^= Tid2.GetHashCode();
		}
		if (Qty2 != 0)
		{
			num ^= Qty2.GetHashCode();
		}
		if (Tid3 != 0)
		{
			num ^= Tid3.GetHashCode();
		}
		if (Qty3 != 0)
		{
			num ^= Qty3.GetHashCode();
		}
		if (Tid4 != 0)
		{
			num ^= Tid4.GetHashCode();
		}
		if (Qty4 != 0)
		{
			num ^= Qty4.GetHashCode();
		}
		if (GoldQty != 0)
		{
			num ^= GoldQty.GetHashCode();
		}
		if (AwardTid1 != 0)
		{
			num ^= AwardTid1.GetHashCode();
		}
		if (AwardQty1 != 0)
		{
			num ^= AwardQty1.GetHashCode();
		}
		if (AwardTid2 != 0)
		{
			num ^= AwardTid2.GetHashCode();
		}
		if (AwardQty2 != 0)
		{
			num ^= AwardQty2.GetHashCode();
		}
		if (AwardTid3 != 0)
		{
			num ^= AwardTid3.GetHashCode();
		}
		if (AwardQty3 != 0)
		{
			num ^= AwardQty3.GetHashCode();
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
		if (Group != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Group);
		}
		if (AdvanceLvl != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(AdvanceLvl);
		}
		if (Tid1 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Tid1);
		}
		if (Qty1 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Qty1);
		}
		if (Tid2 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Tid2);
		}
		if (Qty2 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Qty2);
		}
		if (Tid3 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Tid3);
		}
		if (Qty3 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Qty3);
		}
		if (Tid4 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Tid4);
		}
		if (Qty4 != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(Qty4);
		}
		if (GoldQty != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(GoldQty);
		}
		if (AwardTid1 != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(AwardTid1);
		}
		if (AwardQty1 != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(AwardQty1);
		}
		if (AwardTid2 != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(AwardTid2);
		}
		if (AwardQty2 != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(AwardQty2);
		}
		if (AwardTid3 != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(AwardTid3);
		}
		if (AwardQty3 != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(AwardQty3);
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
		if (Group != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Group);
		}
		if (AdvanceLvl != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AdvanceLvl);
		}
		if (Tid1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tid1);
		}
		if (Qty1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty1);
		}
		if (Tid2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tid2);
		}
		if (Qty2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty2);
		}
		if (Tid3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tid3);
		}
		if (Qty3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty3);
		}
		if (Tid4 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tid4);
		}
		if (Qty4 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty4);
		}
		if (GoldQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GoldQty);
		}
		if (AwardTid1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AwardTid1);
		}
		if (AwardQty1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AwardQty1);
		}
		if (AwardTid2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AwardTid2);
		}
		if (AwardQty2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AwardQty2);
		}
		if (AwardTid3 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AwardTid3);
		}
		if (AwardQty3 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AwardQty3);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharacterAdvance other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Group != 0)
			{
				Group = other.Group;
			}
			if (other.AdvanceLvl != 0)
			{
				AdvanceLvl = other.AdvanceLvl;
			}
			if (other.Tid1 != 0)
			{
				Tid1 = other.Tid1;
			}
			if (other.Qty1 != 0)
			{
				Qty1 = other.Qty1;
			}
			if (other.Tid2 != 0)
			{
				Tid2 = other.Tid2;
			}
			if (other.Qty2 != 0)
			{
				Qty2 = other.Qty2;
			}
			if (other.Tid3 != 0)
			{
				Tid3 = other.Tid3;
			}
			if (other.Qty3 != 0)
			{
				Qty3 = other.Qty3;
			}
			if (other.Tid4 != 0)
			{
				Tid4 = other.Tid4;
			}
			if (other.Qty4 != 0)
			{
				Qty4 = other.Qty4;
			}
			if (other.GoldQty != 0)
			{
				GoldQty = other.GoldQty;
			}
			if (other.AwardTid1 != 0)
			{
				AwardTid1 = other.AwardTid1;
			}
			if (other.AwardQty1 != 0)
			{
				AwardQty1 = other.AwardQty1;
			}
			if (other.AwardTid2 != 0)
			{
				AwardTid2 = other.AwardTid2;
			}
			if (other.AwardQty2 != 0)
			{
				AwardQty2 = other.AwardQty2;
			}
			if (other.AwardTid3 != 0)
			{
				AwardTid3 = other.AwardTid3;
			}
			if (other.AwardQty3 != 0)
			{
				AwardQty3 = other.AwardQty3;
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
				Group = input.ReadInt32();
				break;
			case 24u:
				AdvanceLvl = input.ReadInt32();
				break;
			case 32u:
				Tid1 = input.ReadInt32();
				break;
			case 40u:
				Qty1 = input.ReadInt32();
				break;
			case 48u:
				Tid2 = input.ReadInt32();
				break;
			case 56u:
				Qty2 = input.ReadInt32();
				break;
			case 64u:
				Tid3 = input.ReadInt32();
				break;
			case 72u:
				Qty3 = input.ReadInt32();
				break;
			case 80u:
				Tid4 = input.ReadInt32();
				break;
			case 88u:
				Qty4 = input.ReadInt32();
				break;
			case 96u:
				GoldQty = input.ReadInt32();
				break;
			case 104u:
				AwardTid1 = input.ReadInt32();
				break;
			case 112u:
				AwardQty1 = input.ReadInt32();
				break;
			case 120u:
				AwardTid2 = input.ReadInt32();
				break;
			case 128u:
				AwardQty2 = input.ReadInt32();
				break;
			case 136u:
				AwardTid3 = input.ReadInt32();
				break;
			case 144u:
				AwardQty3 = input.ReadInt32();
				break;
			}
		}
	}
}
