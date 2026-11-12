using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ScoreBossReward : IMessage<ScoreBossReward>, IMessage, IEquatable<ScoreBossReward>, IDeepCloneable<ScoreBossReward>
{
	private static readonly MessageParser<ScoreBossReward> _parser = new MessageParser<ScoreBossReward>(() => new ScoreBossReward());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int StarNeedFieldNumber = 2;

	private int starNeed_;

	public const int RewardItemId1FieldNumber = 3;

	private int rewardItemId1_;

	public const int RewardNum1FieldNumber = 4;

	private int rewardNum1_;

	public const int RewardItemId2FieldNumber = 5;

	private int rewardItemId2_;

	public const int RewardNum2FieldNumber = 6;

	private int rewardNum2_;

	[DebuggerNonUserCode]
	public static MessageParser<ScoreBossReward> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(702);

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
	public int StarNeed
	{
		get
		{
			return starNeed_;
		}
		set
		{
			starNeed_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardItemId1
	{
		get
		{
			return rewardItemId1_;
		}
		set
		{
			rewardItemId1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardNum1
	{
		get
		{
			return rewardNum1_;
		}
		set
		{
			rewardNum1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardItemId2
	{
		get
		{
			return rewardItemId2_;
		}
		set
		{
			rewardItemId2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardNum2
	{
		get
		{
			return rewardNum2_;
		}
		set
		{
			rewardNum2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ScoreBossReward()
	{
	}

	[DebuggerNonUserCode]
	public ScoreBossReward(ScoreBossReward other)
		: this()
	{
		id_ = other.id_;
		starNeed_ = other.starNeed_;
		rewardItemId1_ = other.rewardItemId1_;
		rewardNum1_ = other.rewardNum1_;
		rewardItemId2_ = other.rewardItemId2_;
		rewardNum2_ = other.rewardNum2_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ScoreBossReward Clone()
	{
		return new ScoreBossReward(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ScoreBossReward);
	}

	[DebuggerNonUserCode]
	public bool Equals(ScoreBossReward other)
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
		if (StarNeed != other.StarNeed)
		{
			return false;
		}
		if (RewardItemId1 != other.RewardItemId1)
		{
			return false;
		}
		if (RewardNum1 != other.RewardNum1)
		{
			return false;
		}
		if (RewardItemId2 != other.RewardItemId2)
		{
			return false;
		}
		if (RewardNum2 != other.RewardNum2)
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
		if (StarNeed != 0)
		{
			num ^= StarNeed.GetHashCode();
		}
		if (RewardItemId1 != 0)
		{
			num ^= RewardItemId1.GetHashCode();
		}
		if (RewardNum1 != 0)
		{
			num ^= RewardNum1.GetHashCode();
		}
		if (RewardItemId2 != 0)
		{
			num ^= RewardItemId2.GetHashCode();
		}
		if (RewardNum2 != 0)
		{
			num ^= RewardNum2.GetHashCode();
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
		if (StarNeed != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(StarNeed);
		}
		if (RewardItemId1 != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(RewardItemId1);
		}
		if (RewardNum1 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(RewardNum1);
		}
		if (RewardItemId2 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(RewardItemId2);
		}
		if (RewardNum2 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(RewardNum2);
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
		if (StarNeed != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StarNeed);
		}
		if (RewardItemId1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardItemId1);
		}
		if (RewardNum1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardNum1);
		}
		if (RewardItemId2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardItemId2);
		}
		if (RewardNum2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardNum2);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ScoreBossReward other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.StarNeed != 0)
			{
				StarNeed = other.StarNeed;
			}
			if (other.RewardItemId1 != 0)
			{
				RewardItemId1 = other.RewardItemId1;
			}
			if (other.RewardNum1 != 0)
			{
				RewardNum1 = other.RewardNum1;
			}
			if (other.RewardItemId2 != 0)
			{
				RewardItemId2 = other.RewardItemId2;
			}
			if (other.RewardNum2 != 0)
			{
				RewardNum2 = other.RewardNum2;
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
				StarNeed = input.ReadInt32();
				break;
			case 24u:
				RewardItemId1 = input.ReadInt32();
				break;
			case 32u:
				RewardNum1 = input.ReadInt32();
				break;
			case 40u:
				RewardItemId2 = input.ReadInt32();
				break;
			case 48u:
				RewardNum2 = input.ReadInt32();
				break;
			}
		}
	}
}
