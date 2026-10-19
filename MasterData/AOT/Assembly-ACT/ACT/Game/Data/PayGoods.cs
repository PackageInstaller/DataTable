using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class PayGoods : IMessage<PayGoods>, IMessage, IEquatable<PayGoods>, IDeepCloneable<PayGoods>, IBufferMessage
{
	private static readonly MessageParser<PayGoods> _parser = new MessageParser<PayGoods>(() => new PayGoods());

	private UnknownFieldSet _unknownFields;

	public const int GoodsIdFieldNumber = 1;

	private int goodsId_;

	public const int BeginTimeFieldNumber = 2;

	private long beginTime_;

	public const int EndTimeFieldNumber = 3;

	private long endTime_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<PayGoods> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[284];

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
	public long BeginTime
	{
		get
		{
			return beginTime_;
		}
		set
		{
			beginTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long EndTime
	{
		get
		{
			return endTime_;
		}
		set
		{
			endTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PayGoods()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PayGoods(PayGoods other)
		: this()
	{
		goodsId_ = other.goodsId_;
		beginTime_ = other.beginTime_;
		endTime_ = other.endTime_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PayGoods Clone()
	{
		return new PayGoods(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as PayGoods);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(PayGoods other)
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
		if (BeginTime != other.BeginTime)
		{
			return false;
		}
		if (EndTime != other.EndTime)
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
		if (BeginTime != 0L)
		{
			num ^= BeginTime.GetHashCode();
		}
		if (EndTime != 0L)
		{
			num ^= EndTime.GetHashCode();
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
		if (BeginTime != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(BeginTime);
		}
		if (EndTime != 0L)
		{
			output.WriteRawTag(24);
			output.WriteInt64(EndTime);
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
		if (BeginTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(BeginTime);
		}
		if (EndTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(EndTime);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(PayGoods other)
	{
		if (other != null)
		{
			if (other.GoodsId != 0)
			{
				GoodsId = other.GoodsId;
			}
			if (other.BeginTime != 0L)
			{
				BeginTime = other.BeginTime;
			}
			if (other.EndTime != 0L)
			{
				EndTime = other.EndTime;
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
				BeginTime = input.ReadInt64();
				break;
			case 24u:
				EndTime = input.ReadInt64();
				break;
			}
		}
	}
}
