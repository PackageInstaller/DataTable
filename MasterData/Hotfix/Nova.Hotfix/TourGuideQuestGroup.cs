using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TourGuideQuestGroup : IMessage<TourGuideQuestGroup>, IMessage, IEquatable<TourGuideQuestGroup>, IDeepCloneable<TourGuideQuestGroup>
{
	private static readonly MessageParser<TourGuideQuestGroup> _parser = new MessageParser<TourGuideQuestGroup>(() => new TourGuideQuestGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int OrderFieldNumber = 2;

	private int order_;

	public const int Reward1FieldNumber = 3;

	private int reward1_;

	public const int RewardQty1FieldNumber = 4;

	private int rewardQty1_;

	public const int Reward2FieldNumber = 5;

	private int reward2_;

	public const int RewardQty2FieldNumber = 6;

	private int rewardQty2_;

	public const int Reward3FieldNumber = 7;

	private int reward3_;

	public const int RewardQty3FieldNumber = 8;

	private int rewardQty3_;

	public const int Reward4FieldNumber = 9;

	private int reward4_;

	public const int RewardQty4FieldNumber = 10;

	private int rewardQty4_;

	public const int Reward5FieldNumber = 11;

	private int reward5_;

	public const int RewardQty5FieldNumber = 12;

	private int rewardQty5_;

	public const int Reward6FieldNumber = 13;

	private int reward6_;

	public const int RewardQty6FieldNumber = 14;

	private int rewardQty6_;

	[DebuggerNonUserCode]
	public static MessageParser<TourGuideQuestGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(946);

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
	public int Order
	{
		get
		{
			return order_;
		}
		set
		{
			order_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward1
	{
		get
		{
			return reward1_;
		}
		set
		{
			reward1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardQty1
	{
		get
		{
			return rewardQty1_;
		}
		set
		{
			rewardQty1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward2
	{
		get
		{
			return reward2_;
		}
		set
		{
			reward2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardQty2
	{
		get
		{
			return rewardQty2_;
		}
		set
		{
			rewardQty2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward3
	{
		get
		{
			return reward3_;
		}
		set
		{
			reward3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardQty3
	{
		get
		{
			return rewardQty3_;
		}
		set
		{
			rewardQty3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward4
	{
		get
		{
			return reward4_;
		}
		set
		{
			reward4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardQty4
	{
		get
		{
			return rewardQty4_;
		}
		set
		{
			rewardQty4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward5
	{
		get
		{
			return reward5_;
		}
		set
		{
			reward5_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardQty5
	{
		get
		{
			return rewardQty5_;
		}
		set
		{
			rewardQty5_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward6
	{
		get
		{
			return reward6_;
		}
		set
		{
			reward6_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardQty6
	{
		get
		{
			return rewardQty6_;
		}
		set
		{
			rewardQty6_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TourGuideQuestGroup()
	{
	}

	[DebuggerNonUserCode]
	public TourGuideQuestGroup(TourGuideQuestGroup other)
		: this()
	{
		id_ = other.id_;
		order_ = other.order_;
		reward1_ = other.reward1_;
		rewardQty1_ = other.rewardQty1_;
		reward2_ = other.reward2_;
		rewardQty2_ = other.rewardQty2_;
		reward3_ = other.reward3_;
		rewardQty3_ = other.rewardQty3_;
		reward4_ = other.reward4_;
		rewardQty4_ = other.rewardQty4_;
		reward5_ = other.reward5_;
		rewardQty5_ = other.rewardQty5_;
		reward6_ = other.reward6_;
		rewardQty6_ = other.rewardQty6_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TourGuideQuestGroup Clone()
	{
		return new TourGuideQuestGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TourGuideQuestGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(TourGuideQuestGroup other)
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
		if (Order != other.Order)
		{
			return false;
		}
		if (Reward1 != other.Reward1)
		{
			return false;
		}
		if (RewardQty1 != other.RewardQty1)
		{
			return false;
		}
		if (Reward2 != other.Reward2)
		{
			return false;
		}
		if (RewardQty2 != other.RewardQty2)
		{
			return false;
		}
		if (Reward3 != other.Reward3)
		{
			return false;
		}
		if (RewardQty3 != other.RewardQty3)
		{
			return false;
		}
		if (Reward4 != other.Reward4)
		{
			return false;
		}
		if (RewardQty4 != other.RewardQty4)
		{
			return false;
		}
		if (Reward5 != other.Reward5)
		{
			return false;
		}
		if (RewardQty5 != other.RewardQty5)
		{
			return false;
		}
		if (Reward6 != other.Reward6)
		{
			return false;
		}
		if (RewardQty6 != other.RewardQty6)
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
		if (Order != 0)
		{
			num ^= Order.GetHashCode();
		}
		if (Reward1 != 0)
		{
			num ^= Reward1.GetHashCode();
		}
		if (RewardQty1 != 0)
		{
			num ^= RewardQty1.GetHashCode();
		}
		if (Reward2 != 0)
		{
			num ^= Reward2.GetHashCode();
		}
		if (RewardQty2 != 0)
		{
			num ^= RewardQty2.GetHashCode();
		}
		if (Reward3 != 0)
		{
			num ^= Reward3.GetHashCode();
		}
		if (RewardQty3 != 0)
		{
			num ^= RewardQty3.GetHashCode();
		}
		if (Reward4 != 0)
		{
			num ^= Reward4.GetHashCode();
		}
		if (RewardQty4 != 0)
		{
			num ^= RewardQty4.GetHashCode();
		}
		if (Reward5 != 0)
		{
			num ^= Reward5.GetHashCode();
		}
		if (RewardQty5 != 0)
		{
			num ^= RewardQty5.GetHashCode();
		}
		if (Reward6 != 0)
		{
			num ^= Reward6.GetHashCode();
		}
		if (RewardQty6 != 0)
		{
			num ^= RewardQty6.GetHashCode();
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
		if (Order != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Order);
		}
		if (Reward1 != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Reward1);
		}
		if (RewardQty1 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(RewardQty1);
		}
		if (Reward2 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Reward2);
		}
		if (RewardQty2 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(RewardQty2);
		}
		if (Reward3 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Reward3);
		}
		if (RewardQty3 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(RewardQty3);
		}
		if (Reward4 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Reward4);
		}
		if (RewardQty4 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(RewardQty4);
		}
		if (Reward5 != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(Reward5);
		}
		if (RewardQty5 != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(RewardQty5);
		}
		if (Reward6 != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(Reward6);
		}
		if (RewardQty6 != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(RewardQty6);
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
		if (Order != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Order);
		}
		if (Reward1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward1);
		}
		if (RewardQty1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardQty1);
		}
		if (Reward2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward2);
		}
		if (RewardQty2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardQty2);
		}
		if (Reward3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward3);
		}
		if (RewardQty3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardQty3);
		}
		if (Reward4 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward4);
		}
		if (RewardQty4 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardQty4);
		}
		if (Reward5 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward5);
		}
		if (RewardQty5 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardQty5);
		}
		if (Reward6 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward6);
		}
		if (RewardQty6 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardQty6);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TourGuideQuestGroup other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Order != 0)
			{
				Order = other.Order;
			}
			if (other.Reward1 != 0)
			{
				Reward1 = other.Reward1;
			}
			if (other.RewardQty1 != 0)
			{
				RewardQty1 = other.RewardQty1;
			}
			if (other.Reward2 != 0)
			{
				Reward2 = other.Reward2;
			}
			if (other.RewardQty2 != 0)
			{
				RewardQty2 = other.RewardQty2;
			}
			if (other.Reward3 != 0)
			{
				Reward3 = other.Reward3;
			}
			if (other.RewardQty3 != 0)
			{
				RewardQty3 = other.RewardQty3;
			}
			if (other.Reward4 != 0)
			{
				Reward4 = other.Reward4;
			}
			if (other.RewardQty4 != 0)
			{
				RewardQty4 = other.RewardQty4;
			}
			if (other.Reward5 != 0)
			{
				Reward5 = other.Reward5;
			}
			if (other.RewardQty5 != 0)
			{
				RewardQty5 = other.RewardQty5;
			}
			if (other.Reward6 != 0)
			{
				Reward6 = other.Reward6;
			}
			if (other.RewardQty6 != 0)
			{
				RewardQty6 = other.RewardQty6;
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
				Order = input.ReadInt32();
				break;
			case 24u:
				Reward1 = input.ReadInt32();
				break;
			case 32u:
				RewardQty1 = input.ReadInt32();
				break;
			case 40u:
				Reward2 = input.ReadInt32();
				break;
			case 48u:
				RewardQty2 = input.ReadInt32();
				break;
			case 56u:
				Reward3 = input.ReadInt32();
				break;
			case 64u:
				RewardQty3 = input.ReadInt32();
				break;
			case 72u:
				Reward4 = input.ReadInt32();
				break;
			case 80u:
				RewardQty4 = input.ReadInt32();
				break;
			case 88u:
				Reward5 = input.ReadInt32();
				break;
			case 96u:
				RewardQty5 = input.ReadInt32();
				break;
			case 104u:
				Reward6 = input.ReadInt32();
				break;
			case 112u:
				RewardQty6 = input.ReadInt32();
				break;
			}
		}
	}
}
