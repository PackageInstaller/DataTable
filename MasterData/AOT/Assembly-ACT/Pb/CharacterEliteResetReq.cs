using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class CharacterEliteResetReq : IMessage<CharacterEliteResetReq>, IMessage, IEquatable<CharacterEliteResetReq>, IDeepCloneable<CharacterEliteResetReq>, IBufferMessage
{
	private static readonly MessageParser<CharacterEliteResetReq> _parser = new MessageParser<CharacterEliteResetReq>(() => new CharacterEliteResetReq());

	private UnknownFieldSet _unknownFields;

	public const int CharacterIdFieldNumber = 1;

	private int characterId_;

	public const int PointIdFieldNumber = 2;

	private int pointId_;

	public const int PointNodeFieldNumber = 3;

	private int pointNode_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CharacterEliteResetReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CharacterReflection.Descriptor.MessageTypes[21];

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
	public int PointNode
	{
		get
		{
			return pointNode_;
		}
		set
		{
			pointNode_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterEliteResetReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterEliteResetReq(CharacterEliteResetReq other)
		: this()
	{
		characterId_ = other.characterId_;
		pointId_ = other.pointId_;
		pointNode_ = other.pointNode_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterEliteResetReq Clone()
	{
		return new CharacterEliteResetReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterEliteResetReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CharacterEliteResetReq other)
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
		if (PointNode != other.PointNode)
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
		if (PointNode != 0)
		{
			num ^= PointNode.GetHashCode();
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
		if (PointNode != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(PointNode);
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
		if (PointNode != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PointNode);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CharacterEliteResetReq other)
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
			if (other.PointNode != 0)
			{
				PointNode = other.PointNode;
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
				PointNode = input.ReadInt32();
				break;
			}
		}
	}
}
