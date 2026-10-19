using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MailNtf : IMessage<MailNtf>, IMessage, IEquatable<MailNtf>, IDeepCloneable<MailNtf>, IBufferMessage
{
	private static readonly MessageParser<MailNtf> _parser = new MessageParser<MailNtf>(() => new MailNtf());

	private UnknownFieldSet _unknownFields;

	public const int MailsFieldNumber = 1;

	private static readonly MapField<int, Mail>.Codec _map_mails_codec = new MapField<int, Mail>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Mail.Parser), 10u);

	private readonly MapField<int, Mail> mails_ = new MapField<int, Mail>();

	public const int LockTmplIdsFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_lockTmplIds_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> lockTmplIds_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MailNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MailReflection.Descriptor.MessageTypes[8];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, Mail> Mails => mails_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> LockTmplIds => lockTmplIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MailNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MailNtf(MailNtf other)
		: this()
	{
		mails_ = other.mails_.Clone();
		lockTmplIds_ = other.lockTmplIds_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MailNtf Clone()
	{
		return new MailNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MailNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MailNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Mails.Equals(other.Mails))
		{
			return false;
		}
		if (!lockTmplIds_.Equals(other.lockTmplIds_))
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
		num ^= Mails.GetHashCode();
		num ^= lockTmplIds_.GetHashCode();
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
		mails_.WriteTo(ref output, _map_mails_codec);
		lockTmplIds_.WriteTo(ref output, _repeated_lockTmplIds_codec);
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
		num += mails_.CalculateSize(_map_mails_codec);
		num += lockTmplIds_.CalculateSize(_repeated_lockTmplIds_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MailNtf other)
	{
		if (other != null)
		{
			mails_.Add(other.mails_);
			lockTmplIds_.Add(other.lockTmplIds_);
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
				mails_.AddEntriesFrom(ref input, _map_mails_codec);
				break;
			case 16u:
			case 18u:
				lockTmplIds_.AddEntriesFrom(ref input, _repeated_lockTmplIds_codec);
				break;
			}
		}
	}
}
