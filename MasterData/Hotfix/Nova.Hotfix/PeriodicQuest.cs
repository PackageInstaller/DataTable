using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PeriodicQuest : IMessage<PeriodicQuest>, IMessage, IEquatable<PeriodicQuest>, IDeepCloneable<PeriodicQuest>
{
	private static readonly MessageParser<PeriodicQuest> _parser = new MessageParser<PeriodicQuest>(() => new PeriodicQuest());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int BelongFieldNumber = 2;

	private int belong_;

	public const int GroupidFieldNumber = 3;

	private int groupid_;

	public const int TitleFieldNumber = 4;

	private string title_ = "";

	public const int JumpToFieldNumber = 5;

	private int jumpTo_;

	public const int RewardFieldNumber = 6;

	private int reward_;

	public const int RewardQtyFieldNumber = 7;

	private int rewardQty_;

	public const int Reward2FieldNumber = 8;

	private int reward2_;

	public const int RewardQty2FieldNumber = 9;

	private int rewardQty2_;

	[DebuggerNonUserCode]
	public static MessageParser<PeriodicQuest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(644);

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
	public int Belong
	{
		get
		{
			return belong_;
		}
		set
		{
			belong_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Groupid
	{
		get
		{
			return groupid_;
		}
		set
		{
			groupid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Title
	{
		get
		{
			return title_;
		}
		set
		{
			title_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int JumpTo
	{
		get
		{
			return jumpTo_;
		}
		set
		{
			jumpTo_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward
	{
		get
		{
			return reward_;
		}
		set
		{
			reward_ = value;
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
	public PeriodicQuest()
	{
	}

	[DebuggerNonUserCode]
	public PeriodicQuest(PeriodicQuest other)
		: this()
	{
		id_ = other.id_;
		belong_ = other.belong_;
		groupid_ = other.groupid_;
		title_ = other.title_;
		jumpTo_ = other.jumpTo_;
		reward_ = other.reward_;
		rewardQty_ = other.rewardQty_;
		reward2_ = other.reward2_;
		rewardQty2_ = other.rewardQty2_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PeriodicQuest Clone()
	{
		return new PeriodicQuest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PeriodicQuest);
	}

	[DebuggerNonUserCode]
	public bool Equals(PeriodicQuest other)
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
		if (Belong != other.Belong)
		{
			return false;
		}
		if (Groupid != other.Groupid)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (JumpTo != other.JumpTo)
		{
			return false;
		}
		if (Reward != other.Reward)
		{
			return false;
		}
		if (RewardQty != other.RewardQty)
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
		if (Belong != 0)
		{
			num ^= Belong.GetHashCode();
		}
		if (Groupid != 0)
		{
			num ^= Groupid.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (JumpTo != 0)
		{
			num ^= JumpTo.GetHashCode();
		}
		if (Reward != 0)
		{
			num ^= Reward.GetHashCode();
		}
		if (RewardQty != 0)
		{
			num ^= RewardQty.GetHashCode();
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
		if (Belong != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Belong);
		}
		if (Groupid != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Groupid);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Title);
		}
		if (JumpTo != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(JumpTo);
		}
		if (Reward != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Reward);
		}
		if (RewardQty != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(RewardQty);
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
		if (Belong != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Belong);
		}
		if (Groupid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Groupid);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (JumpTo != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(JumpTo);
		}
		if (Reward != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward);
		}
		if (RewardQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardQty);
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
	public void MergeFrom(PeriodicQuest other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Belong != 0)
			{
				Belong = other.Belong;
			}
			if (other.Groupid != 0)
			{
				Groupid = other.Groupid;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.JumpTo != 0)
			{
				JumpTo = other.JumpTo;
			}
			if (other.Reward != 0)
			{
				Reward = other.Reward;
			}
			if (other.RewardQty != 0)
			{
				RewardQty = other.RewardQty;
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
				Belong = input.ReadInt32();
				break;
			case 24u:
				Groupid = input.ReadInt32();
				break;
			case 34u:
				Title = input.ReadString();
				break;
			case 40u:
				JumpTo = input.ReadInt32();
				break;
			case 48u:
				Reward = input.ReadInt32();
				break;
			case 56u:
				RewardQty = input.ReadInt32();
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
