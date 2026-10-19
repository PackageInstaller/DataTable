using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class BundleInfo : IMessage<BundleInfo>, IMessage, IEquatable<BundleInfo>, IDeepCloneable<BundleInfo>, IBufferMessage
{
	private static readonly MessageParser<BundleInfo> _parser = new MessageParser<BundleInfo>(() => new BundleInfo());

	private UnknownFieldSet _unknownFields;

	public const int GoodsIdFieldNumber = 1;

	private int goodsId_;

	public const int BuyCountFieldNumber = 2;

	private int buyCount_;

	public const int LastRefreshTsFieldNumber = 3;

	private long lastRefreshTs_;

	public const int ShipDaysFieldNumber = 4;

	private static readonly MapField<long, int>.Codec _map_shipDays_codec = new MapField<long, int>.Codec(FieldCodec.ForInt64(8u, 0L), FieldCodec.ForInt32(16u, 0), 34u);

	private readonly MapField<long, int> shipDays_ = new MapField<long, int>();

	public const int SpecialRefreshIdFieldNumber = 5;

	private int specialRefreshId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<BundleInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[297];

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
	public int BuyCount
	{
		get
		{
			return buyCount_;
		}
		set
		{
			buyCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long LastRefreshTs
	{
		get
		{
			return lastRefreshTs_;
		}
		set
		{
			lastRefreshTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<long, int> ShipDays => shipDays_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int SpecialRefreshId
	{
		get
		{
			return specialRefreshId_;
		}
		set
		{
			specialRefreshId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BundleInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BundleInfo(BundleInfo other)
		: this()
	{
		goodsId_ = other.goodsId_;
		buyCount_ = other.buyCount_;
		lastRefreshTs_ = other.lastRefreshTs_;
		shipDays_ = other.shipDays_.Clone();
		specialRefreshId_ = other.specialRefreshId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BundleInfo Clone()
	{
		return new BundleInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as BundleInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(BundleInfo other)
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
		if (BuyCount != other.BuyCount)
		{
			return false;
		}
		if (LastRefreshTs != other.LastRefreshTs)
		{
			return false;
		}
		if (!ShipDays.Equals(other.ShipDays))
		{
			return false;
		}
		if (SpecialRefreshId != other.SpecialRefreshId)
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
		if (BuyCount != 0)
		{
			num ^= BuyCount.GetHashCode();
		}
		if (LastRefreshTs != 0L)
		{
			num ^= LastRefreshTs.GetHashCode();
		}
		num ^= ShipDays.GetHashCode();
		if (SpecialRefreshId != 0)
		{
			num ^= SpecialRefreshId.GetHashCode();
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
		if (BuyCount != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(BuyCount);
		}
		if (LastRefreshTs != 0L)
		{
			output.WriteRawTag(24);
			output.WriteInt64(LastRefreshTs);
		}
		shipDays_.WriteTo(ref output, _map_shipDays_codec);
		if (SpecialRefreshId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(SpecialRefreshId);
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
		if (BuyCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuyCount);
		}
		if (LastRefreshTs != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(LastRefreshTs);
		}
		num += shipDays_.CalculateSize(_map_shipDays_codec);
		if (SpecialRefreshId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SpecialRefreshId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(BundleInfo other)
	{
		if (other != null)
		{
			if (other.GoodsId != 0)
			{
				GoodsId = other.GoodsId;
			}
			if (other.BuyCount != 0)
			{
				BuyCount = other.BuyCount;
			}
			if (other.LastRefreshTs != 0L)
			{
				LastRefreshTs = other.LastRefreshTs;
			}
			shipDays_.Add(other.shipDays_);
			if (other.SpecialRefreshId != 0)
			{
				SpecialRefreshId = other.SpecialRefreshId;
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
			case 16u:
				BuyCount = input.ReadInt32();
				break;
			case 24u:
				LastRefreshTs = input.ReadInt64();
				break;
			case 34u:
				shipDays_.AddEntriesFrom(ref input, _map_shipDays_codec);
				break;
			case 40u:
				SpecialRefreshId = input.ReadInt32();
				break;
			}
		}
	}
}
