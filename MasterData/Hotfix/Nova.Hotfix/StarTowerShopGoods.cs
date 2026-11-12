using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerShopGoods : IMessage<StarTowerShopGoods>, IMessage, IEquatable<StarTowerShopGoods>, IDeepCloneable<StarTowerShopGoods>
{
	private static readonly MessageParser<StarTowerShopGoods> _parser = new MessageParser<StarTowerShopGoods>(() => new StarTowerShopGoods());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GoodsGroupIdFieldNumber = 2;

	private int goodsGroupId_;

	public const int ShowItemFieldNumber = 3;

	private int showItem_;

	public const int ShowItemNumFieldNumber = 4;

	private int showItemNum_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerShopGoods> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(874);

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
	public int GoodsGroupId
	{
		get
		{
			return goodsGroupId_;
		}
		set
		{
			goodsGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ShowItem
	{
		get
		{
			return showItem_;
		}
		set
		{
			showItem_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ShowItemNum
	{
		get
		{
			return showItemNum_;
		}
		set
		{
			showItemNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StarTowerShopGoods()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerShopGoods(StarTowerShopGoods other)
		: this()
	{
		id_ = other.id_;
		goodsGroupId_ = other.goodsGroupId_;
		showItem_ = other.showItem_;
		showItemNum_ = other.showItemNum_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerShopGoods Clone()
	{
		return new StarTowerShopGoods(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerShopGoods);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerShopGoods other)
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
		if (GoodsGroupId != other.GoodsGroupId)
		{
			return false;
		}
		if (ShowItem != other.ShowItem)
		{
			return false;
		}
		if (ShowItemNum != other.ShowItemNum)
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
		if (GoodsGroupId != 0)
		{
			num ^= GoodsGroupId.GetHashCode();
		}
		if (ShowItem != 0)
		{
			num ^= ShowItem.GetHashCode();
		}
		if (ShowItemNum != 0)
		{
			num ^= ShowItemNum.GetHashCode();
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
		if (GoodsGroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GoodsGroupId);
		}
		if (ShowItem != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ShowItem);
		}
		if (ShowItemNum != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ShowItemNum);
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
		if (GoodsGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GoodsGroupId);
		}
		if (ShowItem != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ShowItem);
		}
		if (ShowItemNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ShowItemNum);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerShopGoods other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.GoodsGroupId != 0)
			{
				GoodsGroupId = other.GoodsGroupId;
			}
			if (other.ShowItem != 0)
			{
				ShowItem = other.ShowItem;
			}
			if (other.ShowItemNum != 0)
			{
				ShowItemNum = other.ShowItemNum;
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
				GoodsGroupId = input.ReadInt32();
				break;
			case 24u:
				ShowItem = input.ReadInt32();
				break;
			case 32u:
				ShowItemNum = input.ReadInt32();
				break;
			}
		}
	}
}
