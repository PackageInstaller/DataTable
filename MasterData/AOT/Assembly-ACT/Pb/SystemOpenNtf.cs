using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class SystemOpenNtf : IMessage<SystemOpenNtf>, IMessage, IEquatable<SystemOpenNtf>, IDeepCloneable<SystemOpenNtf>, IBufferMessage
{
	private static readonly MessageParser<SystemOpenNtf> _parser = new MessageParser<SystemOpenNtf>(() => new SystemOpenNtf());

	private UnknownFieldSet _unknownFields;

	public const int OpenSystemsFieldNumber = 1;

	private static readonly FieldCodec<int> _repeated_openSystems_codec = FieldCodec.ForInt32(10u);

	private readonly RepeatedField<int> openSystems_ = new RepeatedField<int>();

	public const int ReadSystemsFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_readSystems_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> readSystems_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SystemOpenNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => SystemReflection.Descriptor.MessageTypes[2];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> OpenSystems => openSystems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> ReadSystems => readSystems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SystemOpenNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SystemOpenNtf(SystemOpenNtf other)
		: this()
	{
		openSystems_ = other.openSystems_.Clone();
		readSystems_ = other.readSystems_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SystemOpenNtf Clone()
	{
		return new SystemOpenNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SystemOpenNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SystemOpenNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!openSystems_.Equals(other.openSystems_))
		{
			return false;
		}
		if (!readSystems_.Equals(other.readSystems_))
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
		num ^= openSystems_.GetHashCode();
		num ^= readSystems_.GetHashCode();
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
		openSystems_.WriteTo(ref output, _repeated_openSystems_codec);
		readSystems_.WriteTo(ref output, _repeated_readSystems_codec);
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
		num += openSystems_.CalculateSize(_repeated_openSystems_codec);
		num += readSystems_.CalculateSize(_repeated_readSystems_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SystemOpenNtf other)
	{
		if (other != null)
		{
			openSystems_.Add(other.openSystems_);
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
			case 8u:
			case 10u:
				openSystems_.AddEntriesFrom(ref input, _repeated_openSystems_codec);
				break;
			case 16u:
			case 18u:
				readSystems_.AddEntriesFrom(ref input, _repeated_readSystems_codec);
				break;
			}
		}
	}
}
