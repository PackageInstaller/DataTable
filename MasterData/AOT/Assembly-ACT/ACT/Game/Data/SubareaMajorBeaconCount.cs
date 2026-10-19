using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class SubareaMajorBeaconCount : IMessage<SubareaMajorBeaconCount>, IMessage, IEquatable<SubareaMajorBeaconCount>, IDeepCloneable<SubareaMajorBeaconCount>, IBufferMessage
{
	private static readonly MessageParser<SubareaMajorBeaconCount> _parser = new MessageParser<SubareaMajorBeaconCount>(() => new SubareaMajorBeaconCount());

	private UnknownFieldSet _unknownFields;

	public const int WeberCabinCountFieldNumber = 1;

	private static readonly MapField<int, int>.Codec _map_weberCabinCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 10u);

	private readonly MapField<int, int> weberCabinCount_ = new MapField<int, int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SubareaMajorBeaconCount> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[217];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> WeberCabinCount => weberCabinCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SubareaMajorBeaconCount()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SubareaMajorBeaconCount(SubareaMajorBeaconCount other)
		: this()
	{
		weberCabinCount_ = other.weberCabinCount_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SubareaMajorBeaconCount Clone()
	{
		return new SubareaMajorBeaconCount(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SubareaMajorBeaconCount);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SubareaMajorBeaconCount other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!WeberCabinCount.Equals(other.WeberCabinCount))
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
		num ^= WeberCabinCount.GetHashCode();
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
		weberCabinCount_.WriteTo(ref output, _map_weberCabinCount_codec);
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
		num += weberCabinCount_.CalculateSize(_map_weberCabinCount_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SubareaMajorBeaconCount other)
	{
		if (other != null)
		{
			weberCabinCount_.Add(other.weberCabinCount_);
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
				weberCabinCount_.AddEntriesFrom(ref input, _map_weberCabinCount_codec);
			}
		}
	}
}
