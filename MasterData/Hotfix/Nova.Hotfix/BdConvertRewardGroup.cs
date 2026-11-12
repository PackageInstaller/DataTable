using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class BdConvertRewardGroup : IMessage<BdConvertRewardGroup>, IMessage, IEquatable<BdConvertRewardGroup>, IDeepCloneable<BdConvertRewardGroup>
{
	private static readonly MessageParser<BdConvertRewardGroup> _parser = new MessageParser<BdConvertRewardGroup>(() => new BdConvertRewardGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int CompleteCondFieldNumber = 3;

	private int completeCond_;

	public const int CompleteCondParamsFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_completeCondParams_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> completeCondParams_ = new RepeatedField<int>();

	public const int RewardsFieldNumber = 5;

	private string rewards_ = "";

	public const int DesFieldNumber = 6;

	private string des_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<BdConvertRewardGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(128);

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
	public RepeatedField<int> CompleteCondParams => completeCondParams_;

	[DebuggerNonUserCode]
	public string Rewards
	{
		get
		{
			return rewards_;
		}
		set
		{
			rewards_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Des
	{
		get
		{
			return des_;
		}
		set
		{
			des_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public BdConvertRewardGroup()
	{
	}

	[DebuggerNonUserCode]
	public BdConvertRewardGroup(BdConvertRewardGroup other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		completeCond_ = other.completeCond_;
		completeCondParams_ = other.completeCondParams_.Clone();
		rewards_ = other.rewards_;
		des_ = other.des_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public BdConvertRewardGroup Clone()
	{
		return new BdConvertRewardGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as BdConvertRewardGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(BdConvertRewardGroup other)
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
		if (CompleteCond != other.CompleteCond)
		{
			return false;
		}
		if (!completeCondParams_.Equals(other.completeCondParams_))
		{
			return false;
		}
		if (Rewards != other.Rewards)
		{
			return false;
		}
		if (Des != other.Des)
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
		if (CompleteCond != 0)
		{
			num ^= CompleteCond.GetHashCode();
		}
		num ^= completeCondParams_.GetHashCode();
		if (Rewards.Length != 0)
		{
			num ^= Rewards.GetHashCode();
		}
		if (Des.Length != 0)
		{
			num ^= Des.GetHashCode();
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
		if (CompleteCond != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CompleteCond);
		}
		completeCondParams_.WriteTo(output, _repeated_completeCondParams_codec);
		if (Rewards.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Rewards);
		}
		if (Des.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Des);
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
		if (CompleteCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompleteCond);
		}
		num += completeCondParams_.CalculateSize(_repeated_completeCondParams_codec);
		if (Rewards.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Rewards);
		}
		if (Des.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Des);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(BdConvertRewardGroup other)
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
			if (other.CompleteCond != 0)
			{
				CompleteCond = other.CompleteCond;
			}
			completeCondParams_.Add(other.completeCondParams_);
			if (other.Rewards.Length != 0)
			{
				Rewards = other.Rewards;
			}
			if (other.Des.Length != 0)
			{
				Des = other.Des;
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
				CompleteCond = input.ReadInt32();
				break;
			case 32u:
			case 34u:
				completeCondParams_.AddEntriesFrom(input, _repeated_completeCondParams_codec);
				break;
			case 42u:
				Rewards = input.ReadString();
				break;
			case 50u:
				Des = input.ReadString();
				break;
			}
		}
	}
}
