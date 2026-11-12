using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityReturneeLoginRewardGroup : IMessage<ActivityReturneeLoginRewardGroup>, IMessage, IEquatable<ActivityReturneeLoginRewardGroup>, IDeepCloneable<ActivityReturneeLoginRewardGroup>
{
	private static readonly MessageParser<ActivityReturneeLoginRewardGroup> _parser = new MessageParser<ActivityReturneeLoginRewardGroup>(() => new ActivityReturneeLoginRewardGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int RewardGroupIdFieldNumber = 2;

	private int rewardGroupId_;

	public const int OrderFieldNumber = 3;

	private int order_;

	public const int RewardId1FieldNumber = 4;

	private int rewardId1_;

	public const int Qty1FieldNumber = 5;

	private int qty1_;

	public const int RewardId2FieldNumber = 6;

	private int rewardId2_;

	public const int Qty2FieldNumber = 7;

	private int qty2_;

	public const int RewardId3FieldNumber = 8;

	private int rewardId3_;

	public const int Qty3FieldNumber = 9;

	private int qty3_;

	public const int RewardIconFieldNumber = 10;

	private string rewardIcon_ = "";

	public const int RewardCountFieldNumber = 11;

	private int rewardCount_;

	public const int RewardDescFieldNumber = 12;

	private string rewardDesc_ = "";

	public const int DisRareFieldNumber = 13;

	private bool disRare_;

	public const int NpcIdFieldNumber = 14;

	private int npcId_;

	public const int VoiceIdFieldNumber = 15;

	private int voiceId_;

	[DebuggerNonUserCode]
	public static MessageParser<ActivityReturneeLoginRewardGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(38);

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
	public int RewardGroupId
	{
		get
		{
			return rewardGroupId_;
		}
		set
		{
			rewardGroupId_ = value;
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
	public int RewardId3
	{
		get
		{
			return rewardId3_;
		}
		set
		{
			rewardId3_ = value;
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
	public string RewardIcon
	{
		get
		{
			return rewardIcon_;
		}
		set
		{
			rewardIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int RewardCount
	{
		get
		{
			return rewardCount_;
		}
		set
		{
			rewardCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string RewardDesc
	{
		get
		{
			return rewardDesc_;
		}
		set
		{
			rewardDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool DisRare
	{
		get
		{
			return disRare_;
		}
		set
		{
			disRare_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NpcId
	{
		get
		{
			return npcId_;
		}
		set
		{
			npcId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int VoiceId
	{
		get
		{
			return voiceId_;
		}
		set
		{
			voiceId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ActivityReturneeLoginRewardGroup()
	{
	}

	[DebuggerNonUserCode]
	public ActivityReturneeLoginRewardGroup(ActivityReturneeLoginRewardGroup other)
		: this()
	{
		id_ = other.id_;
		rewardGroupId_ = other.rewardGroupId_;
		order_ = other.order_;
		rewardId1_ = other.rewardId1_;
		qty1_ = other.qty1_;
		rewardId2_ = other.rewardId2_;
		qty2_ = other.qty2_;
		rewardId3_ = other.rewardId3_;
		qty3_ = other.qty3_;
		rewardIcon_ = other.rewardIcon_;
		rewardCount_ = other.rewardCount_;
		rewardDesc_ = other.rewardDesc_;
		disRare_ = other.disRare_;
		npcId_ = other.npcId_;
		voiceId_ = other.voiceId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityReturneeLoginRewardGroup Clone()
	{
		return new ActivityReturneeLoginRewardGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityReturneeLoginRewardGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityReturneeLoginRewardGroup other)
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
		if (RewardGroupId != other.RewardGroupId)
		{
			return false;
		}
		if (Order != other.Order)
		{
			return false;
		}
		if (RewardId1 != other.RewardId1)
		{
			return false;
		}
		if (Qty1 != other.Qty1)
		{
			return false;
		}
		if (RewardId2 != other.RewardId2)
		{
			return false;
		}
		if (Qty2 != other.Qty2)
		{
			return false;
		}
		if (RewardId3 != other.RewardId3)
		{
			return false;
		}
		if (Qty3 != other.Qty3)
		{
			return false;
		}
		if (RewardIcon != other.RewardIcon)
		{
			return false;
		}
		if (RewardCount != other.RewardCount)
		{
			return false;
		}
		if (RewardDesc != other.RewardDesc)
		{
			return false;
		}
		if (DisRare != other.DisRare)
		{
			return false;
		}
		if (NpcId != other.NpcId)
		{
			return false;
		}
		if (VoiceId != other.VoiceId)
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
		if (RewardGroupId != 0)
		{
			num ^= RewardGroupId.GetHashCode();
		}
		if (Order != 0)
		{
			num ^= Order.GetHashCode();
		}
		if (RewardId1 != 0)
		{
			num ^= RewardId1.GetHashCode();
		}
		if (Qty1 != 0)
		{
			num ^= Qty1.GetHashCode();
		}
		if (RewardId2 != 0)
		{
			num ^= RewardId2.GetHashCode();
		}
		if (Qty2 != 0)
		{
			num ^= Qty2.GetHashCode();
		}
		if (RewardId3 != 0)
		{
			num ^= RewardId3.GetHashCode();
		}
		if (Qty3 != 0)
		{
			num ^= Qty3.GetHashCode();
		}
		if (RewardIcon.Length != 0)
		{
			num ^= RewardIcon.GetHashCode();
		}
		if (RewardCount != 0)
		{
			num ^= RewardCount.GetHashCode();
		}
		if (RewardDesc.Length != 0)
		{
			num ^= RewardDesc.GetHashCode();
		}
		if (DisRare)
		{
			num ^= DisRare.GetHashCode();
		}
		if (NpcId != 0)
		{
			num ^= NpcId.GetHashCode();
		}
		if (VoiceId != 0)
		{
			num ^= VoiceId.GetHashCode();
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
		if (RewardGroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(RewardGroupId);
		}
		if (Order != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Order);
		}
		if (RewardId1 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(RewardId1);
		}
		if (Qty1 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Qty1);
		}
		if (RewardId2 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(RewardId2);
		}
		if (Qty2 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Qty2);
		}
		if (RewardId3 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(RewardId3);
		}
		if (Qty3 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Qty3);
		}
		if (RewardIcon.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(RewardIcon);
		}
		if (RewardCount != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(RewardCount);
		}
		if (RewardDesc.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(RewardDesc);
		}
		if (DisRare)
		{
			output.WriteRawTag(104);
			output.WriteBool(DisRare);
		}
		if (NpcId != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(NpcId);
		}
		if (VoiceId != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(VoiceId);
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
		if (RewardGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardGroupId);
		}
		if (Order != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Order);
		}
		if (RewardId1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardId1);
		}
		if (Qty1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty1);
		}
		if (RewardId2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardId2);
		}
		if (Qty2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty2);
		}
		if (RewardId3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardId3);
		}
		if (Qty3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty3);
		}
		if (RewardIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RewardIcon);
		}
		if (RewardCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardCount);
		}
		if (RewardDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RewardDesc);
		}
		if (DisRare)
		{
			num += 2;
		}
		if (NpcId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NpcId);
		}
		if (VoiceId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(VoiceId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityReturneeLoginRewardGroup other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.RewardGroupId != 0)
			{
				RewardGroupId = other.RewardGroupId;
			}
			if (other.Order != 0)
			{
				Order = other.Order;
			}
			if (other.RewardId1 != 0)
			{
				RewardId1 = other.RewardId1;
			}
			if (other.Qty1 != 0)
			{
				Qty1 = other.Qty1;
			}
			if (other.RewardId2 != 0)
			{
				RewardId2 = other.RewardId2;
			}
			if (other.Qty2 != 0)
			{
				Qty2 = other.Qty2;
			}
			if (other.RewardId3 != 0)
			{
				RewardId3 = other.RewardId3;
			}
			if (other.Qty3 != 0)
			{
				Qty3 = other.Qty3;
			}
			if (other.RewardIcon.Length != 0)
			{
				RewardIcon = other.RewardIcon;
			}
			if (other.RewardCount != 0)
			{
				RewardCount = other.RewardCount;
			}
			if (other.RewardDesc.Length != 0)
			{
				RewardDesc = other.RewardDesc;
			}
			if (other.DisRare)
			{
				DisRare = other.DisRare;
			}
			if (other.NpcId != 0)
			{
				NpcId = other.NpcId;
			}
			if (other.VoiceId != 0)
			{
				VoiceId = other.VoiceId;
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
				RewardGroupId = input.ReadInt32();
				break;
			case 24u:
				Order = input.ReadInt32();
				break;
			case 32u:
				RewardId1 = input.ReadInt32();
				break;
			case 40u:
				Qty1 = input.ReadInt32();
				break;
			case 48u:
				RewardId2 = input.ReadInt32();
				break;
			case 56u:
				Qty2 = input.ReadInt32();
				break;
			case 64u:
				RewardId3 = input.ReadInt32();
				break;
			case 72u:
				Qty3 = input.ReadInt32();
				break;
			case 82u:
				RewardIcon = input.ReadString();
				break;
			case 88u:
				RewardCount = input.ReadInt32();
				break;
			case 98u:
				RewardDesc = input.ReadString();
				break;
			case 104u:
				DisRare = input.ReadBool();
				break;
			case 112u:
				NpcId = input.ReadInt32();
				break;
			case 120u:
				VoiceId = input.ReadInt32();
				break;
			}
		}
	}
}
