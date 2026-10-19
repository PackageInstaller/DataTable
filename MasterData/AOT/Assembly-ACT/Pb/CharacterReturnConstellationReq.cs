using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class CharacterReturnConstellationReq : IMessage<CharacterReturnConstellationReq>, IMessage, IEquatable<CharacterReturnConstellationReq>, IDeepCloneable<CharacterReturnConstellationReq>, IBufferMessage
{
	private static readonly MessageParser<CharacterReturnConstellationReq> _parser = new MessageParser<CharacterReturnConstellationReq>(() => new CharacterReturnConstellationReq());

	private UnknownFieldSet _unknownFields;

	public const int CharacterIdFieldNumber = 1;

	private int characterId_;

	public const int ConstellationIdFieldNumber = 2;

	private int constellationId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CharacterReturnConstellationReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CharacterReflection.Descriptor.MessageTypes[15];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CharacterId
	{
		get
		{
			return characterId_;
		}
		set
		{
			characterId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ConstellationId
	{
		get
		{
			return constellationId_;
		}
		set
		{
			constellationId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterReturnConstellationReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterReturnConstellationReq(CharacterReturnConstellationReq other)
		: this()
	{
		characterId_ = other.characterId_;
		constellationId_ = other.constellationId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterReturnConstellationReq Clone()
	{
		return new CharacterReturnConstellationReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterReturnConstellationReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CharacterReturnConstellationReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (CharacterId != other.CharacterId)
		{
			return false;
		}
		if (ConstellationId != other.ConstellationId)
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
		if (CharacterId != 0)
		{
			num ^= CharacterId.GetHashCode();
		}
		if (ConstellationId != 0)
		{
			num ^= ConstellationId.GetHashCode();
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
		if (CharacterId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(CharacterId);
		}
		if (ConstellationId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ConstellationId);
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
		if (CharacterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharacterId);
		}
		if (ConstellationId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ConstellationId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CharacterReturnConstellationReq other)
	{
		if (other != null)
		{
			if (other.CharacterId != 0)
			{
				CharacterId = other.CharacterId;
			}
			if (other.ConstellationId != 0)
			{
				ConstellationId = other.ConstellationId;
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
			case 8u:
				CharacterId = input.ReadInt32();
				break;
			case 16u:
				ConstellationId = input.ReadInt32();
				break;
			}
		}
	}
}
