using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MapAreaDivinePupilsNtf : IMessage<MapAreaDivinePupilsNtf>, IMessage, IEquatable<MapAreaDivinePupilsNtf>, IDeepCloneable<MapAreaDivinePupilsNtf>, IBufferMessage
{
	private static readonly MessageParser<MapAreaDivinePupilsNtf> _parser = new MessageParser<MapAreaDivinePupilsNtf>(() => new MapAreaDivinePupilsNtf());

	private UnknownFieldSet _unknownFields;

	public const int PupilsFieldNumber = 1;

	private static readonly MapField<int, DivinePupil>.Codec _map_pupils_codec = new MapField<int, DivinePupil>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, DivinePupil.Parser), 10u);

	private readonly MapField<int, DivinePupil> pupils_ = new MapField<int, DivinePupil>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapAreaDivinePupilsNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MapReflection.Descriptor.MessageTypes[12];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, DivinePupil> Pupils => pupils_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapAreaDivinePupilsNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapAreaDivinePupilsNtf(MapAreaDivinePupilsNtf other)
		: this()
	{
		pupils_ = other.pupils_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapAreaDivinePupilsNtf Clone()
	{
		return new MapAreaDivinePupilsNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapAreaDivinePupilsNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapAreaDivinePupilsNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Pupils.Equals(other.Pupils))
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
		num ^= Pupils.GetHashCode();
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
		pupils_.WriteTo(ref output, _map_pupils_codec);
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
		num += pupils_.CalculateSize(_map_pupils_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapAreaDivinePupilsNtf other)
	{
		if (other != null)
		{
			pupils_.Add(other.pupils_);
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
				pupils_.AddEntriesFrom(ref input, _map_pupils_codec);
			}
		}
	}
}
