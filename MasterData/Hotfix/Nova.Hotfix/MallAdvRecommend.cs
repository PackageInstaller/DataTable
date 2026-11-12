using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MallAdvRecommend : IMessage<MallAdvRecommend>, IMessage, IEquatable<MallAdvRecommend>, IDeepCloneable<MallAdvRecommend>
{
	private static readonly MessageParser<MallAdvRecommend> _parser = new MessageParser<MallAdvRecommend>(() => new MallAdvRecommend());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private string id_ = "";

	public const int PathFieldNumber = 2;

	private string path_ = "";

	public const int SortFieldNumber = 3;

	private int sort_;

	public const int ItemIdFieldNumber = 4;

	private string itemId_ = "";

	public const int ItemTypeFieldNumber = 5;

	private int itemType_;

	[DebuggerNonUserCode]
	public static MessageParser<MallAdvRecommend> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(514);

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
	public string Path
	{
		get
		{
			return path_;
		}
		set
		{
			path_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string ItemId
	{
		get
		{
			return itemId_;
		}
		set
		{
			itemId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ItemType
	{
		get
		{
			return itemType_;
		}
		set
		{
			itemType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public MallAdvRecommend()
	{
	}

	[DebuggerNonUserCode]
	public MallAdvRecommend(MallAdvRecommend other)
		: this()
	{
		id_ = other.id_;
		path_ = other.path_;
		sort_ = other.sort_;
		itemId_ = other.itemId_;
		itemType_ = other.itemType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MallAdvRecommend Clone()
	{
		return new MallAdvRecommend(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MallAdvRecommend);
	}

	[DebuggerNonUserCode]
	public bool Equals(MallAdvRecommend other)
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
		if (Path != other.Path)
		{
			return false;
		}
		if (Sort != other.Sort)
		{
			return false;
		}
		if (ItemId != other.ItemId)
		{
			return false;
		}
		if (ItemType != other.ItemType)
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
		if (Path.Length != 0)
		{
			num ^= Path.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		if (ItemId.Length != 0)
		{
			num ^= ItemId.GetHashCode();
		}
		if (ItemType != 0)
		{
			num ^= ItemType.GetHashCode();
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
		if (Path.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Path);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Sort);
		}
		if (ItemId.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(ItemId);
		}
		if (ItemType != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ItemType);
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
		if (Path.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Path);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		if (ItemId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ItemId);
		}
		if (ItemType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemType);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MallAdvRecommend other)
	{
		if (other != null)
		{
			if (other.Id.Length != 0)
			{
				Id = other.Id;
			}
			if (other.Path.Length != 0)
			{
				Path = other.Path;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			if (other.ItemId.Length != 0)
			{
				ItemId = other.ItemId;
			}
			if (other.ItemType != 0)
			{
				ItemType = other.ItemType;
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
				Path = input.ReadString();
				break;
			case 24u:
				Sort = input.ReadInt32();
				break;
			case 34u:
				ItemId = input.ReadString();
				break;
			case 40u:
				ItemType = input.ReadInt32();
				break;
			}
		}
	}
}
