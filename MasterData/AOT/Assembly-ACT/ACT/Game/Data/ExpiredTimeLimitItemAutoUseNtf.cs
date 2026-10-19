using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ExpiredTimeLimitItemAutoUseNtf : IMessage<ExpiredTimeLimitItemAutoUseNtf>, IMessage, IEquatable<ExpiredTimeLimitItemAutoUseNtf>, IDeepCloneable<ExpiredTimeLimitItemAutoUseNtf>, IBufferMessage
{
	private static readonly MessageParser<ExpiredTimeLimitItemAutoUseNtf> _parser = new MessageParser<ExpiredTimeLimitItemAutoUseNtf>(() => new ExpiredTimeLimitItemAutoUseNtf());

	private UnknownFieldSet _unknownFields;

	public const int ItemsFieldNumber = 1;

	private static readonly FieldCodec<ExpiredTimeLimitItemAutoUseEntry> _repeated_items_codec = FieldCodec.ForMessage(10u, ExpiredTimeLimitItemAutoUseEntry.Parser);

	private readonly RepeatedField<ExpiredTimeLimitItemAutoUseEntry> items_ = new RepeatedField<ExpiredTimeLimitItemAutoUseEntry>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ExpiredTimeLimitItemAutoUseNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[16];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<ExpiredTimeLimitItemAutoUseEntry> Items => items_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ExpiredTimeLimitItemAutoUseNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ExpiredTimeLimitItemAutoUseNtf(ExpiredTimeLimitItemAutoUseNtf other)
		: this()
	{
		items_ = other.items_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ExpiredTimeLimitItemAutoUseNtf Clone()
	{
		return new ExpiredTimeLimitItemAutoUseNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ExpiredTimeLimitItemAutoUseNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ExpiredTimeLimitItemAutoUseNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!items_.Equals(other.items_))
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
		num ^= items_.GetHashCode();
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
		items_.WriteTo(ref output, _repeated_items_codec);
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
		num += items_.CalculateSize(_repeated_items_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ExpiredTimeLimitItemAutoUseNtf other)
	{
		if (other != null)
		{
			items_.Add(other.items_);
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
				items_.AddEntriesFrom(ref input, _repeated_items_codec);
			}
		}
	}
}
