using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class WeekBossFloor : IMessage<WeekBossFloor>, IMessage, IEquatable<WeekBossFloor>, IDeepCloneable<WeekBossFloor>
{
	private static readonly MessageParser<WeekBossFloor> _parser = new MessageParser<WeekBossFloor>(() => new WeekBossFloor());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int SceneNameFieldNumber = 2;

	private string sceneName_ = "";

	public const int ConfigPrefabNameFieldNumber = 3;

	private string configPrefabName_ = "";

	public const int ThemeFieldNumber = 4;

	private int theme_;

	public const int BGMFieldNumber = 5;

	private string bGM_ = "";

	public const int LeaveTriggerEventFieldNumber = 6;

	private string leaveTriggerEvent_ = "";

	public const int MonsterLvFieldNumber = 7;

	private int monsterLv_;

	public const int DungeonDelayFieldNumber = 8;

	private int dungeonDelay_;

	public const int IntroCutsceneFieldNumber = 9;

	private string introCutscene_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<WeekBossFloor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1076);

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
	public WeekBossFloor()
	{
	}

	[DebuggerNonUserCode]
	public WeekBossFloor(WeekBossFloor other)
		: this()
	{
		id_ = other.id_;
		sceneName_ = other.sceneName_;
		configPrefabName_ = other.configPrefabName_;
		theme_ = other.theme_;
		bGM_ = other.bGM_;
		leaveTriggerEvent_ = other.leaveTriggerEvent_;
		monsterLv_ = other.monsterLv_;
		dungeonDelay_ = other.dungeonDelay_;
		introCutscene_ = other.introCutscene_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public WeekBossFloor Clone()
	{
		return new WeekBossFloor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as WeekBossFloor);
	}

	[DebuggerNonUserCode]
	public bool Equals(WeekBossFloor other)
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
		if (MonsterLv != other.MonsterLv)
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
		if (MonsterLv != 0)
		{
			num ^= MonsterLv.GetHashCode();
		}
		if (DungeonDelay != 0)
		{
			num ^= DungeonDelay.GetHashCode();
		}
		if (IntroCutscene.Length != 0)
		{
			num ^= IntroCutscene.GetHashCode();
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
		if (Theme != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Theme);
		}
		if (BGM.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(BGM);
		}
		if (LeaveTriggerEvent.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(LeaveTriggerEvent);
		}
		if (MonsterLv != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(MonsterLv);
		}
		if (DungeonDelay != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(DungeonDelay);
		}
		if (IntroCutscene.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(IntroCutscene);
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
		if (MonsterLv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterLv);
		}
		if (DungeonDelay != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DungeonDelay);
		}
		if (IntroCutscene.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IntroCutscene);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(WeekBossFloor other)
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
			if (other.MonsterLv != 0)
			{
				MonsterLv = other.MonsterLv;
			}
			if (other.DungeonDelay != 0)
			{
				DungeonDelay = other.DungeonDelay;
			}
			if (other.IntroCutscene.Length != 0)
			{
				IntroCutscene = other.IntroCutscene;
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
			case 32u:
				Theme = input.ReadInt32();
				break;
			case 42u:
				BGM = input.ReadString();
				break;
			case 50u:
				LeaveTriggerEvent = input.ReadString();
				break;
			case 56u:
				MonsterLv = input.ReadInt32();
				break;
			case 64u:
				DungeonDelay = input.ReadInt32();
				break;
			case 74u:
				IntroCutscene = input.ReadString();
				break;
			}
		}
	}
}
