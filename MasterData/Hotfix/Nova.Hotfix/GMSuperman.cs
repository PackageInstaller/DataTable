using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GMSuperman : IMessage<GMSuperman>, IMessage, IEquatable<GMSuperman>, IDeepCloneable<GMSuperman>
{
	private static readonly MessageParser<GMSuperman> _parser = new MessageParser<GMSuperman>(() => new GMSuperman());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int CharLevelFieldNumber = 3;

	private int charLevel_;

	public const int CharSkillFieldNumber = 4;

	private string charSkill_ = "";

	public const int TalentKeyFieldNumber = 5;

	private int talentKey_;

	public const int TalentNormalFieldNumber = 6;

	private int talentNormal_;

	public const int AffinityFieldNumber = 7;

	private int affinity_;

	public const int DiscLevelFieldNumber = 8;

	private int discLevel_;

	public const int DiscPhaseFieldNumber = 9;

	private int discPhase_;

	public const int DiscStarFieldNumber = 10;

	private int discStar_;

	public const int WorldClassFieldNumber = 11;

	private int worldClass_;

	public const int LevelClearFieldNumber = 12;

	private bool levelClear_;

	public const int StarTowerGrowthFieldNumber = 13;

	private int starTowerGrowth_;

	[DebuggerNonUserCode]
	public static MessageParser<GMSuperman> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(384);

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
	public int CharLevel
	{
		get
		{
			return charLevel_;
		}
		set
		{
			charLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string CharSkill
	{
		get
		{
			return charSkill_;
		}
		set
		{
			charSkill_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int TalentKey
	{
		get
		{
			return talentKey_;
		}
		set
		{
			talentKey_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TalentNormal
	{
		get
		{
			return talentNormal_;
		}
		set
		{
			talentNormal_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Affinity
	{
		get
		{
			return affinity_;
		}
		set
		{
			affinity_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DiscLevel
	{
		get
		{
			return discLevel_;
		}
		set
		{
			discLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DiscPhase
	{
		get
		{
			return discPhase_;
		}
		set
		{
			discPhase_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DiscStar
	{
		get
		{
			return discStar_;
		}
		set
		{
			discStar_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WorldClass
	{
		get
		{
			return worldClass_;
		}
		set
		{
			worldClass_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool LevelClear
	{
		get
		{
			return levelClear_;
		}
		set
		{
			levelClear_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int StarTowerGrowth
	{
		get
		{
			return starTowerGrowth_;
		}
		set
		{
			starTowerGrowth_ = value;
		}
	}

	[DebuggerNonUserCode]
	public GMSuperman()
	{
	}

	[DebuggerNonUserCode]
	public GMSuperman(GMSuperman other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		charLevel_ = other.charLevel_;
		charSkill_ = other.charSkill_;
		talentKey_ = other.talentKey_;
		talentNormal_ = other.talentNormal_;
		affinity_ = other.affinity_;
		discLevel_ = other.discLevel_;
		discPhase_ = other.discPhase_;
		discStar_ = other.discStar_;
		worldClass_ = other.worldClass_;
		levelClear_ = other.levelClear_;
		starTowerGrowth_ = other.starTowerGrowth_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GMSuperman Clone()
	{
		return new GMSuperman(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GMSuperman);
	}

	[DebuggerNonUserCode]
	public bool Equals(GMSuperman other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (CharLevel != other.CharLevel)
		{
			return false;
		}
		if (CharSkill != other.CharSkill)
		{
			return false;
		}
		if (TalentKey != other.TalentKey)
		{
			return false;
		}
		if (TalentNormal != other.TalentNormal)
		{
			return false;
		}
		if (Affinity != other.Affinity)
		{
			return false;
		}
		if (DiscLevel != other.DiscLevel)
		{
			return false;
		}
		if (DiscPhase != other.DiscPhase)
		{
			return false;
		}
		if (DiscStar != other.DiscStar)
		{
			return false;
		}
		if (WorldClass != other.WorldClass)
		{
			return false;
		}
		if (LevelClear != other.LevelClear)
		{
			return false;
		}
		if (StarTowerGrowth != other.StarTowerGrowth)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (CharLevel != 0)
		{
			num ^= CharLevel.GetHashCode();
		}
		if (CharSkill.Length != 0)
		{
			num ^= CharSkill.GetHashCode();
		}
		if (TalentKey != 0)
		{
			num ^= TalentKey.GetHashCode();
		}
		if (TalentNormal != 0)
		{
			num ^= TalentNormal.GetHashCode();
		}
		if (Affinity != 0)
		{
			num ^= Affinity.GetHashCode();
		}
		if (DiscLevel != 0)
		{
			num ^= DiscLevel.GetHashCode();
		}
		if (DiscPhase != 0)
		{
			num ^= DiscPhase.GetHashCode();
		}
		if (DiscStar != 0)
		{
			num ^= DiscStar.GetHashCode();
		}
		if (WorldClass != 0)
		{
			num ^= WorldClass.GetHashCode();
		}
		if (LevelClear)
		{
			num ^= LevelClear.GetHashCode();
		}
		if (StarTowerGrowth != 0)
		{
			num ^= StarTowerGrowth.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (CharLevel != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CharLevel);
		}
		if (CharSkill.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(CharSkill);
		}
		if (TalentKey != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(TalentKey);
		}
		if (TalentNormal != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(TalentNormal);
		}
		if (Affinity != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Affinity);
		}
		if (DiscLevel != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(DiscLevel);
		}
		if (DiscPhase != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(DiscPhase);
		}
		if (DiscStar != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(DiscStar);
		}
		if (WorldClass != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(WorldClass);
		}
		if (LevelClear)
		{
			output.WriteRawTag(96);
			output.WriteBool(LevelClear);
		}
		if (StarTowerGrowth != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(StarTowerGrowth);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (CharLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharLevel);
		}
		if (CharSkill.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CharSkill);
		}
		if (TalentKey != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TalentKey);
		}
		if (TalentNormal != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TalentNormal);
		}
		if (Affinity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Affinity);
		}
		if (DiscLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DiscLevel);
		}
		if (DiscPhase != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DiscPhase);
		}
		if (DiscStar != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DiscStar);
		}
		if (WorldClass != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WorldClass);
		}
		if (LevelClear)
		{
			num += 2;
		}
		if (StarTowerGrowth != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StarTowerGrowth);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(GMSuperman other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.CharLevel != 0)
			{
				CharLevel = other.CharLevel;
			}
			if (other.CharSkill.Length != 0)
			{
				CharSkill = other.CharSkill;
			}
			if (other.TalentKey != 0)
			{
				TalentKey = other.TalentKey;
			}
			if (other.TalentNormal != 0)
			{
				TalentNormal = other.TalentNormal;
			}
			if (other.Affinity != 0)
			{
				Affinity = other.Affinity;
			}
			if (other.DiscLevel != 0)
			{
				DiscLevel = other.DiscLevel;
			}
			if (other.DiscPhase != 0)
			{
				DiscPhase = other.DiscPhase;
			}
			if (other.DiscStar != 0)
			{
				DiscStar = other.DiscStar;
			}
			if (other.WorldClass != 0)
			{
				WorldClass = other.WorldClass;
			}
			if (other.LevelClear)
			{
				LevelClear = other.LevelClear;
			}
			if (other.StarTowerGrowth != 0)
			{
				StarTowerGrowth = other.StarTowerGrowth;
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
				Name = input.ReadString();
				break;
			case 24u:
				CharLevel = input.ReadInt32();
				break;
			case 34u:
				CharSkill = input.ReadString();
				break;
			case 40u:
				TalentKey = input.ReadInt32();
				break;
			case 48u:
				TalentNormal = input.ReadInt32();
				break;
			case 56u:
				Affinity = input.ReadInt32();
				break;
			case 64u:
				DiscLevel = input.ReadInt32();
				break;
			case 72u:
				DiscPhase = input.ReadInt32();
				break;
			case 80u:
				DiscStar = input.ReadInt32();
				break;
			case 88u:
				WorldClass = input.ReadInt32();
				break;
			case 96u:
				LevelClear = input.ReadBool();
				break;
			case 104u:
				StarTowerGrowth = input.ReadInt32();
				break;
			}
		}
	}
}
