using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ItemMonitorDailyData : IMessage<ItemMonitorDailyData>, IMessage, IEquatable<ItemMonitorDailyData>, IDeepCloneable<ItemMonitorDailyData>, IBufferMessage
{
	private static readonly MessageParser<ItemMonitorDailyData> _parser = new MessageParser<ItemMonitorDailyData>(() => new ItemMonitorDailyData());

	private UnknownFieldSet _unknownFields;

	public const int PeriodStartTsFieldNumber = 1;

	private long periodStartTs_;

	public const int ItemCountsFieldNumber = 2;

	private static readonly MapField<int, int>.Codec _map_itemCounts_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 18u);

	private readonly MapField<int, int> itemCounts_ = new MapField<int, int>();

	public const int AlertedItemsFieldNumber = 3;

	private static readonly MapField<int, bool>.Codec _map_alertedItems_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 26u);

	private readonly MapField<int, bool> alertedItems_ = new MapField<int, bool>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ItemMonitorDailyData> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[161];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long PeriodStartTs
	{
		get
		{
			return periodStartTs_;
		}
		set
		{
			periodStartTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> ItemCounts => itemCounts_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> AlertedItems => alertedItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ItemMonitorDailyData()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ItemMonitorDailyData(ItemMonitorDailyData other)
		: this()
	{
		periodStartTs_ = other.periodStartTs_;
		itemCounts_ = other.itemCounts_.Clone();
		alertedItems_ = other.alertedItems_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ItemMonitorDailyData Clone()
	{
		return new ItemMonitorDailyData(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ItemMonitorDailyData);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ItemMonitorDailyData other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (PeriodStartTs != other.PeriodStartTs)
		{
			return false;
		}
		if (!ItemCounts.Equals(other.ItemCounts))
		{
			return false;
		}
		if (!AlertedItems.Equals(other.AlertedItems))
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
		if (PeriodStartTs != 0L)
		{
			num ^= PeriodStartTs.GetHashCode();
		}
		num ^= ItemCounts.GetHashCode();
		num ^= AlertedItems.GetHashCode();
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
		if (PeriodStartTs != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(PeriodStartTs);
		}
		itemCounts_.WriteTo(ref output, _map_itemCounts_codec);
		alertedItems_.WriteTo(ref output, _map_alertedItems_codec);
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
		if (PeriodStartTs != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(PeriodStartTs);
		}
		num += itemCounts_.CalculateSize(_map_itemCounts_codec);
		num += alertedItems_.CalculateSize(_map_alertedItems_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ItemMonitorDailyData other)
	{
		if (other != null)
		{
			if (other.PeriodStartTs != 0L)
			{
				PeriodStartTs = other.PeriodStartTs;
			}
			itemCounts_.Add(other.itemCounts_);
			alertedItems_.Add(other.alertedItems_);
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
				PeriodStartTs = input.ReadInt64();
				break;
			case 18u:
				itemCounts_.AddEntriesFrom(ref input, _map_itemCounts_codec);
				break;
			case 26u:
				alertedItems_.AddEntriesFrom(ref input, _map_alertedItems_codec);
				break;
			}
		}
	}
}
