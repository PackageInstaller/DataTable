using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TowerDefenseLevel : IMessage<TowerDefenseLevel>, IMessage, IEquatable<TowerDefenseLevel>, IDeepCloneable<TowerDefenseLevel>
{
	private static readonly MessageParser<TowerDefenseLevel> _parser = new MessageParser<TowerDefenseLevel>(() => new TowerDefenseLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ActivityIdFieldNumber = 2;

	private int activityId_;

	public const int ActiveTimeFieldNumber = 3;

	private int activeTime_;

	public const int LevelNameFieldNumber = 4;

	private string levelName_ = "";

	public const int LevelPageFieldNumber = 5;

	private int levelPage_;

	public const int LevelIconFieldNumber = 6;

	private string levelIcon_ = "";

	public const int LevelBgFieldNumber = 7;

	private string levelBg_ = "";

	public const int FloorIdFieldNumber = 8;

	private int floorId_;

	public const int PreLevelFieldNumber = 9;

	private int preLevel_;

	public const int SkipFieldNumber = 10;

	private bool skip_;

	public const int MonsterPreviewFieldNumber = 11;

	private int monsterPreview_;

	public const int Des1FieldNumber = 12;

	private string des1_ = "";

	public const int Des2FieldNumber = 13;

	private string des2_ = "";

	public const int Des3FieldNumber = 14;

	private string des3_ = "";

	public const int Condition1FieldNumber = 15;

	private int condition1_;

	public const int Condition2FieldNumber = 16;

	private int condition2_;

	public const int Condition3FieldNumber = 17;

	private int condition3_;

	public const int Item1FieldNumber = 18;

	private int item1_;

	public const int Qty1FieldNumber = 19;

	private int qty1_;

	public const int Item2FieldNumber = 20;

	private int item2_;

	public const int Qty2FieldNumber = 21;

	private int qty2_;

	public const int RewardPreviewFieldNumber = 22;

	private string rewardPreview_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<TowerDefenseLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(960);

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
	public int ActivityId
	{
		get
		{
			return activityId_;
		}
		set
		{
			activityId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ActiveTime
	{
		get
		{
			return activeTime_;
		}
		set
		{
			activeTime_ = value;
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
	public int LevelPage
	{
		get
		{
			return levelPage_;
		}
		set
		{
			levelPage_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string LevelIcon
	{
		get
		{
			return levelIcon_;
		}
		set
		{
			levelIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string LevelBg
	{
		get
		{
			return levelBg_;
		}
		set
		{
			levelBg_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int PreLevel
	{
		get
		{
			return preLevel_;
		}
		set
		{
			preLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Skip
	{
		get
		{
			return skip_;
		}
		set
		{
			skip_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MonsterPreview
	{
		get
		{
			return monsterPreview_;
		}
		set
		{
			monsterPreview_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Des1
	{
		get
		{
			return des1_;
		}
		set
		{
			des1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Des2
	{
		get
		{
			return des2_;
		}
		set
		{
			des2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Des3
	{
		get
		{
			return des3_;
		}
		set
		{
			des3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Condition1
	{
		get
		{
			return condition1_;
		}
		set
		{
			condition1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Condition2
	{
		get
		{
			return condition2_;
		}
		set
		{
			condition2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Condition3
	{
		get
		{
			return condition3_;
		}
		set
		{
			condition3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Item1
	{
		get
		{
			return item1_;
		}
		set
		{
			item1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty1
	{
		get
		{
			return qty1_;
		}
		set
		{
			qty1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Item2
	{
		get
		{
			return item2_;
		}
		set
		{
			item2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty2
	{
		get
		{
			return qty2_;
		}
		set
		{
			qty2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string RewardPreview
	{
		get
		{
			return rewardPreview_;
		}
		set
		{
			rewardPreview_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public TowerDefenseLevel()
	{
	}

	[DebuggerNonUserCode]
	public TowerDefenseLevel(TowerDefenseLevel other)
		: this()
	{
		id_ = other.id_;
		activityId_ = other.activityId_;
		activeTime_ = other.activeTime_;
		levelName_ = other.levelName_;
		levelPage_ = other.levelPage_;
		levelIcon_ = other.levelIcon_;
		levelBg_ = other.levelBg_;
		floorId_ = other.floorId_;
		preLevel_ = other.preLevel_;
		skip_ = other.skip_;
		monsterPreview_ = other.monsterPreview_;
		des1_ = other.des1_;
		des2_ = other.des2_;
		des3_ = other.des3_;
		condition1_ = other.condition1_;
		condition2_ = other.condition2_;
		condition3_ = other.condition3_;
		item1_ = other.item1_;
		qty1_ = other.qty1_;
		item2_ = other.item2_;
		qty2_ = other.qty2_;
		rewardPreview_ = other.rewardPreview_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TowerDefenseLevel Clone()
	{
		return new TowerDefenseLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TowerDefenseLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(TowerDefenseLevel other)
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
		if (ActivityId != other.ActivityId)
		{
			return false;
		}
		if (ActiveTime != other.ActiveTime)
		{
			return false;
		}
		if (LevelName != other.LevelName)
		{
			return false;
		}
		if (LevelPage != other.LevelPage)
		{
			return false;
		}
		if (LevelIcon != other.LevelIcon)
		{
			return false;
		}
		if (LevelBg != other.LevelBg)
		{
			return false;
		}
		if (FloorId != other.FloorId)
		{
			return false;
		}
		if (PreLevel != other.PreLevel)
		{
			return false;
		}
		if (Skip != other.Skip)
		{
			return false;
		}
		if (MonsterPreview != other.MonsterPreview)
		{
			return false;
		}
		if (Des1 != other.Des1)
		{
			return false;
		}
		if (Des2 != other.Des2)
		{
			return false;
		}
		if (Des3 != other.Des3)
		{
			return false;
		}
		if (Condition1 != other.Condition1)
		{
			return false;
		}
		if (Condition2 != other.Condition2)
		{
			return false;
		}
		if (Condition3 != other.Condition3)
		{
			return false;
		}
		if (Item1 != other.Item1)
		{
			return false;
		}
		if (Qty1 != other.Qty1)
		{
			return false;
		}
		if (Item2 != other.Item2)
		{
			return false;
		}
		if (Qty2 != other.Qty2)
		{
			return false;
		}
		if (RewardPreview != other.RewardPreview)
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
		if (ActivityId != 0)
		{
			num ^= ActivityId.GetHashCode();
		}
		if (ActiveTime != 0)
		{
			num ^= ActiveTime.GetHashCode();
		}
		if (LevelName.Length != 0)
		{
			num ^= LevelName.GetHashCode();
		}
		if (LevelPage != 0)
		{
			num ^= LevelPage.GetHashCode();
		}
		if (LevelIcon.Length != 0)
		{
			num ^= LevelIcon.GetHashCode();
		}
		if (LevelBg.Length != 0)
		{
			num ^= LevelBg.GetHashCode();
		}
		if (FloorId != 0)
		{
			num ^= FloorId.GetHashCode();
		}
		if (PreLevel != 0)
		{
			num ^= PreLevel.GetHashCode();
		}
		if (Skip)
		{
			num ^= Skip.GetHashCode();
		}
		if (MonsterPreview != 0)
		{
			num ^= MonsterPreview.GetHashCode();
		}
		if (Des1.Length != 0)
		{
			num ^= Des1.GetHashCode();
		}
		if (Des2.Length != 0)
		{
			num ^= Des2.GetHashCode();
		}
		if (Des3.Length != 0)
		{
			num ^= Des3.GetHashCode();
		}
		if (Condition1 != 0)
		{
			num ^= Condition1.GetHashCode();
		}
		if (Condition2 != 0)
		{
			num ^= Condition2.GetHashCode();
		}
		if (Condition3 != 0)
		{
			num ^= Condition3.GetHashCode();
		}
		if (Item1 != 0)
		{
			num ^= Item1.GetHashCode();
		}
		if (Qty1 != 0)
		{
			num ^= Qty1.GetHashCode();
		}
		if (Item2 != 0)
		{
			num ^= Item2.GetHashCode();
		}
		if (Qty2 != 0)
		{
			num ^= Qty2.GetHashCode();
		}
		if (RewardPreview.Length != 0)
		{
			num ^= RewardPreview.GetHashCode();
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
		if (ActivityId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ActivityId);
		}
		if (ActiveTime != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ActiveTime);
		}
		if (LevelName.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(LevelName);
		}
		if (LevelPage != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(LevelPage);
		}
		if (LevelIcon.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(LevelIcon);
		}
		if (LevelBg.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(LevelBg);
		}
		if (FloorId != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(FloorId);
		}
		if (PreLevel != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(PreLevel);
		}
		if (Skip)
		{
			output.WriteRawTag(80);
			output.WriteBool(Skip);
		}
		if (MonsterPreview != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(MonsterPreview);
		}
		if (Des1.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(Des1);
		}
		if (Des2.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(Des2);
		}
		if (Des3.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(Des3);
		}
		if (Condition1 != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(Condition1);
		}
		if (Condition2 != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(Condition2);
		}
		if (Condition3 != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(Condition3);
		}
		if (Item1 != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(Item1);
		}
		if (Qty1 != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(Qty1);
		}
		if (Item2 != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(Item2);
		}
		if (Qty2 != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(Qty2);
		}
		if (RewardPreview.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(RewardPreview);
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
		if (ActivityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityId);
		}
		if (ActiveTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActiveTime);
		}
		if (LevelName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LevelName);
		}
		if (LevelPage != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelPage);
		}
		if (LevelIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LevelIcon);
		}
		if (LevelBg.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LevelBg);
		}
		if (FloorId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorId);
		}
		if (PreLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevel);
		}
		if (Skip)
		{
			num += 2;
		}
		if (MonsterPreview != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterPreview);
		}
		if (Des1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Des1);
		}
		if (Des2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Des2);
		}
		if (Des3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Des3);
		}
		if (Condition1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Condition1);
		}
		if (Condition2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Condition2);
		}
		if (Condition3 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Condition3);
		}
		if (Item1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Item1);
		}
		if (Qty1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Qty1);
		}
		if (Item2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Item2);
		}
		if (Qty2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Qty2);
		}
		if (RewardPreview.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(RewardPreview);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TowerDefenseLevel other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			if (other.ActiveTime != 0)
			{
				ActiveTime = other.ActiveTime;
			}
			if (other.LevelName.Length != 0)
			{
				LevelName = other.LevelName;
			}
			if (other.LevelPage != 0)
			{
				LevelPage = other.LevelPage;
			}
			if (other.LevelIcon.Length != 0)
			{
				LevelIcon = other.LevelIcon;
			}
			if (other.LevelBg.Length != 0)
			{
				LevelBg = other.LevelBg;
			}
			if (other.FloorId != 0)
			{
				FloorId = other.FloorId;
			}
			if (other.PreLevel != 0)
			{
				PreLevel = other.PreLevel;
			}
			if (other.Skip)
			{
				Skip = other.Skip;
			}
			if (other.MonsterPreview != 0)
			{
				MonsterPreview = other.MonsterPreview;
			}
			if (other.Des1.Length != 0)
			{
				Des1 = other.Des1;
			}
			if (other.Des2.Length != 0)
			{
				Des2 = other.Des2;
			}
			if (other.Des3.Length != 0)
			{
				Des3 = other.Des3;
			}
			if (other.Condition1 != 0)
			{
				Condition1 = other.Condition1;
			}
			if (other.Condition2 != 0)
			{
				Condition2 = other.Condition2;
			}
			if (other.Condition3 != 0)
			{
				Condition3 = other.Condition3;
			}
			if (other.Item1 != 0)
			{
				Item1 = other.Item1;
			}
			if (other.Qty1 != 0)
			{
				Qty1 = other.Qty1;
			}
			if (other.Item2 != 0)
			{
				Item2 = other.Item2;
			}
			if (other.Qty2 != 0)
			{
				Qty2 = other.Qty2;
			}
			if (other.RewardPreview.Length != 0)
			{
				RewardPreview = other.RewardPreview;
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
				ActivityId = input.ReadInt32();
				break;
			case 24u:
				ActiveTime = input.ReadInt32();
				break;
			case 34u:
				LevelName = input.ReadString();
				break;
			case 40u:
				LevelPage = input.ReadInt32();
				break;
			case 50u:
				LevelIcon = input.ReadString();
				break;
			case 58u:
				LevelBg = input.ReadString();
				break;
			case 64u:
				FloorId = input.ReadInt32();
				break;
			case 72u:
				PreLevel = input.ReadInt32();
				break;
			case 80u:
				Skip = input.ReadBool();
				break;
			case 88u:
				MonsterPreview = input.ReadInt32();
				break;
			case 98u:
				Des1 = input.ReadString();
				break;
			case 106u:
				Des2 = input.ReadString();
				break;
			case 114u:
				Des3 = input.ReadString();
				break;
			case 120u:
				Condition1 = input.ReadInt32();
				break;
			case 128u:
				Condition2 = input.ReadInt32();
				break;
			case 136u:
				Condition3 = input.ReadInt32();
				break;
			case 144u:
				Item1 = input.ReadInt32();
				break;
			case 152u:
				Qty1 = input.ReadInt32();
				break;
			case 160u:
				Item2 = input.ReadInt32();
				break;
			case 168u:
				Qty2 = input.ReadInt32();
				break;
			case 178u:
				RewardPreview = input.ReadString();
				break;
			}
		}
	}
}
