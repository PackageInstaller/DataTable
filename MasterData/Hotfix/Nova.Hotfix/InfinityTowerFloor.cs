using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class InfinityTowerFloor : IMessage<InfinityTowerFloor>, IMessage, IEquatable<InfinityTowerFloor>, IDeepCloneable<InfinityTowerFloor>
{
	private static readonly MessageParser<InfinityTowerFloor> _parser = new MessageParser<InfinityTowerFloor>(() => new InfinityTowerFloor());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int LvIdFieldNumber = 2;

	private int lvId_;

	public const int MapIdFieldNumber = 3;

	private int mapId_;

	public const int BattleLvFieldNumber = 4;

	private int battleLv_;

	public const int FloorFuncFieldNumber = 5;

	private int floorFunc_;

	public const int MonsterLvFieldNumber = 6;

	private int monsterLv_;

	public const int StageFieldNumber = 7;

	private int stage_;

	public const int SetIdFieldNumber = 8;

	private int setId_;

	public const int LimitTimeFieldNumber = 9;

	private int limitTime_;

	public const int PreviewMonsterGroupIdFieldNumber = 10;

	private int previewMonsterGroupId_;

	public const int AffixIdFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_affixId_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> affixId_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<InfinityTowerFloor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(454);

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
	public int LvId
	{
		get
		{
			return lvId_;
		}
		set
		{
			lvId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MapId
	{
		get
		{
			return mapId_;
		}
		set
		{
			mapId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BattleLv
	{
		get
		{
			return battleLv_;
		}
		set
		{
			battleLv_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FloorFunc
	{
		get
		{
			return floorFunc_;
		}
		set
		{
			floorFunc_ = value;
		}
	}

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
	public int Stage
	{
		get
		{
			return stage_;
		}
		set
		{
			stage_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SetId
	{
		get
		{
			return setId_;
		}
		set
		{
			setId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LimitTime
	{
		get
		{
			return limitTime_;
		}
		set
		{
			limitTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PreviewMonsterGroupId
	{
		get
		{
			return previewMonsterGroupId_;
		}
		set
		{
			previewMonsterGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> AffixId => affixId_;

	[DebuggerNonUserCode]
	public InfinityTowerFloor()
	{
	}

	[DebuggerNonUserCode]
	public InfinityTowerFloor(InfinityTowerFloor other)
		: this()
	{
		id_ = other.id_;
		lvId_ = other.lvId_;
		mapId_ = other.mapId_;
		battleLv_ = other.battleLv_;
		floorFunc_ = other.floorFunc_;
		monsterLv_ = other.monsterLv_;
		stage_ = other.stage_;
		setId_ = other.setId_;
		limitTime_ = other.limitTime_;
		previewMonsterGroupId_ = other.previewMonsterGroupId_;
		affixId_ = other.affixId_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public InfinityTowerFloor Clone()
	{
		return new InfinityTowerFloor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as InfinityTowerFloor);
	}

	[DebuggerNonUserCode]
	public bool Equals(InfinityTowerFloor other)
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
		if (LvId != other.LvId)
		{
			return false;
		}
		if (MapId != other.MapId)
		{
			return false;
		}
		if (BattleLv != other.BattleLv)
		{
			return false;
		}
		if (FloorFunc != other.FloorFunc)
		{
			return false;
		}
		if (MonsterLv != other.MonsterLv)
		{
			return false;
		}
		if (Stage != other.Stage)
		{
			return false;
		}
		if (SetId != other.SetId)
		{
			return false;
		}
		if (LimitTime != other.LimitTime)
		{
			return false;
		}
		if (PreviewMonsterGroupId != other.PreviewMonsterGroupId)
		{
			return false;
		}
		if (!affixId_.Equals(other.affixId_))
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
		if (LvId != 0)
		{
			num ^= LvId.GetHashCode();
		}
		if (MapId != 0)
		{
			num ^= MapId.GetHashCode();
		}
		if (BattleLv != 0)
		{
			num ^= BattleLv.GetHashCode();
		}
		if (FloorFunc != 0)
		{
			num ^= FloorFunc.GetHashCode();
		}
		if (MonsterLv != 0)
		{
			num ^= MonsterLv.GetHashCode();
		}
		if (Stage != 0)
		{
			num ^= Stage.GetHashCode();
		}
		if (SetId != 0)
		{
			num ^= SetId.GetHashCode();
		}
		if (LimitTime != 0)
		{
			num ^= LimitTime.GetHashCode();
		}
		if (PreviewMonsterGroupId != 0)
		{
			num ^= PreviewMonsterGroupId.GetHashCode();
		}
		num ^= affixId_.GetHashCode();
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
		if (LvId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(LvId);
		}
		if (MapId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(MapId);
		}
		if (BattleLv != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(BattleLv);
		}
		if (FloorFunc != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(FloorFunc);
		}
		if (MonsterLv != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(MonsterLv);
		}
		if (Stage != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Stage);
		}
		if (SetId != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(SetId);
		}
		if (LimitTime != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(LimitTime);
		}
		if (PreviewMonsterGroupId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(PreviewMonsterGroupId);
		}
		affixId_.WriteTo(output, _repeated_affixId_codec);
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
		if (LvId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LvId);
		}
		if (MapId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MapId);
		}
		if (BattleLv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BattleLv);
		}
		if (FloorFunc != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorFunc);
		}
		if (MonsterLv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterLv);
		}
		if (Stage != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Stage);
		}
		if (SetId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SetId);
		}
		if (LimitTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LimitTime);
		}
		if (PreviewMonsterGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreviewMonsterGroupId);
		}
		num += affixId_.CalculateSize(_repeated_affixId_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(InfinityTowerFloor other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.LvId != 0)
			{
				LvId = other.LvId;
			}
			if (other.MapId != 0)
			{
				MapId = other.MapId;
			}
			if (other.BattleLv != 0)
			{
				BattleLv = other.BattleLv;
			}
			if (other.FloorFunc != 0)
			{
				FloorFunc = other.FloorFunc;
			}
			if (other.MonsterLv != 0)
			{
				MonsterLv = other.MonsterLv;
			}
			if (other.Stage != 0)
			{
				Stage = other.Stage;
			}
			if (other.SetId != 0)
			{
				SetId = other.SetId;
			}
			if (other.LimitTime != 0)
			{
				LimitTime = other.LimitTime;
			}
			if (other.PreviewMonsterGroupId != 0)
			{
				PreviewMonsterGroupId = other.PreviewMonsterGroupId;
			}
			affixId_.Add(other.affixId_);
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
				LvId = input.ReadInt32();
				break;
			case 24u:
				MapId = input.ReadInt32();
				break;
			case 32u:
				BattleLv = input.ReadInt32();
				break;
			case 40u:
				FloorFunc = input.ReadInt32();
				break;
			case 48u:
				MonsterLv = input.ReadInt32();
				break;
			case 56u:
				Stage = input.ReadInt32();
				break;
			case 64u:
				SetId = input.ReadInt32();
				break;
			case 72u:
				LimitTime = input.ReadInt32();
				break;
			case 80u:
				PreviewMonsterGroupId = input.ReadInt32();
				break;
			case 88u:
			case 90u:
				affixId_.AddEntriesFrom(input, _repeated_affixId_codec);
				break;
			}
		}
	}
}
