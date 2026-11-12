using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TrialFloor : IMessage<TrialFloor>, IMessage, IEquatable<TrialFloor>, IDeepCloneable<TrialFloor>
{
	private static readonly MessageParser<TrialFloor> _parser = new MessageParser<TrialFloor>(() => new TrialFloor());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TrialCharFieldNumber = 2;

	private int trialChar_;

	public const int TrialSectTypeFieldNumber = 3;

	private int trialSectType_;

	public const int SceneNameFieldNumber = 4;

	private string sceneName_ = "";

	public const int ConfigPrefabNameFieldNumber = 5;

	private string configPrefabName_ = "";

	public const int TrialBuildFieldNumber = 6;

	private int trialBuild_;

	public const int QuestFlowFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_questFlow_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> questFlow_ = new RepeatedField<int>();

	public const int BGMFieldNumber = 8;

	private string bGM_ = "";

	public const int LeaveTriggerEventFieldNumber = 9;

	private string leaveTriggerEvent_ = "";

	public const int DungeonDelayFieldNumber = 10;

	private int dungeonDelay_;

	public const int ThemeFieldNumber = 11;

	private int theme_;

	public const int MonsterLvFieldNumber = 12;

	private int monsterLv_;

	[DebuggerNonUserCode]
	public static MessageParser<TrialFloor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1034);

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
	public int TrialChar
	{
		get
		{
			return trialChar_;
		}
		set
		{
			trialChar_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TrialSectType
	{
		get
		{
			return trialSectType_;
		}
		set
		{
			trialSectType_ = value;
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
	public int TrialBuild
	{
		get
		{
			return trialBuild_;
		}
		set
		{
			trialBuild_ = value;
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
	public TrialFloor()
	{
	}

	[DebuggerNonUserCode]
	public TrialFloor(TrialFloor other)
		: this()
	{
		id_ = other.id_;
		trialChar_ = other.trialChar_;
		trialSectType_ = other.trialSectType_;
		sceneName_ = other.sceneName_;
		configPrefabName_ = other.configPrefabName_;
		trialBuild_ = other.trialBuild_;
		questFlow_ = other.questFlow_.Clone();
		bGM_ = other.bGM_;
		leaveTriggerEvent_ = other.leaveTriggerEvent_;
		dungeonDelay_ = other.dungeonDelay_;
		theme_ = other.theme_;
		monsterLv_ = other.monsterLv_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TrialFloor Clone()
	{
		return new TrialFloor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TrialFloor);
	}

	[DebuggerNonUserCode]
	public bool Equals(TrialFloor other)
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
		if (TrialChar != other.TrialChar)
		{
			return false;
		}
		if (TrialSectType != other.TrialSectType)
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
		if (TrialBuild != other.TrialBuild)
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
		if (DungeonDelay != other.DungeonDelay)
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
		if (TrialChar != 0)
		{
			num ^= TrialChar.GetHashCode();
		}
		if (TrialSectType != 0)
		{
			num ^= TrialSectType.GetHashCode();
		}
		if (SceneName.Length != 0)
		{
			num ^= SceneName.GetHashCode();
		}
		if (ConfigPrefabName.Length != 0)
		{
			num ^= ConfigPrefabName.GetHashCode();
		}
		if (TrialBuild != 0)
		{
			num ^= TrialBuild.GetHashCode();
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
		if (DungeonDelay != 0)
		{
			num ^= DungeonDelay.GetHashCode();
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
		if (TrialChar != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(TrialChar);
		}
		if (TrialSectType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(TrialSectType);
		}
		if (SceneName.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(SceneName);
		}
		if (ConfigPrefabName.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(ConfigPrefabName);
		}
		if (TrialBuild != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(TrialBuild);
		}
		questFlow_.WriteTo(output, _repeated_questFlow_codec);
		if (BGM.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(BGM);
		}
		if (LeaveTriggerEvent.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(LeaveTriggerEvent);
		}
		if (DungeonDelay != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(DungeonDelay);
		}
		if (Theme != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(Theme);
		}
		if (MonsterLv != 0)
		{
			output.WriteRawTag(96);
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
		if (TrialChar != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TrialChar);
		}
		if (TrialSectType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TrialSectType);
		}
		if (SceneName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SceneName);
		}
		if (ConfigPrefabName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ConfigPrefabName);
		}
		if (TrialBuild != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TrialBuild);
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
		if (DungeonDelay != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DungeonDelay);
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
	public void MergeFrom(TrialFloor other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.TrialChar != 0)
			{
				TrialChar = other.TrialChar;
			}
			if (other.TrialSectType != 0)
			{
				TrialSectType = other.TrialSectType;
			}
			if (other.SceneName.Length != 0)
			{
				SceneName = other.SceneName;
			}
			if (other.ConfigPrefabName.Length != 0)
			{
				ConfigPrefabName = other.ConfigPrefabName;
			}
			if (other.TrialBuild != 0)
			{
				TrialBuild = other.TrialBuild;
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
			if (other.DungeonDelay != 0)
			{
				DungeonDelay = other.DungeonDelay;
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
			case 16u:
				TrialChar = input.ReadInt32();
				break;
			case 24u:
				TrialSectType = input.ReadInt32();
				break;
			case 34u:
				SceneName = input.ReadString();
				break;
			case 42u:
				ConfigPrefabName = input.ReadString();
				break;
			case 48u:
				TrialBuild = input.ReadInt32();
				break;
			case 56u:
			case 58u:
				questFlow_.AddEntriesFrom(input, _repeated_questFlow_codec);
				break;
			case 66u:
				BGM = input.ReadString();
				break;
			case 74u:
				LeaveTriggerEvent = input.ReadString();
				break;
			case 80u:
				DungeonDelay = input.ReadInt32();
				break;
			case 88u:
				Theme = input.ReadInt32();
				break;
			case 96u:
				MonsterLv = input.ReadInt32();
				break;
			}
		}
	}
}
