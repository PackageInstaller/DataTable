using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class AreaSubAreaCompleteCount : IMessage<AreaSubAreaCompleteCount>, IMessage, IEquatable<AreaSubAreaCompleteCount>, IDeepCloneable<AreaSubAreaCompleteCount>, IBufferMessage
{
	private static readonly MessageParser<AreaSubAreaCompleteCount> _parser = new MessageParser<AreaSubAreaCompleteCount>(() => new AreaSubAreaCompleteCount());

	private UnknownFieldSet _unknownFields;

	public const int SubAreaCountFieldNumber = 1;

	private static readonly MapField<int, int>.Codec _map_subAreaCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 10u);

	private readonly MapField<int, int> subAreaCount_ = new MapField<int, int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AreaSubAreaCompleteCount> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[221];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> SubAreaCount => subAreaCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AreaSubAreaCompleteCount()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AreaSubAreaCompleteCount(AreaSubAreaCompleteCount other)
		: this()
	{
		subAreaCount_ = other.subAreaCount_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AreaSubAreaCompleteCount Clone()
	{
		return new AreaSubAreaCompleteCount(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AreaSubAreaCompleteCount);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AreaSubAreaCompleteCount other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!SubAreaCount.Equals(other.SubAreaCount))
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
		num ^= SubAreaCount.GetHashCode();
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
		subAreaCount_.WriteTo(ref output, _map_subAreaCount_codec);
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
		num += subAreaCount_.CalculateSize(_map_subAreaCount_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AreaSubAreaCompleteCount other)
	{
		if (other != null)
		{
			subAreaCount_.Add(other.subAreaCount_);
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
				subAreaCount_.AddEntriesFrom(ref input, _map_subAreaCount_codec);
			}
		}
	}
}
