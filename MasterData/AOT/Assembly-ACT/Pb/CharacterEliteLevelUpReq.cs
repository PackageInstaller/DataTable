using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class CharacterEliteLevelUpReq : IMessage<CharacterEliteLevelUpReq>, IMessage, IEquatable<CharacterEliteLevelUpReq>, IDeepCloneable<CharacterEliteLevelUpReq>, IBufferMessage
{
	private static readonly MessageParser<CharacterEliteLevelUpReq> _parser = new MessageParser<CharacterEliteLevelUpReq>(() => new CharacterEliteLevelUpReq());

	private UnknownFieldSet _unknownFields;

	public const int CharacterIdFieldNumber = 1;

	private int characterId_;

	public const int PointIdFieldNumber = 2;

	private int pointId_;

	public const int ToLevelFieldNumber = 3;

	private int toLevel_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CharacterEliteLevelUpReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CharacterReflection.Descriptor.MessageTypes[19];

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
	public int PointId
	{
		get
		{
			return pointId_;
		}
		set
		{
			pointId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ToLevel
	{
		get
		{
			return toLevel_;
		}
		set
		{
			toLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterEliteLevelUpReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterEliteLevelUpReq(CharacterEliteLevelUpReq other)
		: this()
	{
		characterId_ = other.characterId_;
		pointId_ = other.pointId_;
		toLevel_ = other.toLevel_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterEliteLevelUpReq Clone()
	{
		return new CharacterEliteLevelUpReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterEliteLevelUpReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CharacterEliteLevelUpReq other)
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
		if (PointId != other.PointId)
		{
			return false;
		}
		if (ToLevel != other.ToLevel)
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
		if (PointId != 0)
		{
			num ^= PointId.GetHashCode();
		}
		if (ToLevel != 0)
		{
			num ^= ToLevel.GetHashCode();
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
		if (PointId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(PointId);
		}
		if (ToLevel != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ToLevel);
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
		if (PointId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PointId);
		}
		if (ToLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ToLevel);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CharacterEliteLevelUpReq other)
	{
		if (other != null)
		{
			if (other.CharacterId != 0)
			{
				CharacterId = other.CharacterId;
			}
			if (other.PointId != 0)
			{
				PointId = other.PointId;
			}
			if (other.ToLevel != 0)
			{
				ToLevel = other.ToLevel;
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
				PointId = input.ReadInt32();
				break;
			case 24u:
				ToLevel = input.ReadInt32();
				break;
			}
		}
	}
}
