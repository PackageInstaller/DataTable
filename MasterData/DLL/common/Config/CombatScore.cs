using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class CombatScore : IMessage<CombatScore>, IMessage, IEquatable<CombatScore>, IDeepCloneable<CombatScore>
{
	private static readonly MessageParser<CombatScore> _parser = new MessageParser<CombatScore>(() => new CombatScore());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int DescribeFieldNumber = 2;

	private string describe_ = "";

	public const int FloorValueFieldNumber = 3;

	private int floorValue_;

	public const int ScoreReductionFieldNumber = 4;

	private int scoreReduction_;

	public const int ExposedAddFieldNumber = 5;

	private int exposedAdd_;

	public const int AttackAddFieldNumber = 6;

	private int attackAdd_;

	public const int CombatOffFieldNumber = 7;

	private int combatOff_;

	[DebuggerNonUserCode]
	public static MessageParser<CombatScore> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[23];

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
	public string Describe
	{
		get
		{
			return describe_;
		}
		set
		{
			describe_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int FloorValue
	{
		get
		{
			return floorValue_;
		}
		set
		{
			floorValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ScoreReduction
	{
		get
		{
			return scoreReduction_;
		}
		set
		{
			scoreReduction_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ExposedAdd
	{
		get
		{
			return exposedAdd_;
		}
		set
		{
			exposedAdd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AttackAdd
	{
		get
		{
			return attackAdd_;
		}
		set
		{
			attackAdd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CombatOff
	{
		get
		{
			return combatOff_;
		}
		set
		{
			combatOff_ = value;
		}
	}

	[DebuggerNonUserCode]
	public CombatScore()
	{
	}

	[DebuggerNonUserCode]
	public CombatScore(CombatScore other)
		: this()
	{
		iD_ = other.iD_;
		describe_ = other.describe_;
		floorValue_ = other.floorValue_;
		scoreReduction_ = other.scoreReduction_;
		exposedAdd_ = other.exposedAdd_;
		attackAdd_ = other.attackAdd_;
		combatOff_ = other.combatOff_;
	}

	[DebuggerNonUserCode]
	public CombatScore Clone()
	{
		return new CombatScore(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CombatScore);
	}

	[DebuggerNonUserCode]
	public bool Equals(CombatScore other)
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
		if (Describe != other.Describe)
		{
			return false;
		}
		if (FloorValue != other.FloorValue)
		{
			return false;
		}
		if (ScoreReduction != other.ScoreReduction)
		{
			return false;
		}
		if (ExposedAdd != other.ExposedAdd)
		{
			return false;
		}
		if (AttackAdd != other.AttackAdd)
		{
			return false;
		}
		if (CombatOff != other.CombatOff)
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
		if (Describe.Length != 0)
		{
			num ^= Describe.GetHashCode();
		}
		if (FloorValue != 0)
		{
			num ^= FloorValue.GetHashCode();
		}
		if (ScoreReduction != 0)
		{
			num ^= ScoreReduction.GetHashCode();
		}
		if (ExposedAdd != 0)
		{
			num ^= ExposedAdd.GetHashCode();
		}
		if (AttackAdd != 0)
		{
			num ^= AttackAdd.GetHashCode();
		}
		if (CombatOff != 0)
		{
			num ^= CombatOff.GetHashCode();
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
		if (Describe.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Describe);
		}
		if (FloorValue != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(FloorValue);
		}
		if (ScoreReduction != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ScoreReduction);
		}
		if (ExposedAdd != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ExposedAdd);
		}
		if (AttackAdd != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(AttackAdd);
		}
		if (CombatOff != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(CombatOff);
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
		if (Describe.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Describe);
		}
		if (FloorValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorValue);
		}
		if (ScoreReduction != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ScoreReduction);
		}
		if (ExposedAdd != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ExposedAdd);
		}
		if (AttackAdd != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AttackAdd);
		}
		if (CombatOff != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CombatOff);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CombatScore other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Describe.Length != 0)
			{
				Describe = other.Describe;
			}
			if (other.FloorValue != 0)
			{
				FloorValue = other.FloorValue;
			}
			if (other.ScoreReduction != 0)
			{
				ScoreReduction = other.ScoreReduction;
			}
			if (other.ExposedAdd != 0)
			{
				ExposedAdd = other.ExposedAdd;
			}
			if (other.AttackAdd != 0)
			{
				AttackAdd = other.AttackAdd;
			}
			if (other.CombatOff != 0)
			{
				CombatOff = other.CombatOff;
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
			case 18u:
				Describe = input.ReadString();
				break;
			case 24u:
				FloorValue = input.ReadInt32();
				break;
			case 32u:
				ScoreReduction = input.ReadInt32();
				break;
			case 40u:
				ExposedAdd = input.ReadInt32();
				break;
			case 48u:
				AttackAdd = input.ReadInt32();
				break;
			case 56u:
				CombatOff = input.ReadInt32();
				break;
			}
		}
	}
}
