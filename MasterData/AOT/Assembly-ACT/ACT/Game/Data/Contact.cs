using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Contact : IMessage<Contact>, IMessage, IEquatable<Contact>, IDeepCloneable<Contact>, IBufferMessage
{
	private static readonly MessageParser<Contact> _parser = new MessageParser<Contact>(() => new Contact());

	private UnknownFieldSet _unknownFields;

	public const int CharacterSessionsFieldNumber = 1;

	private static readonly MapField<int, ContactCharacterSession>.Codec _map_characterSessions_codec = new MapField<int, ContactCharacterSession>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ContactCharacterSession.Parser), 10u);

	private readonly MapField<int, ContactCharacterSession> characterSessions_ = new MapField<int, ContactCharacterSession>();

	public const int LastRandomDailyMessageTsFieldNumber = 2;

	private long lastRandomDailyMessageTs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Contact> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[246];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ContactCharacterSession> CharacterSessions => characterSessions_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long LastRandomDailyMessageTs
	{
		get
		{
			return lastRandomDailyMessageTs_;
		}
		set
		{
			lastRandomDailyMessageTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Contact()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Contact(Contact other)
		: this()
	{
		characterSessions_ = other.characterSessions_.Clone();
		lastRandomDailyMessageTs_ = other.lastRandomDailyMessageTs_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Contact Clone()
	{
		return new Contact(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Contact);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Contact other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!CharacterSessions.Equals(other.CharacterSessions))
		{
			return false;
		}
		if (LastRandomDailyMessageTs != other.LastRandomDailyMessageTs)
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
		num ^= CharacterSessions.GetHashCode();
		if (LastRandomDailyMessageTs != 0L)
		{
			num ^= LastRandomDailyMessageTs.GetHashCode();
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
		characterSessions_.WriteTo(ref output, _map_characterSessions_codec);
		if (LastRandomDailyMessageTs != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(LastRandomDailyMessageTs);
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
		num += characterSessions_.CalculateSize(_map_characterSessions_codec);
		if (LastRandomDailyMessageTs != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(LastRandomDailyMessageTs);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Contact other)
	{
		if (other != null)
		{
			characterSessions_.Add(other.characterSessions_);
			if (other.LastRandomDailyMessageTs != 0L)
			{
				LastRandomDailyMessageTs = other.LastRandomDailyMessageTs;
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
				characterSessions_.AddEntriesFrom(ref input, _map_characterSessions_codec);
				break;
			case 16u:
				LastRandomDailyMessageTs = input.ReadInt64();
				break;
			}
		}
	}
}
