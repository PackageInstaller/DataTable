using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TutorialLevelFloor : IMessage<TutorialLevelFloor>, IMessage, IEquatable<TutorialLevelFloor>, IDeepCloneable<TutorialLevelFloor>
{
	private static readonly MessageParser<TutorialLevelFloor> _parser = new MessageParser<TutorialLevelFloor>(() => new TutorialLevelFloor());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int SceneNameFieldNumber = 2;

	private string sceneName_ = "";

	public const int ConfigPrefabNameFieldNumber = 3;

	private string configPrefabName_ = "";

	public const int ScriptTypeFieldNumber = 4;

	private int scriptType_;

	public const int QuestFlowFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_questFlow_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> questFlow_ = new RepeatedField<int>();

	public const int BGMFieldNumber = 6;

	private string bGM_ = "";

	public const int LeaveTriggerEventFieldNumber = 7;

	private string leaveTriggerEvent_ = "";

	public const int ThemeFieldNumber = 8;

	private int theme_;

	public const int MonsterLvFieldNumber = 9;

	private int monsterLv_;

	[DebuggerNonUserCode]
	public static MessageParser<TutorialLevelFloor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1042);

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
	public int ScriptType
	{
		get
		{
			return scriptType_;
		}
		set
		{
			scriptType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> QuestFlow => questFlow_;

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
	public TutorialLevelFloor()
	{
	}

	[DebuggerNonUserCode]
	public TutorialLevelFloor(TutorialLevelFloor other)
		: this()
	{
		id_ = other.id_;
		sceneName_ = other.sceneName_;
		configPrefabName_ = other.configPrefabName_;
		scriptType_ = other.scriptType_;
		questFlow_ = other.questFlow_.Clone();
		bGM_ = other.bGM_;
		leaveTriggerEvent_ = other.leaveTriggerEvent_;
		theme_ = other.theme_;
		monsterLv_ = other.monsterLv_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TutorialLevelFloor Clone()
	{
		return new TutorialLevelFloor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TutorialLevelFloor);
	}

	[DebuggerNonUserCode]
	public bool Equals(TutorialLevelFloor other)
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
		if (ScriptType != other.ScriptType)
		{
			return false;
		}
		if (!questFlow_.Equals(other.questFlow_))
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
		if (Theme != other.Theme)
		{
			return false;
		}
		if (MonsterLv != other.MonsterLv)
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
		if (ScriptType != 0)
		{
			num ^= ScriptType.GetHashCode();
		}
		num ^= questFlow_.GetHashCode();
		if (BGM.Length != 0)
		{
			num ^= BGM.GetHashCode();
		}
		if (LeaveTriggerEvent.Length != 0)
		{
			num ^= LeaveTriggerEvent.GetHashCode();
		}
		if (Theme != 0)
		{
			num ^= Theme.GetHashCode();
		}
		if (MonsterLv != 0)
		{
			num ^= MonsterLv.GetHashCode();
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
		if (ScriptType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ScriptType);
		}
		questFlow_.WriteTo(output, _repeated_questFlow_codec);
		if (BGM.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(BGM);
		}
		if (LeaveTriggerEvent.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(LeaveTriggerEvent);
		}
		if (Theme != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Theme);
		}
		if (MonsterLv != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(MonsterLv);
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
		if (ScriptType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ScriptType);
		}
		num += questFlow_.CalculateSize(_repeated_questFlow_codec);
		if (BGM.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BGM);
		}
		if (LeaveTriggerEvent.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LeaveTriggerEvent);
		}
		if (Theme != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Theme);
		}
		if (MonsterLv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterLv);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TutorialLevelFloor other)
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
			if (other.ScriptType != 0)
			{
				ScriptType = other.ScriptType;
			}
			questFlow_.Add(other.questFlow_);
			if (other.BGM.Length != 0)
			{
				BGM = other.BGM;
			}
			if (other.LeaveTriggerEvent.Length != 0)
			{
				LeaveTriggerEvent = other.LeaveTriggerEvent;
			}
			if (other.Theme != 0)
			{
				Theme = other.Theme;
			}
			if (other.MonsterLv != 0)
			{
				MonsterLv = other.MonsterLv;
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
				ScriptType = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				questFlow_.AddEntriesFrom(input, _repeated_questFlow_codec);
				break;
			case 50u:
				BGM = input.ReadString();
				break;
			case 58u:
				LeaveTriggerEvent = input.ReadString();
				break;
			case 64u:
				Theme = input.ReadInt32();
				break;
			case 72u:
				MonsterLv = input.ReadInt32();
				break;
			}
		}
	}
}
