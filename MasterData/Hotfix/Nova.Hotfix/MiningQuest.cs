using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MiningQuest : IMessage<MiningQuest>, IMessage, IEquatable<MiningQuest>, IDeepCloneable<MiningQuest>
{
	private static readonly MessageParser<MiningQuest> _parser = new MessageParser<MiningQuest>(() => new MiningQuest());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int ActivityIdFieldNumber = 3;

	private int activityId_;

	public const int QuestDesFieldNumber = 4;

	private string questDes_ = "";

	public const int CompleteCondFieldNumber = 5;

	private int completeCond_;

	public const int CompleteCondParamsFieldNumber = 6;

	private string completeCondParams_ = "";

	public const int JumpToFieldNumber = 7;

	private int jumpTo_;

	public const int RewardIdFieldNumber = 8;

	private int rewardId_;

	public const int RewardQtyFieldNumber = 9;

	private int rewardQty_;

	[DebuggerNonUserCode]
	public static MessageParser<MiningQuest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(556);

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
	public int GroupId
	{
		get
		{
			return groupId_;
		}
		set
		{
			groupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ActivityId
	{
		get
		{
			return activityId_;
		}
		set
		{
			activityId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string QuestDes
	{
		get
		{
			return questDes_;
		}
		set
		{
			questDes_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public MiningQuest()
	{
	}

	[DebuggerNonUserCode]
	public MiningQuest(MiningQuest other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		activityId_ = other.activityId_;
		questDes_ = other.questDes_;
		completeCond_ = other.completeCond_;
		completeCondParams_ = other.completeCondParams_;
		jumpTo_ = other.jumpTo_;
		rewardId_ = other.rewardId_;
		rewardQty_ = other.rewardQty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MiningQuest Clone()
	{
		return new MiningQuest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MiningQuest);
	}

	[DebuggerNonUserCode]
	public bool Equals(MiningQuest other)
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
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (ActivityId != other.ActivityId)
		{
			return false;
		}
		if (QuestDes != other.QuestDes)
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
		if (JumpTo != other.JumpTo)
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
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (ActivityId != 0)
		{
			num ^= ActivityId.GetHashCode();
		}
		if (QuestDes.Length != 0)
		{
			num ^= QuestDes.GetHashCode();
		}
		if (CompleteCond != 0)
		{
			num ^= CompleteCond.GetHashCode();
		}
		if (CompleteCondParams.Length != 0)
		{
			num ^= CompleteCondParams.GetHashCode();
		}
		if (JumpTo != 0)
		{
			num ^= JumpTo.GetHashCode();
		}
		if (RewardId != 0)
		{
			num ^= RewardId.GetHashCode();
		}
		if (RewardQty != 0)
		{
			num ^= RewardQty.GetHashCode();
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
		if (GroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GroupId);
		}
		if (ActivityId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ActivityId);
		}
		if (QuestDes.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(QuestDes);
		}
		if (CompleteCond != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(CompleteCond);
		}
		if (CompleteCondParams.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(CompleteCondParams);
		}
		if (JumpTo != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(JumpTo);
		}
		if (RewardId != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(RewardId);
		}
		if (RewardQty != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(RewardQty);
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
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (ActivityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityId);
		}
		if (QuestDes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(QuestDes);
		}
		if (CompleteCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompleteCond);
		}
		if (CompleteCondParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CompleteCondParams);
		}
		if (JumpTo != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(JumpTo);
		}
		if (RewardId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardId);
		}
		if (RewardQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardQty);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MiningQuest other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			if (other.QuestDes.Length != 0)
			{
				QuestDes = other.QuestDes;
			}
			if (other.CompleteCond != 0)
			{
				CompleteCond = other.CompleteCond;
			}
			if (other.CompleteCondParams.Length != 0)
			{
				CompleteCondParams = other.CompleteCondParams;
			}
			if (other.JumpTo != 0)
			{
				JumpTo = other.JumpTo;
			}
			if (other.RewardId != 0)
			{
				RewardId = other.RewardId;
			}
			if (other.RewardQty != 0)
			{
				RewardQty = other.RewardQty;
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
				GroupId = input.ReadInt32();
				break;
			case 24u:
				ActivityId = input.ReadInt32();
				break;
			case 34u:
				QuestDes = input.ReadString();
				break;
			case 40u:
				CompleteCond = input.ReadInt32();
				break;
			case 50u:
				CompleteCondParams = input.ReadString();
				break;
			case 56u:
				JumpTo = input.ReadInt32();
				break;
			case 64u:
				RewardId = input.ReadInt32();
				break;
			case 72u:
				RewardQty = input.ReadInt32();
				break;
			}
		}
	}
}
