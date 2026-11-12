using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierQuest : IMessage<SoldierQuest>, IMessage, IEquatable<SoldierQuest>, IDeepCloneable<SoldierQuest>
{
	private static readonly MessageParser<SoldierQuest> _parser = new MessageParser<SoldierQuest>(() => new SoldierQuest());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupFieldNumber = 2;

	private int group_;

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int CompleteCondFieldNumber = 4;

	private int completeCond_;

	public const int CompleteCondParamsFieldNumber = 5;

	private string completeCondParams_ = "";

	public const int Reward1FieldNumber = 6;

	private int reward1_;

	public const int RewardQty1FieldNumber = 7;

	private int rewardQty1_;

	public const int Reward2FieldNumber = 8;

	private int reward2_;

	public const int RewardQty2FieldNumber = 9;

	private int rewardQty2_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierQuest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(784);

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
	public string Desc
	{
		get
		{
			return desc_;
		}
		set
		{
			desc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int CompleteCond
	{
		get
		{
			return completeCond_;
		}
		set
		{
			completeCond_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string CompleteCondParams
	{
		get
		{
			return completeCondParams_;
		}
		set
		{
			completeCondParams_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public SoldierQuest()
	{
	}

	[DebuggerNonUserCode]
	public SoldierQuest(SoldierQuest other)
		: this()
	{
		id_ = other.id_;
		group_ = other.group_;
		desc_ = other.desc_;
		completeCond_ = other.completeCond_;
		completeCondParams_ = other.completeCondParams_;
		reward1_ = other.reward1_;
		rewardQty1_ = other.rewardQty1_;
		reward2_ = other.reward2_;
		rewardQty2_ = other.rewardQty2_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierQuest Clone()
	{
		return new SoldierQuest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierQuest);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierQuest other)
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
		if (Desc != other.Desc)
		{
			return false;
		}
		if (CompleteCond != other.CompleteCond)
		{
			return false;
		}
		if (CompleteCondParams != other.CompleteCondParams)
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
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (CompleteCond != 0)
		{
			num ^= CompleteCond.GetHashCode();
		}
		if (CompleteCondParams.Length != 0)
		{
			num ^= CompleteCondParams.GetHashCode();
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
		if (Desc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Desc);
		}
		if (CompleteCond != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CompleteCond);
		}
		if (CompleteCondParams.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(CompleteCondParams);
		}
		if (Reward1 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Reward1);
		}
		if (RewardQty1 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(RewardQty1);
		}
		if (Reward2 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Reward2);
		}
		if (RewardQty2 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(RewardQty2);
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
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (CompleteCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompleteCond);
		}
		if (CompleteCondParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CompleteCondParams);
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
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierQuest other)
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
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.CompleteCond != 0)
			{
				CompleteCond = other.CompleteCond;
			}
			if (other.CompleteCondParams.Length != 0)
			{
				CompleteCondParams = other.CompleteCondParams;
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
			case 26u:
				Desc = input.ReadString();
				break;
			case 32u:
				CompleteCond = input.ReadInt32();
				break;
			case 42u:
				CompleteCondParams = input.ReadString();
				break;
			case 48u:
				Reward1 = input.ReadInt32();
				break;
			case 56u:
				RewardQty1 = input.ReadInt32();
				break;
			case 64u:
				Reward2 = input.ReadInt32();
				break;
			case 72u:
				RewardQty2 = input.ReadInt32();
				break;
			}
		}
	}
}
