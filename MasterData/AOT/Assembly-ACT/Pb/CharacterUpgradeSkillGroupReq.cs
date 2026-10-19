using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class CharacterUpgradeSkillGroupReq : IMessage<CharacterUpgradeSkillGroupReq>, IMessage, IEquatable<CharacterUpgradeSkillGroupReq>, IDeepCloneable<CharacterUpgradeSkillGroupReq>, IBufferMessage
{
	private static readonly MessageParser<CharacterUpgradeSkillGroupReq> _parser = new MessageParser<CharacterUpgradeSkillGroupReq>(() => new CharacterUpgradeSkillGroupReq());

	private UnknownFieldSet _unknownFields;

	public const int CharacterIdFieldNumber = 1;

	private int characterId_;

	public const int SkillGroupIdFieldNumber = 2;

	private int skillGroupId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CharacterUpgradeSkillGroupReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CharacterReflection.Descriptor.MessageTypes[11];

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
	public int SkillGroupId
	{
		get
		{
			return skillGroupId_;
		}
		set
		{
			skillGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterUpgradeSkillGroupReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterUpgradeSkillGroupReq(CharacterUpgradeSkillGroupReq other)
		: this()
	{
		characterId_ = other.characterId_;
		skillGroupId_ = other.skillGroupId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterUpgradeSkillGroupReq Clone()
	{
		return new CharacterUpgradeSkillGroupReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterUpgradeSkillGroupReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CharacterUpgradeSkillGroupReq other)
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
		if (SkillGroupId != other.SkillGroupId)
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
		if (SkillGroupId != 0)
		{
			num ^= SkillGroupId.GetHashCode();
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
		if (SkillGroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(SkillGroupId);
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
		if (SkillGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkillGroupId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CharacterUpgradeSkillGroupReq other)
	{
		if (other != null)
		{
			if (other.CharacterId != 0)
			{
				CharacterId = other.CharacterId;
			}
			if (other.SkillGroupId != 0)
			{
				SkillGroupId = other.SkillGroupId;
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
				SkillGroupId = input.ReadInt32();
				break;
			}
		}
	}
}
