using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MapSubmitDivinePupilAck : IMessage<MapSubmitDivinePupilAck>, IMessage, IEquatable<MapSubmitDivinePupilAck>, IDeepCloneable<MapSubmitDivinePupilAck>, IBufferMessage
{
	private static readonly MessageParser<MapSubmitDivinePupilAck> _parser = new MessageParser<MapSubmitDivinePupilAck>(() => new MapSubmitDivinePupilAck());

	private UnknownFieldSet _unknownFields;

	public const int GotItemsFieldNumber = 1;

	private static readonly FieldCodec<UniversalItem> _repeated_gotItems_codec = FieldCodec.ForMessage(10u, UniversalItem.Parser);

	private readonly RepeatedField<UniversalItem> gotItems_ = new RepeatedField<UniversalItem>();

	public const int LatestDivinePupilInfoFieldNumber = 2;

	private DivinePupil latestDivinePupilInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapSubmitDivinePupilAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MapReflection.Descriptor.MessageTypes[14];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<UniversalItem> GotItems => gotItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DivinePupil LatestDivinePupilInfo
	{
		get
		{
			return latestDivinePupilInfo_;
		}
		set
		{
			latestDivinePupilInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapSubmitDivinePupilAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapSubmitDivinePupilAck(MapSubmitDivinePupilAck other)
		: this()
	{
		gotItems_ = other.gotItems_.Clone();
		latestDivinePupilInfo_ = ((other.latestDivinePupilInfo_ != null) ? other.latestDivinePupilInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapSubmitDivinePupilAck Clone()
	{
		return new MapSubmitDivinePupilAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapSubmitDivinePupilAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapSubmitDivinePupilAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!gotItems_.Equals(other.gotItems_))
		{
			return false;
		}
		if (!object.Equals(LatestDivinePupilInfo, other.LatestDivinePupilInfo))
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
		num ^= gotItems_.GetHashCode();
		if (latestDivinePupilInfo_ != null)
		{
			num ^= LatestDivinePupilInfo.GetHashCode();
		}
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
		gotItems_.WriteTo(ref output, _repeated_gotItems_codec);
		if (latestDivinePupilInfo_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(LatestDivinePupilInfo);
		}
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
		num += gotItems_.CalculateSize(_repeated_gotItems_codec);
		if (latestDivinePupilInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(LatestDivinePupilInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapSubmitDivinePupilAck other)
	{
		if (other == null)
		{
			return;
		}
		gotItems_.Add(other.gotItems_);
		if (other.latestDivinePupilInfo_ != null)
		{
			if (latestDivinePupilInfo_ == null)
			{
				LatestDivinePupilInfo = new DivinePupil();
			}
			LatestDivinePupilInfo.MergeFrom(other.LatestDivinePupilInfo);
		}
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
				gotItems_.AddEntriesFrom(ref input, _repeated_gotItems_codec);
				break;
			case 18u:
				if (latestDivinePupilInfo_ == null)
				{
					LatestDivinePupilInfo = new DivinePupil();
				}
				input.ReadMessage(LatestDivinePupilInfo);
				break;
			}
		}
	}
}
