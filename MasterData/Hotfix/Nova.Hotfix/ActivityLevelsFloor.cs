using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityLevelsFloor : IMessage<ActivityLevelsFloor>, IMessage, IEquatable<ActivityLevelsFloor>, IDeepCloneable<ActivityLevelsFloor>
{
	private static readonly MessageParser<ActivityLevelsFloor> _parser = new MessageParser<ActivityLevelsFloor>(() => new ActivityLevelsFloor());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int MonsterLvFieldNumber = 2;

	private int monsterLv_;

	public const int SceneNameFieldNumber = 3;

	private string sceneName_ = "";

	public const int ConfigPrefabNameFieldNumber = 4;

	private string configPrefabName_ = "";

	public const int MirFieldNumber = 5;

	private bool mir_;

	public const int ThemeFieldNumber = 6;

	private int theme_;

	public const int BGMFieldNumber = 7;

	private string bGM_ = "";

	public const int LeaveTriggerEventFieldNumber = 8;

	private string leaveTriggerEvent_ = "";

	public const int IntroCutsceneFieldNumber = 9;

	private string introCutscene_ = "";

	public const int LevelScriptFieldNumber = 10;

	private string levelScript_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<ActivityLevelsFloor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(20);

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
	public bool Mir
	{
		get
		{
			return mir_;
		}
		set
		{
			mir_ = value;
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
	public ActivityLevelsFloor()
	{
	}

	[DebuggerNonUserCode]
	public ActivityLevelsFloor(ActivityLevelsFloor other)
		: this()
	{
		id_ = other.id_;
		monsterLv_ = other.monsterLv_;
		sceneName_ = other.sceneName_;
		configPrefabName_ = other.configPrefabName_;
		mir_ = other.mir_;
		theme_ = other.theme_;
		bGM_ = other.bGM_;
		leaveTriggerEvent_ = other.leaveTriggerEvent_;
		introCutscene_ = other.introCutscene_;
		levelScript_ = other.levelScript_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityLevelsFloor Clone()
	{
		return new ActivityLevelsFloor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityLevelsFloor);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityLevelsFloor other)
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
		if (MonsterLv != other.MonsterLv)
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
		if (Mir != other.Mir)
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
		if (MonsterLv != 0)
		{
			num ^= MonsterLv.GetHashCode();
		}
		if (SceneName.Length != 0)
		{
			num ^= SceneName.GetHashCode();
		}
		if (ConfigPrefabName.Length != 0)
		{
			num ^= ConfigPrefabName.GetHashCode();
		}
		if (Mir)
		{
			num ^= Mir.GetHashCode();
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
		if (MonsterLv != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(MonsterLv);
		}
		if (SceneName.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(SceneName);
		}
		if (ConfigPrefabName.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(ConfigPrefabName);
		}
		if (Mir)
		{
			output.WriteRawTag(40);
			output.WriteBool(Mir);
		}
		if (Theme != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Theme);
		}
		if (BGM.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(BGM);
		}
		if (LeaveTriggerEvent.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(LeaveTriggerEvent);
		}
		if (IntroCutscene.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(IntroCutscene);
		}
		if (LevelScript.Length != 0)
		{
			output.WriteRawTag(82);
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
		if (MonsterLv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterLv);
		}
		if (SceneName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SceneName);
		}
		if (ConfigPrefabName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ConfigPrefabName);
		}
		if (Mir)
		{
			num += 2;
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
		if (IntroCutscene.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IntroCutscene);
		}
		if (LevelScript.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LevelScript);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityLevelsFloor other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.MonsterLv != 0)
			{
				MonsterLv = other.MonsterLv;
			}
			if (other.SceneName.Length != 0)
			{
				SceneName = other.SceneName;
			}
			if (other.ConfigPrefabName.Length != 0)
			{
				ConfigPrefabName = other.ConfigPrefabName;
			}
			if (other.Mir)
			{
				Mir = other.Mir;
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
				MonsterLv = input.ReadInt32();
				break;
			case 26u:
				SceneName = input.ReadString();
				break;
			case 34u:
				ConfigPrefabName = input.ReadString();
				break;
			case 40u:
				Mir = input.ReadBool();
				break;
			case 48u:
				Theme = input.ReadInt32();
				break;
			case 58u:
				BGM = input.ReadString();
				break;
			case 66u:
				LeaveTriggerEvent = input.ReadString();
				break;
			case 74u:
				IntroCutscene = input.ReadString();
				break;
			case 82u:
				LevelScript = input.ReadString();
				break;
			}
		}
	}
}
