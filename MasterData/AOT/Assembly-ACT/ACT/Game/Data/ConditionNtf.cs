using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ConditionNtf : IMessage<ConditionNtf>, IMessage, IEquatable<ConditionNtf>, IDeepCloneable<ConditionNtf>, IBufferMessage
{
	private static readonly MessageParser<ConditionNtf> _parser = new MessageParser<ConditionNtf>(() => new ConditionNtf());

	private UnknownFieldSet _unknownFields;

	public const int ConditionsFieldNumber = 1;

	private static readonly MapField<int, long>.Codec _map_conditions_codec = new MapField<int, long>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt64(16u, 0L), 10u);

	private readonly MapField<int, long> conditions_ = new MapField<int, long>();

	public const int DailyConditionsFieldNumber = 2;

	private static readonly MapField<int, long>.Codec _map_dailyConditions_codec = new MapField<int, long>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt64(16u, 0L), 18u);

	private readonly MapField<int, long> dailyConditions_ = new MapField<int, long>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ConditionNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[12];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, long> Conditions => conditions_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, long> DailyConditions => dailyConditions_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ConditionNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ConditionNtf(ConditionNtf other)
		: this()
	{
		conditions_ = other.conditions_.Clone();
		dailyConditions_ = other.dailyConditions_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ConditionNtf Clone()
	{
		return new ConditionNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ConditionNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ConditionNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Conditions.Equals(other.Conditions))
		{
			return false;
		}
		if (!DailyConditions.Equals(other.DailyConditions))
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
		num ^= Conditions.GetHashCode();
		num ^= DailyConditions.GetHashCode();
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
		conditions_.WriteTo(ref output, _map_conditions_codec);
		dailyConditions_.WriteTo(ref output, _map_dailyConditions_codec);
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
		num += conditions_.CalculateSize(_map_conditions_codec);
		num += dailyConditions_.CalculateSize(_map_dailyConditions_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ConditionNtf other)
	{
		if (other != null)
		{
			conditions_.Add(other.conditions_);
			dailyConditions_.Add(other.dailyConditions_);
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
				conditions_.AddEntriesFrom(ref input, _map_conditions_codec);
				break;
			case 18u:
				dailyConditions_.AddEntriesFrom(ref input, _map_dailyConditions_codec);
				break;
			}
		}
	}
}
