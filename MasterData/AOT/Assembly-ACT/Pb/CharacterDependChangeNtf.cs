using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class CharacterDependChangeNtf : IMessage<CharacterDependChangeNtf>, IMessage, IEquatable<CharacterDependChangeNtf>, IDeepCloneable<CharacterDependChangeNtf>, IBufferMessage
{
	private static readonly MessageParser<CharacterDependChangeNtf> _parser = new MessageParser<CharacterDependChangeNtf>(() => new CharacterDependChangeNtf());

	private UnknownFieldSet _unknownFields;

	public const int SceneEnumFieldNumber = 1;

	private int sceneEnum_;

	public const int CharacterDependSnapshotFieldNumber = 2;

	private CharacterDependSnapshot characterDependSnapshot_;

	public const int ExtraCharacterDependSnapshotFieldNumber = 3;

	private CharacterDependSnapshot extraCharacterDependSnapshot_;

	public const int RemoveFieldNumber = 4;

	private bool remove_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CharacterDependChangeNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CharacterReflection.Descriptor.MessageTypes[2];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int SceneEnum
	{
		get
		{
			return sceneEnum_;
		}
		set
		{
			sceneEnum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterDependSnapshot CharacterDependSnapshot
	{
		get
		{
			return characterDependSnapshot_;
		}
		set
		{
			characterDependSnapshot_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterDependSnapshot ExtraCharacterDependSnapshot
	{
		get
		{
			return extraCharacterDependSnapshot_;
		}
		set
		{
			extraCharacterDependSnapshot_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Remove
	{
		get
		{
			return remove_;
		}
		set
		{
			remove_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterDependChangeNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterDependChangeNtf(CharacterDependChangeNtf other)
		: this()
	{
		sceneEnum_ = other.sceneEnum_;
		characterDependSnapshot_ = ((other.characterDependSnapshot_ != null) ? other.characterDependSnapshot_.Clone() : null);
		extraCharacterDependSnapshot_ = ((other.extraCharacterDependSnapshot_ != null) ? other.extraCharacterDependSnapshot_.Clone() : null);
		remove_ = other.remove_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterDependChangeNtf Clone()
	{
		return new CharacterDependChangeNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterDependChangeNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CharacterDependChangeNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (SceneEnum != other.SceneEnum)
		{
			return false;
		}
		if (!object.Equals(CharacterDependSnapshot, other.CharacterDependSnapshot))
		{
			return false;
		}
		if (!object.Equals(ExtraCharacterDependSnapshot, other.ExtraCharacterDependSnapshot))
		{
			return false;
		}
		if (Remove != other.Remove)
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
		if (SceneEnum != 0)
		{
			num ^= SceneEnum.GetHashCode();
		}
		if (characterDependSnapshot_ != null)
		{
			num ^= CharacterDependSnapshot.GetHashCode();
		}
		if (extraCharacterDependSnapshot_ != null)
		{
			num ^= ExtraCharacterDependSnapshot.GetHashCode();
		}
		if (Remove)
		{
			num ^= Remove.GetHashCode();
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
		if (SceneEnum != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(SceneEnum);
		}
		if (characterDependSnapshot_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(CharacterDependSnapshot);
		}
		if (extraCharacterDependSnapshot_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(ExtraCharacterDependSnapshot);
		}
		if (Remove)
		{
			output.WriteRawTag(32);
			output.WriteBool(Remove);
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
		if (SceneEnum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SceneEnum);
		}
		if (characterDependSnapshot_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(CharacterDependSnapshot);
		}
		if (extraCharacterDependSnapshot_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ExtraCharacterDependSnapshot);
		}
		if (Remove)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CharacterDependChangeNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.SceneEnum != 0)
		{
			SceneEnum = other.SceneEnum;
		}
		if (other.characterDependSnapshot_ != null)
		{
			if (characterDependSnapshot_ == null)
			{
				CharacterDependSnapshot = new CharacterDependSnapshot();
			}
			CharacterDependSnapshot.MergeFrom(other.CharacterDependSnapshot);
		}
		if (other.extraCharacterDependSnapshot_ != null)
		{
			if (extraCharacterDependSnapshot_ == null)
			{
				ExtraCharacterDependSnapshot = new CharacterDependSnapshot();
			}
			ExtraCharacterDependSnapshot.MergeFrom(other.ExtraCharacterDependSnapshot);
		}
		if (other.Remove)
		{
			Remove = other.Remove;
		}
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
				SceneEnum = input.ReadInt32();
				break;
			case 18u:
				if (characterDependSnapshot_ == null)
				{
					CharacterDependSnapshot = new CharacterDependSnapshot();
				}
				input.ReadMessage(CharacterDependSnapshot);
				break;
			case 26u:
				if (extraCharacterDependSnapshot_ == null)
				{
					ExtraCharacterDependSnapshot = new CharacterDependSnapshot();
				}
				input.ReadMessage(ExtraCharacterDependSnapshot);
				break;
			case 32u:
				Remove = input.ReadBool();
				break;
			}
		}
	}
}
