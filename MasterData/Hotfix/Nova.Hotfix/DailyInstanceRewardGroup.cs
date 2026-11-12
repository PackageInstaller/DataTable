using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DailyInstanceRewardGroup : IMessage<DailyInstanceRewardGroup>, IMessage, IEquatable<DailyInstanceRewardGroup>, IDeepCloneable<DailyInstanceRewardGroup>
{
	private static readonly MessageParser<DailyInstanceRewardGroup> _parser = new MessageParser<DailyInstanceRewardGroup>(() => new DailyInstanceRewardGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int DailyRewardTypeFieldNumber = 3;

	private int dailyRewardType_;

	public const int RewardNameFieldNumber = 4;

	private string rewardName_ = "";

	public const int RewardDesFieldNumber = 5;

	private string rewardDes_ = "";

	public const int RewardIconFieldNumber = 6;

	private string rewardIcon_ = "";

	public const int DropIdFieldNumber = 7;

	private int dropId_;

	public const int BaseAwardPreviewFieldNumber = 8;

	private string baseAwardPreview_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<DailyInstanceRewardGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(232);

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
	public int DailyRewardType
	{
		get
		{
			return dailyRewardType_;
		}
		set
		{
			dailyRewardType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string RewardName
	{
		get
		{
			return rewardName_;
		}
		set
		{
			rewardName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string RewardDes
	{
		get
		{
			return rewardDes_;
		}
		set
		{
			rewardDes_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int DropId
	{
		get
		{
			return dropId_;
		}
		set
		{
			dropId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BaseAwardPreview
	{
		get
		{
			return baseAwardPreview_;
		}
		set
		{
			baseAwardPreview_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public DailyInstanceRewardGroup()
	{
	}

	[DebuggerNonUserCode]
	public DailyInstanceRewardGroup(DailyInstanceRewardGroup other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		dailyRewardType_ = other.dailyRewardType_;
		rewardName_ = other.rewardName_;
		rewardDes_ = other.rewardDes_;
		rewardIcon_ = other.rewardIcon_;
		dropId_ = other.dropId_;
		baseAwardPreview_ = other.baseAwardPreview_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DailyInstanceRewardGroup Clone()
	{
		return new DailyInstanceRewardGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DailyInstanceRewardGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(DailyInstanceRewardGroup other)
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
		if (DailyRewardType != other.DailyRewardType)
		{
			return false;
		}
		if (RewardName != other.RewardName)
		{
			return false;
		}
		if (RewardDes != other.RewardDes)
		{
			return false;
		}
		if (RewardIcon != other.RewardIcon)
		{
			return false;
		}
		if (DropId != other.DropId)
		{
			return false;
		}
		if (BaseAwardPreview != other.BaseAwardPreview)
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
		if (DailyRewardType != 0)
		{
			num ^= DailyRewardType.GetHashCode();
		}
		if (RewardName.Length != 0)
		{
			num ^= RewardName.GetHashCode();
		}
		if (RewardDes.Length != 0)
		{
			num ^= RewardDes.GetHashCode();
		}
		if (RewardIcon.Length != 0)
		{
			num ^= RewardIcon.GetHashCode();
		}
		if (DropId != 0)
		{
			num ^= DropId.GetHashCode();
		}
		if (BaseAwardPreview.Length != 0)
		{
			num ^= BaseAwardPreview.GetHashCode();
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
		if (DailyRewardType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(DailyRewardType);
		}
		if (RewardName.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(RewardName);
		}
		if (RewardDes.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(RewardDes);
		}
		if (RewardIcon.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(RewardIcon);
		}
		if (DropId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(DropId);
		}
		if (BaseAwardPreview.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(BaseAwardPreview);
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
		if (DailyRewardType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DailyRewardType);
		}
		if (RewardName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RewardName);
		}
		if (RewardDes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RewardDes);
		}
		if (RewardIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RewardIcon);
		}
		if (DropId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DropId);
		}
		if (BaseAwardPreview.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BaseAwardPreview);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DailyInstanceRewardGroup other)
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
			if (other.DailyRewardType != 0)
			{
				DailyRewardType = other.DailyRewardType;
			}
			if (other.RewardName.Length != 0)
			{
				RewardName = other.RewardName;
			}
			if (other.RewardDes.Length != 0)
			{
				RewardDes = other.RewardDes;
			}
			if (other.RewardIcon.Length != 0)
			{
				RewardIcon = other.RewardIcon;
			}
			if (other.DropId != 0)
			{
				DropId = other.DropId;
			}
			if (other.BaseAwardPreview.Length != 0)
			{
				BaseAwardPreview = other.BaseAwardPreview;
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
				DailyRewardType = input.ReadInt32();
				break;
			case 34u:
				RewardName = input.ReadString();
				break;
			case 42u:
				RewardDes = input.ReadString();
				break;
			case 50u:
				RewardIcon = input.ReadString();
				break;
			case 56u:
				DropId = input.ReadInt32();
				break;
			case 66u:
				BaseAwardPreview = input.ReadString();
				break;
			}
		}
	}
}
