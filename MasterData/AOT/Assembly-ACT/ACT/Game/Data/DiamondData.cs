using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class DiamondData : IMessage<DiamondData>, IMessage, IEquatable<DiamondData>, IDeepCloneable<DiamondData>, IBufferMessage
{
	private static readonly MessageParser<DiamondData> _parser = new MessageParser<DiamondData>(() => new DiamondData());

	private UnknownFieldSet _unknownFields;

	public const int DiamondInfoFieldNumber = 1;

	private static readonly MapField<int, DiamondInfo>.Codec _map_diamondInfo_codec = new MapField<int, DiamondInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ACT.Game.Data.DiamondInfo.Parser), 10u);

	private readonly MapField<int, DiamondInfo> diamondInfo_ = new MapField<int, DiamondInfo>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<DiamondData> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[296];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, DiamondInfo> DiamondInfo => diamondInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DiamondData()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DiamondData(DiamondData other)
		: this()
	{
		diamondInfo_ = other.diamondInfo_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DiamondData Clone()
	{
		return new DiamondData(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as DiamondData);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(DiamondData other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!DiamondInfo.Equals(other.DiamondInfo))
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
		num ^= DiamondInfo.GetHashCode();
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
		diamondInfo_.WriteTo(ref output, _map_diamondInfo_codec);
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
		num += diamondInfo_.CalculateSize(_map_diamondInfo_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(DiamondData other)
	{
		if (other != null)
		{
			diamondInfo_.Add(other.diamondInfo_);
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
				diamondInfo_.AddEntriesFrom(ref input, _map_diamondInfo_codec);
			}
		}
	}
}
