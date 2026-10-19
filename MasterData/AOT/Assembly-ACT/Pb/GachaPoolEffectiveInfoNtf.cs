using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class GachaPoolEffectiveInfoNtf : IMessage<GachaPoolEffectiveInfoNtf>, IMessage, IEquatable<GachaPoolEffectiveInfoNtf>, IDeepCloneable<GachaPoolEffectiveInfoNtf>, IBufferMessage
{
	private static readonly MessageParser<GachaPoolEffectiveInfoNtf> _parser = new MessageParser<GachaPoolEffectiveInfoNtf>(() => new GachaPoolEffectiveInfoNtf());

	private UnknownFieldSet _unknownFields;

	public const int InfoFieldNumber = 1;

	private static readonly FieldCodec<GachaPoolEffectiveInfo> _repeated_info_codec = FieldCodec.ForMessage(10u, GachaPoolEffectiveInfo.Parser);

	private readonly RepeatedField<GachaPoolEffectiveInfo> info_ = new RepeatedField<GachaPoolEffectiveInfo>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GachaPoolEffectiveInfoNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[19];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<GachaPoolEffectiveInfo> Info => info_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolEffectiveInfoNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolEffectiveInfoNtf(GachaPoolEffectiveInfoNtf other)
		: this()
	{
		info_ = other.info_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolEffectiveInfoNtf Clone()
	{
		return new GachaPoolEffectiveInfoNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GachaPoolEffectiveInfoNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GachaPoolEffectiveInfoNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!info_.Equals(other.info_))
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
		num ^= info_.GetHashCode();
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
		info_.WriteTo(ref output, _repeated_info_codec);
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
		num += info_.CalculateSize(_repeated_info_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GachaPoolEffectiveInfoNtf other)
	{
		if (other != null)
		{
			info_.Add(other.info_);
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
				info_.AddEntriesFrom(ref input, _repeated_info_codec);
			}
		}
	}
}
