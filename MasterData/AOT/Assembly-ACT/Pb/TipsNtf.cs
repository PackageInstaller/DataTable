using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class TipsNtf : IMessage<TipsNtf>, IMessage, IEquatable<TipsNtf>, IDeepCloneable<TipsNtf>, IBufferMessage
{
	private static readonly MessageParser<TipsNtf> _parser = new MessageParser<TipsNtf>(() => new TipsNtf());

	private UnknownFieldSet _unknownFields;

	public const int ErrCodeFieldNumber = 1;

	private string errCode_ = "";

	public const int OverflowItemsFieldNumber = 2;

	private static readonly FieldCodec<UniversalItem> _repeated_overflowItems_codec = FieldCodec.ForMessage(18u, UniversalItem.Parser);

	private readonly RepeatedField<UniversalItem> overflowItems_ = new RepeatedField<UniversalItem>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TipsNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[143];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string ErrCode
	{
		get
		{
			return errCode_;
		}
		set
		{
			errCode_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<UniversalItem> OverflowItems => overflowItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TipsNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TipsNtf(TipsNtf other)
		: this()
	{
		errCode_ = other.errCode_;
		overflowItems_ = other.overflowItems_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TipsNtf Clone()
	{
		return new TipsNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TipsNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TipsNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ErrCode != other.ErrCode)
		{
			return false;
		}
		if (!overflowItems_.Equals(other.overflowItems_))
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
		if (ErrCode.Length != 0)
		{
			num ^= ErrCode.GetHashCode();
		}
		num ^= overflowItems_.GetHashCode();
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
		if (ErrCode.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(ErrCode);
		}
		overflowItems_.WriteTo(ref output, _repeated_overflowItems_codec);
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
		if (ErrCode.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ErrCode);
		}
		num += overflowItems_.CalculateSize(_repeated_overflowItems_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TipsNtf other)
	{
		if (other != null)
		{
			if (other.ErrCode.Length != 0)
			{
				ErrCode = other.ErrCode;
			}
			overflowItems_.Add(other.overflowItems_);
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
				ErrCode = input.ReadString();
				break;
			case 18u:
				overflowItems_.AddEntriesFrom(ref input, _repeated_overflowItems_codec);
				break;
			}
		}
	}
}
