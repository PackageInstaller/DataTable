using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ContactCharacterSessionNtf : IMessage<ContactCharacterSessionNtf>, IMessage, IEquatable<ContactCharacterSessionNtf>, IDeepCloneable<ContactCharacterSessionNtf>, IBufferMessage
{
	private static readonly MessageParser<ContactCharacterSessionNtf> _parser = new MessageParser<ContactCharacterSessionNtf>(() => new ContactCharacterSessionNtf());

	private UnknownFieldSet _unknownFields;

	public const int SessionsFieldNumber = 1;

	private static readonly FieldCodec<ContactCharacterSession> _repeated_sessions_codec = FieldCodec.ForMessage(10u, ContactCharacterSession.Parser);

	private readonly RepeatedField<ContactCharacterSession> sessions_ = new RepeatedField<ContactCharacterSession>();

	public const int GmModeFieldNumber = 2;

	private ContactGMMode gmMode_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ContactCharacterSessionNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ContactReflection.Descriptor.MessageTypes[2];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<ContactCharacterSession> Sessions => sessions_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ContactGMMode GmMode
	{
		get
		{
			return gmMode_;
		}
		set
		{
			gmMode_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ContactCharacterSessionNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ContactCharacterSessionNtf(ContactCharacterSessionNtf other)
		: this()
	{
		sessions_ = other.sessions_.Clone();
		gmMode_ = other.gmMode_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ContactCharacterSessionNtf Clone()
	{
		return new ContactCharacterSessionNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ContactCharacterSessionNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ContactCharacterSessionNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!sessions_.Equals(other.sessions_))
		{
			return false;
		}
		if (GmMode != other.GmMode)
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
		num ^= sessions_.GetHashCode();
		if (GmMode != ContactGMMode.None)
		{
			num ^= GmMode.GetHashCode();
		}
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
		sessions_.WriteTo(ref output, _repeated_sessions_codec);
		if (GmMode != ContactGMMode.None)
		{
			output.WriteRawTag(16);
			output.WriteEnum((int)GmMode);
		}
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
		num += sessions_.CalculateSize(_repeated_sessions_codec);
		if (GmMode != ContactGMMode.None)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)GmMode);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ContactCharacterSessionNtf other)
	{
		if (other != null)
		{
			sessions_.Add(other.sessions_);
			if (other.GmMode != ContactGMMode.None)
			{
				GmMode = other.GmMode;
			}
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
				sessions_.AddEntriesFrom(ref input, _repeated_sessions_codec);
				break;
			case 16u:
				GmMode = (ContactGMMode)input.ReadEnum();
				break;
			}
		}
	}
}
