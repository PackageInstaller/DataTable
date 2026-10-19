using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class AchievementSyncInfo : IMessage<AchievementSyncInfo>, IMessage, IEquatable<AchievementSyncInfo>, IDeepCloneable<AchievementSyncInfo>, IBufferMessage
{
	private static readonly MessageParser<AchievementSyncInfo> _parser = new MessageParser<AchievementSyncInfo>(() => new AchievementSyncInfo());

	private UnknownFieldSet _unknownFields;

	public const int FightTypeCntInfoFieldNumber = 1;

	private static readonly MapField<int, int>.Codec _map_fightTypeCntInfo_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 10u);

	private readonly MapField<int, int> fightTypeCntInfo_ = new MapField<int, int>();

	public const int BossKillTimeFieldNumber = 2;

	private static readonly MapField<int, int>.Codec _map_bossKillTime_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 18u);

	private readonly MapField<int, int> bossKillTime_ = new MapField<int, int>();

	public const int UseSkillCountFieldNumber = 3;

	private static readonly MapField<int, int>.Codec _map_useSkillCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 26u);

	private readonly MapField<int, int> useSkillCount_ = new MapField<int, int>();

	public const int CharacterDieOnOneHitFieldNumber = 4;

	private static readonly MapField<int, int>.Codec _map_characterDieOnOneHit_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 34u);

	private readonly MapField<int, int> characterDieOnOneHit_ = new MapField<int, int>();

	public const int DamageAccumulateByTypeFieldNumber = 5;

	private static readonly MapField<int, int>.Codec _map_damageAccumulateByType_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 42u);

	private readonly MapField<int, int> damageAccumulateByType_ = new MapField<int, int>();

	public const int InteractedNPCsFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_interactedNPCs_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> interactedNPCs_ = new RepeatedField<int>();

	public const int DamageTypeDieOnOneHitFieldNumber = 7;

	private static readonly MapField<int, int>.Codec _map_damageTypeDieOnOneHit_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 58u);

	private readonly MapField<int, int> damageTypeDieOnOneHit_ = new MapField<int, int>();

	public const int CharacterKillMonsterInAirCountFieldNumber = 8;

	private static readonly MapField<int, int>.Codec _map_characterKillMonsterInAirCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 66u);

	private readonly MapField<int, int> characterKillMonsterInAirCount_ = new MapField<int, int>();

	public const int PlayerDeadByMonsterPointIDFieldNumber = 9;

	private static readonly MapField<int, int>.Codec _map_playerDeadByMonsterPointID_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 74u);

	private readonly MapField<int, int> playerDeadByMonsterPointID_ = new MapField<int, int>();

	public const int DamageOnceMaximumByTypeFieldNumber = 10;

	private static readonly MapField<int, int>.Codec _map_damageOnceMaximumByType_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 82u);

	private readonly MapField<int, int> damageOnceMaximumByType_ = new MapField<int, int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AchievementSyncInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[105];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> FightTypeCntInfo => fightTypeCntInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> BossKillTime => bossKillTime_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> UseSkillCount => useSkillCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> CharacterDieOnOneHit => characterDieOnOneHit_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> DamageAccumulateByType => damageAccumulateByType_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> InteractedNPCs => interactedNPCs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> DamageTypeDieOnOneHit => damageTypeDieOnOneHit_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> CharacterKillMonsterInAirCount => characterKillMonsterInAirCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> PlayerDeadByMonsterPointID => playerDeadByMonsterPointID_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> DamageOnceMaximumByType => damageOnceMaximumByType_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementSyncInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementSyncInfo(AchievementSyncInfo other)
		: this()
	{
		fightTypeCntInfo_ = other.fightTypeCntInfo_.Clone();
		bossKillTime_ = other.bossKillTime_.Clone();
		useSkillCount_ = other.useSkillCount_.Clone();
		characterDieOnOneHit_ = other.characterDieOnOneHit_.Clone();
		damageAccumulateByType_ = other.damageAccumulateByType_.Clone();
		interactedNPCs_ = other.interactedNPCs_.Clone();
		damageTypeDieOnOneHit_ = other.damageTypeDieOnOneHit_.Clone();
		characterKillMonsterInAirCount_ = other.characterKillMonsterInAirCount_.Clone();
		playerDeadByMonsterPointID_ = other.playerDeadByMonsterPointID_.Clone();
		damageOnceMaximumByType_ = other.damageOnceMaximumByType_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementSyncInfo Clone()
	{
		return new AchievementSyncInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AchievementSyncInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AchievementSyncInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!FightTypeCntInfo.Equals(other.FightTypeCntInfo))
		{
			return false;
		}
		if (!BossKillTime.Equals(other.BossKillTime))
		{
			return false;
		}
		if (!UseSkillCount.Equals(other.UseSkillCount))
		{
			return false;
		}
		if (!CharacterDieOnOneHit.Equals(other.CharacterDieOnOneHit))
		{
			return false;
		}
		if (!DamageAccumulateByType.Equals(other.DamageAccumulateByType))
		{
			return false;
		}
		if (!interactedNPCs_.Equals(other.interactedNPCs_))
		{
			return false;
		}
		if (!DamageTypeDieOnOneHit.Equals(other.DamageTypeDieOnOneHit))
		{
			return false;
		}
		if (!CharacterKillMonsterInAirCount.Equals(other.CharacterKillMonsterInAirCount))
		{
			return false;
		}
		if (!PlayerDeadByMonsterPointID.Equals(other.PlayerDeadByMonsterPointID))
		{
			return false;
		}
		if (!DamageOnceMaximumByType.Equals(other.DamageOnceMaximumByType))
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
		num ^= FightTypeCntInfo.GetHashCode();
		num ^= BossKillTime.GetHashCode();
		num ^= UseSkillCount.GetHashCode();
		num ^= CharacterDieOnOneHit.GetHashCode();
		num ^= DamageAccumulateByType.GetHashCode();
		num ^= interactedNPCs_.GetHashCode();
		num ^= DamageTypeDieOnOneHit.GetHashCode();
		num ^= CharacterKillMonsterInAirCount.GetHashCode();
		num ^= PlayerDeadByMonsterPointID.GetHashCode();
		num ^= DamageOnceMaximumByType.GetHashCode();
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
		fightTypeCntInfo_.WriteTo(ref output, _map_fightTypeCntInfo_codec);
		bossKillTime_.WriteTo(ref output, _map_bossKillTime_codec);
		useSkillCount_.WriteTo(ref output, _map_useSkillCount_codec);
		characterDieOnOneHit_.WriteTo(ref output, _map_characterDieOnOneHit_codec);
		damageAccumulateByType_.WriteTo(ref output, _map_damageAccumulateByType_codec);
		interactedNPCs_.WriteTo(ref output, _repeated_interactedNPCs_codec);
		damageTypeDieOnOneHit_.WriteTo(ref output, _map_damageTypeDieOnOneHit_codec);
		characterKillMonsterInAirCount_.WriteTo(ref output, _map_characterKillMonsterInAirCount_codec);
		playerDeadByMonsterPointID_.WriteTo(ref output, _map_playerDeadByMonsterPointID_codec);
		damageOnceMaximumByType_.WriteTo(ref output, _map_damageOnceMaximumByType_codec);
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
		num += fightTypeCntInfo_.CalculateSize(_map_fightTypeCntInfo_codec);
		num += bossKillTime_.CalculateSize(_map_bossKillTime_codec);
		num += useSkillCount_.CalculateSize(_map_useSkillCount_codec);
		num += characterDieOnOneHit_.CalculateSize(_map_characterDieOnOneHit_codec);
		num += damageAccumulateByType_.CalculateSize(_map_damageAccumulateByType_codec);
		num += interactedNPCs_.CalculateSize(_repeated_interactedNPCs_codec);
		num += damageTypeDieOnOneHit_.CalculateSize(_map_damageTypeDieOnOneHit_codec);
		num += characterKillMonsterInAirCount_.CalculateSize(_map_characterKillMonsterInAirCount_codec);
		num += playerDeadByMonsterPointID_.CalculateSize(_map_playerDeadByMonsterPointID_codec);
		num += damageOnceMaximumByType_.CalculateSize(_map_damageOnceMaximumByType_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AchievementSyncInfo other)
	{
		if (other != null)
		{
			fightTypeCntInfo_.Add(other.fightTypeCntInfo_);
			bossKillTime_.Add(other.bossKillTime_);
			useSkillCount_.Add(other.useSkillCount_);
			characterDieOnOneHit_.Add(other.characterDieOnOneHit_);
			damageAccumulateByType_.Add(other.damageAccumulateByType_);
			interactedNPCs_.Add(other.interactedNPCs_);
			damageTypeDieOnOneHit_.Add(other.damageTypeDieOnOneHit_);
			characterKillMonsterInAirCount_.Add(other.characterKillMonsterInAirCount_);
			playerDeadByMonsterPointID_.Add(other.playerDeadByMonsterPointID_);
			damageOnceMaximumByType_.Add(other.damageOnceMaximumByType_);
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
				fightTypeCntInfo_.AddEntriesFrom(ref input, _map_fightTypeCntInfo_codec);
				break;
			case 18u:
				bossKillTime_.AddEntriesFrom(ref input, _map_bossKillTime_codec);
				break;
			case 26u:
				useSkillCount_.AddEntriesFrom(ref input, _map_useSkillCount_codec);
				break;
			case 34u:
				characterDieOnOneHit_.AddEntriesFrom(ref input, _map_characterDieOnOneHit_codec);
				break;
			case 42u:
				damageAccumulateByType_.AddEntriesFrom(ref input, _map_damageAccumulateByType_codec);
				break;
			case 48u:
			case 50u:
				interactedNPCs_.AddEntriesFrom(ref input, _repeated_interactedNPCs_codec);
				break;
			case 58u:
				damageTypeDieOnOneHit_.AddEntriesFrom(ref input, _map_damageTypeDieOnOneHit_codec);
				break;
			case 66u:
				characterKillMonsterInAirCount_.AddEntriesFrom(ref input, _map_characterKillMonsterInAirCount_codec);
				break;
			case 74u:
				playerDeadByMonsterPointID_.AddEntriesFrom(ref input, _map_playerDeadByMonsterPointID_codec);
				break;
			case 82u:
				damageOnceMaximumByType_.AddEntriesFrom(ref input, _map_damageOnceMaximumByType_codec);
				break;
			}
		}
	}
}
