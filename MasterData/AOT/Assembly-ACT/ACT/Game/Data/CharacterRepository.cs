using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class CharacterRepository : IMessage<CharacterRepository>, IMessage, IEquatable<CharacterRepository>, IDeepCloneable<CharacterRepository>, IBufferMessage
{
	private static readonly MessageParser<CharacterRepository> _parser = new MessageParser<CharacterRepository>(() => new CharacterRepository());

	private UnknownFieldSet _unknownFields;

	public const int CharactersFieldNumber = 1;

	private static readonly MapField<int, Character>.Codec _map_characters_codec = new MapField<int, Character>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Character.Parser), 10u);

	private readonly MapField<int, Character> characters_ = new MapField<int, Character>();

	public const int CharacterDependSnapshotFieldNumber = 2;

	private CharacterDependSnapshot characterDependSnapshot_;

	public const int ExtraCharactersFieldNumber = 3;

	private static readonly MapField<int, Character>.Codec _map_extraCharacters_codec = new MapField<int, Character>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Character.Parser), 26u);

	private readonly MapField<int, Character> extraCharacters_ = new MapField<int, Character>();

	public const int ExtraCharacterDependSnapshotFieldNumber = 4;

	private CharacterDependSnapshot extraCharacterDependSnapshot_;

	public const int PotionsFieldNumber = 5;

	private static readonly MapField<int, PotionItem>.Codec _map_potions_codec = new MapField<int, PotionItem>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, PotionItem.Parser), 42u);

	private readonly MapField<int, PotionItem> potions_ = new MapField<int, PotionItem>();

	public const int TrialPotionsFieldNumber = 6;

	private static readonly MapField<int, PotionItem>.Codec _map_trialPotions_codec = new MapField<int, PotionItem>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, PotionItem.Parser), 50u);

	private readonly MapField<int, PotionItem> trialPotions_ = new MapField<int, PotionItem>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CharacterRepository> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[69];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, Character> Characters => characters_;

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
	public MapField<int, Character> ExtraCharacters => extraCharacters_;

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
	public MapField<int, PotionItem> Potions => potions_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, PotionItem> TrialPotions => trialPotions_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterRepository()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterRepository(CharacterRepository other)
		: this()
	{
		characters_ = other.characters_.Clone();
		characterDependSnapshot_ = ((other.characterDependSnapshot_ != null) ? other.characterDependSnapshot_.Clone() : null);
		extraCharacters_ = other.extraCharacters_.Clone();
		extraCharacterDependSnapshot_ = ((other.extraCharacterDependSnapshot_ != null) ? other.extraCharacterDependSnapshot_.Clone() : null);
		potions_ = other.potions_.Clone();
		trialPotions_ = other.trialPotions_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterRepository Clone()
	{
		return new CharacterRepository(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterRepository);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CharacterRepository other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Characters.Equals(other.Characters))
		{
			return false;
		}
		if (!object.Equals(CharacterDependSnapshot, other.CharacterDependSnapshot))
		{
			return false;
		}
		if (!ExtraCharacters.Equals(other.ExtraCharacters))
		{
			return false;
		}
		if (!object.Equals(ExtraCharacterDependSnapshot, other.ExtraCharacterDependSnapshot))
		{
			return false;
		}
		if (!Potions.Equals(other.Potions))
		{
			return false;
		}
		if (!TrialPotions.Equals(other.TrialPotions))
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
		num ^= Characters.GetHashCode();
		if (characterDependSnapshot_ != null)
		{
			num ^= CharacterDependSnapshot.GetHashCode();
		}
		num ^= ExtraCharacters.GetHashCode();
		if (extraCharacterDependSnapshot_ != null)
		{
			num ^= ExtraCharacterDependSnapshot.GetHashCode();
		}
		num ^= Potions.GetHashCode();
		num ^= TrialPotions.GetHashCode();
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
		characters_.WriteTo(ref output, _map_characters_codec);
		if (characterDependSnapshot_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(CharacterDependSnapshot);
		}
		extraCharacters_.WriteTo(ref output, _map_extraCharacters_codec);
		if (extraCharacterDependSnapshot_ != null)
		{
			output.WriteRawTag(34);
			output.WriteMessage(ExtraCharacterDependSnapshot);
		}
		potions_.WriteTo(ref output, _map_potions_codec);
		trialPotions_.WriteTo(ref output, _map_trialPotions_codec);
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
		num += characters_.CalculateSize(_map_characters_codec);
		if (characterDependSnapshot_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(CharacterDependSnapshot);
		}
		num += extraCharacters_.CalculateSize(_map_extraCharacters_codec);
		if (extraCharacterDependSnapshot_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ExtraCharacterDependSnapshot);
		}
		num += potions_.CalculateSize(_map_potions_codec);
		num += trialPotions_.CalculateSize(_map_trialPotions_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CharacterRepository other)
	{
		if (other == null)
		{
			return;
		}
		characters_.Add(other.characters_);
		if (other.characterDependSnapshot_ != null)
		{
			if (characterDependSnapshot_ == null)
			{
				CharacterDependSnapshot = new CharacterDependSnapshot();
			}
			CharacterDependSnapshot.MergeFrom(other.CharacterDependSnapshot);
		}
		extraCharacters_.Add(other.extraCharacters_);
		if (other.extraCharacterDependSnapshot_ != null)
		{
			if (extraCharacterDependSnapshot_ == null)
			{
				ExtraCharacterDependSnapshot = new CharacterDependSnapshot();
			}
			ExtraCharacterDependSnapshot.MergeFrom(other.ExtraCharacterDependSnapshot);
		}
		potions_.Add(other.potions_);
		trialPotions_.Add(other.trialPotions_);
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
			case 10u:
				characters_.AddEntriesFrom(ref input, _map_characters_codec);
				break;
			case 18u:
				if (characterDependSnapshot_ == null)
				{
					CharacterDependSnapshot = new CharacterDependSnapshot();
				}
				input.ReadMessage(CharacterDependSnapshot);
				break;
			case 26u:
				extraCharacters_.AddEntriesFrom(ref input, _map_extraCharacters_codec);
				break;
			case 34u:
				if (extraCharacterDependSnapshot_ == null)
				{
					ExtraCharacterDependSnapshot = new CharacterDependSnapshot();
				}
				input.ReadMessage(ExtraCharacterDependSnapshot);
				break;
			case 42u:
				potions_.AddEntriesFrom(ref input, _map_potions_codec);
				break;
			case 50u:
				trialPotions_.AddEntriesFrom(ref input, _map_trialPotions_codec);
				break;
			}
		}
	}
}
