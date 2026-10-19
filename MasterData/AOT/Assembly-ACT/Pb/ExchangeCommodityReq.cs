using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ExchangeCommodityReq : IMessage<ExchangeCommodityReq>, IMessage, IEquatable<ExchangeCommodityReq>, IDeepCloneable<ExchangeCommodityReq>, IBufferMessage
{
	private static readonly MessageParser<ExchangeCommodityReq> _parser = new MessageParser<ExchangeCommodityReq>(() => new ExchangeCommodityReq());

	private UnknownFieldSet _unknownFields;

	public const int CommodityIdFieldNumber = 1;

	private int commodityId_;

	public const int IndexsFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_indexs_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> indexs_ = new RepeatedField<int>();

	public const int SubShopIdFieldNumber = 3;

	private int subShopId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ExchangeCommodityReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ShopReflection.Descriptor.MessageTypes[7];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CommodityId
	{
		get
		{
			return commodityId_;
		}
		set
		{
			commodityId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> Indexs => indexs_;

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
	public ExchangeCommodityReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ExchangeCommodityReq(ExchangeCommodityReq other)
		: this()
	{
		commodityId_ = other.commodityId_;
		indexs_ = other.indexs_.Clone();
		subShopId_ = other.subShopId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ExchangeCommodityReq Clone()
	{
		return new ExchangeCommodityReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ExchangeCommodityReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ExchangeCommodityReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (CommodityId != other.CommodityId)
		{
			return false;
		}
		if (!indexs_.Equals(other.indexs_))
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
		if (CommodityId != 0)
		{
			num ^= CommodityId.GetHashCode();
		}
		num ^= indexs_.GetHashCode();
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
		if (CommodityId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(CommodityId);
		}
		indexs_.WriteTo(ref output, _repeated_indexs_codec);
		if (SubShopId != 0)
		{
			output.WriteRawTag(24);
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
		if (CommodityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CommodityId);
		}
		num += indexs_.CalculateSize(_repeated_indexs_codec);
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
	public void MergeFrom(ExchangeCommodityReq other)
	{
		if (other != null)
		{
			if (other.CommodityId != 0)
			{
				CommodityId = other.CommodityId;
			}
			indexs_.Add(other.indexs_);
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
				CommodityId = input.ReadInt32();
				break;
			case 16u:
			case 18u:
				indexs_.AddEntriesFrom(ref input, _repeated_indexs_codec);
				break;
			case 24u:
				SubShopId = input.ReadInt32();
				break;
			}
		}
	}
}
