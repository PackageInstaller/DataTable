using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DormReward : IMessage<DormReward>, IMessage, IEquatable<DormReward>, IDeepCloneable<DormReward>
{
	private static readonly MessageParser<DormReward> _parser = new MessageParser<DormReward>(() => new DormReward());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int DormRewardTypeFieldNumber = 2;

	private int dormRewardType_;

	public const int DropIdFieldNumber = 3;

	private int dropId_;

	public const int ConditionsFieldNumber = 4;

	private string conditions_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<DormReward> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(302);

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
	public int DormRewardType
	{
		get
		{
			return dormRewardType_;
		}
		set
		{
			dormRewardType_ = value;
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
	public string Conditions
	{
		get
		{
			return conditions_;
		}
		set
		{
			conditions_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public DormReward()
	{
	}

	[DebuggerNonUserCode]
	public DormReward(DormReward other)
		: this()
	{
		id_ = other.id_;
		dormRewardType_ = other.dormRewardType_;
		dropId_ = other.dropId_;
		conditions_ = other.conditions_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DormReward Clone()
	{
		return new DormReward(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DormReward);
	}

	[DebuggerNonUserCode]
	public bool Equals(DormReward other)
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
		if (DormRewardType != other.DormRewardType)
		{
			return false;
		}
		if (DropId != other.DropId)
		{
			return false;
		}
		if (Conditions != other.Conditions)
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
		if (DormRewardType != 0)
		{
			num ^= DormRewardType.GetHashCode();
		}
		if (DropId != 0)
		{
			num ^= DropId.GetHashCode();
		}
		if (Conditions.Length != 0)
		{
			num ^= Conditions.GetHashCode();
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
		if (DormRewardType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(DormRewardType);
		}
		if (DropId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(DropId);
		}
		if (Conditions.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Conditions);
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
		if (DormRewardType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DormRewardType);
		}
		if (DropId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DropId);
		}
		if (Conditions.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Conditions);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DormReward other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.DormRewardType != 0)
			{
				DormRewardType = other.DormRewardType;
			}
			if (other.DropId != 0)
			{
				DropId = other.DropId;
			}
			if (other.Conditions.Length != 0)
			{
				Conditions = other.Conditions;
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
				DormRewardType = input.ReadInt32();
				break;
			case 24u:
				DropId = input.ReadInt32();
				break;
			case 34u:
				Conditions = input.ReadString();
				break;
			}
		}
	}
}
