using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class monster_standard : IMessage<monster_standard>, IMessage, IEquatable<monster_standard>, IDeepCloneable<monster_standard>
{
	private static readonly MessageParser<monster_standard> _parser = new MessageParser<monster_standard>(() => new monster_standard());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int Attack1FieldNumber = 2;

	private int attack1_;

	public const int Defense1FieldNumber = 3;

	private int defense1_;

	public const int Hp1FieldNumber = 4;

	private int hp1_;

	public const int Attack2FieldNumber = 5;

	private int attack2_;

	public const int Defense2FieldNumber = 6;

	private int defense2_;

	public const int Hp2FieldNumber = 7;

	private int hp2_;

	public const int Attack3FieldNumber = 8;

	private int attack3_;

	public const int Defense3FieldNumber = 9;

	private int defense3_;

	public const int Hp3FieldNumber = 10;

	private int hp3_;

	public const int HpRatioFieldNumber = 11;

	private int hpRatio_;

	[DebuggerNonUserCode]
	public static MessageParser<monster_standard> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[86];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ID
	{
		get
		{
			return iD_;
		}
		set
		{
			iD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Attack1
	{
		get
		{
			return attack1_;
		}
		set
		{
			attack1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Defense1
	{
		get
		{
			return defense1_;
		}
		set
		{
			defense1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Hp1
	{
		get
		{
			return hp1_;
		}
		set
		{
			hp1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Attack2
	{
		get
		{
			return attack2_;
		}
		set
		{
			attack2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Defense2
	{
		get
		{
			return defense2_;
		}
		set
		{
			defense2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Hp2
	{
		get
		{
			return hp2_;
		}
		set
		{
			hp2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Attack3
	{
		get
		{
			return attack3_;
		}
		set
		{
			attack3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Defense3
	{
		get
		{
			return defense3_;
		}
		set
		{
			defense3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Hp3
	{
		get
		{
			return hp3_;
		}
		set
		{
			hp3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HpRatio
	{
		get
		{
			return hpRatio_;
		}
		set
		{
			hpRatio_ = value;
		}
	}

	[DebuggerNonUserCode]
	public monster_standard()
	{
	}

	[DebuggerNonUserCode]
	public monster_standard(monster_standard other)
		: this()
	{
		iD_ = other.iD_;
		attack1_ = other.attack1_;
		defense1_ = other.defense1_;
		hp1_ = other.hp1_;
		attack2_ = other.attack2_;
		defense2_ = other.defense2_;
		hp2_ = other.hp2_;
		attack3_ = other.attack3_;
		defense3_ = other.defense3_;
		hp3_ = other.hp3_;
		hpRatio_ = other.hpRatio_;
	}

	[DebuggerNonUserCode]
	public monster_standard Clone()
	{
		return new monster_standard(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as monster_standard);
	}

	[DebuggerNonUserCode]
	public bool Equals(monster_standard other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ID != other.ID)
		{
			return false;
		}
		if (Attack1 != other.Attack1)
		{
			return false;
		}
		if (Defense1 != other.Defense1)
		{
			return false;
		}
		if (Hp1 != other.Hp1)
		{
			return false;
		}
		if (Attack2 != other.Attack2)
		{
			return false;
		}
		if (Defense2 != other.Defense2)
		{
			return false;
		}
		if (Hp2 != other.Hp2)
		{
			return false;
		}
		if (Attack3 != other.Attack3)
		{
			return false;
		}
		if (Defense3 != other.Defense3)
		{
			return false;
		}
		if (Hp3 != other.Hp3)
		{
			return false;
		}
		if (HpRatio != other.HpRatio)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		if (Attack1 != 0)
		{
			num ^= Attack1.GetHashCode();
		}
		if (Defense1 != 0)
		{
			num ^= Defense1.GetHashCode();
		}
		if (Hp1 != 0)
		{
			num ^= Hp1.GetHashCode();
		}
		if (Attack2 != 0)
		{
			num ^= Attack2.GetHashCode();
		}
		if (Defense2 != 0)
		{
			num ^= Defense2.GetHashCode();
		}
		if (Hp2 != 0)
		{
			num ^= Hp2.GetHashCode();
		}
		if (Attack3 != 0)
		{
			num ^= Attack3.GetHashCode();
		}
		if (Defense3 != 0)
		{
			num ^= Defense3.GetHashCode();
		}
		if (Hp3 != 0)
		{
			num ^= Hp3.GetHashCode();
		}
		if (HpRatio != 0)
		{
			num ^= HpRatio.GetHashCode();
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
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		if (Attack1 != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Attack1);
		}
		if (Defense1 != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Defense1);
		}
		if (Hp1 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Hp1);
		}
		if (Attack2 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Attack2);
		}
		if (Defense2 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Defense2);
		}
		if (Hp2 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Hp2);
		}
		if (Attack3 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Attack3);
		}
		if (Defense3 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Defense3);
		}
		if (Hp3 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Hp3);
		}
		if (HpRatio != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(HpRatio);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (Attack1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Attack1);
		}
		if (Defense1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Defense1);
		}
		if (Hp1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Hp1);
		}
		if (Attack2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Attack2);
		}
		if (Defense2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Defense2);
		}
		if (Hp2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Hp2);
		}
		if (Attack3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Attack3);
		}
		if (Defense3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Defense3);
		}
		if (Hp3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Hp3);
		}
		if (HpRatio != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HpRatio);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(monster_standard other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Attack1 != 0)
			{
				Attack1 = other.Attack1;
			}
			if (other.Defense1 != 0)
			{
				Defense1 = other.Defense1;
			}
			if (other.Hp1 != 0)
			{
				Hp1 = other.Hp1;
			}
			if (other.Attack2 != 0)
			{
				Attack2 = other.Attack2;
			}
			if (other.Defense2 != 0)
			{
				Defense2 = other.Defense2;
			}
			if (other.Hp2 != 0)
			{
				Hp2 = other.Hp2;
			}
			if (other.Attack3 != 0)
			{
				Attack3 = other.Attack3;
			}
			if (other.Defense3 != 0)
			{
				Defense3 = other.Defense3;
			}
			if (other.Hp3 != 0)
			{
				Hp3 = other.Hp3;
			}
			if (other.HpRatio != 0)
			{
				HpRatio = other.HpRatio;
			}
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
				input.SkipLastField();
				break;
			case 8u:
				ID = input.ReadInt32();
				break;
			case 16u:
				Attack1 = input.ReadInt32();
				break;
			case 24u:
				Defense1 = input.ReadInt32();
				break;
			case 32u:
				Hp1 = input.ReadInt32();
				break;
			case 40u:
				Attack2 = input.ReadInt32();
				break;
			case 48u:
				Defense2 = input.ReadInt32();
				break;
			case 56u:
				Hp2 = input.ReadInt32();
				break;
			case 64u:
				Attack3 = input.ReadInt32();
				break;
			case 72u:
				Defense3 = input.ReadInt32();
				break;
			case 80u:
				Hp3 = input.ReadInt32();
				break;
			case 88u:
				HpRatio = input.ReadInt32();
				break;
			}
		}
	}
}
