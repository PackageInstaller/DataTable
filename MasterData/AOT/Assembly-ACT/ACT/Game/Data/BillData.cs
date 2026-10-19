using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class BillData : IMessage<BillData>, IMessage, IEquatable<BillData>, IDeepCloneable<BillData>, IBufferMessage
{
	private static readonly MessageParser<BillData> _parser = new MessageParser<BillData>(() => new BillData());

	private UnknownFieldSet _unknownFields;

	public const int BillBuyCountFieldNumber = 1;

	private static readonly MapField<int, int>.Codec _map_billBuyCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 10u);

	private readonly MapField<int, int> billBuyCount_ = new MapField<int, int>();

	public const int IsRebateFieldNumber = 2;

	private bool isRebate_;

	public const int DisplayOrdersFieldNumber = 3;

	private static readonly MapField<string, DisplayOrderInfo>.Codec _map_displayOrders_codec = new MapField<string, DisplayOrderInfo>.Codec(FieldCodec.ForString(10u, ""), FieldCodec.ForMessage(18u, DisplayOrderInfo.Parser), 26u);

	private readonly MapField<string, DisplayOrderInfo> displayOrders_ = new MapField<string, DisplayOrderInfo>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<BillData> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[166];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> BillBuyCount => billBuyCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool IsRebate
	{
		get
		{
			return isRebate_;
		}
		set
		{
			isRebate_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<string, DisplayOrderInfo> DisplayOrders => displayOrders_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BillData()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BillData(BillData other)
		: this()
	{
		billBuyCount_ = other.billBuyCount_.Clone();
		isRebate_ = other.isRebate_;
		displayOrders_ = other.displayOrders_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BillData Clone()
	{
		return new BillData(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as BillData);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(BillData other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!BillBuyCount.Equals(other.BillBuyCount))
		{
			return false;
		}
		if (IsRebate != other.IsRebate)
		{
			return false;
		}
		if (!DisplayOrders.Equals(other.DisplayOrders))
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
		num ^= BillBuyCount.GetHashCode();
		if (IsRebate)
		{
			num ^= IsRebate.GetHashCode();
		}
		num ^= DisplayOrders.GetHashCode();
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
		billBuyCount_.WriteTo(ref output, _map_billBuyCount_codec);
		if (IsRebate)
		{
			output.WriteRawTag(16);
			output.WriteBool(IsRebate);
		}
		displayOrders_.WriteTo(ref output, _map_displayOrders_codec);
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
		num += billBuyCount_.CalculateSize(_map_billBuyCount_codec);
		if (IsRebate)
		{
			num += 2;
		}
		num += displayOrders_.CalculateSize(_map_displayOrders_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(BillData other)
	{
		if (other != null)
		{
			billBuyCount_.Add(other.billBuyCount_);
			if (other.IsRebate)
			{
				IsRebate = other.IsRebate;
			}
			displayOrders_.Add(other.displayOrders_);
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
			case 10u:
				billBuyCount_.AddEntriesFrom(ref input, _map_billBuyCount_codec);
				break;
			case 16u:
				IsRebate = input.ReadBool();
				break;
			case 26u:
				displayOrders_.AddEntriesFrom(ref input, _map_displayOrders_codec);
				break;
			}
		}
	}
}
