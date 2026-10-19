using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class OpenedSystems : IMessage<OpenedSystems>, IMessage, IEquatable<OpenedSystems>, IDeepCloneable<OpenedSystems>, IBufferMessage
{
	private static readonly MessageParser<OpenedSystems> _parser = new MessageParser<OpenedSystems>(() => new OpenedSystems());

	private UnknownFieldSet _unknownFields;

	public const int SystemsFieldNumber = 1;

	private static readonly MapField<int, bool>.Codec _map_systems_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 10u);

	private readonly MapField<int, bool> systems_ = new MapField<int, bool>();

	public const int ReadSystemsFieldNumber = 2;

	private static readonly MapField<int, bool>.Codec _map_readSystems_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 18u);

	private readonly MapField<int, bool> readSystems_ = new MapField<int, bool>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<OpenedSystems> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[116];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> Systems => systems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> ReadSystems => readSystems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OpenedSystems()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OpenedSystems(OpenedSystems other)
		: this()
	{
		systems_ = other.systems_.Clone();
		readSystems_ = other.readSystems_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OpenedSystems Clone()
	{
		return new OpenedSystems(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as OpenedSystems);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(OpenedSystems other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Systems.Equals(other.Systems))
		{
			return false;
		}
		if (!ReadSystems.Equals(other.ReadSystems))
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
		num ^= Systems.GetHashCode();
		num ^= ReadSystems.GetHashCode();
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
		systems_.WriteTo(ref output, _map_systems_codec);
		readSystems_.WriteTo(ref output, _map_readSystems_codec);
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
		num += systems_.CalculateSize(_map_systems_codec);
		num += readSystems_.CalculateSize(_map_readSystems_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(OpenedSystems other)
	{
		if (other != null)
		{
			systems_.Add(other.systems_);
			readSystems_.Add(other.readSystems_);
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
				systems_.AddEntriesFrom(ref input, _map_systems_codec);
				break;
			case 18u:
				readSystems_.AddEntriesFrom(ref input, _map_readSystems_codec);
				break;
			}
		}
	}
}
