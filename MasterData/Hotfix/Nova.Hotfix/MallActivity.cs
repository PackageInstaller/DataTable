using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MallActivity : IMessage<MallActivity>, IMessage, IEquatable<MallActivity>, IDeepCloneable<MallActivity>
{
	private static readonly MessageParser<MallActivity> _parser = new MessageParser<MallActivity>(() => new MallActivity());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private string id_ = "";

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int GroupIdFieldNumber = 3;

	private int groupId_;

	public const int StatisticalGroupFieldNumber = 4;

	private string statisticalGroup_ = "";

	public const int PriceFieldNumber = 5;

	private int price_;

	public const int ShowPriceFieldNumber = 6;

	private string showPrice_ = "";

	public const int ActivityIdFieldNumber = 7;

	private int activityId_;

	public const int IsNewFieldNumber = 8;

	private bool isNew_;

	[DebuggerNonUserCode]
	public static MessageParser<MallActivity> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(512);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public string Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string StatisticalGroup
	{
		get
		{
			return statisticalGroup_;
		}
		set
		{
			statisticalGroup_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Price
	{
		get
		{
			return price_;
		}
		set
		{
			price_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ShowPrice
	{
		get
		{
			return showPrice_;
		}
		set
		{
			showPrice_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public bool IsNew
	{
		get
		{
			return isNew_;
		}
		set
		{
			isNew_ = value;
		}
	}

	[DebuggerNonUserCode]
	public MallActivity()
	{
	}

	[DebuggerNonUserCode]
	public MallActivity(MallActivity other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		groupId_ = other.groupId_;
		statisticalGroup_ = other.statisticalGroup_;
		price_ = other.price_;
		showPrice_ = other.showPrice_;
		activityId_ = other.activityId_;
		isNew_ = other.isNew_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MallActivity Clone()
	{
		return new MallActivity(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MallActivity);
	}

	[DebuggerNonUserCode]
	public bool Equals(MallActivity other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (StatisticalGroup != other.StatisticalGroup)
		{
			return false;
		}
		if (Price != other.Price)
		{
			return false;
		}
		if (ShowPrice != other.ShowPrice)
		{
			return false;
		}
		if (ActivityId != other.ActivityId)
		{
			return false;
		}
		if (IsNew != other.IsNew)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id.Length != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (StatisticalGroup.Length != 0)
		{
			num ^= StatisticalGroup.GetHashCode();
		}
		if (Price != 0)
		{
			num ^= Price.GetHashCode();
		}
		if (ShowPrice.Length != 0)
		{
			num ^= ShowPrice.GetHashCode();
		}
		if (ActivityId != 0)
		{
			num ^= ActivityId.GetHashCode();
		}
		if (IsNew)
		{
			num ^= IsNew.GetHashCode();
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
		if (Id.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(Id);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (GroupId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(GroupId);
		}
		if (StatisticalGroup.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(StatisticalGroup);
		}
		if (Price != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Price);
		}
		if (ShowPrice.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(ShowPrice);
		}
		if (ActivityId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ActivityId);
		}
		if (IsNew)
		{
			output.WriteRawTag(64);
			output.WriteBool(IsNew);
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
		if (Id.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Id);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (StatisticalGroup.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StatisticalGroup);
		}
		if (Price != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Price);
		}
		if (ShowPrice.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ShowPrice);
		}
		if (ActivityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityId);
		}
		if (IsNew)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MallActivity other)
	{
		if (other != null)
		{
			if (other.Id.Length != 0)
			{
				Id = other.Id;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.StatisticalGroup.Length != 0)
			{
				StatisticalGroup = other.StatisticalGroup;
			}
			if (other.Price != 0)
			{
				Price = other.Price;
			}
			if (other.ShowPrice.Length != 0)
			{
				ShowPrice = other.ShowPrice;
			}
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			if (other.IsNew)
			{
				IsNew = other.IsNew;
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
			case 10u:
				Id = input.ReadString();
				break;
			case 18u:
				Name = input.ReadString();
				break;
			case 24u:
				GroupId = input.ReadInt32();
				break;
			case 34u:
				StatisticalGroup = input.ReadString();
				break;
			case 40u:
				Price = input.ReadInt32();
				break;
			case 50u:
				ShowPrice = input.ReadString();
				break;
			case 56u:
				ActivityId = input.ReadInt32();
				break;
			case 64u:
				IsNew = input.ReadBool();
				break;
			}
		}
	}
}
