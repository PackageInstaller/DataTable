using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class CreatOrderReq : IMessage<CreatOrderReq>, IMessage, IEquatable<CreatOrderReq>, IDeepCloneable<CreatOrderReq>, IBufferMessage
{
	private static readonly MessageParser<CreatOrderReq> _parser = new MessageParser<CreatOrderReq>(() => new CreatOrderReq());

	private UnknownFieldSet _unknownFields;

	public const int GoodsIdFieldNumber = 1;

	private int goodsId_;

	public const int CurrencyFieldNumber = 2;

	private string currency_ = "";

	public const int IndexsFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_indexs_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> indexs_ = new RepeatedField<int>();

	public const int ItemIdFieldNumber = 4;

	private int itemId_;

	public const int SubShopIdFieldNumber = 5;

	private int subShopId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CreatOrderReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => BillReflection.Descriptor.MessageTypes[0];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int GoodsId
	{
		get
		{
			return goodsId_;
		}
		set
		{
			goodsId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Currency
	{
		get
		{
			return currency_;
		}
		set
		{
			currency_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> Indexs => indexs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
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
	[GeneratedCode("protoc", null)]
	public int SubShopId
	{
		get
		{
			return subShopId_;
		}
		set
		{
			subShopId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CreatOrderReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CreatOrderReq(CreatOrderReq other)
		: this()
	{
		goodsId_ = other.goodsId_;
		currency_ = other.currency_;
		indexs_ = other.indexs_.Clone();
		itemId_ = other.itemId_;
		subShopId_ = other.subShopId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CreatOrderReq Clone()
	{
		return new CreatOrderReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CreatOrderReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CreatOrderReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (GoodsId != other.GoodsId)
		{
			return false;
		}
		if (Currency != other.Currency)
		{
			return false;
		}
		if (!indexs_.Equals(other.indexs_))
		{
			return false;
		}
		if (ItemId != other.ItemId)
		{
			return false;
		}
		if (SubShopId != other.SubShopId)
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
		if (GoodsId != 0)
		{
			num ^= GoodsId.GetHashCode();
		}
		if (Currency.Length != 0)
		{
			num ^= Currency.GetHashCode();
		}
		num ^= indexs_.GetHashCode();
		if (ItemId != 0)
		{
			num ^= ItemId.GetHashCode();
		}
		if (SubShopId != 0)
		{
			num ^= SubShopId.GetHashCode();
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
		if (GoodsId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(GoodsId);
		}
		if (Currency.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Currency);
		}
		indexs_.WriteTo(ref output, _repeated_indexs_codec);
		if (ItemId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ItemId);
		}
		if (SubShopId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(SubShopId);
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
		if (GoodsId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GoodsId);
		}
		if (Currency.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Currency);
		}
		num += indexs_.CalculateSize(_repeated_indexs_codec);
		if (ItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemId);
		}
		if (SubShopId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SubShopId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CreatOrderReq other)
	{
		if (other != null)
		{
			if (other.GoodsId != 0)
			{
				GoodsId = other.GoodsId;
			}
			if (other.Currency.Length != 0)
			{
				Currency = other.Currency;
			}
			indexs_.Add(other.indexs_);
			if (other.ItemId != 0)
			{
				ItemId = other.ItemId;
			}
			if (other.SubShopId != 0)
			{
				SubShopId = other.SubShopId;
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
				GoodsId = input.ReadInt32();
				break;
			case 18u:
				Currency = input.ReadString();
				break;
			case 24u:
			case 26u:
				indexs_.AddEntriesFrom(ref input, _repeated_indexs_codec);
				break;
			case 32u:
				ItemId = input.ReadInt32();
				break;
			case 40u:
				SubShopId = input.ReadInt32();
				break;
			}
		}
	}
}
