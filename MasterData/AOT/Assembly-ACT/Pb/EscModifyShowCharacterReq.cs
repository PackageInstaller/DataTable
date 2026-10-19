using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class EscModifyShowCharacterReq : IMessage<EscModifyShowCharacterReq>, IMessage, IEquatable<EscModifyShowCharacterReq>, IDeepCloneable<EscModifyShowCharacterReq>, IBufferMessage
{
	private static readonly MessageParser<EscModifyShowCharacterReq> _parser = new MessageParser<EscModifyShowCharacterReq>(() => new EscModifyShowCharacterReq());

	private UnknownFieldSet _unknownFields;

	public const int ShowCharacterIdsFieldNumber = 1;

	private static readonly FieldCodec<int> _repeated_showCharacterIds_codec = FieldCodec.ForInt32(10u);

	private readonly RepeatedField<int> showCharacterIds_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<EscModifyShowCharacterReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ProfileReflection.Descriptor.MessageTypes[21];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> ShowCharacterIds => showCharacterIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EscModifyShowCharacterReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EscModifyShowCharacterReq(EscModifyShowCharacterReq other)
		: this()
	{
		showCharacterIds_ = other.showCharacterIds_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EscModifyShowCharacterReq Clone()
	{
		return new EscModifyShowCharacterReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as EscModifyShowCharacterReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(EscModifyShowCharacterReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!showCharacterIds_.Equals(other.showCharacterIds_))
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
		num ^= showCharacterIds_.GetHashCode();
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
		showCharacterIds_.WriteTo(ref output, _repeated_showCharacterIds_codec);
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
		num += showCharacterIds_.CalculateSize(_repeated_showCharacterIds_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(EscModifyShowCharacterReq other)
	{
		if (other != null)
		{
			showCharacterIds_.Add(other.showCharacterIds_);
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
			if (num != 8 && num != 10)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
			}
			else
			{
				showCharacterIds_.AddEntriesFrom(ref input, _repeated_showCharacterIds_codec);
			}
		}
	}
}
