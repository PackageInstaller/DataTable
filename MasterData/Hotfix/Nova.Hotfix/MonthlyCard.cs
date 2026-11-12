using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MonthlyCard : IMessage<MonthlyCard>, IMessage, IEquatable<MonthlyCard>, IDeepCloneable<MonthlyCard>
{
	private static readonly MessageParser<MonthlyCard> _parser = new MessageParser<MonthlyCard>(() => new MonthlyCard());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CardIdFieldNumber = 2;

	private int cardId_;

	public const int RewardId1FieldNumber = 3;

	private int rewardId1_;

	public const int RewardNum1FieldNumber = 4;

	private int rewardNum1_;

	public const int RewardId2FieldNumber = 5;

	private int rewardId2_;

	public const int RewardNum2FieldNumber = 6;

	private int rewardNum2_;

	[DebuggerNonUserCode]
	public static MessageParser<MonthlyCard> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(592);

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
	public int CardId
	{
		get
		{
			return cardId_;
		}
		set
		{
			cardId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardId1
	{
		get
		{
			return rewardId1_;
		}
		set
		{
			rewardId1_ = value;
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
	public int RewardId2
	{
		get
		{
			return rewardId2_;
		}
		set
		{
			rewardId2_ = value;
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
	public MonthlyCard()
	{
	}

	[DebuggerNonUserCode]
	public MonthlyCard(MonthlyCard other)
		: this()
	{
		id_ = other.id_;
		cardId_ = other.cardId_;
		rewardId1_ = other.rewardId1_;
		rewardNum1_ = other.rewardNum1_;
		rewardId2_ = other.rewardId2_;
		rewardNum2_ = other.rewardNum2_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MonthlyCard Clone()
	{
		return new MonthlyCard(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MonthlyCard);
	}

	[DebuggerNonUserCode]
	public bool Equals(MonthlyCard other)
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
		if (CardId != other.CardId)
		{
			return false;
		}
		if (RewardId1 != other.RewardId1)
		{
			return false;
		}
		if (RewardNum1 != other.RewardNum1)
		{
			return false;
		}
		if (RewardId2 != other.RewardId2)
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
		if (CardId != 0)
		{
			num ^= CardId.GetHashCode();
		}
		if (RewardId1 != 0)
		{
			num ^= RewardId1.GetHashCode();
		}
		if (RewardNum1 != 0)
		{
			num ^= RewardNum1.GetHashCode();
		}
		if (RewardId2 != 0)
		{
			num ^= RewardId2.GetHashCode();
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
		if (CardId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CardId);
		}
		if (RewardId1 != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(RewardId1);
		}
		if (RewardNum1 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(RewardNum1);
		}
		if (RewardId2 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(RewardId2);
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
		if (CardId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CardId);
		}
		if (RewardId1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardId1);
		}
		if (RewardNum1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardNum1);
		}
		if (RewardId2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardId2);
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
	public void MergeFrom(MonthlyCard other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.CardId != 0)
			{
				CardId = other.CardId;
			}
			if (other.RewardId1 != 0)
			{
				RewardId1 = other.RewardId1;
			}
			if (other.RewardNum1 != 0)
			{
				RewardNum1 = other.RewardNum1;
			}
			if (other.RewardId2 != 0)
			{
				RewardId2 = other.RewardId2;
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
				CardId = input.ReadInt32();
				break;
			case 24u:
				RewardId1 = input.ReadInt32();
				break;
			case 32u:
				RewardNum1 = input.ReadInt32();
				break;
			case 40u:
				RewardId2 = input.ReadInt32();
				break;
			case 48u:
				RewardNum2 = input.ReadInt32();
				break;
			}
		}
	}
}
