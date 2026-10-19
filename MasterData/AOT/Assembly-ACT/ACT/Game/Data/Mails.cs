using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Mails : IMessage<Mails>, IMessage, IEquatable<Mails>, IDeepCloneable<Mails>, IBufferMessage
{
	private static readonly MessageParser<Mails> _parser = new MessageParser<Mails>(() => new Mails());

	private UnknownFieldSet _unknownFields;

	public const int LockMailIDsFieldNumber = 1;

	private static readonly MapField<int, bool>.Codec _map_lockMailIDs_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 10u);

	private readonly MapField<int, bool> lockMailIDs_ = new MapField<int, bool>();

	public const int GeneratedMailTmplsFieldNumber = 2;

	private static readonly MapField<int, TmplMailIDs>.Codec _map_generatedMailTmpls_codec = new MapField<int, TmplMailIDs>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, TmplMailIDs.Parser), 18u);

	private readonly MapField<int, TmplMailIDs> generatedMailTmpls_ = new MapField<int, TmplMailIDs>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Mails> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[146];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> LockMailIDs => lockMailIDs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, TmplMailIDs> GeneratedMailTmpls => generatedMailTmpls_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Mails()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Mails(Mails other)
		: this()
	{
		lockMailIDs_ = other.lockMailIDs_.Clone();
		generatedMailTmpls_ = other.generatedMailTmpls_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Mails Clone()
	{
		return new Mails(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Mails);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Mails other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!LockMailIDs.Equals(other.LockMailIDs))
		{
			return false;
		}
		if (!GeneratedMailTmpls.Equals(other.GeneratedMailTmpls))
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
		num ^= LockMailIDs.GetHashCode();
		num ^= GeneratedMailTmpls.GetHashCode();
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
		lockMailIDs_.WriteTo(ref output, _map_lockMailIDs_codec);
		generatedMailTmpls_.WriteTo(ref output, _map_generatedMailTmpls_codec);
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
		num += lockMailIDs_.CalculateSize(_map_lockMailIDs_codec);
		num += generatedMailTmpls_.CalculateSize(_map_generatedMailTmpls_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Mails other)
	{
		if (other != null)
		{
			lockMailIDs_.Add(other.lockMailIDs_);
			generatedMailTmpls_.Add(other.generatedMailTmpls_);
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
				lockMailIDs_.AddEntriesFrom(ref input, _map_lockMailIDs_codec);
				break;
			case 18u:
				generatedMailTmpls_.AddEntriesFrom(ref input, _map_generatedMailTmpls_codec);
				break;
			}
		}
	}
}
