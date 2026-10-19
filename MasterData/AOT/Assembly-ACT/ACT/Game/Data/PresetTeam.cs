using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using System.Linq;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class PresetTeam : IMessage<PresetTeam>, IMessage, IEquatable<PresetTeam>, IDeepCloneable<PresetTeam>, IBufferMessage
{
	private static readonly MessageParser<PresetTeam> _parser = new MessageParser<PresetTeam>(() => new PresetTeam());

	private UnknownFieldSet _unknownFields;

	public const int CharacterIdsFieldNumber = 1;

	private static readonly FieldCodec<int> _repeated_characterIds_codec = FieldCodec.ForInt32(10u);

	private readonly RepeatedField<int> characterIds_ = new RepeatedField<int>();

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int BattleCharacterIdxFieldNumber = 3;

	private int battleCharacterIdx_;

	public const int EquipPotionIdFieldNumber = 4;

	private int equipPotionId_;

	private const int _characterNum = 3;

	private const int _characterLastIndex = 2;

	private Character[] m_TeamCharacter = new Character[3];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<PresetTeam> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[68];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> CharacterIds => characterIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int BattleCharacterIdx
	{
		get
		{
			return battleCharacterIdx_;
		}
		set
		{
			battleCharacterIdx_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int EquipPotionId
	{
		get
		{
			return equipPotionId_;
		}
		set
		{
			equipPotionId_ = value;
		}
	}

	public int BattleCharacterId => characterIds_[battleCharacterIdx_];

	public int TeamCharacterNum => Enumerable.Count(characterIds_, (int _) => _ != 0);

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PresetTeam()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PresetTeam(PresetTeam other)
		: this()
	{
		characterIds_ = other.characterIds_.Clone();
		name_ = other.name_;
		battleCharacterIdx_ = other.battleCharacterIdx_;
		equipPotionId_ = other.equipPotionId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PresetTeam Clone()
	{
		return new PresetTeam(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as PresetTeam);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(PresetTeam other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!characterIds_.Equals(other.characterIds_))
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (BattleCharacterIdx != other.BattleCharacterIdx)
		{
			return false;
		}
		if (EquipPotionId != other.EquipPotionId)
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
		num ^= characterIds_.GetHashCode();
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (BattleCharacterIdx != 0)
		{
			num ^= BattleCharacterIdx.GetHashCode();
		}
		if (EquipPotionId != 0)
		{
			num ^= EquipPotionId.GetHashCode();
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
		characterIds_.WriteTo(ref output, _repeated_characterIds_codec);
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (BattleCharacterIdx != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(BattleCharacterIdx);
		}
		if (EquipPotionId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(EquipPotionId);
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
		num += characterIds_.CalculateSize(_repeated_characterIds_codec);
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (BattleCharacterIdx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BattleCharacterIdx);
		}
		if (EquipPotionId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EquipPotionId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(PresetTeam other)
	{
		if (other != null)
		{
			characterIds_.Add(other.characterIds_);
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.BattleCharacterIdx != 0)
			{
				BattleCharacterIdx = other.BattleCharacterIdx;
			}
			if (other.EquipPotionId != 0)
			{
				EquipPotionId = other.EquipPotionId;
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
			case 10u:
				characterIds_.AddEntriesFrom(ref input, _repeated_characterIds_codec);
				break;
			case 18u:
				Name = input.ReadString();
				break;
			case 24u:
				BattleCharacterIdx = input.ReadInt32();
				break;
			case 32u:
				EquipPotionId = input.ReadInt32();
				break;
			}
		}
	}

	public int GetFirstEntity()
	{
		for (int i = 0; i < characterIds_.Count; i++)
		{
			if (characterIds_[i] != 0)
			{
				return i;
			}
		}
		return -1;
	}

	public int GetCharacterIndex(int characterId)
	{
		for (int i = 0; i < characterIds_.Count; i++)
		{
			if (characterIds_[i] == characterId)
			{
				return i;
			}
		}
		return -1;
	}

	public Character[] GetTeamCharacters()
	{
		for (int i = 0; i < characterIds_.Count; i++)
		{
			if (characterIds_[i] == 0)
			{
				m_TeamCharacter[i] = null;
			}
			else if (m_TeamCharacter[i] == null || m_TeamCharacter[i].Id != characterIds_[i])
			{
				m_TeamCharacter[i] = G.localPlayer.GetCharacter(characterIds_[i]);
			}
		}
		return m_TeamCharacter;
	}

	public void SetTeamCharacters(Character[] characters)
	{
		m_TeamCharacter = characters;
		characterIds_.Clear();
		foreach (Character character in characters)
		{
			characterIds_.Add(character?.Id ?? 0);
		}
	}

	public void ReplaceCharacter(Character character, int index)
	{
		characterIds_[index] = character.Id;
		m_TeamCharacter[index] = character;
	}

	public void ClearTeamCharacters()
	{
		m_TeamCharacter = null;
		characterIds_.Clear();
	}

	public void RefillPosition()
	{
		for (int i = 0; i < characterIds_.Count; i++)
		{
			if (characterIds_[i] != 0)
			{
				continue;
			}
			for (int j = i + 1; j < characterIds_.Count; j++)
			{
				if (characterIds_[j] != 0)
				{
					characterIds_[i] = characterIds_[j];
					characterIds_[j] = 0;
					m_TeamCharacter[i] = m_TeamCharacter[j];
					m_TeamCharacter[j] = null;
					break;
				}
			}
		}
	}

	public int GetCharacterLevel(int index)
	{
		if (index < 0 || index > 2)
		{
			_ = LuminApplication.LogEnabled;
			return 0;
		}
		return G.localPlayer.GetCharacter(characterIds_[index]).Level;
	}

	public float GetCharactersAverageLevel()
	{
		float num = 0f;
		foreach (int item in characterIds_)
		{
			Character character = G.localPlayer.GetCharacter(item);
			if (character != null)
			{
				num += (float)character.Level;
			}
		}
		return (float)Math.Round(num / (float)TeamCharacterNum, 1);
	}

	public float GetAverageUsedSkillPoint()
	{
		float num = 0f;
		foreach (int item in characterIds_)
		{
			Character character = G.localPlayer.GetCharacter(item);
			if (character != null)
			{
				num += (float)character.GetUsedSkillPoint();
			}
		}
		return (float)Math.Round(num / (float)TeamCharacterNum, 1);
	}
}
