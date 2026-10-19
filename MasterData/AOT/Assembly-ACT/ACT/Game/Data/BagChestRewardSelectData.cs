using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class BagChestRewardSelectData : IMessage<BagChestRewardSelectData>, IMessage, IEquatable<BagChestRewardSelectData>, IDeepCloneable<BagChestRewardSelectData>, IBufferMessage
{
	private static readonly MessageParser<BagChestRewardSelectData> _parser = new MessageParser<BagChestRewardSelectData>(() => new BagChestRewardSelectData());

	private UnknownFieldSet _unknownFields;

	public const int ChestRecordsFieldNumber = 1;

	private static readonly MapField<int, BagChestRewardSelectRecord>.Codec _map_chestRecords_codec = new MapField<int, BagChestRewardSelectRecord>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, BagChestRewardSelectRecord.Parser), 10u);

	private readonly MapField<int, BagChestRewardSelectRecord> chestRecords_ = new MapField<int, BagChestRewardSelectRecord>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<BagChestRewardSelectData> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[119];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, BagChestRewardSelectRecord> ChestRecords => chestRecords_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BagChestRewardSelectData()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BagChestRewardSelectData(BagChestRewardSelectData other)
		: this()
	{
		chestRecords_ = other.chestRecords_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BagChestRewardSelectData Clone()
	{
		return new BagChestRewardSelectData(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as BagChestRewardSelectData);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(BagChestRewardSelectData other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!ChestRecords.Equals(other.ChestRecords))
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
		num ^= ChestRecords.GetHashCode();
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
		chestRecords_.WriteTo(ref output, _map_chestRecords_codec);
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
		num += chestRecords_.CalculateSize(_map_chestRecords_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(BagChestRewardSelectData other)
	{
		if (other != null)
		{
			chestRecords_.Add(other.chestRecords_);
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
			if (num != 10)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
			}
			else
			{
				chestRecords_.AddEntriesFrom(ref input, _map_chestRecords_codec);
			}
		}
	}
}
