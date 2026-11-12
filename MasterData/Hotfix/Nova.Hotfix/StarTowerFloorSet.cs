using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerFloorSet : IMessage<StarTowerFloorSet>, IMessage, IEquatable<StarTowerFloorSet>, IDeepCloneable<StarTowerFloorSet>
{
	private static readonly MessageParser<StarTowerFloorSet> _parser = new MessageParser<StarTowerFloorSet>(() => new StarTowerFloorSet());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int BattleLvsFieldNumber = 2;

	private int battleLvs_;

	public const int StageFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_stage_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> stage_ = new RepeatedField<int>();

	public const int RoomTypeFieldNumber = 4;

	private int roomType_;

	public const int MapIDFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_mapID_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> mapID_ = new RepeatedField<int>();

	public const int FloorIDFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_floorID_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> floorID_ = new RepeatedField<int>();

	public const int MonsterLvFieldNumber = 7;

	private int monsterLv_;

	public const int ThemeSkillLvFieldNumber = 8;

	private int themeSkillLv_;

	public const int WeightFieldNumber = 9;

	private int weight_;

	public const int MutexGroupFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_mutexGroup_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> mutexGroup_ = new RepeatedField<int>();

	public const int SpecialModeIdFieldNumber = 11;

	private int specialModeId_;

	public const int MonsterGroupBlacklistFieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_monsterGroupBlacklist_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> monsterGroupBlacklist_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerFloorSet> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(852);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BattleLvs
	{
		get
		{
			return battleLvs_;
		}
		set
		{
			battleLvs_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Stage => stage_;

	[DebuggerNonUserCode]
	public int RoomType
	{
		get
		{
			return roomType_;
		}
		set
		{
			roomType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> MapID => mapID_;

	[DebuggerNonUserCode]
	public RepeatedField<int> FloorID => floorID_;

	[DebuggerNonUserCode]
	public int MonsterLv
	{
		get
		{
			return monsterLv_;
		}
		set
		{
			monsterLv_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ThemeSkillLv
	{
		get
		{
			return themeSkillLv_;
		}
		set
		{
			themeSkillLv_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Weight
	{
		get
		{
			return weight_;
		}
		set
		{
			weight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> MutexGroup => mutexGroup_;

	[DebuggerNonUserCode]
	public int SpecialModeId
	{
		get
		{
			return specialModeId_;
		}
		set
		{
			specialModeId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> MonsterGroupBlacklist => monsterGroupBlacklist_;

	[DebuggerNonUserCode]
	public StarTowerFloorSet()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerFloorSet(StarTowerFloorSet other)
		: this()
	{
		id_ = other.id_;
		battleLvs_ = other.battleLvs_;
		stage_ = other.stage_.Clone();
		roomType_ = other.roomType_;
		mapID_ = other.mapID_.Clone();
		floorID_ = other.floorID_.Clone();
		monsterLv_ = other.monsterLv_;
		themeSkillLv_ = other.themeSkillLv_;
		weight_ = other.weight_;
		mutexGroup_ = other.mutexGroup_.Clone();
		specialModeId_ = other.specialModeId_;
		monsterGroupBlacklist_ = other.monsterGroupBlacklist_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerFloorSet Clone()
	{
		return new StarTowerFloorSet(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerFloorSet);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerFloorSet other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (BattleLvs != other.BattleLvs)
		{
			return false;
		}
		if (!stage_.Equals(other.stage_))
		{
			return false;
		}
		if (RoomType != other.RoomType)
		{
			return false;
		}
		if (!mapID_.Equals(other.mapID_))
		{
			return false;
		}
		if (!floorID_.Equals(other.floorID_))
		{
			return false;
		}
		if (MonsterLv != other.MonsterLv)
		{
			return false;
		}
		if (ThemeSkillLv != other.ThemeSkillLv)
		{
			return false;
		}
		if (Weight != other.Weight)
		{
			return false;
		}
		if (!mutexGroup_.Equals(other.mutexGroup_))
		{
			return false;
		}
		if (SpecialModeId != other.SpecialModeId)
		{
			return false;
		}
		if (!monsterGroupBlacklist_.Equals(other.monsterGroupBlacklist_))
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (BattleLvs != 0)
		{
			num ^= BattleLvs.GetHashCode();
		}
		num ^= stage_.GetHashCode();
		if (RoomType != 0)
		{
			num ^= RoomType.GetHashCode();
		}
		num ^= mapID_.GetHashCode();
		num ^= floorID_.GetHashCode();
		if (MonsterLv != 0)
		{
			num ^= MonsterLv.GetHashCode();
		}
		if (ThemeSkillLv != 0)
		{
			num ^= ThemeSkillLv.GetHashCode();
		}
		if (Weight != 0)
		{
			num ^= Weight.GetHashCode();
		}
		num ^= mutexGroup_.GetHashCode();
		if (SpecialModeId != 0)
		{
			num ^= SpecialModeId.GetHashCode();
		}
		num ^= monsterGroupBlacklist_.GetHashCode();
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (BattleLvs != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(BattleLvs);
		}
		stage_.WriteTo(output, _repeated_stage_codec);
		if (RoomType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(RoomType);
		}
		mapID_.WriteTo(output, _repeated_mapID_codec);
		floorID_.WriteTo(output, _repeated_floorID_codec);
		if (MonsterLv != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(MonsterLv);
		}
		if (ThemeSkillLv != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ThemeSkillLv);
		}
		if (Weight != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Weight);
		}
		mutexGroup_.WriteTo(output, _repeated_mutexGroup_codec);
		if (SpecialModeId != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(SpecialModeId);
		}
		monsterGroupBlacklist_.WriteTo(output, _repeated_monsterGroupBlacklist_codec);
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (BattleLvs != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BattleLvs);
		}
		num += stage_.CalculateSize(_repeated_stage_codec);
		if (RoomType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RoomType);
		}
		num += mapID_.CalculateSize(_repeated_mapID_codec);
		num += floorID_.CalculateSize(_repeated_floorID_codec);
		if (MonsterLv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterLv);
		}
		if (ThemeSkillLv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ThemeSkillLv);
		}
		if (Weight != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Weight);
		}
		num += mutexGroup_.CalculateSize(_repeated_mutexGroup_codec);
		if (SpecialModeId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SpecialModeId);
		}
		num += monsterGroupBlacklist_.CalculateSize(_repeated_monsterGroupBlacklist_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerFloorSet other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.BattleLvs != 0)
			{
				BattleLvs = other.BattleLvs;
			}
			stage_.Add(other.stage_);
			if (other.RoomType != 0)
			{
				RoomType = other.RoomType;
			}
			mapID_.Add(other.mapID_);
			floorID_.Add(other.floorID_);
			if (other.MonsterLv != 0)
			{
				MonsterLv = other.MonsterLv;
			}
			if (other.ThemeSkillLv != 0)
			{
				ThemeSkillLv = other.ThemeSkillLv;
			}
			if (other.Weight != 0)
			{
				Weight = other.Weight;
			}
			mutexGroup_.Add(other.mutexGroup_);
			if (other.SpecialModeId != 0)
			{
				SpecialModeId = other.SpecialModeId;
			}
			monsterGroupBlacklist_.Add(other.monsterGroupBlacklist_);
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 16u:
				BattleLvs = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				stage_.AddEntriesFrom(input, _repeated_stage_codec);
				break;
			case 32u:
				RoomType = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				mapID_.AddEntriesFrom(input, _repeated_mapID_codec);
				break;
			case 48u:
			case 50u:
				floorID_.AddEntriesFrom(input, _repeated_floorID_codec);
				break;
			case 56u:
				MonsterLv = input.ReadInt32();
				break;
			case 64u:
				ThemeSkillLv = input.ReadInt32();
				break;
			case 72u:
				Weight = input.ReadInt32();
				break;
			case 80u:
			case 82u:
				mutexGroup_.AddEntriesFrom(input, _repeated_mutexGroup_codec);
				break;
			case 88u:
				SpecialModeId = input.ReadInt32();
				break;
			case 96u:
			case 98u:
				monsterGroupBlacklist_.AddEntriesFrom(input, _repeated_monsterGroupBlacklist_codec);
				break;
			}
		}
	}
}
