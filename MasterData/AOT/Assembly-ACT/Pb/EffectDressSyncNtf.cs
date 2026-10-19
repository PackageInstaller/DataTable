using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class EffectDressSyncNtf : IMessage<EffectDressSyncNtf>, IMessage, IEquatable<EffectDressSyncNtf>, IDeepCloneable<EffectDressSyncNtf>, IBufferMessage
{
	private static readonly MessageParser<EffectDressSyncNtf> _parser = new MessageParser<EffectDressSyncNtf>(() => new EffectDressSyncNtf());

	private UnknownFieldSet _unknownFields;

	public const int EffectDressesFieldNumber = 1;

	private static readonly FieldCodec<EffectDressInfo> _repeated_effectDresses_codec = FieldCodec.ForMessage(10u, EffectDressInfo.Parser);

	private readonly RepeatedField<EffectDressInfo> effectDresses_ = new RepeatedField<EffectDressInfo>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<EffectDressSyncNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[9];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<EffectDressInfo> EffectDresses => effectDresses_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EffectDressSyncNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EffectDressSyncNtf(EffectDressSyncNtf other)
		: this()
	{
		effectDresses_ = other.effectDresses_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EffectDressSyncNtf Clone()
	{
		return new EffectDressSyncNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as EffectDressSyncNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(EffectDressSyncNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!effectDresses_.Equals(other.effectDresses_))
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
		num ^= effectDresses_.GetHashCode();
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
		effectDresses_.WriteTo(ref output, _repeated_effectDresses_codec);
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
		num += effectDresses_.CalculateSize(_repeated_effectDresses_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(EffectDressSyncNtf other)
	{
		if (other != null)
		{
			effectDresses_.Add(other.effectDresses_);
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
				effectDresses_.AddEntriesFrom(ref input, _repeated_effectDresses_codec);
			}
		}
	}
}
