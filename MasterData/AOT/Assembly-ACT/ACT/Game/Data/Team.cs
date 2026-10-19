using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Team : IMessage<Team>, IMessage, IEquatable<Team>, IDeepCloneable<Team>, IBufferMessage
{
	private static readonly MessageParser<Team> _parser = new MessageParser<Team>(() => new Team());

	private UnknownFieldSet _unknownFields;

	public const int CharacterIdsFieldNumber = 1;

	private static readonly FieldCodec<int> _repeated_characterIds_codec = FieldCodec.ForInt32(10u);

	private readonly RepeatedField<int> characterIds_ = new RepeatedField<int>();

	public const int BattleCharacterIdxFieldNumber = 2;

	private int battleCharacterIdx_;

	public const int ExtraCharacterIdsFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_extraCharacterIds_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> extraCharacterIds_ = new RepeatedField<int>();

	public const int EquipPotionIdFieldNumber = 4;

	private int equipPotionId_;

	public const int EquippedTrialPotionFieldNumber = 5;

	private bool equippedTrialPotion_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Team> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[71];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> CharacterIds => characterIds_;

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
	public RepeatedField<int> ExtraCharacterIds => extraCharacterIds_;

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

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool EquippedTrialPotion
	{
		get
		{
			return equippedTrialPotion_;
		}
		set
		{
			equippedTrialPotion_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Team()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Team(Team other)
		: this()
	{
		characterIds_ = other.characterIds_.Clone();
		battleCharacterIdx_ = other.battleCharacterIdx_;
		extraCharacterIds_ = other.extraCharacterIds_.Clone();
		equipPotionId_ = other.equipPotionId_;
		equippedTrialPotion_ = other.equippedTrialPotion_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Team Clone()
	{
		return new Team(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Team);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Team other)
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
		if (BattleCharacterIdx != other.BattleCharacterIdx)
		{
			return false;
		}
		if (!extraCharacterIds_.Equals(other.extraCharacterIds_))
		{
			return false;
		}
		if (EquipPotionId != other.EquipPotionId)
		{
			return false;
		}
		if (EquippedTrialPotion != other.EquippedTrialPotion)
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
		if (BattleCharacterIdx != 0)
		{
			num ^= BattleCharacterIdx.GetHashCode();
		}
		num ^= extraCharacterIds_.GetHashCode();
		if (EquipPotionId != 0)
		{
			num ^= EquipPotionId.GetHashCode();
		}
		if (EquippedTrialPotion)
		{
			num ^= EquippedTrialPotion.GetHashCode();
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
		if (BattleCharacterIdx != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(BattleCharacterIdx);
		}
		extraCharacterIds_.WriteTo(ref output, _repeated_extraCharacterIds_codec);
		if (EquipPotionId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(EquipPotionId);
		}
		if (EquippedTrialPotion)
		{
			output.WriteRawTag(40);
			output.WriteBool(EquippedTrialPotion);
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
		if (BattleCharacterIdx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BattleCharacterIdx);
		}
		num += extraCharacterIds_.CalculateSize(_repeated_extraCharacterIds_codec);
		if (EquipPotionId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EquipPotionId);
		}
		if (EquippedTrialPotion)
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
	public void MergeFrom(Team other)
	{
		if (other != null)
		{
			characterIds_.Add(other.characterIds_);
			if (other.BattleCharacterIdx != 0)
			{
				BattleCharacterIdx = other.BattleCharacterIdx;
			}
			extraCharacterIds_.Add(other.extraCharacterIds_);
			if (other.EquipPotionId != 0)
			{
				EquipPotionId = other.EquipPotionId;
			}
			if (other.EquippedTrialPotion)
			{
				EquippedTrialPotion = other.EquippedTrialPotion;
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
			case 16u:
				BattleCharacterIdx = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				extraCharacterIds_.AddEntriesFrom(ref input, _repeated_extraCharacterIds_codec);
				break;
			case 32u:
				EquipPotionId = input.ReadInt32();
				break;
			case 40u:
				EquippedTrialPotion = input.ReadBool();
				break;
			}
		}
	}
}
