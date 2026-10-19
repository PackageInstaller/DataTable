using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class DiamondInfo : IMessage<DiamondInfo>, IMessage, IEquatable<DiamondInfo>, IDeepCloneable<DiamondInfo>, IBufferMessage
{
	private static readonly MessageParser<DiamondInfo> _parser = new MessageParser<DiamondInfo>(() => new DiamondInfo());

	private UnknownFieldSet _unknownFields;

	public const int GoodsIdFieldNumber = 1;

	private int goodsId_;

	public const int FirstBuyTimeFieldNumber = 2;

	private long firstBuyTime_;

	public const int LimitDoubleFieldNumber = 3;

	private static readonly MapField<int, long>.Codec _map_limitDouble_codec = new MapField<int, long>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt64(16u, 0L), 26u);

	private readonly MapField<int, long> limitDouble_ = new MapField<int, long>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<DiamondInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[295];

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
	public long FirstBuyTime
	{
		get
		{
			return firstBuyTime_;
		}
		set
		{
			firstBuyTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, long> LimitDouble => limitDouble_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DiamondInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DiamondInfo(DiamondInfo other)
		: this()
	{
		goodsId_ = other.goodsId_;
		firstBuyTime_ = other.firstBuyTime_;
		limitDouble_ = other.limitDouble_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DiamondInfo Clone()
	{
		return new DiamondInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as DiamondInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(DiamondInfo other)
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
		if (FirstBuyTime != other.FirstBuyTime)
		{
			return false;
		}
		if (!LimitDouble.Equals(other.LimitDouble))
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
		if (FirstBuyTime != 0L)
		{
			num ^= FirstBuyTime.GetHashCode();
		}
		num ^= LimitDouble.GetHashCode();
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
		if (FirstBuyTime != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(FirstBuyTime);
		}
		limitDouble_.WriteTo(ref output, _map_limitDouble_codec);
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
		if (FirstBuyTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(FirstBuyTime);
		}
		num += limitDouble_.CalculateSize(_map_limitDouble_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(DiamondInfo other)
	{
		if (other != null)
		{
			if (other.GoodsId != 0)
			{
				GoodsId = other.GoodsId;
			}
			if (other.FirstBuyTime != 0L)
			{
				FirstBuyTime = other.FirstBuyTime;
			}
			limitDouble_.Add(other.limitDouble_);
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
				FirstBuyTime = input.ReadInt64();
				break;
			case 26u:
				limitDouble_.AddEntriesFrom(ref input, _map_limitDouble_codec);
				break;
			}
		}
	}
}
