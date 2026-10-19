using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class RedeemCode : IMessage<RedeemCode>, IMessage, IEquatable<RedeemCode>, IDeepCloneable<RedeemCode>, IBufferMessage
{
	private static readonly MessageParser<RedeemCode> _parser = new MessageParser<RedeemCode>(() => new RedeemCode());

	private UnknownFieldSet _unknownFields;

	public const int UsedCodesFieldNumber = 1;

	private static readonly FieldCodec<string> _repeated_usedCodes_codec = FieldCodec.ForString(10u);

	private readonly RepeatedField<string> usedCodes_ = new RepeatedField<string>();

	public const int UsedCodeBatchsFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_usedCodeBatchs_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> usedCodeBatchs_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RedeemCode> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[66];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<string> UsedCodes => usedCodes_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> UsedCodeBatchs => usedCodeBatchs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RedeemCode()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RedeemCode(RedeemCode other)
		: this()
	{
		usedCodes_ = other.usedCodes_.Clone();
		usedCodeBatchs_ = other.usedCodeBatchs_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RedeemCode Clone()
	{
		return new RedeemCode(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RedeemCode);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RedeemCode other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!usedCodes_.Equals(other.usedCodes_))
		{
			return false;
		}
		if (!usedCodeBatchs_.Equals(other.usedCodeBatchs_))
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
		num ^= usedCodes_.GetHashCode();
		num ^= usedCodeBatchs_.GetHashCode();
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
		usedCodes_.WriteTo(ref output, _repeated_usedCodes_codec);
		usedCodeBatchs_.WriteTo(ref output, _repeated_usedCodeBatchs_codec);
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
		num += usedCodes_.CalculateSize(_repeated_usedCodes_codec);
		num += usedCodeBatchs_.CalculateSize(_repeated_usedCodeBatchs_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RedeemCode other)
	{
		if (other != null)
		{
			usedCodes_.Add(other.usedCodes_);
			usedCodeBatchs_.Add(other.usedCodeBatchs_);
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
				usedCodes_.AddEntriesFrom(ref input, _repeated_usedCodes_codec);
				break;
			case 16u:
			case 18u:
				usedCodeBatchs_.AddEntriesFrom(ref input, _repeated_usedCodeBatchs_codec);
				break;
			}
		}
	}
}
