using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ShopBuyCommodityReq : IMessage<ShopBuyCommodityReq>, IMessage, IEquatable<ShopBuyCommodityReq>, IDeepCloneable<ShopBuyCommodityReq>, IBufferMessage
{
	private static readonly MessageParser<ShopBuyCommodityReq> _parser = new MessageParser<ShopBuyCommodityReq>(() => new ShopBuyCommodityReq());

	private UnknownFieldSet _unknownFields;

	public const int ShopIdFieldNumber = 1;

	private int shopId_;

	public const int SubShopIdxFieldNumber = 2;

	private int subShopIdx_;

	public const int CommodityIdxFieldNumber = 3;

	private int commodityIdx_;

	public const int BuyNumFieldNumber = 4;

	private int buyNum_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ShopBuyCommodityReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ShopReflection.Descriptor.MessageTypes[1];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ShopId
	{
		get
		{
			return shopId_;
		}
		set
		{
			shopId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int SubShopIdx
	{
		get
		{
			return subShopIdx_;
		}
		set
		{
			subShopIdx_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CommodityIdx
	{
		get
		{
			return commodityIdx_;
		}
		set
		{
			commodityIdx_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int BuyNum
	{
		get
		{
			return buyNum_;
		}
		set
		{
			buyNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ShopBuyCommodityReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ShopBuyCommodityReq(ShopBuyCommodityReq other)
		: this()
	{
		shopId_ = other.shopId_;
		subShopIdx_ = other.subShopIdx_;
		commodityIdx_ = other.commodityIdx_;
		buyNum_ = other.buyNum_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ShopBuyCommodityReq Clone()
	{
		return new ShopBuyCommodityReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ShopBuyCommodityReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ShopBuyCommodityReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ShopId != other.ShopId)
		{
			return false;
		}
		if (SubShopIdx != other.SubShopIdx)
		{
			return false;
		}
		if (CommodityIdx != other.CommodityIdx)
		{
			return false;
		}
		if (BuyNum != other.BuyNum)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		if (ShopId != 0)
		{
			num ^= ShopId.GetHashCode();
		}
		if (SubShopIdx != 0)
		{
			num ^= SubShopIdx.GetHashCode();
		}
		if (CommodityIdx != 0)
		{
			num ^= CommodityIdx.GetHashCode();
		}
		if (BuyNum != 0)
		{
			num ^= BuyNum.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (ShopId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ShopId);
		}
		if (SubShopIdx != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(SubShopIdx);
		}
		if (CommodityIdx != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CommodityIdx);
		}
		if (BuyNum != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(BuyNum);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		if (ShopId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ShopId);
		}
		if (SubShopIdx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SubShopIdx);
		}
		if (CommodityIdx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CommodityIdx);
		}
		if (BuyNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuyNum);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ShopBuyCommodityReq other)
	{
		if (other != null)
		{
			if (other.ShopId != 0)
			{
				ShopId = other.ShopId;
			}
			if (other.SubShopIdx != 0)
			{
				SubShopIdx = other.SubShopIdx;
			}
			if (other.CommodityIdx != 0)
			{
				CommodityIdx = other.CommodityIdx;
			}
			if (other.BuyNum != 0)
			{
				BuyNum = other.BuyNum;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				ShopId = input.ReadInt32();
				break;
			case 16u:
				SubShopIdx = input.ReadInt32();
				break;
			case 24u:
				CommodityIdx = input.ReadInt32();
				break;
			case 32u:
				BuyNum = input.ReadInt32();
				break;
			}
		}
	}
}
