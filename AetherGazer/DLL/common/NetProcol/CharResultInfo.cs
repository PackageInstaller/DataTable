using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

public sealed class CharResultInfo : IMessage<CharResultInfo>, IMessage, IEquatable<CharResultInfo>, IDeepCloneable<CharResultInfo>
{
	private static readonly MessageParser<CharResultInfo> _parser = new MessageParser<CharResultInfo>(() => new CharResultInfo());

	public const int HeroIDFieldNumber = 1;

	private int heroID_;

	public const int CurrentHPFieldNumber = 2;

	private long currentHP_;

	public const int MaxHPFieldNumber = 3;

	private long maxHP_;

	public const int DamageFieldNumber = 4;

	private long damage_;

	public const int HurtFieldNumber = 5;

	private long hurt_;

	public const int CureFieldNumber = 6;

	private long cure_;

	[DebuggerNonUserCode]
	public static MessageParser<CharResultInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[19];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int HeroID
	{
		get
		{
			return heroID_;
		}
		set
		{
			heroID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public long CurrentHP
	{
		get
		{
			return currentHP_;
		}
		set
		{
			currentHP_ = value;
		}
	}

	[DebuggerNonUserCode]
	public long MaxHP
	{
		get
		{
			return maxHP_;
		}
		set
		{
			maxHP_ = value;
		}
	}

	[DebuggerNonUserCode]
	public long Damage
	{
		get
		{
			return damage_;
		}
		set
		{
			damage_ = value;
		}
	}

	[DebuggerNonUserCode]
	public long Hurt
	{
		get
		{
			return hurt_;
		}
		set
		{
			hurt_ = value;
		}
	}

	[DebuggerNonUserCode]
	public long Cure
	{
		get
		{
			return cure_;
		}
		set
		{
			cure_ = value;
		}
	}

	[DebuggerNonUserCode]
	public CharResultInfo()
	{
	}

	[DebuggerNonUserCode]
	public CharResultInfo(CharResultInfo other)
		: this()
	{
		heroID_ = other.heroID_;
		currentHP_ = other.currentHP_;
		maxHP_ = other.maxHP_;
		damage_ = other.damage_;
		hurt_ = other.hurt_;
		cure_ = other.cure_;
	}

	[DebuggerNonUserCode]
	public CharResultInfo Clone()
	{
		return new CharResultInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharResultInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharResultInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (HeroID != other.HeroID)
		{
			return false;
		}
		if (CurrentHP != other.CurrentHP)
		{
			return false;
		}
		if (MaxHP != other.MaxHP)
		{
			return false;
		}
		if (Damage != other.Damage)
		{
			return false;
		}
		if (Hurt != other.Hurt)
		{
			return false;
		}
		if (Cure != other.Cure)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (HeroID != 0)
		{
			num ^= HeroID.GetHashCode();
		}
		if (CurrentHP != 0L)
		{
			num ^= CurrentHP.GetHashCode();
		}
		if (MaxHP != 0L)
		{
			num ^= MaxHP.GetHashCode();
		}
		if (Damage != 0L)
		{
			num ^= Damage.GetHashCode();
		}
		if (Hurt != 0L)
		{
			num ^= Hurt.GetHashCode();
		}
		if (Cure != 0L)
		{
			num ^= Cure.GetHashCode();
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
		if (HeroID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(HeroID);
		}
		if (CurrentHP != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(CurrentHP);
		}
		if (MaxHP != 0L)
		{
			output.WriteRawTag(24);
			output.WriteInt64(MaxHP);
		}
		if (Damage != 0L)
		{
			output.WriteRawTag(32);
			output.WriteInt64(Damage);
		}
		if (Hurt != 0L)
		{
			output.WriteRawTag(40);
			output.WriteInt64(Hurt);
		}
		if (Cure != 0L)
		{
			output.WriteRawTag(48);
			output.WriteInt64(Cure);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (HeroID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HeroID);
		}
		if (CurrentHP != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(CurrentHP);
		}
		if (MaxHP != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(MaxHP);
		}
		if (Damage != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Damage);
		}
		if (Hurt != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Hurt);
		}
		if (Cure != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Cure);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharResultInfo other)
	{
		if (other != null)
		{
			if (other.HeroID != 0)
			{
				HeroID = other.HeroID;
			}
			if (other.CurrentHP != 0L)
			{
				CurrentHP = other.CurrentHP;
			}
			if (other.MaxHP != 0L)
			{
				MaxHP = other.MaxHP;
			}
			if (other.Damage != 0L)
			{
				Damage = other.Damage;
			}
			if (other.Hurt != 0L)
			{
				Hurt = other.Hurt;
			}
			if (other.Cure != 0L)
			{
				Cure = other.Cure;
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
				HeroID = input.ReadInt32();
				break;
			case 16u:
				CurrentHP = input.ReadInt64();
				break;
			case 24u:
				MaxHP = input.ReadInt64();
				break;
			case 32u:
				Damage = input.ReadInt64();
				break;
			case 40u:
				Hurt = input.ReadInt64();
				break;
			case 48u:
				Cure = input.ReadInt64();
				break;
			}
		}
	}
}
