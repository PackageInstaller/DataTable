using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class EscAvatarFrameNtf : IMessage<EscAvatarFrameNtf>, IMessage, IEquatable<EscAvatarFrameNtf>, IDeepCloneable<EscAvatarFrameNtf>, IBufferMessage
{
	private static readonly MessageParser<EscAvatarFrameNtf> _parser = new MessageParser<EscAvatarFrameNtf>(() => new EscAvatarFrameNtf());

	private UnknownFieldSet _unknownFields;

	public const int GetAvatarFrameIdsFieldNumber = 1;

	private static readonly FieldCodec<int> _repeated_getAvatarFrameIds_codec = FieldCodec.ForInt32(10u);

	private readonly RepeatedField<int> getAvatarFrameIds_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<EscAvatarFrameNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ProfileReflection.Descriptor.MessageTypes[17];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> GetAvatarFrameIds => getAvatarFrameIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EscAvatarFrameNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EscAvatarFrameNtf(EscAvatarFrameNtf other)
		: this()
	{
		getAvatarFrameIds_ = other.getAvatarFrameIds_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EscAvatarFrameNtf Clone()
	{
		return new EscAvatarFrameNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as EscAvatarFrameNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(EscAvatarFrameNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!getAvatarFrameIds_.Equals(other.getAvatarFrameIds_))
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
		num ^= getAvatarFrameIds_.GetHashCode();
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
		getAvatarFrameIds_.WriteTo(ref output, _repeated_getAvatarFrameIds_codec);
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
		num += getAvatarFrameIds_.CalculateSize(_repeated_getAvatarFrameIds_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(EscAvatarFrameNtf other)
	{
		if (other != null)
		{
			getAvatarFrameIds_.Add(other.getAvatarFrameIds_);
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
				getAvatarFrameIds_.AddEntriesFrom(ref input, _repeated_getAvatarFrameIds_codec);
			}
		}
	}
}
