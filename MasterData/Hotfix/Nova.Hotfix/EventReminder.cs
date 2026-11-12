using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class EventReminder : IMessage<EventReminder>, IMessage, IEquatable<EventReminder>, IDeepCloneable<EventReminder>
{
	private static readonly MessageParser<EventReminder> _parser = new MessageParser<EventReminder>(() => new EventReminder());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ModuleTypeFieldNumber = 2;

	private int moduleType_;

	public const int NameFieldNumber = 3;

	private string name_ = "";

	public const int LimitDayFieldNumber = 4;

	private int limitDay_;

	public const int LimitDay2FieldNumber = 5;

	private int limitDay2_;

	public const int IconFieldNumber = 6;

	private string icon_ = "";

	public const int ItemIconFieldNumber = 7;

	private string itemIcon_ = "";

	public const int Item1IdFieldNumber = 8;

	private int item1Id_;

	public const int Item2IdFieldNumber = 9;

	private int item2Id_;

	public const int JumpToFieldNumber = 10;

	private int jumpTo_;

	[DebuggerNonUserCode]
	public static MessageParser<EventReminder> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(344);

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
	public int ModuleType
	{
		get
		{
			return moduleType_;
		}
		set
		{
			moduleType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int LimitDay
	{
		get
		{
			return limitDay_;
		}
		set
		{
			limitDay_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LimitDay2
	{
		get
		{
			return limitDay2_;
		}
		set
		{
			limitDay2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ItemIcon
	{
		get
		{
			return itemIcon_;
		}
		set
		{
			itemIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Item1Id
	{
		get
		{
			return item1Id_;
		}
		set
		{
			item1Id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Item2Id
	{
		get
		{
			return item2Id_;
		}
		set
		{
			item2Id_ = value;
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
	public EventReminder()
	{
	}

	[DebuggerNonUserCode]
	public EventReminder(EventReminder other)
		: this()
	{
		id_ = other.id_;
		moduleType_ = other.moduleType_;
		name_ = other.name_;
		limitDay_ = other.limitDay_;
		limitDay2_ = other.limitDay2_;
		icon_ = other.icon_;
		itemIcon_ = other.itemIcon_;
		item1Id_ = other.item1Id_;
		item2Id_ = other.item2Id_;
		jumpTo_ = other.jumpTo_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public EventReminder Clone()
	{
		return new EventReminder(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as EventReminder);
	}

	[DebuggerNonUserCode]
	public bool Equals(EventReminder other)
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
		if (ModuleType != other.ModuleType)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (LimitDay != other.LimitDay)
		{
			return false;
		}
		if (LimitDay2 != other.LimitDay2)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (ItemIcon != other.ItemIcon)
		{
			return false;
		}
		if (Item1Id != other.Item1Id)
		{
			return false;
		}
		if (Item2Id != other.Item2Id)
		{
			return false;
		}
		if (JumpTo != other.JumpTo)
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
		if (ModuleType != 0)
		{
			num ^= ModuleType.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (LimitDay != 0)
		{
			num ^= LimitDay.GetHashCode();
		}
		if (LimitDay2 != 0)
		{
			num ^= LimitDay2.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (ItemIcon.Length != 0)
		{
			num ^= ItemIcon.GetHashCode();
		}
		if (Item1Id != 0)
		{
			num ^= Item1Id.GetHashCode();
		}
		if (Item2Id != 0)
		{
			num ^= Item2Id.GetHashCode();
		}
		if (JumpTo != 0)
		{
			num ^= JumpTo.GetHashCode();
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
		if (ModuleType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ModuleType);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Name);
		}
		if (LimitDay != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(LimitDay);
		}
		if (LimitDay2 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(LimitDay2);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Icon);
		}
		if (ItemIcon.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(ItemIcon);
		}
		if (Item1Id != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Item1Id);
		}
		if (Item2Id != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Item2Id);
		}
		if (JumpTo != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(JumpTo);
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
		if (ModuleType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ModuleType);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (LimitDay != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LimitDay);
		}
		if (LimitDay2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LimitDay2);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (ItemIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ItemIcon);
		}
		if (Item1Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Item1Id);
		}
		if (Item2Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Item2Id);
		}
		if (JumpTo != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(JumpTo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(EventReminder other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ModuleType != 0)
			{
				ModuleType = other.ModuleType;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.LimitDay != 0)
			{
				LimitDay = other.LimitDay;
			}
			if (other.LimitDay2 != 0)
			{
				LimitDay2 = other.LimitDay2;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.ItemIcon.Length != 0)
			{
				ItemIcon = other.ItemIcon;
			}
			if (other.Item1Id != 0)
			{
				Item1Id = other.Item1Id;
			}
			if (other.Item2Id != 0)
			{
				Item2Id = other.Item2Id;
			}
			if (other.JumpTo != 0)
			{
				JumpTo = other.JumpTo;
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
				ModuleType = input.ReadInt32();
				break;
			case 26u:
				Name = input.ReadString();
				break;
			case 32u:
				LimitDay = input.ReadInt32();
				break;
			case 40u:
				LimitDay2 = input.ReadInt32();
				break;
			case 50u:
				Icon = input.ReadString();
				break;
			case 58u:
				ItemIcon = input.ReadString();
				break;
			case 64u:
				Item1Id = input.ReadInt32();
				break;
			case 72u:
				Item2Id = input.ReadInt32();
				break;
			case 80u:
				JumpTo = input.ReadInt32();
				break;
			}
		}
	}
}
