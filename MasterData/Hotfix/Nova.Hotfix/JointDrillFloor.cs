using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class JointDrillFloor : IMessage<JointDrillFloor>, IMessage, IEquatable<JointDrillFloor>, IDeepCloneable<JointDrillFloor>
{
	private static readonly MessageParser<JointDrillFloor> _parser = new MessageParser<JointDrillFloor>(() => new JointDrillFloor());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int FloorIdFieldNumber = 2;

	private int floorId_;

	public const int BattleLvsFieldNumber = 3;

	private int battleLvs_;

	public const int FloorTypeFieldNumber = 4;

	private int floorType_;

	public const int BattleLvsToggleFieldNumber = 5;

	private int battleLvsToggle_;

	public const int BattleLvsToggleParam1FieldNumber = 6;

	private string battleLvsToggleParam1_ = "";

	public const int MaxEnergyValueFieldNumber = 7;

	private int maxEnergyValue_;

	public const int SaveEnergyValueFieldNumber = 8;

	private bool saveEnergyValue_;

	public const int TeamSaveEnergyValueFieldNumber = 9;

	private bool teamSaveEnergyValue_;

	public const int SaveResilienceFieldNumber = 10;

	private bool saveResilience_;

	public const int TeamSaveResilienceFieldNumber = 11;

	private bool teamSaveResilience_;

	public const int SceneNameFieldNumber = 12;

	private string sceneName_ = "";

	public const int ConfigPrefabNameFieldNumber = 13;

	private string configPrefabName_ = "";

	public const int ThemeFieldNumber = 14;

	private int theme_;

	public const int BGMFieldNumber = 15;

	private string bGM_ = "";

	public const int LeaveTriggerEventFieldNumber = 16;

	private string leaveTriggerEvent_ = "";

	public const int DungeonDelayFieldNumber = 17;

	private int dungeonDelay_;

	public const int IntroCutsceneFieldNumber = 18;

	private string introCutscene_ = "";

	public const int LevelScriptFieldNumber = 19;

	private string levelScript_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<JointDrillFloor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(476);

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
	public int FloorId
	{
		get
		{
			return floorId_;
		}
		set
		{
			floorId_ = value;
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
	public int FloorType
	{
		get
		{
			return floorType_;
		}
		set
		{
			floorType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BattleLvsToggle
	{
		get
		{
			return battleLvsToggle_;
		}
		set
		{
			battleLvsToggle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BattleLvsToggleParam1
	{
		get
		{
			return battleLvsToggleParam1_;
		}
		set
		{
			battleLvsToggleParam1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int MaxEnergyValue
	{
		get
		{
			return maxEnergyValue_;
		}
		set
		{
			maxEnergyValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool SaveEnergyValue
	{
		get
		{
			return saveEnergyValue_;
		}
		set
		{
			saveEnergyValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool TeamSaveEnergyValue
	{
		get
		{
			return teamSaveEnergyValue_;
		}
		set
		{
			teamSaveEnergyValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool SaveResilience
	{
		get
		{
			return saveResilience_;
		}
		set
		{
			saveResilience_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool TeamSaveResilience
	{
		get
		{
			return teamSaveResilience_;
		}
		set
		{
			teamSaveResilience_ = value;
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
	public int Theme
	{
		get
		{
			return theme_;
		}
		set
		{
			theme_ = value;
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
	public int DungeonDelay
	{
		get
		{
			return dungeonDelay_;
		}
		set
		{
			dungeonDelay_ = value;
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
	public JointDrillFloor()
	{
	}

	[DebuggerNonUserCode]
	public JointDrillFloor(JointDrillFloor other)
		: this()
	{
		id_ = other.id_;
		floorId_ = other.floorId_;
		battleLvs_ = other.battleLvs_;
		floorType_ = other.floorType_;
		battleLvsToggle_ = other.battleLvsToggle_;
		battleLvsToggleParam1_ = other.battleLvsToggleParam1_;
		maxEnergyValue_ = other.maxEnergyValue_;
		saveEnergyValue_ = other.saveEnergyValue_;
		teamSaveEnergyValue_ = other.teamSaveEnergyValue_;
		saveResilience_ = other.saveResilience_;
		teamSaveResilience_ = other.teamSaveResilience_;
		sceneName_ = other.sceneName_;
		configPrefabName_ = other.configPrefabName_;
		theme_ = other.theme_;
		bGM_ = other.bGM_;
		leaveTriggerEvent_ = other.leaveTriggerEvent_;
		dungeonDelay_ = other.dungeonDelay_;
		introCutscene_ = other.introCutscene_;
		levelScript_ = other.levelScript_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public JointDrillFloor Clone()
	{
		return new JointDrillFloor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as JointDrillFloor);
	}

	[DebuggerNonUserCode]
	public bool Equals(JointDrillFloor other)
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
		if (FloorId != other.FloorId)
		{
			return false;
		}
		if (BattleLvs != other.BattleLvs)
		{
			return false;
		}
		if (FloorType != other.FloorType)
		{
			return false;
		}
		if (BattleLvsToggle != other.BattleLvsToggle)
		{
			return false;
		}
		if (BattleLvsToggleParam1 != other.BattleLvsToggleParam1)
		{
			return false;
		}
		if (MaxEnergyValue != other.MaxEnergyValue)
		{
			return false;
		}
		if (SaveEnergyValue != other.SaveEnergyValue)
		{
			return false;
		}
		if (TeamSaveEnergyValue != other.TeamSaveEnergyValue)
		{
			return false;
		}
		if (SaveResilience != other.SaveResilience)
		{
			return false;
		}
		if (TeamSaveResilience != other.TeamSaveResilience)
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
		if (Theme != other.Theme)
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
		if (DungeonDelay != other.DungeonDelay)
		{
			return false;
		}
		if (IntroCutscene != other.IntroCutscene)
		{
			return false;
		}
		if (LevelScript != other.LevelScript)
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
		if (FloorId != 0)
		{
			num ^= FloorId.GetHashCode();
		}
		if (BattleLvs != 0)
		{
			num ^= BattleLvs.GetHashCode();
		}
		if (FloorType != 0)
		{
			num ^= FloorType.GetHashCode();
		}
		if (BattleLvsToggle != 0)
		{
			num ^= BattleLvsToggle.GetHashCode();
		}
		if (BattleLvsToggleParam1.Length != 0)
		{
			num ^= BattleLvsToggleParam1.GetHashCode();
		}
		if (MaxEnergyValue != 0)
		{
			num ^= MaxEnergyValue.GetHashCode();
		}
		if (SaveEnergyValue)
		{
			num ^= SaveEnergyValue.GetHashCode();
		}
		if (TeamSaveEnergyValue)
		{
			num ^= TeamSaveEnergyValue.GetHashCode();
		}
		if (SaveResilience)
		{
			num ^= SaveResilience.GetHashCode();
		}
		if (TeamSaveResilience)
		{
			num ^= TeamSaveResilience.GetHashCode();
		}
		if (SceneName.Length != 0)
		{
			num ^= SceneName.GetHashCode();
		}
		if (ConfigPrefabName.Length != 0)
		{
			num ^= ConfigPrefabName.GetHashCode();
		}
		if (Theme != 0)
		{
			num ^= Theme.GetHashCode();
		}
		if (BGM.Length != 0)
		{
			num ^= BGM.GetHashCode();
		}
		if (LeaveTriggerEvent.Length != 0)
		{
			num ^= LeaveTriggerEvent.GetHashCode();
		}
		if (DungeonDelay != 0)
		{
			num ^= DungeonDelay.GetHashCode();
		}
		if (IntroCutscene.Length != 0)
		{
			num ^= IntroCutscene.GetHashCode();
		}
		if (LevelScript.Length != 0)
		{
			num ^= LevelScript.GetHashCode();
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
		if (FloorId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(FloorId);
		}
		if (BattleLvs != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(BattleLvs);
		}
		if (FloorType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(FloorType);
		}
		if (BattleLvsToggle != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(BattleLvsToggle);
		}
		if (BattleLvsToggleParam1.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(BattleLvsToggleParam1);
		}
		if (MaxEnergyValue != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(MaxEnergyValue);
		}
		if (SaveEnergyValue)
		{
			output.WriteRawTag(64);
			output.WriteBool(SaveEnergyValue);
		}
		if (TeamSaveEnergyValue)
		{
			output.WriteRawTag(72);
			output.WriteBool(TeamSaveEnergyValue);
		}
		if (SaveResilience)
		{
			output.WriteRawTag(80);
			output.WriteBool(SaveResilience);
		}
		if (TeamSaveResilience)
		{
			output.WriteRawTag(88);
			output.WriteBool(TeamSaveResilience);
		}
		if (SceneName.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(SceneName);
		}
		if (ConfigPrefabName.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(ConfigPrefabName);
		}
		if (Theme != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(Theme);
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
		if (DungeonDelay != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(DungeonDelay);
		}
		if (IntroCutscene.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(IntroCutscene);
		}
		if (LevelScript.Length != 0)
		{
			output.WriteRawTag(154, 1);
			output.WriteString(LevelScript);
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
		if (FloorId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorId);
		}
		if (BattleLvs != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BattleLvs);
		}
		if (FloorType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorType);
		}
		if (BattleLvsToggle != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BattleLvsToggle);
		}
		if (BattleLvsToggleParam1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BattleLvsToggleParam1);
		}
		if (MaxEnergyValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxEnergyValue);
		}
		if (SaveEnergyValue)
		{
			num += 2;
		}
		if (TeamSaveEnergyValue)
		{
			num += 2;
		}
		if (SaveResilience)
		{
			num += 2;
		}
		if (TeamSaveResilience)
		{
			num += 2;
		}
		if (SceneName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SceneName);
		}
		if (ConfigPrefabName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ConfigPrefabName);
		}
		if (Theme != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Theme);
		}
		if (BGM.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BGM);
		}
		if (LeaveTriggerEvent.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(LeaveTriggerEvent);
		}
		if (DungeonDelay != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DungeonDelay);
		}
		if (IntroCutscene.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(IntroCutscene);
		}
		if (LevelScript.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(LevelScript);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(JointDrillFloor other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.FloorId != 0)
			{
				FloorId = other.FloorId;
			}
			if (other.BattleLvs != 0)
			{
				BattleLvs = other.BattleLvs;
			}
			if (other.FloorType != 0)
			{
				FloorType = other.FloorType;
			}
			if (other.BattleLvsToggle != 0)
			{
				BattleLvsToggle = other.BattleLvsToggle;
			}
			if (other.BattleLvsToggleParam1.Length != 0)
			{
				BattleLvsToggleParam1 = other.BattleLvsToggleParam1;
			}
			if (other.MaxEnergyValue != 0)
			{
				MaxEnergyValue = other.MaxEnergyValue;
			}
			if (other.SaveEnergyValue)
			{
				SaveEnergyValue = other.SaveEnergyValue;
			}
			if (other.TeamSaveEnergyValue)
			{
				TeamSaveEnergyValue = other.TeamSaveEnergyValue;
			}
			if (other.SaveResilience)
			{
				SaveResilience = other.SaveResilience;
			}
			if (other.TeamSaveResilience)
			{
				TeamSaveResilience = other.TeamSaveResilience;
			}
			if (other.SceneName.Length != 0)
			{
				SceneName = other.SceneName;
			}
			if (other.ConfigPrefabName.Length != 0)
			{
				ConfigPrefabName = other.ConfigPrefabName;
			}
			if (other.Theme != 0)
			{
				Theme = other.Theme;
			}
			if (other.BGM.Length != 0)
			{
				BGM = other.BGM;
			}
			if (other.LeaveTriggerEvent.Length != 0)
			{
				LeaveTriggerEvent = other.LeaveTriggerEvent;
			}
			if (other.DungeonDelay != 0)
			{
				DungeonDelay = other.DungeonDelay;
			}
			if (other.IntroCutscene.Length != 0)
			{
				IntroCutscene = other.IntroCutscene;
			}
			if (other.LevelScript.Length != 0)
			{
				LevelScript = other.LevelScript;
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
			case 16u:
				FloorId = input.ReadInt32();
				break;
			case 24u:
				BattleLvs = input.ReadInt32();
				break;
			case 32u:
				FloorType = input.ReadInt32();
				break;
			case 40u:
				BattleLvsToggle = input.ReadInt32();
				break;
			case 50u:
				BattleLvsToggleParam1 = input.ReadString();
				break;
			case 56u:
				MaxEnergyValue = input.ReadInt32();
				break;
			case 64u:
				SaveEnergyValue = input.ReadBool();
				break;
			case 72u:
				TeamSaveEnergyValue = input.ReadBool();
				break;
			case 80u:
				SaveResilience = input.ReadBool();
				break;
			case 88u:
				TeamSaveResilience = input.ReadBool();
				break;
			case 98u:
				SceneName = input.ReadString();
				break;
			case 106u:
				ConfigPrefabName = input.ReadString();
				break;
			case 112u:
				Theme = input.ReadInt32();
				break;
			case 122u:
				BGM = input.ReadString();
				break;
			case 130u:
				LeaveTriggerEvent = input.ReadString();
				break;
			case 136u:
				DungeonDelay = input.ReadInt32();
				break;
			case 146u:
				IntroCutscene = input.ReadString();
				break;
			case 154u:
				LevelScript = input.ReadString();
				break;
			}
		}
	}
}
