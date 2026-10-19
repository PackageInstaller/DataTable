using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class TeamUsage : IMessage<TeamUsage>, IMessage, IEquatable<TeamUsage>, IDeepCloneable<TeamUsage>, IBufferMessage
{
	private static readonly MessageParser<TeamUsage> _parser = new MessageParser<TeamUsage>(() => new TeamUsage());

	private UnknownFieldSet _unknownFields;

	public const int CharacterUsageFieldNumber = 1;

	private static readonly FieldCodec<TeamCharacterUsage> _repeated_characterUsage_codec = FieldCodec.ForMessage(10u, TeamCharacterUsage.Parser);

	private readonly RepeatedField<TeamCharacterUsage> characterUsage_ = new RepeatedField<TeamCharacterUsage>();

	public const int BattleCharacterIdxFieldNumber = 2;

	private int battleCharacterIdx_;

	public const int EquipPotionIdFieldNumber = 3;

	private int equipPotionId_;

	public const int IsTrialPotionFieldNumber = 4;

	private int isTrialPotion_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TeamUsage> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[75];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<TeamCharacterUsage> CharacterUsage => characterUsage_;

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

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int IsTrialPotion
	{
		get
		{
			return isTrialPotion_;
		}
		set
		{
			isTrialPotion_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TeamUsage()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TeamUsage(TeamUsage other)
		: this()
	{
		characterUsage_ = other.characterUsage_.Clone();
		battleCharacterIdx_ = other.battleCharacterIdx_;
		equipPotionId_ = other.equipPotionId_;
		isTrialPotion_ = other.isTrialPotion_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TeamUsage Clone()
	{
		return new TeamUsage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TeamUsage);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TeamUsage other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!characterUsage_.Equals(other.characterUsage_))
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
		if (IsTrialPotion != other.IsTrialPotion)
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
		num ^= characterUsage_.GetHashCode();
		if (BattleCharacterIdx != 0)
		{
			num ^= BattleCharacterIdx.GetHashCode();
		}
		if (EquipPotionId != 0)
		{
			num ^= EquipPotionId.GetHashCode();
		}
		if (IsTrialPotion != 0)
		{
			num ^= IsTrialPotion.GetHashCode();
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
		characterUsage_.WriteTo(ref output, _repeated_characterUsage_codec);
		if (BattleCharacterIdx != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(BattleCharacterIdx);
		}
		if (EquipPotionId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(EquipPotionId);
		}
		if (IsTrialPotion != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(IsTrialPotion);
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
		num += characterUsage_.CalculateSize(_repeated_characterUsage_codec);
		if (BattleCharacterIdx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BattleCharacterIdx);
		}
		if (EquipPotionId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EquipPotionId);
		}
		if (IsTrialPotion != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(IsTrialPotion);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TeamUsage other)
	{
		if (other != null)
		{
			characterUsage_.Add(other.characterUsage_);
			if (other.BattleCharacterIdx != 0)
			{
				BattleCharacterIdx = other.BattleCharacterIdx;
			}
			if (other.EquipPotionId != 0)
			{
				EquipPotionId = other.EquipPotionId;
			}
			if (other.IsTrialPotion != 0)
			{
				IsTrialPotion = other.IsTrialPotion;
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
			case 10u:
				characterUsage_.AddEntriesFrom(ref input, _repeated_characterUsage_codec);
				break;
			case 16u:
				BattleCharacterIdx = input.ReadInt32();
				break;
			case 24u:
				EquipPotionId = input.ReadInt32();
				break;
			case 32u:
				IsTrialPotion = input.ReadInt32();
				break;
			}
		}
	}
}
