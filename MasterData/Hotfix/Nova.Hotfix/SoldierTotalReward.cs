using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierTotalReward : IMessage<SoldierTotalReward>, IMessage, IEquatable<SoldierTotalReward>, IDeepCloneable<SoldierTotalReward>
{
	private static readonly MessageParser<SoldierTotalReward> _parser = new MessageParser<SoldierTotalReward>(() => new SoldierTotalReward());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int SeasonIdFieldNumber = 2;

	private int seasonId_;

	public const int LevelFieldNumber = 3;

	private int level_;

	public const int NeedExpFieldNumber = 4;

	private int needExp_;

	public const int RewardIdFieldNumber = 5;

	private int rewardId_;

	public const int RewardQtyFieldNumber = 6;

	private int rewardQty_;

	public const int KeyRewardFieldNumber = 7;

	private bool keyReward_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierTotalReward> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(814);

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
	public int SeasonId
	{
		get
		{
			return seasonId_;
		}
		set
		{
			seasonId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Level
	{
		get
		{
			return level_;
		}
		set
		{
			level_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NeedExp
	{
		get
		{
			return needExp_;
		}
		set
		{
			needExp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardId
	{
		get
		{
			return rewardId_;
		}
		set
		{
			rewardId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardQty
	{
		get
		{
			return rewardQty_;
		}
		set
		{
			rewardQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool KeyReward
	{
		get
		{
			return keyReward_;
		}
		set
		{
			keyReward_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierTotalReward()
	{
	}

	[DebuggerNonUserCode]
	public SoldierTotalReward(SoldierTotalReward other)
		: this()
	{
		id_ = other.id_;
		seasonId_ = other.seasonId_;
		level_ = other.level_;
		needExp_ = other.needExp_;
		rewardId_ = other.rewardId_;
		rewardQty_ = other.rewardQty_;
		keyReward_ = other.keyReward_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierTotalReward Clone()
	{
		return new SoldierTotalReward(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierTotalReward);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierTotalReward other)
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
		if (SeasonId != other.SeasonId)
		{
			return false;
		}
		if (Level != other.Level)
		{
			return false;
		}
		if (NeedExp != other.NeedExp)
		{
			return false;
		}
		if (RewardId != other.RewardId)
		{
			return false;
		}
		if (RewardQty != other.RewardQty)
		{
			return false;
		}
		if (KeyReward != other.KeyReward)
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
		if (SeasonId != 0)
		{
			num ^= SeasonId.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (NeedExp != 0)
		{
			num ^= NeedExp.GetHashCode();
		}
		if (RewardId != 0)
		{
			num ^= RewardId.GetHashCode();
		}
		if (RewardQty != 0)
		{
			num ^= RewardQty.GetHashCode();
		}
		if (KeyReward)
		{
			num ^= KeyReward.GetHashCode();
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
		if (SeasonId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(SeasonId);
		}
		if (Level != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Level);
		}
		if (NeedExp != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(NeedExp);
		}
		if (RewardId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(RewardId);
		}
		if (RewardQty != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(RewardQty);
		}
		if (KeyReward)
		{
			output.WriteRawTag(56);
			output.WriteBool(KeyReward);
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
		if (SeasonId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SeasonId);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (NeedExp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NeedExp);
		}
		if (RewardId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardId);
		}
		if (RewardQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardQty);
		}
		if (KeyReward)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierTotalReward other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.SeasonId != 0)
			{
				SeasonId = other.SeasonId;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.NeedExp != 0)
			{
				NeedExp = other.NeedExp;
			}
			if (other.RewardId != 0)
			{
				RewardId = other.RewardId;
			}
			if (other.RewardQty != 0)
			{
				RewardQty = other.RewardQty;
			}
			if (other.KeyReward)
			{
				KeyReward = other.KeyReward;
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
				SeasonId = input.ReadInt32();
				break;
			case 24u:
				Level = input.ReadInt32();
				break;
			case 32u:
				NeedExp = input.ReadInt32();
				break;
			case 40u:
				RewardId = input.ReadInt32();
				break;
			case 48u:
				RewardQty = input.ReadInt32();
				break;
			case 56u:
				KeyReward = input.ReadBool();
				break;
			}
		}
	}
}
