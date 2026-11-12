using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class BreakOutFloor : IMessage<BreakOutFloor>, IMessage, IEquatable<BreakOutFloor>, IDeepCloneable<BreakOutFloor>
{
	private static readonly MessageParser<BreakOutFloor> _parser = new MessageParser<BreakOutFloor>(() => new BreakOutFloor());

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

	public const int TimeFieldNumber = 8;

	private int time_;

	public const int HeartFieldNumber = 9;

	private int heart_;

	public const int ScoreFieldNumber = 10;

	private int score_;

	public const int DropsFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_drops_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> drops_ = new RepeatedField<int>();

	public const int CountsFieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_counts_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> counts_ = new RepeatedField<int>();

	public const int DropParamFieldNumber = 13;

	private static readonly FieldCodec<int> _repeated_dropParam_codec = FieldCodec.ForInt32(106u);

	private readonly RepeatedField<int> dropParam_ = new RepeatedField<int>();

	public const int IntroCutsceneFieldNumber = 14;

	private string introCutscene_ = "";

	public const int DictionaryIDFieldNumber = 15;

	private int dictionaryID_;

	[DebuggerNonUserCode]
	public static MessageParser<BreakOutFloor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(138);

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
	public int Time
	{
		get
		{
			return time_;
		}
		set
		{
			time_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Heart
	{
		get
		{
			return heart_;
		}
		set
		{
			heart_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Score
	{
		get
		{
			return score_;
		}
		set
		{
			score_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Drops => drops_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Counts => counts_;

	[DebuggerNonUserCode]
	public RepeatedField<int> DropParam => dropParam_;

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
	public int DictionaryID
	{
		get
		{
			return dictionaryID_;
		}
		set
		{
			dictionaryID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public BreakOutFloor()
	{
	}

	[DebuggerNonUserCode]
	public BreakOutFloor(BreakOutFloor other)
		: this()
	{
		id_ = other.id_;
		sceneName_ = other.sceneName_;
		configPrefabName_ = other.configPrefabName_;
		theme_ = other.theme_;
		bGM_ = other.bGM_;
		leaveTriggerEvent_ = other.leaveTriggerEvent_;
		monsterLv_ = other.monsterLv_;
		time_ = other.time_;
		heart_ = other.heart_;
		score_ = other.score_;
		drops_ = other.drops_.Clone();
		counts_ = other.counts_.Clone();
		dropParam_ = other.dropParam_.Clone();
		introCutscene_ = other.introCutscene_;
		dictionaryID_ = other.dictionaryID_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public BreakOutFloor Clone()
	{
		return new BreakOutFloor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as BreakOutFloor);
	}

	[DebuggerNonUserCode]
	public bool Equals(BreakOutFloor other)
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
		if (Time != other.Time)
		{
			return false;
		}
		if (Heart != other.Heart)
		{
			return false;
		}
		if (Score != other.Score)
		{
			return false;
		}
		if (!drops_.Equals(other.drops_))
		{
			return false;
		}
		if (!counts_.Equals(other.counts_))
		{
			return false;
		}
		if (!dropParam_.Equals(other.dropParam_))
		{
			return false;
		}
		if (IntroCutscene != other.IntroCutscene)
		{
			return false;
		}
		if (DictionaryID != other.DictionaryID)
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
		if (Time != 0)
		{
			num ^= Time.GetHashCode();
		}
		if (Heart != 0)
		{
			num ^= Heart.GetHashCode();
		}
		if (Score != 0)
		{
			num ^= Score.GetHashCode();
		}
		num ^= drops_.GetHashCode();
		num ^= counts_.GetHashCode();
		num ^= dropParam_.GetHashCode();
		if (IntroCutscene.Length != 0)
		{
			num ^= IntroCutscene.GetHashCode();
		}
		if (DictionaryID != 0)
		{
			num ^= DictionaryID.GetHashCode();
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
		if (Time != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Time);
		}
		if (Heart != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Heart);
		}
		if (Score != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Score);
		}
		drops_.WriteTo(output, _repeated_drops_codec);
		counts_.WriteTo(output, _repeated_counts_codec);
		dropParam_.WriteTo(output, _repeated_dropParam_codec);
		if (IntroCutscene.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(IntroCutscene);
		}
		if (DictionaryID != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(DictionaryID);
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
		if (Time != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Time);
		}
		if (Heart != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Heart);
		}
		if (Score != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Score);
		}
		num += drops_.CalculateSize(_repeated_drops_codec);
		num += counts_.CalculateSize(_repeated_counts_codec);
		num += dropParam_.CalculateSize(_repeated_dropParam_codec);
		if (IntroCutscene.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IntroCutscene);
		}
		if (DictionaryID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DictionaryID);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(BreakOutFloor other)
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
			if (other.Time != 0)
			{
				Time = other.Time;
			}
			if (other.Heart != 0)
			{
				Heart = other.Heart;
			}
			if (other.Score != 0)
			{
				Score = other.Score;
			}
			drops_.Add(other.drops_);
			counts_.Add(other.counts_);
			dropParam_.Add(other.dropParam_);
			if (other.IntroCutscene.Length != 0)
			{
				IntroCutscene = other.IntroCutscene;
			}
			if (other.DictionaryID != 0)
			{
				DictionaryID = other.DictionaryID;
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
				Time = input.ReadInt32();
				break;
			case 72u:
				Heart = input.ReadInt32();
				break;
			case 80u:
				Score = input.ReadInt32();
				break;
			case 88u:
			case 90u:
				drops_.AddEntriesFrom(input, _repeated_drops_codec);
				break;
			case 96u:
			case 98u:
				counts_.AddEntriesFrom(input, _repeated_counts_codec);
				break;
			case 104u:
			case 106u:
				dropParam_.AddEntriesFrom(input, _repeated_dropParam_codec);
				break;
			case 114u:
				IntroCutscene = input.ReadString();
				break;
			case 120u:
				DictionaryID = input.ReadInt32();
				break;
			}
		}
	}
}
