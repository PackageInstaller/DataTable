using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class CharacterChangeNtf : IMessage<CharacterChangeNtf>, IMessage, IEquatable<CharacterChangeNtf>, IDeepCloneable<CharacterChangeNtf>, IBufferMessage
{
	private static readonly MessageParser<CharacterChangeNtf> _parser = new MessageParser<CharacterChangeNtf>(() => new CharacterChangeNtf());

	private UnknownFieldSet _unknownFields;

	public const int SceneEnumFieldNumber = 1;

	private int sceneEnum_;

	public const int CharactersFieldNumber = 2;

	private static readonly MapField<int, Character>.Codec _map_characters_codec = new MapField<int, Character>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Character.Parser), 18u);

	private readonly MapField<int, Character> characters_ = new MapField<int, Character>();

	public const int ExtraCharactersFieldNumber = 3;

	private static readonly MapField<int, Character>.Codec _map_extraCharacters_codec = new MapField<int, Character>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Character.Parser), 26u);

	private readonly MapField<int, Character> extraCharacters_ = new MapField<int, Character>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CharacterChangeNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CharacterReflection.Descriptor.MessageTypes[1];

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
	public MapField<int, Character> Characters => characters_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, Character> ExtraCharacters => extraCharacters_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterChangeNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterChangeNtf(CharacterChangeNtf other)
		: this()
	{
		sceneEnum_ = other.sceneEnum_;
		characters_ = other.characters_.Clone();
		extraCharacters_ = other.extraCharacters_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterChangeNtf Clone()
	{
		return new CharacterChangeNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterChangeNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CharacterChangeNtf other)
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
		if (!Characters.Equals(other.Characters))
		{
			return false;
		}
		if (!ExtraCharacters.Equals(other.ExtraCharacters))
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
		num ^= Characters.GetHashCode();
		num ^= ExtraCharacters.GetHashCode();
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
		characters_.WriteTo(ref output, _map_characters_codec);
		extraCharacters_.WriteTo(ref output, _map_extraCharacters_codec);
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
		num += characters_.CalculateSize(_map_characters_codec);
		num += extraCharacters_.CalculateSize(_map_extraCharacters_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CharacterChangeNtf other)
	{
		if (other != null)
		{
			if (other.SceneEnum != 0)
			{
				SceneEnum = other.SceneEnum;
			}
			characters_.Add(other.characters_);
			extraCharacters_.Add(other.extraCharacters_);
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
				SceneEnum = input.ReadInt32();
				break;
			case 18u:
				characters_.AddEntriesFrom(ref input, _map_characters_codec);
				break;
			case 26u:
				extraCharacters_.AddEntriesFrom(ref input, _map_extraCharacters_codec);
				break;
			}
		}
	}
}
