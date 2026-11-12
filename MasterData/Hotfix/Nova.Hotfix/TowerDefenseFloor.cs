using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TowerDefenseFloor : IMessage<TowerDefenseFloor>, IMessage, IEquatable<TowerDefenseFloor>, IDeepCloneable<TowerDefenseFloor>
{
	private static readonly MessageParser<TowerDefenseFloor> _parser = new MessageParser<TowerDefenseFloor>(() => new TowerDefenseFloor());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int SceneNameFieldNumber = 2;

	private string sceneName_ = "";

	public const int ConfigPrefabNameFieldNumber = 3;

	private string configPrefabName_ = "";

	public const int MiniMapNameFieldNumber = 4;

	private string miniMapName_ = "";

	public const int LevelScriptFieldNumber = 5;

	private string levelScript_ = "";

	public const int DurabilityFieldNumber = 6;

	private int durability_;

	public const int MonsterNumFieldNumber = 7;

	private int monsterNum_;

	public const int MemberNumFieldNumber = 8;

	private int memberNum_;

	public const int TeamGroupFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_teamGroup_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> teamGroup_ = new RepeatedField<int>();

	public const int CharPoolGroupFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_charPoolGroup_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> charPoolGroup_ = new RepeatedField<int>();

	public const int InitPlayerNumFieldNumber = 11;

	private int initPlayerNum_;

	public const int InitPlayersFieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_initPlayers_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> initPlayers_ = new RepeatedField<int>();

	public const int UpgradeSpeedFieldNumber = 13;

	private int upgradeSpeed_;

	public const int ItemIDFieldNumber = 14;

	private int itemID_;

	public const int BGMFieldNumber = 15;

	private string bGM_ = "";

	public const int LeaveTriggerEventFieldNumber = 16;

	private string leaveTriggerEvent_ = "";

	public const int IntroCutsceneFieldNumber = 17;

	private string introCutscene_ = "";

	public const int TDLevelGamePlayTypeFieldNumber = 18;

	private int tDLevelGamePlayType_;

	[DebuggerNonUserCode]
	public static MessageParser<TowerDefenseFloor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(954);

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
	public string SceneName
	{
		get
		{
			return sceneName_;
		}
		set
		{
			sceneName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ConfigPrefabName
	{
		get
		{
			return configPrefabName_;
		}
		set
		{
			configPrefabName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string MiniMapName
	{
		get
		{
			return miniMapName_;
		}
		set
		{
			miniMapName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string LevelScript
	{
		get
		{
			return levelScript_;
		}
		set
		{
			levelScript_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Durability
	{
		get
		{
			return durability_;
		}
		set
		{
			durability_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MonsterNum
	{
		get
		{
			return monsterNum_;
		}
		set
		{
			monsterNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MemberNum
	{
		get
		{
			return memberNum_;
		}
		set
		{
			memberNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> TeamGroup => teamGroup_;

	[DebuggerNonUserCode]
	public RepeatedField<int> CharPoolGroup => charPoolGroup_;

	[DebuggerNonUserCode]
	public int InitPlayerNum
	{
		get
		{
			return initPlayerNum_;
		}
		set
		{
			initPlayerNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> InitPlayers => initPlayers_;

	[DebuggerNonUserCode]
	public int UpgradeSpeed
	{
		get
		{
			return upgradeSpeed_;
		}
		set
		{
			upgradeSpeed_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ItemID
	{
		get
		{
			return itemID_;
		}
		set
		{
			itemID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BGM
	{
		get
		{
			return bGM_;
		}
		set
		{
			bGM_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string LeaveTriggerEvent
	{
		get
		{
			return leaveTriggerEvent_;
		}
		set
		{
			leaveTriggerEvent_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string IntroCutscene
	{
		get
		{
			return introCutscene_;
		}
		set
		{
			introCutscene_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int TDLevelGamePlayType
	{
		get
		{
			return tDLevelGamePlayType_;
		}
		set
		{
			tDLevelGamePlayType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TowerDefenseFloor()
	{
	}

	[DebuggerNonUserCode]
	public TowerDefenseFloor(TowerDefenseFloor other)
		: this()
	{
		id_ = other.id_;
		sceneName_ = other.sceneName_;
		configPrefabName_ = other.configPrefabName_;
		miniMapName_ = other.miniMapName_;
		levelScript_ = other.levelScript_;
		durability_ = other.durability_;
		monsterNum_ = other.monsterNum_;
		memberNum_ = other.memberNum_;
		teamGroup_ = other.teamGroup_.Clone();
		charPoolGroup_ = other.charPoolGroup_.Clone();
		initPlayerNum_ = other.initPlayerNum_;
		initPlayers_ = other.initPlayers_.Clone();
		upgradeSpeed_ = other.upgradeSpeed_;
		itemID_ = other.itemID_;
		bGM_ = other.bGM_;
		leaveTriggerEvent_ = other.leaveTriggerEvent_;
		introCutscene_ = other.introCutscene_;
		tDLevelGamePlayType_ = other.tDLevelGamePlayType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TowerDefenseFloor Clone()
	{
		return new TowerDefenseFloor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TowerDefenseFloor);
	}

	[DebuggerNonUserCode]
	public bool Equals(TowerDefenseFloor other)
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
		if (SceneName != other.SceneName)
		{
			return false;
		}
		if (ConfigPrefabName != other.ConfigPrefabName)
		{
			return false;
		}
		if (MiniMapName != other.MiniMapName)
		{
			return false;
		}
		if (LevelScript != other.LevelScript)
		{
			return false;
		}
		if (Durability != other.Durability)
		{
			return false;
		}
		if (MonsterNum != other.MonsterNum)
		{
			return false;
		}
		if (MemberNum != other.MemberNum)
		{
			return false;
		}
		if (!teamGroup_.Equals(other.teamGroup_))
		{
			return false;
		}
		if (!charPoolGroup_.Equals(other.charPoolGroup_))
		{
			return false;
		}
		if (InitPlayerNum != other.InitPlayerNum)
		{
			return false;
		}
		if (!initPlayers_.Equals(other.initPlayers_))
		{
			return false;
		}
		if (UpgradeSpeed != other.UpgradeSpeed)
		{
			return false;
		}
		if (ItemID != other.ItemID)
		{
			return false;
		}
		if (BGM != other.BGM)
		{
			return false;
		}
		if (LeaveTriggerEvent != other.LeaveTriggerEvent)
		{
			return false;
		}
		if (IntroCutscene != other.IntroCutscene)
		{
			return false;
		}
		if (TDLevelGamePlayType != other.TDLevelGamePlayType)
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
		if (SceneName.Length != 0)
		{
			num ^= SceneName.GetHashCode();
		}
		if (ConfigPrefabName.Length != 0)
		{
			num ^= ConfigPrefabName.GetHashCode();
		}
		if (MiniMapName.Length != 0)
		{
			num ^= MiniMapName.GetHashCode();
		}
		if (LevelScript.Length != 0)
		{
			num ^= LevelScript.GetHashCode();
		}
		if (Durability != 0)
		{
			num ^= Durability.GetHashCode();
		}
		if (MonsterNum != 0)
		{
			num ^= MonsterNum.GetHashCode();
		}
		if (MemberNum != 0)
		{
			num ^= MemberNum.GetHashCode();
		}
		num ^= teamGroup_.GetHashCode();
		num ^= charPoolGroup_.GetHashCode();
		if (InitPlayerNum != 0)
		{
			num ^= InitPlayerNum.GetHashCode();
		}
		num ^= initPlayers_.GetHashCode();
		if (UpgradeSpeed != 0)
		{
			num ^= UpgradeSpeed.GetHashCode();
		}
		if (ItemID != 0)
		{
			num ^= ItemID.GetHashCode();
		}
		if (BGM.Length != 0)
		{
			num ^= BGM.GetHashCode();
		}
		if (LeaveTriggerEvent.Length != 0)
		{
			num ^= LeaveTriggerEvent.GetHashCode();
		}
		if (IntroCutscene.Length != 0)
		{
			num ^= IntroCutscene.GetHashCode();
		}
		if (TDLevelGamePlayType != 0)
		{
			num ^= TDLevelGamePlayType.GetHashCode();
		}
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
		if (SceneName.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(SceneName);
		}
		if (ConfigPrefabName.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(ConfigPrefabName);
		}
		if (MiniMapName.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(MiniMapName);
		}
		if (LevelScript.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(LevelScript);
		}
		if (Durability != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Durability);
		}
		if (MonsterNum != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(MonsterNum);
		}
		if (MemberNum != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(MemberNum);
		}
		teamGroup_.WriteTo(output, _repeated_teamGroup_codec);
		charPoolGroup_.WriteTo(output, _repeated_charPoolGroup_codec);
		if (InitPlayerNum != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(InitPlayerNum);
		}
		initPlayers_.WriteTo(output, _repeated_initPlayers_codec);
		if (UpgradeSpeed != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(UpgradeSpeed);
		}
		if (ItemID != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(ItemID);
		}
		if (BGM.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(BGM);
		}
		if (LeaveTriggerEvent.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(LeaveTriggerEvent);
		}
		if (IntroCutscene.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(IntroCutscene);
		}
		if (TDLevelGamePlayType != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(TDLevelGamePlayType);
		}
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
		if (SceneName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SceneName);
		}
		if (ConfigPrefabName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ConfigPrefabName);
		}
		if (MiniMapName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(MiniMapName);
		}
		if (LevelScript.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LevelScript);
		}
		if (Durability != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Durability);
		}
		if (MonsterNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterNum);
		}
		if (MemberNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MemberNum);
		}
		num += teamGroup_.CalculateSize(_repeated_teamGroup_codec);
		num += charPoolGroup_.CalculateSize(_repeated_charPoolGroup_codec);
		if (InitPlayerNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(InitPlayerNum);
		}
		num += initPlayers_.CalculateSize(_repeated_initPlayers_codec);
		if (UpgradeSpeed != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UpgradeSpeed);
		}
		if (ItemID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemID);
		}
		if (BGM.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BGM);
		}
		if (LeaveTriggerEvent.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(LeaveTriggerEvent);
		}
		if (IntroCutscene.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(IntroCutscene);
		}
		if (TDLevelGamePlayType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TDLevelGamePlayType);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TowerDefenseFloor other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.SceneName.Length != 0)
			{
				SceneName = other.SceneName;
			}
			if (other.ConfigPrefabName.Length != 0)
			{
				ConfigPrefabName = other.ConfigPrefabName;
			}
			if (other.MiniMapName.Length != 0)
			{
				MiniMapName = other.MiniMapName;
			}
			if (other.LevelScript.Length != 0)
			{
				LevelScript = other.LevelScript;
			}
			if (other.Durability != 0)
			{
				Durability = other.Durability;
			}
			if (other.MonsterNum != 0)
			{
				MonsterNum = other.MonsterNum;
			}
			if (other.MemberNum != 0)
			{
				MemberNum = other.MemberNum;
			}
			teamGroup_.Add(other.teamGroup_);
			charPoolGroup_.Add(other.charPoolGroup_);
			if (other.InitPlayerNum != 0)
			{
				InitPlayerNum = other.InitPlayerNum;
			}
			initPlayers_.Add(other.initPlayers_);
			if (other.UpgradeSpeed != 0)
			{
				UpgradeSpeed = other.UpgradeSpeed;
			}
			if (other.ItemID != 0)
			{
				ItemID = other.ItemID;
			}
			if (other.BGM.Length != 0)
			{
				BGM = other.BGM;
			}
			if (other.LeaveTriggerEvent.Length != 0)
			{
				LeaveTriggerEvent = other.LeaveTriggerEvent;
			}
			if (other.IntroCutscene.Length != 0)
			{
				IntroCutscene = other.IntroCutscene;
			}
			if (other.TDLevelGamePlayType != 0)
			{
				TDLevelGamePlayType = other.TDLevelGamePlayType;
			}
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
			case 18u:
				SceneName = input.ReadString();
				break;
			case 26u:
				ConfigPrefabName = input.ReadString();
				break;
			case 34u:
				MiniMapName = input.ReadString();
				break;
			case 42u:
				LevelScript = input.ReadString();
				break;
			case 48u:
				Durability = input.ReadInt32();
				break;
			case 56u:
				MonsterNum = input.ReadInt32();
				break;
			case 64u:
				MemberNum = input.ReadInt32();
				break;
			case 72u:
			case 74u:
				teamGroup_.AddEntriesFrom(input, _repeated_teamGroup_codec);
				break;
			case 80u:
			case 82u:
				charPoolGroup_.AddEntriesFrom(input, _repeated_charPoolGroup_codec);
				break;
			case 88u:
				InitPlayerNum = input.ReadInt32();
				break;
			case 96u:
			case 98u:
				initPlayers_.AddEntriesFrom(input, _repeated_initPlayers_codec);
				break;
			case 104u:
				UpgradeSpeed = input.ReadInt32();
				break;
			case 112u:
				ItemID = input.ReadInt32();
				break;
			case 122u:
				BGM = input.ReadString();
				break;
			case 130u:
				LeaveTriggerEvent = input.ReadString();
				break;
			case 138u:
				IntroCutscene = input.ReadString();
				break;
			case 144u:
				TDLevelGamePlayType = input.ReadInt32();
				break;
			}
		}
	}
}
