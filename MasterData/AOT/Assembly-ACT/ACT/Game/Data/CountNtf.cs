using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class CountNtf : IMessage<CountNtf>, IMessage, IEquatable<CountNtf>, IDeepCloneable<CountNtf>, IBufferMessage
{
	private static readonly MessageParser<CountNtf> _parser = new MessageParser<CountNtf>(() => new CountNtf());

	private UnknownFieldSet _unknownFields;

	public const int CountsFieldNumber = 1;

	private static readonly MapField<int, long>.Codec _map_counts_codec = new MapField<int, long>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt64(16u, 0L), 10u);

	private readonly MapField<int, long> counts_ = new MapField<int, long>();

	public const int DailyCountsFieldNumber = 2;

	private static readonly MapField<int, long>.Codec _map_dailyCounts_codec = new MapField<int, long>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt64(16u, 0L), 18u);

	private readonly MapField<int, long> dailyCounts_ = new MapField<int, long>();

	public const int WeekCountsFieldNumber = 3;

	private static readonly MapField<int, long>.Codec _map_weekCounts_codec = new MapField<int, long>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt64(16u, 0L), 26u);

	private readonly MapField<int, long> weekCounts_ = new MapField<int, long>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CountNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[11];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, long> Counts => counts_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, long> DailyCounts => dailyCounts_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, long> WeekCounts => weekCounts_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CountNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CountNtf(CountNtf other)
		: this()
	{
		counts_ = other.counts_.Clone();
		dailyCounts_ = other.dailyCounts_.Clone();
		weekCounts_ = other.weekCounts_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CountNtf Clone()
	{
		return new CountNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CountNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CountNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Counts.Equals(other.Counts))
		{
			return false;
		}
		if (!DailyCounts.Equals(other.DailyCounts))
		{
			return false;
		}
		if (!WeekCounts.Equals(other.WeekCounts))
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
		num ^= Counts.GetHashCode();
		num ^= DailyCounts.GetHashCode();
		num ^= WeekCounts.GetHashCode();
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
		counts_.WriteTo(ref output, _map_counts_codec);
		dailyCounts_.WriteTo(ref output, _map_dailyCounts_codec);
		weekCounts_.WriteTo(ref output, _map_weekCounts_codec);
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
		num += counts_.CalculateSize(_map_counts_codec);
		num += dailyCounts_.CalculateSize(_map_dailyCounts_codec);
		num += weekCounts_.CalculateSize(_map_weekCounts_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CountNtf other)
	{
		if (other != null)
		{
			counts_.Add(other.counts_);
			dailyCounts_.Add(other.dailyCounts_);
			weekCounts_.Add(other.weekCounts_);
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
				counts_.AddEntriesFrom(ref input, _map_counts_codec);
				break;
			case 18u:
				dailyCounts_.AddEntriesFrom(ref input, _map_dailyCounts_codec);
				break;
			case 26u:
				weekCounts_.AddEntriesFrom(ref input, _map_weekCounts_codec);
				break;
			}
		}
	}
}
