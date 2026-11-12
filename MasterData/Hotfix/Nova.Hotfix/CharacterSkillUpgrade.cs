using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharacterSkillUpgrade : IMessage<CharacterSkillUpgrade>, IMessage, IEquatable<CharacterSkillUpgrade>, IDeepCloneable<CharacterSkillUpgrade>
{
	private static readonly MessageParser<CharacterSkillUpgrade> _parser = new MessageParser<CharacterSkillUpgrade>(() => new CharacterSkillUpgrade());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupFieldNumber = 2;

	private int group_;

	public const int AdvanceNumFieldNumber = 3;

	private int advanceNum_;

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

	[DebuggerNonUserCode]
	public static MessageParser<CharacterSkillUpgrade> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(166);

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
	public int AdvanceNum
	{
		get
		{
			return advanceNum_;
		}
		set
		{
			advanceNum_ = value;
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
	public CharacterSkillUpgrade()
	{
	}

	[DebuggerNonUserCode]
	public CharacterSkillUpgrade(CharacterSkillUpgrade other)
		: this()
	{
		id_ = other.id_;
		group_ = other.group_;
		advanceNum_ = other.advanceNum_;
		tid1_ = other.tid1_;
		qty1_ = other.qty1_;
		tid2_ = other.tid2_;
		qty2_ = other.qty2_;
		tid3_ = other.tid3_;
		qty3_ = other.qty3_;
		tid4_ = other.tid4_;
		qty4_ = other.qty4_;
		goldQty_ = other.goldQty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharacterSkillUpgrade Clone()
	{
		return new CharacterSkillUpgrade(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterSkillUpgrade);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharacterSkillUpgrade other)
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
		if (AdvanceNum != other.AdvanceNum)
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
		if (AdvanceNum != 0)
		{
			num ^= AdvanceNum.GetHashCode();
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
		if (AdvanceNum != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(AdvanceNum);
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
		if (AdvanceNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AdvanceNum);
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
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharacterSkillUpgrade other)
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
			if (other.AdvanceNum != 0)
			{
				AdvanceNum = other.AdvanceNum;
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
				AdvanceNum = input.ReadInt32();
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
			}
		}
	}
}
