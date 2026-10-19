using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ChipUnloadReq : IMessage<ChipUnloadReq>, IMessage, IEquatable<ChipUnloadReq>, IDeepCloneable<ChipUnloadReq>, IBufferMessage
{
	private static readonly MessageParser<ChipUnloadReq> _parser = new MessageParser<ChipUnloadReq>(() => new ChipUnloadReq());

	private UnknownFieldSet _unknownFields;

	public const int CharacterIdFieldNumber = 1;

	private int characterId_;

	public const int ChipUidFieldNumber = 2;

	private int chipUid_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ChipUnloadReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ChipReflection.Descriptor.MessageTypes[4];

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
	public int ChipUid
	{
		get
		{
			return chipUid_;
		}
		set
		{
			chipUid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ChipUnloadReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ChipUnloadReq(ChipUnloadReq other)
		: this()
	{
		characterId_ = other.characterId_;
		chipUid_ = other.chipUid_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ChipUnloadReq Clone()
	{
		return new ChipUnloadReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ChipUnloadReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ChipUnloadReq other)
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
		if (ChipUid != other.ChipUid)
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
		if (ChipUid != 0)
		{
			num ^= ChipUid.GetHashCode();
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
		if (ChipUid != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ChipUid);
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
		if (ChipUid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChipUid);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ChipUnloadReq other)
	{
		if (other != null)
		{
			if (other.CharacterId != 0)
			{
				CharacterId = other.CharacterId;
			}
			if (other.ChipUid != 0)
			{
				ChipUid = other.ChipUid;
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
				ChipUid = input.ReadInt32();
				break;
			}
		}
	}
}
