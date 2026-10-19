using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MessageBoardAddSyntaxNtf : IMessage<MessageBoardAddSyntaxNtf>, IMessage, IEquatable<MessageBoardAddSyntaxNtf>, IDeepCloneable<MessageBoardAddSyntaxNtf>, IBufferMessage
{
	private static readonly MessageParser<MessageBoardAddSyntaxNtf> _parser = new MessageParser<MessageBoardAddSyntaxNtf>(() => new MessageBoardAddSyntaxNtf());

	private UnknownFieldSet _unknownFields;

	public const int SyntaxIdsFieldNumber = 1;

	private static readonly FieldCodec<int> _repeated_syntaxIds_codec = FieldCodec.ForInt32(10u);

	private readonly RepeatedField<int> syntaxIds_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MessageBoardAddSyntaxNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MessageboardReflection.Descriptor.MessageTypes[1];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> SyntaxIds => syntaxIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MessageBoardAddSyntaxNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MessageBoardAddSyntaxNtf(MessageBoardAddSyntaxNtf other)
		: this()
	{
		syntaxIds_ = other.syntaxIds_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MessageBoardAddSyntaxNtf Clone()
	{
		return new MessageBoardAddSyntaxNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MessageBoardAddSyntaxNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MessageBoardAddSyntaxNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!syntaxIds_.Equals(other.syntaxIds_))
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
		num ^= syntaxIds_.GetHashCode();
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
		syntaxIds_.WriteTo(ref output, _repeated_syntaxIds_codec);
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
		num += syntaxIds_.CalculateSize(_repeated_syntaxIds_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MessageBoardAddSyntaxNtf other)
	{
		if (other != null)
		{
			syntaxIds_.Add(other.syntaxIds_);
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
				syntaxIds_.AddEntriesFrom(ref input, _repeated_syntaxIds_codec);
			}
		}
	}
}
