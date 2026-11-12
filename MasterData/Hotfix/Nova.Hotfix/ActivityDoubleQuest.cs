using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityDoubleQuest : IMessage<ActivityDoubleQuest>, IMessage, IEquatable<ActivityDoubleQuest>, IDeepCloneable<ActivityDoubleQuest>
{
	private static readonly MessageParser<ActivityDoubleQuest> _parser = new MessageParser<ActivityDoubleQuest>(() => new ActivityDoubleQuest());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ActivityIdFieldNumber = 2;

	private int activityId_;

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int QuestTypeFieldNumber = 4;

	private int questType_;

	public const int QuestParamsFieldNumber = 5;

	private string questParams_ = "";

	public const int ItemIdFieldNumber = 6;

	private int itemId_;

	public const int ItemQtyFieldNumber = 7;

	private int itemQty_;

	[DebuggerNonUserCode]
	public static MessageParser<ActivityDoubleQuest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(10);

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
	public int QuestType
	{
		get
		{
			return questType_;
		}
		set
		{
			questType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string QuestParams
	{
		get
		{
			return questParams_;
		}
		set
		{
			questParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ItemId
	{
		get
		{
			return itemId_;
		}
		set
		{
			itemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ItemQty
	{
		get
		{
			return itemQty_;
		}
		set
		{
			itemQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ActivityDoubleQuest()
	{
	}

	[DebuggerNonUserCode]
	public ActivityDoubleQuest(ActivityDoubleQuest other)
		: this()
	{
		id_ = other.id_;
		activityId_ = other.activityId_;
		desc_ = other.desc_;
		questType_ = other.questType_;
		questParams_ = other.questParams_;
		itemId_ = other.itemId_;
		itemQty_ = other.itemQty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityDoubleQuest Clone()
	{
		return new ActivityDoubleQuest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityDoubleQuest);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityDoubleQuest other)
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
		if (ActivityId != other.ActivityId)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (QuestType != other.QuestType)
		{
			return false;
		}
		if (QuestParams != other.QuestParams)
		{
			return false;
		}
		if (ItemId != other.ItemId)
		{
			return false;
		}
		if (ItemQty != other.ItemQty)
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
		if (ActivityId != 0)
		{
			num ^= ActivityId.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (QuestType != 0)
		{
			num ^= QuestType.GetHashCode();
		}
		if (QuestParams.Length != 0)
		{
			num ^= QuestParams.GetHashCode();
		}
		if (ItemId != 0)
		{
			num ^= ItemId.GetHashCode();
		}
		if (ItemQty != 0)
		{
			num ^= ItemQty.GetHashCode();
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
		if (ActivityId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ActivityId);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Desc);
		}
		if (QuestType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(QuestType);
		}
		if (QuestParams.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(QuestParams);
		}
		if (ItemId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(ItemId);
		}
		if (ItemQty != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ItemQty);
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
		if (ActivityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityId);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (QuestType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(QuestType);
		}
		if (QuestParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(QuestParams);
		}
		if (ItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemId);
		}
		if (ItemQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemQty);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityDoubleQuest other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.QuestType != 0)
			{
				QuestType = other.QuestType;
			}
			if (other.QuestParams.Length != 0)
			{
				QuestParams = other.QuestParams;
			}
			if (other.ItemId != 0)
			{
				ItemId = other.ItemId;
			}
			if (other.ItemQty != 0)
			{
				ItemQty = other.ItemQty;
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
				ActivityId = input.ReadInt32();
				break;
			case 26u:
				Desc = input.ReadString();
				break;
			case 32u:
				QuestType = input.ReadInt32();
				break;
			case 42u:
				QuestParams = input.ReadString();
				break;
			case 48u:
				ItemId = input.ReadInt32();
				break;
			case 56u:
				ItemQty = input.ReadInt32();
				break;
			}
		}
	}
}
