using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GoldenSpyLevel : IMessage<GoldenSpyLevel>, IMessage, IEquatable<GoldenSpyLevel>, IDeepCloneable<GoldenSpyLevel>
{
	private static readonly MessageParser<GoldenSpyLevel> _parser = new MessageParser<GoldenSpyLevel>(() => new GoldenSpyLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int LevelTypeFieldNumber = 2;

	private int levelType_;

	public const int LevelNameFieldNumber = 3;

	private string levelName_ = "";

	public const int ConfigIdFieldNumber = 4;

	private int configId_;

	public const int IconPathFieldNumber = 5;

	private string iconPath_ = "";

	public const int FloorListFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_floorList_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> floorList_ = new RepeatedField<int>();

	public const int RandomFloorIdFieldNumber = 7;

	private string randomFloorId_ = "";

	public const int PreLevelIdFieldNumber = 8;

	private int preLevelId_;

	public const int ScoreFieldNumber = 9;

	private int score_;

	public const int WinCondDescFieldNumber = 10;

	private string winCondDesc_ = "";

	public const int BuffCardPoolIdFieldNumber = 11;

	private int buffCardPoolId_;

	public const int BuffRefeshCountFieldNumber = 12;

	private int buffRefeshCount_;

	public const int LevelDescFieldNumber = 13;

	private string levelDesc_ = "";

	public const int SkillFieldNumber = 14;

	private string skill_ = "";

	public const int Item1IdFieldNumber = 15;

	private int item1Id_;

	public const int Item1CountFieldNumber = 16;

	private int item1Count_;

	public const int Item2IdFieldNumber = 17;

	private int item2Id_;

	public const int Item2CountFieldNumber = 18;

	private int item2Count_;

	public const int Param1FieldNumber = 19;

	private string param1_ = "";

	public const int Param2FieldNumber = 20;

	private string param2_ = "";

	public const int Param3FieldNumber = 21;

	private string param3_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<GoldenSpyLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(402);

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
	public int LevelType
	{
		get
		{
			return levelType_;
		}
		set
		{
			levelType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string LevelName
	{
		get
		{
			return levelName_;
		}
		set
		{
			levelName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ConfigId
	{
		get
		{
			return configId_;
		}
		set
		{
			configId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string IconPath
	{
		get
		{
			return iconPath_;
		}
		set
		{
			iconPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> FloorList => floorList_;

	[DebuggerNonUserCode]
	public string RandomFloorId
	{
		get
		{
			return randomFloorId_;
		}
		set
		{
			randomFloorId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int PreLevelId
	{
		get
		{
			return preLevelId_;
		}
		set
		{
			preLevelId_ = value;
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
	public string WinCondDesc
	{
		get
		{
			return winCondDesc_;
		}
		set
		{
			winCondDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int BuffCardPoolId
	{
		get
		{
			return buffCardPoolId_;
		}
		set
		{
			buffCardPoolId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BuffRefeshCount
	{
		get
		{
			return buffRefeshCount_;
		}
		set
		{
			buffRefeshCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string LevelDesc
	{
		get
		{
			return levelDesc_;
		}
		set
		{
			levelDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Skill
	{
		get
		{
			return skill_;
		}
		set
		{
			skill_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Item1Id
	{
		get
		{
			return item1Id_;
		}
		set
		{
			item1Id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Item1Count
	{
		get
		{
			return item1Count_;
		}
		set
		{
			item1Count_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Item2Id
	{
		get
		{
			return item2Id_;
		}
		set
		{
			item2Id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Item2Count
	{
		get
		{
			return item2Count_;
		}
		set
		{
			item2Count_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Param1
	{
		get
		{
			return param1_;
		}
		set
		{
			param1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param2
	{
		get
		{
			return param2_;
		}
		set
		{
			param2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param3
	{
		get
		{
			return param3_;
		}
		set
		{
			param3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public GoldenSpyLevel()
	{
	}

	[DebuggerNonUserCode]
	public GoldenSpyLevel(GoldenSpyLevel other)
		: this()
	{
		id_ = other.id_;
		levelType_ = other.levelType_;
		levelName_ = other.levelName_;
		configId_ = other.configId_;
		iconPath_ = other.iconPath_;
		floorList_ = other.floorList_.Clone();
		randomFloorId_ = other.randomFloorId_;
		preLevelId_ = other.preLevelId_;
		score_ = other.score_;
		winCondDesc_ = other.winCondDesc_;
		buffCardPoolId_ = other.buffCardPoolId_;
		buffRefeshCount_ = other.buffRefeshCount_;
		levelDesc_ = other.levelDesc_;
		skill_ = other.skill_;
		item1Id_ = other.item1Id_;
		item1Count_ = other.item1Count_;
		item2Id_ = other.item2Id_;
		item2Count_ = other.item2Count_;
		param1_ = other.param1_;
		param2_ = other.param2_;
		param3_ = other.param3_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GoldenSpyLevel Clone()
	{
		return new GoldenSpyLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GoldenSpyLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(GoldenSpyLevel other)
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
		if (LevelType != other.LevelType)
		{
			return false;
		}
		if (LevelName != other.LevelName)
		{
			return false;
		}
		if (ConfigId != other.ConfigId)
		{
			return false;
		}
		if (IconPath != other.IconPath)
		{
			return false;
		}
		if (!floorList_.Equals(other.floorList_))
		{
			return false;
		}
		if (RandomFloorId != other.RandomFloorId)
		{
			return false;
		}
		if (PreLevelId != other.PreLevelId)
		{
			return false;
		}
		if (Score != other.Score)
		{
			return false;
		}
		if (WinCondDesc != other.WinCondDesc)
		{
			return false;
		}
		if (BuffCardPoolId != other.BuffCardPoolId)
		{
			return false;
		}
		if (BuffRefeshCount != other.BuffRefeshCount)
		{
			return false;
		}
		if (LevelDesc != other.LevelDesc)
		{
			return false;
		}
		if (Skill != other.Skill)
		{
			return false;
		}
		if (Item1Id != other.Item1Id)
		{
			return false;
		}
		if (Item1Count != other.Item1Count)
		{
			return false;
		}
		if (Item2Id != other.Item2Id)
		{
			return false;
		}
		if (Item2Count != other.Item2Count)
		{
			return false;
		}
		if (Param1 != other.Param1)
		{
			return false;
		}
		if (Param2 != other.Param2)
		{
			return false;
		}
		if (Param3 != other.Param3)
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
		if (LevelType != 0)
		{
			num ^= LevelType.GetHashCode();
		}
		if (LevelName.Length != 0)
		{
			num ^= LevelName.GetHashCode();
		}
		if (ConfigId != 0)
		{
			num ^= ConfigId.GetHashCode();
		}
		if (IconPath.Length != 0)
		{
			num ^= IconPath.GetHashCode();
		}
		num ^= floorList_.GetHashCode();
		if (RandomFloorId.Length != 0)
		{
			num ^= RandomFloorId.GetHashCode();
		}
		if (PreLevelId != 0)
		{
			num ^= PreLevelId.GetHashCode();
		}
		if (Score != 0)
		{
			num ^= Score.GetHashCode();
		}
		if (WinCondDesc.Length != 0)
		{
			num ^= WinCondDesc.GetHashCode();
		}
		if (BuffCardPoolId != 0)
		{
			num ^= BuffCardPoolId.GetHashCode();
		}
		if (BuffRefeshCount != 0)
		{
			num ^= BuffRefeshCount.GetHashCode();
		}
		if (LevelDesc.Length != 0)
		{
			num ^= LevelDesc.GetHashCode();
		}
		if (Skill.Length != 0)
		{
			num ^= Skill.GetHashCode();
		}
		if (Item1Id != 0)
		{
			num ^= Item1Id.GetHashCode();
		}
		if (Item1Count != 0)
		{
			num ^= Item1Count.GetHashCode();
		}
		if (Item2Id != 0)
		{
			num ^= Item2Id.GetHashCode();
		}
		if (Item2Count != 0)
		{
			num ^= Item2Count.GetHashCode();
		}
		if (Param1.Length != 0)
		{
			num ^= Param1.GetHashCode();
		}
		if (Param2.Length != 0)
		{
			num ^= Param2.GetHashCode();
		}
		if (Param3.Length != 0)
		{
			num ^= Param3.GetHashCode();
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
		if (LevelType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(LevelType);
		}
		if (LevelName.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(LevelName);
		}
		if (ConfigId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ConfigId);
		}
		if (IconPath.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(IconPath);
		}
		floorList_.WriteTo(output, _repeated_floorList_codec);
		if (RandomFloorId.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(RandomFloorId);
		}
		if (PreLevelId != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(PreLevelId);
		}
		if (Score != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Score);
		}
		if (WinCondDesc.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(WinCondDesc);
		}
		if (BuffCardPoolId != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(BuffCardPoolId);
		}
		if (BuffRefeshCount != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(BuffRefeshCount);
		}
		if (LevelDesc.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(LevelDesc);
		}
		if (Skill.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(Skill);
		}
		if (Item1Id != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(Item1Id);
		}
		if (Item1Count != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(Item1Count);
		}
		if (Item2Id != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(Item2Id);
		}
		if (Item2Count != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(Item2Count);
		}
		if (Param1.Length != 0)
		{
			output.WriteRawTag(154, 1);
			output.WriteString(Param1);
		}
		if (Param2.Length != 0)
		{
			output.WriteRawTag(162, 1);
			output.WriteString(Param2);
		}
		if (Param3.Length != 0)
		{
			output.WriteRawTag(170, 1);
			output.WriteString(Param3);
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
		if (LevelType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelType);
		}
		if (LevelName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LevelName);
		}
		if (ConfigId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ConfigId);
		}
		if (IconPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconPath);
		}
		num += floorList_.CalculateSize(_repeated_floorList_codec);
		if (RandomFloorId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RandomFloorId);
		}
		if (PreLevelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevelId);
		}
		if (Score != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Score);
		}
		if (WinCondDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(WinCondDesc);
		}
		if (BuffCardPoolId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuffCardPoolId);
		}
		if (BuffRefeshCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuffRefeshCount);
		}
		if (LevelDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LevelDesc);
		}
		if (Skill.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Skill);
		}
		if (Item1Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Item1Id);
		}
		if (Item1Count != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Item1Count);
		}
		if (Item2Id != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Item2Id);
		}
		if (Item2Count != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Item2Count);
		}
		if (Param1.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param1);
		}
		if (Param2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param2);
		}
		if (Param3.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param3);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(GoldenSpyLevel other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.LevelType != 0)
			{
				LevelType = other.LevelType;
			}
			if (other.LevelName.Length != 0)
			{
				LevelName = other.LevelName;
			}
			if (other.ConfigId != 0)
			{
				ConfigId = other.ConfigId;
			}
			if (other.IconPath.Length != 0)
			{
				IconPath = other.IconPath;
			}
			floorList_.Add(other.floorList_);
			if (other.RandomFloorId.Length != 0)
			{
				RandomFloorId = other.RandomFloorId;
			}
			if (other.PreLevelId != 0)
			{
				PreLevelId = other.PreLevelId;
			}
			if (other.Score != 0)
			{
				Score = other.Score;
			}
			if (other.WinCondDesc.Length != 0)
			{
				WinCondDesc = other.WinCondDesc;
			}
			if (other.BuffCardPoolId != 0)
			{
				BuffCardPoolId = other.BuffCardPoolId;
			}
			if (other.BuffRefeshCount != 0)
			{
				BuffRefeshCount = other.BuffRefeshCount;
			}
			if (other.LevelDesc.Length != 0)
			{
				LevelDesc = other.LevelDesc;
			}
			if (other.Skill.Length != 0)
			{
				Skill = other.Skill;
			}
			if (other.Item1Id != 0)
			{
				Item1Id = other.Item1Id;
			}
			if (other.Item1Count != 0)
			{
				Item1Count = other.Item1Count;
			}
			if (other.Item2Id != 0)
			{
				Item2Id = other.Item2Id;
			}
			if (other.Item2Count != 0)
			{
				Item2Count = other.Item2Count;
			}
			if (other.Param1.Length != 0)
			{
				Param1 = other.Param1;
			}
			if (other.Param2.Length != 0)
			{
				Param2 = other.Param2;
			}
			if (other.Param3.Length != 0)
			{
				Param3 = other.Param3;
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
				LevelType = input.ReadInt32();
				break;
			case 26u:
				LevelName = input.ReadString();
				break;
			case 32u:
				ConfigId = input.ReadInt32();
				break;
			case 42u:
				IconPath = input.ReadString();
				break;
			case 48u:
			case 50u:
				floorList_.AddEntriesFrom(input, _repeated_floorList_codec);
				break;
			case 58u:
				RandomFloorId = input.ReadString();
				break;
			case 64u:
				PreLevelId = input.ReadInt32();
				break;
			case 72u:
				Score = input.ReadInt32();
				break;
			case 82u:
				WinCondDesc = input.ReadString();
				break;
			case 88u:
				BuffCardPoolId = input.ReadInt32();
				break;
			case 96u:
				BuffRefeshCount = input.ReadInt32();
				break;
			case 106u:
				LevelDesc = input.ReadString();
				break;
			case 114u:
				Skill = input.ReadString();
				break;
			case 120u:
				Item1Id = input.ReadInt32();
				break;
			case 128u:
				Item1Count = input.ReadInt32();
				break;
			case 136u:
				Item2Id = input.ReadInt32();
				break;
			case 144u:
				Item2Count = input.ReadInt32();
				break;
			case 154u:
				Param1 = input.ReadString();
				break;
			case 162u:
				Param2 = input.ReadString();
				break;
			case 170u:
				Param3 = input.ReadString();
				break;
			}
		}
	}
}
