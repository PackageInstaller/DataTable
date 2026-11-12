using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DailyInstanceFloor : IMessage<DailyInstanceFloor>, IMessage, IEquatable<DailyInstanceFloor>, IDeepCloneable<DailyInstanceFloor>
{
	private static readonly MessageParser<DailyInstanceFloor> _parser = new MessageParser<DailyInstanceFloor>(() => new DailyInstanceFloor());

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

	public const int MonsterIdFieldNumber = 7;

	private int monsterId_;

	public const int OneStarConditionFieldNumber = 8;

	private int oneStarCondition_;

	public const int TwoStarConditionFieldNumber = 9;

	private int twoStarCondition_;

	public const int ThreeStarConditionFieldNumber = 10;

	private int threeStarCondition_;

	public const int LevelTotalTimeFieldNumber = 11;

	private int levelTotalTime_;

	public const int TimeEndSettlementFieldNumber = 12;

	private bool timeEndSettlement_;

	public const int StarConditionTypeFieldNumber = 13;

	private int starConditionType_;

	public const int MonsterLvFieldNumber = 14;

	private int monsterLv_;

	public const int DropEntityGroupIdFieldNumber = 15;

	private int dropEntityGroupId_;

	public const int DropEntityRateFieldNumber = 16;

	private int dropEntityRate_;

	public const int DropMaxNumFieldNumber = 17;

	private int dropMaxNum_;

	public const int IntroCutsceneFieldNumber = 18;

	private string introCutscene_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<DailyInstanceFloor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(230);

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
	public int MonsterId
	{
		get
		{
			return monsterId_;
		}
		set
		{
			monsterId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int OneStarCondition
	{
		get
		{
			return oneStarCondition_;
		}
		set
		{
			oneStarCondition_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TwoStarCondition
	{
		get
		{
			return twoStarCondition_;
		}
		set
		{
			twoStarCondition_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ThreeStarCondition
	{
		get
		{
			return threeStarCondition_;
		}
		set
		{
			threeStarCondition_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LevelTotalTime
	{
		get
		{
			return levelTotalTime_;
		}
		set
		{
			levelTotalTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool TimeEndSettlement
	{
		get
		{
			return timeEndSettlement_;
		}
		set
		{
			timeEndSettlement_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int StarConditionType
	{
		get
		{
			return starConditionType_;
		}
		set
		{
			starConditionType_ = value;
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
	public int DropEntityGroupId
	{
		get
		{
			return dropEntityGroupId_;
		}
		set
		{
			dropEntityGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DropEntityRate
	{
		get
		{
			return dropEntityRate_;
		}
		set
		{
			dropEntityRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DropMaxNum
	{
		get
		{
			return dropMaxNum_;
		}
		set
		{
			dropMaxNum_ = value;
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
	public DailyInstanceFloor()
	{
	}

	[DebuggerNonUserCode]
	public DailyInstanceFloor(DailyInstanceFloor other)
		: this()
	{
		id_ = other.id_;
		sceneName_ = other.sceneName_;
		configPrefabName_ = other.configPrefabName_;
		theme_ = other.theme_;
		bGM_ = other.bGM_;
		leaveTriggerEvent_ = other.leaveTriggerEvent_;
		monsterId_ = other.monsterId_;
		oneStarCondition_ = other.oneStarCondition_;
		twoStarCondition_ = other.twoStarCondition_;
		threeStarCondition_ = other.threeStarCondition_;
		levelTotalTime_ = other.levelTotalTime_;
		timeEndSettlement_ = other.timeEndSettlement_;
		starConditionType_ = other.starConditionType_;
		monsterLv_ = other.monsterLv_;
		dropEntityGroupId_ = other.dropEntityGroupId_;
		dropEntityRate_ = other.dropEntityRate_;
		dropMaxNum_ = other.dropMaxNum_;
		introCutscene_ = other.introCutscene_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DailyInstanceFloor Clone()
	{
		return new DailyInstanceFloor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DailyInstanceFloor);
	}

	[DebuggerNonUserCode]
	public bool Equals(DailyInstanceFloor other)
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
		if (MonsterId != other.MonsterId)
		{
			return false;
		}
		if (OneStarCondition != other.OneStarCondition)
		{
			return false;
		}
		if (TwoStarCondition != other.TwoStarCondition)
		{
			return false;
		}
		if (ThreeStarCondition != other.ThreeStarCondition)
		{
			return false;
		}
		if (LevelTotalTime != other.LevelTotalTime)
		{
			return false;
		}
		if (TimeEndSettlement != other.TimeEndSettlement)
		{
			return false;
		}
		if (StarConditionType != other.StarConditionType)
		{
			return false;
		}
		if (MonsterLv != other.MonsterLv)
		{
			return false;
		}
		if (DropEntityGroupId != other.DropEntityGroupId)
		{
			return false;
		}
		if (DropEntityRate != other.DropEntityRate)
		{
			return false;
		}
		if (DropMaxNum != other.DropMaxNum)
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
		if (MonsterId != 0)
		{
			num ^= MonsterId.GetHashCode();
		}
		if (OneStarCondition != 0)
		{
			num ^= OneStarCondition.GetHashCode();
		}
		if (TwoStarCondition != 0)
		{
			num ^= TwoStarCondition.GetHashCode();
		}
		if (ThreeStarCondition != 0)
		{
			num ^= ThreeStarCondition.GetHashCode();
		}
		if (LevelTotalTime != 0)
		{
			num ^= LevelTotalTime.GetHashCode();
		}
		if (TimeEndSettlement)
		{
			num ^= TimeEndSettlement.GetHashCode();
		}
		if (StarConditionType != 0)
		{
			num ^= StarConditionType.GetHashCode();
		}
		if (MonsterLv != 0)
		{
			num ^= MonsterLv.GetHashCode();
		}
		if (DropEntityGroupId != 0)
		{
			num ^= DropEntityGroupId.GetHashCode();
		}
		if (DropEntityRate != 0)
		{
			num ^= DropEntityRate.GetHashCode();
		}
		if (DropMaxNum != 0)
		{
			num ^= DropMaxNum.GetHashCode();
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
		if (MonsterId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(MonsterId);
		}
		if (OneStarCondition != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(OneStarCondition);
		}
		if (TwoStarCondition != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(TwoStarCondition);
		}
		if (ThreeStarCondition != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(ThreeStarCondition);
		}
		if (LevelTotalTime != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(LevelTotalTime);
		}
		if (TimeEndSettlement)
		{
			output.WriteRawTag(96);
			output.WriteBool(TimeEndSettlement);
		}
		if (StarConditionType != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(StarConditionType);
		}
		if (MonsterLv != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(MonsterLv);
		}
		if (DropEntityGroupId != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(DropEntityGroupId);
		}
		if (DropEntityRate != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(DropEntityRate);
		}
		if (DropMaxNum != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(DropMaxNum);
		}
		if (IntroCutscene.Length != 0)
		{
			output.WriteRawTag(146, 1);
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
		if (MonsterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterId);
		}
		if (OneStarCondition != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OneStarCondition);
		}
		if (TwoStarCondition != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TwoStarCondition);
		}
		if (ThreeStarCondition != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ThreeStarCondition);
		}
		if (LevelTotalTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelTotalTime);
		}
		if (TimeEndSettlement)
		{
			num += 2;
		}
		if (StarConditionType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StarConditionType);
		}
		if (MonsterLv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterLv);
		}
		if (DropEntityGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DropEntityGroupId);
		}
		if (DropEntityRate != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DropEntityRate);
		}
		if (DropMaxNum != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DropMaxNum);
		}
		if (IntroCutscene.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(IntroCutscene);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DailyInstanceFloor other)
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
			if (other.MonsterId != 0)
			{
				MonsterId = other.MonsterId;
			}
			if (other.OneStarCondition != 0)
			{
				OneStarCondition = other.OneStarCondition;
			}
			if (other.TwoStarCondition != 0)
			{
				TwoStarCondition = other.TwoStarCondition;
			}
			if (other.ThreeStarCondition != 0)
			{
				ThreeStarCondition = other.ThreeStarCondition;
			}
			if (other.LevelTotalTime != 0)
			{
				LevelTotalTime = other.LevelTotalTime;
			}
			if (other.TimeEndSettlement)
			{
				TimeEndSettlement = other.TimeEndSettlement;
			}
			if (other.StarConditionType != 0)
			{
				StarConditionType = other.StarConditionType;
			}
			if (other.MonsterLv != 0)
			{
				MonsterLv = other.MonsterLv;
			}
			if (other.DropEntityGroupId != 0)
			{
				DropEntityGroupId = other.DropEntityGroupId;
			}
			if (other.DropEntityRate != 0)
			{
				DropEntityRate = other.DropEntityRate;
			}
			if (other.DropMaxNum != 0)
			{
				DropMaxNum = other.DropMaxNum;
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
				MonsterId = input.ReadInt32();
				break;
			case 64u:
				OneStarCondition = input.ReadInt32();
				break;
			case 72u:
				TwoStarCondition = input.ReadInt32();
				break;
			case 80u:
				ThreeStarCondition = input.ReadInt32();
				break;
			case 88u:
				LevelTotalTime = input.ReadInt32();
				break;
			case 96u:
				TimeEndSettlement = input.ReadBool();
				break;
			case 104u:
				StarConditionType = input.ReadInt32();
				break;
			case 112u:
				MonsterLv = input.ReadInt32();
				break;
			case 120u:
				DropEntityGroupId = input.ReadInt32();
				break;
			case 128u:
				DropEntityRate = input.ReadInt32();
				break;
			case 136u:
				DropMaxNum = input.ReadInt32();
				break;
			case 146u:
				IntroCutscene = input.ReadString();
				break;
			}
		}
	}
}
