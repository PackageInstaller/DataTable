using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ItemPackMark : IMessage<ItemPackMark>, IMessage, IEquatable<ItemPackMark>, IDeepCloneable<ItemPackMark>
{
	private static readonly MessageParser<ItemPackMark> _parser = new MessageParser<ItemPackMark>(() => new ItemPackMark());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int PackMarkFieldNumber = 2;

	private int packMark_;

	public const int ItemStypeFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_itemStype_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> itemStype_ = new RepeatedField<int>();

	public const int NameFieldNumber = 4;

	private string name_ = "";

	public const int SortFieldNumber = 5;

	private int sort_;

	[DebuggerNonUserCode]
	public static MessageParser<ItemPackMark> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(468);

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
	public int PackMark
	{
		get
		{
			return packMark_;
		}
		set
		{
			packMark_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> ItemStype => itemStype_;

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
	public int Sort
	{
		get
		{
			return sort_;
		}
		set
		{
			sort_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ItemPackMark()
	{
	}

	[DebuggerNonUserCode]
	public ItemPackMark(ItemPackMark other)
		: this()
	{
		id_ = other.id_;
		packMark_ = other.packMark_;
		itemStype_ = other.itemStype_.Clone();
		name_ = other.name_;
		sort_ = other.sort_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ItemPackMark Clone()
	{
		return new ItemPackMark(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ItemPackMark);
	}

	[DebuggerNonUserCode]
	public bool Equals(ItemPackMark other)
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
		if (PackMark != other.PackMark)
		{
			return false;
		}
		if (!itemStype_.Equals(other.itemStype_))
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Sort != other.Sort)
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
		if (PackMark != 0)
		{
			num ^= PackMark.GetHashCode();
		}
		num ^= itemStype_.GetHashCode();
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
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
		if (PackMark != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(PackMark);
		}
		itemStype_.WriteTo(output, _repeated_itemStype_codec);
		if (Name.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Sort);
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
		if (PackMark != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PackMark);
		}
		num += itemStype_.CalculateSize(_repeated_itemStype_codec);
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ItemPackMark other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.PackMark != 0)
			{
				PackMark = other.PackMark;
			}
			itemStype_.Add(other.itemStype_);
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
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
				PackMark = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				itemStype_.AddEntriesFrom(input, _repeated_itemStype_codec);
				break;
			case 34u:
				Name = input.ReadString();
				break;
			case 40u:
				Sort = input.ReadInt32();
				break;
			}
		}
	}
}
