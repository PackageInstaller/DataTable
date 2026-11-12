using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class JointDrill_2_Floor : IMessage<JointDrill_2_Floor>, IMessage, IEquatable<JointDrill_2_Floor>, IDeepCloneable<JointDrill_2_Floor>
{
	private static readonly MessageParser<JointDrill_2_Floor> _parser = new MessageParser<JointDrill_2_Floor>(() => new JointDrill_2_Floor());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int FloorIdFieldNumber = 2;

	private int floorId_;

	public const int BattleLvsFieldNumber = 3;

	private int battleLvs_;

	public const int FloorChangeIDFieldNumber = 4;

	private int floorChangeID_;

	public const int MaxEnergyValueFieldNumber = 5;

	private int maxEnergyValue_;

	public const int SaveEnergyValueFieldNumber = 6;

	private bool saveEnergyValue_;

	public const int TeamSaveEnergyValueFieldNumber = 7;

	private bool teamSaveEnergyValue_;

	public const int SaveResilienceFieldNumber = 8;

	private bool saveResilience_;

	public const int TeamSaveResilienceFieldNumber = 9;

	private bool teamSaveResilience_;

	public const int SceneNameFieldNumber = 10;

	private string sceneName_ = "";

	public const int ConfigPrefabNameFieldNumber = 11;

	private string configPrefabName_ = "";

	public const int ThemeFieldNumber = 12;

	private int theme_;

	public const int BGMFieldNumber = 13;

	private string bGM_ = "";

	public const int LeaveTriggerEventFieldNumber = 14;

	private string leaveTriggerEvent_ = "";

	public const int DungeonDelayFieldNumber = 15;

	private int dungeonDelay_;

	public const int IntroCutsceneFieldNumber = 16;

	private string introCutscene_ = "";

	public const int LevelScriptFieldNumber = 17;

	private string levelScript_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<JointDrill_2_Floor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(484);

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
	public int FloorChangeID
	{
		get
		{
			return floorChangeID_;
		}
		set
		{
			floorChangeID_ = value;
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
	public JointDrill_2_Floor()
	{
	}

	[DebuggerNonUserCode]
	public JointDrill_2_Floor(JointDrill_2_Floor other)
		: this()
	{
		id_ = other.id_;
		floorId_ = other.floorId_;
		battleLvs_ = other.battleLvs_;
		floorChangeID_ = other.floorChangeID_;
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
	public JointDrill_2_Floor Clone()
	{
		return new JointDrill_2_Floor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as JointDrill_2_Floor);
	}

	[DebuggerNonUserCode]
	public bool Equals(JointDrill_2_Floor other)
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
		if (FloorChangeID != other.FloorChangeID)
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
		if (FloorChangeID != 0)
		{
			num ^= FloorChangeID.GetHashCode();
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
		if (FloorChangeID != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(FloorChangeID);
		}
		if (MaxEnergyValue != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(MaxEnergyValue);
		}
		if (SaveEnergyValue)
		{
			output.WriteRawTag(48);
			output.WriteBool(SaveEnergyValue);
		}
		if (TeamSaveEnergyValue)
		{
			output.WriteRawTag(56);
			output.WriteBool(TeamSaveEnergyValue);
		}
		if (SaveResilience)
		{
			output.WriteRawTag(64);
			output.WriteBool(SaveResilience);
		}
		if (TeamSaveResilience)
		{
			output.WriteRawTag(72);
			output.WriteBool(TeamSaveResilience);
		}
		if (SceneName.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(SceneName);
		}
		if (ConfigPrefabName.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(ConfigPrefabName);
		}
		if (Theme != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(Theme);
		}
		if (BGM.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(BGM);
		}
		if (LeaveTriggerEvent.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(LeaveTriggerEvent);
		}
		if (DungeonDelay != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(DungeonDelay);
		}
		if (IntroCutscene.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(IntroCutscene);
		}
		if (LevelScript.Length != 0)
		{
			output.WriteRawTag(138, 1);
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
		if (FloorChangeID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorChangeID);
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
			num += 1 + CodedOutputStream.ComputeStringSize(LeaveTriggerEvent);
		}
		if (DungeonDelay != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DungeonDelay);
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
	public void MergeFrom(JointDrill_2_Floor other)
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
			if (other.FloorChangeID != 0)
			{
				FloorChangeID = other.FloorChangeID;
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
				FloorChangeID = input.ReadInt32();
				break;
			case 40u:
				MaxEnergyValue = input.ReadInt32();
				break;
			case 48u:
				SaveEnergyValue = input.ReadBool();
				break;
			case 56u:
				TeamSaveEnergyValue = input.ReadBool();
				break;
			case 64u:
				SaveResilience = input.ReadBool();
				break;
			case 72u:
				TeamSaveResilience = input.ReadBool();
				break;
			case 82u:
				SceneName = input.ReadString();
				break;
			case 90u:
				ConfigPrefabName = input.ReadString();
				break;
			case 96u:
				Theme = input.ReadInt32();
				break;
			case 106u:
				BGM = input.ReadString();
				break;
			case 114u:
				LeaveTriggerEvent = input.ReadString();
				break;
			case 120u:
				DungeonDelay = input.ReadInt32();
				break;
			case 130u:
				IntroCutscene = input.ReadString();
				break;
			case 138u:
				LevelScript = input.ReadString();
				break;
			}
		}
	}
}
