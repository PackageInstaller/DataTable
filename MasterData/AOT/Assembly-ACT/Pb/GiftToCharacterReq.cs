using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class GiftToCharacterReq : IMessage<GiftToCharacterReq>, IMessage, IEquatable<GiftToCharacterReq>, IDeepCloneable<GiftToCharacterReq>, IBufferMessage
{
	private static readonly MessageParser<GiftToCharacterReq> _parser = new MessageParser<GiftToCharacterReq>(() => new GiftToCharacterReq());

	private UnknownFieldSet _unknownFields;

	public const int GiftsFieldNumber = 1;

	private static readonly FieldCodec<Item> _repeated_gifts_codec = FieldCodec.ForMessage(10u, Item.Parser);

	private readonly RepeatedField<Item> gifts_ = new RepeatedField<Item>();

	public const int CharacterIDFieldNumber = 2;

	private int characterID_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GiftToCharacterReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => LoungeReflection.Descriptor.MessageTypes[4];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> Gifts => gifts_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CharacterID
	{
		get
		{
			return characterID_;
		}
		set
		{
			characterID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GiftToCharacterReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GiftToCharacterReq(GiftToCharacterReq other)
		: this()
	{
		gifts_ = other.gifts_.Clone();
		characterID_ = other.characterID_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GiftToCharacterReq Clone()
	{
		return new GiftToCharacterReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GiftToCharacterReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GiftToCharacterReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!gifts_.Equals(other.gifts_))
		{
			return false;
		}
		if (CharacterID != other.CharacterID)
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
		num ^= gifts_.GetHashCode();
		if (CharacterID != 0)
		{
			num ^= CharacterID.GetHashCode();
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
		gifts_.WriteTo(ref output, _repeated_gifts_codec);
		if (CharacterID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CharacterID);
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
		num += gifts_.CalculateSize(_repeated_gifts_codec);
		if (CharacterID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharacterID);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GiftToCharacterReq other)
	{
		if (other != null)
		{
			gifts_.Add(other.gifts_);
			if (other.CharacterID != 0)
			{
				CharacterID = other.CharacterID;
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
				gifts_.AddEntriesFrom(ref input, _repeated_gifts_codec);
				break;
			case 16u:
				CharacterID = input.ReadInt32();
				break;
			}
		}
	}
}
