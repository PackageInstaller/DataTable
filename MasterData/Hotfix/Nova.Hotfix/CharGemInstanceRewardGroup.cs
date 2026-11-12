using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharGemInstanceRewardGroup : IMessage<CharGemInstanceRewardGroup>, IMessage, IEquatable<CharGemInstanceRewardGroup>, IDeepCloneable<CharGemInstanceRewardGroup>
{
	private static readonly MessageParser<CharGemInstanceRewardGroup> _parser = new MessageParser<CharGemInstanceRewardGroup>(() => new CharGemInstanceRewardGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int RewardTypeFieldNumber = 3;

	private int rewardType_;

	public const int RewardNameFieldNumber = 4;

	private string rewardName_ = "";

	public const int DropIdFieldNumber = 5;

	private int dropId_;

	public const int BaseAwardPreviewFieldNumber = 6;

	private string baseAwardPreview_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<CharGemInstanceRewardGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(194);

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
	public int RewardType
	{
		get
		{
			return rewardType_;
		}
		set
		{
			rewardType_ = value;
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
	public CharGemInstanceRewardGroup()
	{
	}

	[DebuggerNonUserCode]
	public CharGemInstanceRewardGroup(CharGemInstanceRewardGroup other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		rewardType_ = other.rewardType_;
		rewardName_ = other.rewardName_;
		dropId_ = other.dropId_;
		baseAwardPreview_ = other.baseAwardPreview_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharGemInstanceRewardGroup Clone()
	{
		return new CharGemInstanceRewardGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharGemInstanceRewardGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharGemInstanceRewardGroup other)
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
		if (RewardType != other.RewardType)
		{
			return false;
		}
		if (RewardName != other.RewardName)
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
		if (RewardType != 0)
		{
			num ^= RewardType.GetHashCode();
		}
		if (RewardName.Length != 0)
		{
			num ^= RewardName.GetHashCode();
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
		if (RewardType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(RewardType);
		}
		if (RewardName.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(RewardName);
		}
		if (DropId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(DropId);
		}
		if (BaseAwardPreview.Length != 0)
		{
			output.WriteRawTag(50);
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
		if (RewardType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardType);
		}
		if (RewardName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RewardName);
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
	public void MergeFrom(CharGemInstanceRewardGroup other)
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
			if (other.RewardType != 0)
			{
				RewardType = other.RewardType;
			}
			if (other.RewardName.Length != 0)
			{
				RewardName = other.RewardName;
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
				RewardType = input.ReadInt32();
				break;
			case 34u:
				RewardName = input.ReadString();
				break;
			case 40u:
				DropId = input.ReadInt32();
				break;
			case 50u:
				BaseAwardPreview = input.ReadString();
				break;
			}
		}
	}
}
