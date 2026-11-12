using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierFloor : IMessage<SoldierFloor>, IMessage, IEquatable<SoldierFloor>, IDeepCloneable<SoldierFloor>
{
	private static readonly MessageParser<SoldierFloor> _parser = new MessageParser<SoldierFloor>(() => new SoldierFloor());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int DefaultFieldNumber = 2;

	private int default_;

	public const int BattleTimeFieldNumber = 3;

	private int battleTime_;

	public const int BothAddBuffFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_bothAddBuff_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> bothAddBuff_ = new RepeatedField<int>();

	public const int SceneNameFieldNumber = 5;

	private string sceneName_ = "";

	public const int ConfigPrefabNameFieldNumber = 6;

	private string configPrefabName_ = "";

	public const int MapPreviewFieldNumber = 7;

	private string mapPreview_ = "";

	public const int MonsterPreviewFieldNumber = 8;

	private string monsterPreview_ = "";

	public const int LevelScriptFieldNumber = 9;

	private string levelScript_ = "";

	public const int BGMFieldNumber = 10;

	private string bGM_ = "";

	public const int IntroCutsceneFieldNumber = 11;

	private string introCutscene_ = "";

	public const int IsDpsCheckStageFieldNumber = 12;

	private bool isDpsCheckStage_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierFloor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(764);

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
	public int Default
	{
		get
		{
			return default_;
		}
		set
		{
			default_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BattleTime
	{
		get
		{
			return battleTime_;
		}
		set
		{
			battleTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> BothAddBuff => bothAddBuff_;

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
	public string MapPreview
	{
		get
		{
			return mapPreview_;
		}
		set
		{
			mapPreview_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string MonsterPreview
	{
		get
		{
			return monsterPreview_;
		}
		set
		{
			monsterPreview_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public bool IsDpsCheckStage
	{
		get
		{
			return isDpsCheckStage_;
		}
		set
		{
			isDpsCheckStage_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierFloor()
	{
	}

	[DebuggerNonUserCode]
	public SoldierFloor(SoldierFloor other)
		: this()
	{
		id_ = other.id_;
		default_ = other.default_;
		battleTime_ = other.battleTime_;
		bothAddBuff_ = other.bothAddBuff_.Clone();
		sceneName_ = other.sceneName_;
		configPrefabName_ = other.configPrefabName_;
		mapPreview_ = other.mapPreview_;
		monsterPreview_ = other.monsterPreview_;
		levelScript_ = other.levelScript_;
		bGM_ = other.bGM_;
		introCutscene_ = other.introCutscene_;
		isDpsCheckStage_ = other.isDpsCheckStage_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierFloor Clone()
	{
		return new SoldierFloor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierFloor);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierFloor other)
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
		if (Default != other.Default)
		{
			return false;
		}
		if (BattleTime != other.BattleTime)
		{
			return false;
		}
		if (!bothAddBuff_.Equals(other.bothAddBuff_))
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
		if (MapPreview != other.MapPreview)
		{
			return false;
		}
		if (MonsterPreview != other.MonsterPreview)
		{
			return false;
		}
		if (LevelScript != other.LevelScript)
		{
			return false;
		}
		if (BGM != other.BGM)
		{
			return false;
		}
		if (IntroCutscene != other.IntroCutscene)
		{
			return false;
		}
		if (IsDpsCheckStage != other.IsDpsCheckStage)
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
		if (Default != 0)
		{
			num ^= Default.GetHashCode();
		}
		if (BattleTime != 0)
		{
			num ^= BattleTime.GetHashCode();
		}
		num ^= bothAddBuff_.GetHashCode();
		if (SceneName.Length != 0)
		{
			num ^= SceneName.GetHashCode();
		}
		if (ConfigPrefabName.Length != 0)
		{
			num ^= ConfigPrefabName.GetHashCode();
		}
		if (MapPreview.Length != 0)
		{
			num ^= MapPreview.GetHashCode();
		}
		if (MonsterPreview.Length != 0)
		{
			num ^= MonsterPreview.GetHashCode();
		}
		if (LevelScript.Length != 0)
		{
			num ^= LevelScript.GetHashCode();
		}
		if (BGM.Length != 0)
		{
			num ^= BGM.GetHashCode();
		}
		if (IntroCutscene.Length != 0)
		{
			num ^= IntroCutscene.GetHashCode();
		}
		if (IsDpsCheckStage)
		{
			num ^= IsDpsCheckStage.GetHashCode();
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
		if (Default != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Default);
		}
		if (BattleTime != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(BattleTime);
		}
		bothAddBuff_.WriteTo(output, _repeated_bothAddBuff_codec);
		if (SceneName.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(SceneName);
		}
		if (ConfigPrefabName.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(ConfigPrefabName);
		}
		if (MapPreview.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(MapPreview);
		}
		if (MonsterPreview.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(MonsterPreview);
		}
		if (LevelScript.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(LevelScript);
		}
		if (BGM.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(BGM);
		}
		if (IntroCutscene.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(IntroCutscene);
		}
		if (IsDpsCheckStage)
		{
			output.WriteRawTag(96);
			output.WriteBool(IsDpsCheckStage);
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
		if (Default != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Default);
		}
		if (BattleTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BattleTime);
		}
		num += bothAddBuff_.CalculateSize(_repeated_bothAddBuff_codec);
		if (SceneName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SceneName);
		}
		if (ConfigPrefabName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ConfigPrefabName);
		}
		if (MapPreview.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(MapPreview);
		}
		if (MonsterPreview.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(MonsterPreview);
		}
		if (LevelScript.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LevelScript);
		}
		if (BGM.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BGM);
		}
		if (IntroCutscene.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IntroCutscene);
		}
		if (IsDpsCheckStage)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierFloor other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Default != 0)
			{
				Default = other.Default;
			}
			if (other.BattleTime != 0)
			{
				BattleTime = other.BattleTime;
			}
			bothAddBuff_.Add(other.bothAddBuff_);
			if (other.SceneName.Length != 0)
			{
				SceneName = other.SceneName;
			}
			if (other.ConfigPrefabName.Length != 0)
			{
				ConfigPrefabName = other.ConfigPrefabName;
			}
			if (other.MapPreview.Length != 0)
			{
				MapPreview = other.MapPreview;
			}
			if (other.MonsterPreview.Length != 0)
			{
				MonsterPreview = other.MonsterPreview;
			}
			if (other.LevelScript.Length != 0)
			{
				LevelScript = other.LevelScript;
			}
			if (other.BGM.Length != 0)
			{
				BGM = other.BGM;
			}
			if (other.IntroCutscene.Length != 0)
			{
				IntroCutscene = other.IntroCutscene;
			}
			if (other.IsDpsCheckStage)
			{
				IsDpsCheckStage = other.IsDpsCheckStage;
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
				Default = input.ReadInt32();
				break;
			case 24u:
				BattleTime = input.ReadInt32();
				break;
			case 32u:
			case 34u:
				bothAddBuff_.AddEntriesFrom(input, _repeated_bothAddBuff_codec);
				break;
			case 42u:
				SceneName = input.ReadString();
				break;
			case 50u:
				ConfigPrefabName = input.ReadString();
				break;
			case 58u:
				MapPreview = input.ReadString();
				break;
			case 66u:
				MonsterPreview = input.ReadString();
				break;
			case 74u:
				LevelScript = input.ReadString();
				break;
			case 82u:
				BGM = input.ReadString();
				break;
			case 90u:
				IntroCutscene = input.ReadString();
				break;
			case 96u:
				IsDpsCheckStage = input.ReadBool();
				break;
			}
		}
	}
}
