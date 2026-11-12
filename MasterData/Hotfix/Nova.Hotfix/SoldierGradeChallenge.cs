using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierGradeChallenge : IMessage<SoldierGradeChallenge>, IMessage, IEquatable<SoldierGradeChallenge>, IDeepCloneable<SoldierGradeChallenge>
{
	private static readonly MessageParser<SoldierGradeChallenge> _parser = new MessageParser<SoldierGradeChallenge>(() => new SoldierGradeChallenge());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int SeasonFieldNumber = 2;

	private int season_;

	public const int KeyGradeIdFieldNumber = 3;

	private int keyGradeId_;

	public const int GradeLevelFieldNumber = 4;

	private int gradeLevel_;

	public const int GradeScoreFieldNumber = 5;

	private int gradeScore_;

	public const int NameFieldNumber = 6;

	private string name_ = "";

	public const int IconFieldNumber = 7;

	private string icon_ = "";

	public const int OppoLevelShowFieldNumber = 8;

	private int oppoLevelShow_;

	public const int DiffcultyTemplateLvFieldNumber = 9;

	private int diffcultyTemplateLv_;

	public const int AdjustmentGradeFieldNumber = 10;

	private int adjustmentGrade_;

	public const int AffixCountFieldNumber = 11;

	private int affixCount_;

	public const int AffixGroupIdFieldNumber = 12;

	private int affixGroupId_;

	public const int NodeGroupIdFieldNumber = 13;

	private int nodeGroupId_;

	public const int InitialHpFieldNumber = 14;

	private int initialHp_;

	public const int ScoreFieldNumber = 15;

	private int score_;

	public const int TechPointFieldNumber = 16;

	private int techPoint_;

	public const int CheckStageGroupIdFieldNumber = 17;

	private int checkStageGroupId_;

	public const int OppoAttrAddShowFieldNumber = 18;

	private string oppoAttrAddShow_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<SoldierGradeChallenge> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(766);

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
	public int Season
	{
		get
		{
			return season_;
		}
		set
		{
			season_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int KeyGradeId
	{
		get
		{
			return keyGradeId_;
		}
		set
		{
			keyGradeId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GradeLevel
	{
		get
		{
			return gradeLevel_;
		}
		set
		{
			gradeLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GradeScore
	{
		get
		{
			return gradeScore_;
		}
		set
		{
			gradeScore_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int OppoLevelShow
	{
		get
		{
			return oppoLevelShow_;
		}
		set
		{
			oppoLevelShow_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DiffcultyTemplateLv
	{
		get
		{
			return diffcultyTemplateLv_;
		}
		set
		{
			diffcultyTemplateLv_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AdjustmentGrade
	{
		get
		{
			return adjustmentGrade_;
		}
		set
		{
			adjustmentGrade_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AffixCount
	{
		get
		{
			return affixCount_;
		}
		set
		{
			affixCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AffixGroupId
	{
		get
		{
			return affixGroupId_;
		}
		set
		{
			affixGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NodeGroupId
	{
		get
		{
			return nodeGroupId_;
		}
		set
		{
			nodeGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int InitialHp
	{
		get
		{
			return initialHp_;
		}
		set
		{
			initialHp_ = value;
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
	public int TechPoint
	{
		get
		{
			return techPoint_;
		}
		set
		{
			techPoint_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CheckStageGroupId
	{
		get
		{
			return checkStageGroupId_;
		}
		set
		{
			checkStageGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string OppoAttrAddShow
	{
		get
		{
			return oppoAttrAddShow_;
		}
		set
		{
			oppoAttrAddShow_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public SoldierGradeChallenge()
	{
	}

	[DebuggerNonUserCode]
	public SoldierGradeChallenge(SoldierGradeChallenge other)
		: this()
	{
		id_ = other.id_;
		season_ = other.season_;
		keyGradeId_ = other.keyGradeId_;
		gradeLevel_ = other.gradeLevel_;
		gradeScore_ = other.gradeScore_;
		name_ = other.name_;
		icon_ = other.icon_;
		oppoLevelShow_ = other.oppoLevelShow_;
		diffcultyTemplateLv_ = other.diffcultyTemplateLv_;
		adjustmentGrade_ = other.adjustmentGrade_;
		affixCount_ = other.affixCount_;
		affixGroupId_ = other.affixGroupId_;
		nodeGroupId_ = other.nodeGroupId_;
		initialHp_ = other.initialHp_;
		score_ = other.score_;
		techPoint_ = other.techPoint_;
		checkStageGroupId_ = other.checkStageGroupId_;
		oppoAttrAddShow_ = other.oppoAttrAddShow_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierGradeChallenge Clone()
	{
		return new SoldierGradeChallenge(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierGradeChallenge);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierGradeChallenge other)
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
		if (Season != other.Season)
		{
			return false;
		}
		if (KeyGradeId != other.KeyGradeId)
		{
			return false;
		}
		if (GradeLevel != other.GradeLevel)
		{
			return false;
		}
		if (GradeScore != other.GradeScore)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (OppoLevelShow != other.OppoLevelShow)
		{
			return false;
		}
		if (DiffcultyTemplateLv != other.DiffcultyTemplateLv)
		{
			return false;
		}
		if (AdjustmentGrade != other.AdjustmentGrade)
		{
			return false;
		}
		if (AffixCount != other.AffixCount)
		{
			return false;
		}
		if (AffixGroupId != other.AffixGroupId)
		{
			return false;
		}
		if (NodeGroupId != other.NodeGroupId)
		{
			return false;
		}
		if (InitialHp != other.InitialHp)
		{
			return false;
		}
		if (Score != other.Score)
		{
			return false;
		}
		if (TechPoint != other.TechPoint)
		{
			return false;
		}
		if (CheckStageGroupId != other.CheckStageGroupId)
		{
			return false;
		}
		if (OppoAttrAddShow != other.OppoAttrAddShow)
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
		if (Season != 0)
		{
			num ^= Season.GetHashCode();
		}
		if (KeyGradeId != 0)
		{
			num ^= KeyGradeId.GetHashCode();
		}
		if (GradeLevel != 0)
		{
			num ^= GradeLevel.GetHashCode();
		}
		if (GradeScore != 0)
		{
			num ^= GradeScore.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (OppoLevelShow != 0)
		{
			num ^= OppoLevelShow.GetHashCode();
		}
		if (DiffcultyTemplateLv != 0)
		{
			num ^= DiffcultyTemplateLv.GetHashCode();
		}
		if (AdjustmentGrade != 0)
		{
			num ^= AdjustmentGrade.GetHashCode();
		}
		if (AffixCount != 0)
		{
			num ^= AffixCount.GetHashCode();
		}
		if (AffixGroupId != 0)
		{
			num ^= AffixGroupId.GetHashCode();
		}
		if (NodeGroupId != 0)
		{
			num ^= NodeGroupId.GetHashCode();
		}
		if (InitialHp != 0)
		{
			num ^= InitialHp.GetHashCode();
		}
		if (Score != 0)
		{
			num ^= Score.GetHashCode();
		}
		if (TechPoint != 0)
		{
			num ^= TechPoint.GetHashCode();
		}
		if (CheckStageGroupId != 0)
		{
			num ^= CheckStageGroupId.GetHashCode();
		}
		if (OppoAttrAddShow.Length != 0)
		{
			num ^= OppoAttrAddShow.GetHashCode();
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
		if (Season != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Season);
		}
		if (KeyGradeId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(KeyGradeId);
		}
		if (GradeLevel != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(GradeLevel);
		}
		if (GradeScore != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(GradeScore);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Name);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Icon);
		}
		if (OppoLevelShow != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(OppoLevelShow);
		}
		if (DiffcultyTemplateLv != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(DiffcultyTemplateLv);
		}
		if (AdjustmentGrade != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(AdjustmentGrade);
		}
		if (AffixCount != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(AffixCount);
		}
		if (AffixGroupId != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(AffixGroupId);
		}
		if (NodeGroupId != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(NodeGroupId);
		}
		if (InitialHp != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(InitialHp);
		}
		if (Score != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(Score);
		}
		if (TechPoint != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(TechPoint);
		}
		if (CheckStageGroupId != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(CheckStageGroupId);
		}
		if (OppoAttrAddShow.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(OppoAttrAddShow);
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
		if (Season != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Season);
		}
		if (KeyGradeId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(KeyGradeId);
		}
		if (GradeLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GradeLevel);
		}
		if (GradeScore != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GradeScore);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (OppoLevelShow != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OppoLevelShow);
		}
		if (DiffcultyTemplateLv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DiffcultyTemplateLv);
		}
		if (AdjustmentGrade != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AdjustmentGrade);
		}
		if (AffixCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AffixCount);
		}
		if (AffixGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AffixGroupId);
		}
		if (NodeGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NodeGroupId);
		}
		if (InitialHp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(InitialHp);
		}
		if (Score != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Score);
		}
		if (TechPoint != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TechPoint);
		}
		if (CheckStageGroupId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(CheckStageGroupId);
		}
		if (OppoAttrAddShow.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(OppoAttrAddShow);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierGradeChallenge other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Season != 0)
			{
				Season = other.Season;
			}
			if (other.KeyGradeId != 0)
			{
				KeyGradeId = other.KeyGradeId;
			}
			if (other.GradeLevel != 0)
			{
				GradeLevel = other.GradeLevel;
			}
			if (other.GradeScore != 0)
			{
				GradeScore = other.GradeScore;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.OppoLevelShow != 0)
			{
				OppoLevelShow = other.OppoLevelShow;
			}
			if (other.DiffcultyTemplateLv != 0)
			{
				DiffcultyTemplateLv = other.DiffcultyTemplateLv;
			}
			if (other.AdjustmentGrade != 0)
			{
				AdjustmentGrade = other.AdjustmentGrade;
			}
			if (other.AffixCount != 0)
			{
				AffixCount = other.AffixCount;
			}
			if (other.AffixGroupId != 0)
			{
				AffixGroupId = other.AffixGroupId;
			}
			if (other.NodeGroupId != 0)
			{
				NodeGroupId = other.NodeGroupId;
			}
			if (other.InitialHp != 0)
			{
				InitialHp = other.InitialHp;
			}
			if (other.Score != 0)
			{
				Score = other.Score;
			}
			if (other.TechPoint != 0)
			{
				TechPoint = other.TechPoint;
			}
			if (other.CheckStageGroupId != 0)
			{
				CheckStageGroupId = other.CheckStageGroupId;
			}
			if (other.OppoAttrAddShow.Length != 0)
			{
				OppoAttrAddShow = other.OppoAttrAddShow;
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
				Season = input.ReadInt32();
				break;
			case 24u:
				KeyGradeId = input.ReadInt32();
				break;
			case 32u:
				GradeLevel = input.ReadInt32();
				break;
			case 40u:
				GradeScore = input.ReadInt32();
				break;
			case 50u:
				Name = input.ReadString();
				break;
			case 58u:
				Icon = input.ReadString();
				break;
			case 64u:
				OppoLevelShow = input.ReadInt32();
				break;
			case 72u:
				DiffcultyTemplateLv = input.ReadInt32();
				break;
			case 80u:
				AdjustmentGrade = input.ReadInt32();
				break;
			case 88u:
				AffixCount = input.ReadInt32();
				break;
			case 96u:
				AffixGroupId = input.ReadInt32();
				break;
			case 104u:
				NodeGroupId = input.ReadInt32();
				break;
			case 112u:
				InitialHp = input.ReadInt32();
				break;
			case 120u:
				Score = input.ReadInt32();
				break;
			case 128u:
				TechPoint = input.ReadInt32();
				break;
			case 136u:
				CheckStageGroupId = input.ReadInt32();
				break;
			case 146u:
				OppoAttrAddShow = input.ReadString();
				break;
			}
		}
	}
}
