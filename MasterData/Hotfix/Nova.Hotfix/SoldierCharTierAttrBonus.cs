using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierCharTierAttrBonus : IMessage<SoldierCharTierAttrBonus>, IMessage, IEquatable<SoldierCharTierAttrBonus>, IDeepCloneable<SoldierCharTierAttrBonus>
{
	private static readonly MessageParser<SoldierCharTierAttrBonus> _parser = new MessageParser<SoldierCharTierAttrBonus>(() => new SoldierCharTierAttrBonus());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int HpFieldNumber = 2;

	private int hp_;

	public const int AtkFieldNumber = 3;

	private int atk_;

	public const int DefFieldNumber = 4;

	private int def_;

	public const int CritRateFieldNumber = 5;

	private int critRate_;

	public const int CritPowerFieldNumber = 6;

	private int critPower_;

	public const int ATKSPDPFieldNumber = 7;

	private int aTKSPDP_;

	public const int RecoveryFieldNumber = 8;

	private int recovery_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierCharTierAttrBonus> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(742);

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
	public int Hp
	{
		get
		{
			return hp_;
		}
		set
		{
			hp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Atk
	{
		get
		{
			return atk_;
		}
		set
		{
			atk_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Def
	{
		get
		{
			return def_;
		}
		set
		{
			def_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CritRate
	{
		get
		{
			return critRate_;
		}
		set
		{
			critRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CritPower
	{
		get
		{
			return critPower_;
		}
		set
		{
			critPower_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ATKSPDP
	{
		get
		{
			return aTKSPDP_;
		}
		set
		{
			aTKSPDP_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Recovery
	{
		get
		{
			return recovery_;
		}
		set
		{
			recovery_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierCharTierAttrBonus()
	{
	}

	[DebuggerNonUserCode]
	public SoldierCharTierAttrBonus(SoldierCharTierAttrBonus other)
		: this()
	{
		id_ = other.id_;
		hp_ = other.hp_;
		atk_ = other.atk_;
		def_ = other.def_;
		critRate_ = other.critRate_;
		critPower_ = other.critPower_;
		aTKSPDP_ = other.aTKSPDP_;
		recovery_ = other.recovery_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierCharTierAttrBonus Clone()
	{
		return new SoldierCharTierAttrBonus(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierCharTierAttrBonus);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierCharTierAttrBonus other)
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
		if (Hp != other.Hp)
		{
			return false;
		}
		if (Atk != other.Atk)
		{
			return false;
		}
		if (Def != other.Def)
		{
			return false;
		}
		if (CritRate != other.CritRate)
		{
			return false;
		}
		if (CritPower != other.CritPower)
		{
			return false;
		}
		if (ATKSPDP != other.ATKSPDP)
		{
			return false;
		}
		if (Recovery != other.Recovery)
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
		if (Hp != 0)
		{
			num ^= Hp.GetHashCode();
		}
		if (Atk != 0)
		{
			num ^= Atk.GetHashCode();
		}
		if (Def != 0)
		{
			num ^= Def.GetHashCode();
		}
		if (CritRate != 0)
		{
			num ^= CritRate.GetHashCode();
		}
		if (CritPower != 0)
		{
			num ^= CritPower.GetHashCode();
		}
		if (ATKSPDP != 0)
		{
			num ^= ATKSPDP.GetHashCode();
		}
		if (Recovery != 0)
		{
			num ^= Recovery.GetHashCode();
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
		if (Hp != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Hp);
		}
		if (Atk != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Atk);
		}
		if (Def != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Def);
		}
		if (CritRate != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(CritRate);
		}
		if (CritPower != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(CritPower);
		}
		if (ATKSPDP != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ATKSPDP);
		}
		if (Recovery != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Recovery);
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
		if (Hp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Hp);
		}
		if (Atk != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Atk);
		}
		if (Def != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Def);
		}
		if (CritRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CritRate);
		}
		if (CritPower != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CritPower);
		}
		if (ATKSPDP != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ATKSPDP);
		}
		if (Recovery != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Recovery);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierCharTierAttrBonus other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Hp != 0)
			{
				Hp = other.Hp;
			}
			if (other.Atk != 0)
			{
				Atk = other.Atk;
			}
			if (other.Def != 0)
			{
				Def = other.Def;
			}
			if (other.CritRate != 0)
			{
				CritRate = other.CritRate;
			}
			if (other.CritPower != 0)
			{
				CritPower = other.CritPower;
			}
			if (other.ATKSPDP != 0)
			{
				ATKSPDP = other.ATKSPDP;
			}
			if (other.Recovery != 0)
			{
				Recovery = other.Recovery;
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
				Hp = input.ReadInt32();
				break;
			case 24u:
				Atk = input.ReadInt32();
				break;
			case 32u:
				Def = input.ReadInt32();
				break;
			case 40u:
				CritRate = input.ReadInt32();
				break;
			case 48u:
				CritPower = input.ReadInt32();
				break;
			case 56u:
				ATKSPDP = input.ReadInt32();
				break;
			case 64u:
				Recovery = input.ReadInt32();
				break;
			}
		}
	}
}
