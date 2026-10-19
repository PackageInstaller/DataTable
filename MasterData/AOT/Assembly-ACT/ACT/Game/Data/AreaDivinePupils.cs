using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class AreaDivinePupils : IMessage<AreaDivinePupils>, IMessage, IEquatable<AreaDivinePupils>, IDeepCloneable<AreaDivinePupils>, IBufferMessage
{
	private static readonly MessageParser<AreaDivinePupils> _parser = new MessageParser<AreaDivinePupils>(() => new AreaDivinePupils());

	private UnknownFieldSet _unknownFields;

	public const int AreasFieldNumber = 1;

	private static readonly MapField<int, DivinePupil>.Codec _map_areas_codec = new MapField<int, DivinePupil>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, DivinePupil.Parser), 10u);

	private readonly MapField<int, DivinePupil> areas_ = new MapField<int, DivinePupil>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AreaDivinePupils> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[86];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, DivinePupil> Areas => areas_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AreaDivinePupils()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AreaDivinePupils(AreaDivinePupils other)
		: this()
	{
		areas_ = other.areas_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AreaDivinePupils Clone()
	{
		return new AreaDivinePupils(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AreaDivinePupils);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AreaDivinePupils other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Areas.Equals(other.Areas))
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
		num ^= Areas.GetHashCode();
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
		areas_.WriteTo(ref output, _map_areas_codec);
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
		num += areas_.CalculateSize(_map_areas_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AreaDivinePupils other)
	{
		if (other != null)
		{
			areas_.Add(other.areas_);
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
				areas_.AddEntriesFrom(ref input, _map_areas_codec);
			}
		}
	}
}
