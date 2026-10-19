using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class OperationalActivityDataNtf : IMessage<OperationalActivityDataNtf>, IMessage, IEquatable<OperationalActivityDataNtf>, IDeepCloneable<OperationalActivityDataNtf>, IBufferMessage
{
	private static readonly MessageParser<OperationalActivityDataNtf> _parser = new MessageParser<OperationalActivityDataNtf>(() => new OperationalActivityDataNtf());

	private UnknownFieldSet _unknownFields;

	public const int ActivitysFieldNumber = 1;

	private static readonly MapField<int, OperationalActivityData>.Codec _map_activitys_codec = new MapField<int, OperationalActivityData>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, OperationalActivityData.Parser), 10u);

	private readonly MapField<int, OperationalActivityData> activitys_ = new MapField<int, OperationalActivityData>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<OperationalActivityDataNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[121];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, OperationalActivityData> Activitys => activitys_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OperationalActivityDataNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OperationalActivityDataNtf(OperationalActivityDataNtf other)
		: this()
	{
		activitys_ = other.activitys_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OperationalActivityDataNtf Clone()
	{
		return new OperationalActivityDataNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as OperationalActivityDataNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(OperationalActivityDataNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Activitys.Equals(other.Activitys))
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
		num ^= Activitys.GetHashCode();
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
		activitys_.WriteTo(ref output, _map_activitys_codec);
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
		num += activitys_.CalculateSize(_map_activitys_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(OperationalActivityDataNtf other)
	{
		if (other != null)
		{
			activitys_.Add(other.activitys_);
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
				activitys_.AddEntriesFrom(ref input, _map_activitys_codec);
			}
		}
	}
}
