using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierBossTemplate : IMessage<SoldierBossTemplate>, IMessage, IEquatable<SoldierBossTemplate>, IDeepCloneable<SoldierBossTemplate>
{
	private static readonly MessageParser<SoldierBossTemplate> _parser = new MessageParser<SoldierBossTemplate>(() => new SoldierBossTemplate());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int PersonalityIntuitionFieldNumber = 3;

	private int personalityIntuition_;

	public const int PersonalityAnalysisFieldNumber = 4;

	private int personalityAnalysis_;

	public const int PersonalityChaosFieldNumber = 5;

	private int personalityChaos_;

	public const int SoldierPlayerHeadFieldNumber = 6;

	private string soldierPlayerHead_ = "";

	public const int SoldierRoleSkillTypeFieldNumber = 7;

	private int soldierRoleSkillType_;

	public const int SoldierRoleSkillIconFieldNumber = 8;

	private string soldierRoleSkillIcon_ = "";

	public const int TitleFieldNumber = 9;

	private string title_ = "";

	public const int DescFieldNumber = 10;

	private string desc_ = "";

	public const int PathFieldNumber = 11;

	private string path_ = "";

	public const int SkillFieldNumber = 12;

	private int skill_;

	public const int IsUnlockFieldNumber = 13;

	private bool isUnlock_;

	public const int TechNodeIdFieldNumber = 14;

	private int techNodeId_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierBossTemplate> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(732);

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
	public int PersonalityIntuition
	{
		get
		{
			return personalityIntuition_;
		}
		set
		{
			personalityIntuition_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PersonalityAnalysis
	{
		get
		{
			return personalityAnalysis_;
		}
		set
		{
			personalityAnalysis_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PersonalityChaos
	{
		get
		{
			return personalityChaos_;
		}
		set
		{
			personalityChaos_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string SoldierPlayerHead
	{
		get
		{
			return soldierPlayerHead_;
		}
		set
		{
			soldierPlayerHead_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int SoldierRoleSkillType
	{
		get
		{
			return soldierRoleSkillType_;
		}
		set
		{
			soldierRoleSkillType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string SoldierRoleSkillIcon
	{
		get
		{
			return soldierRoleSkillIcon_;
		}
		set
		{
			soldierRoleSkillIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Title
	{
		get
		{
			return title_;
		}
		set
		{
			title_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc
	{
		get
		{
			return desc_;
		}
		set
		{
			desc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Path
	{
		get
		{
			return path_;
		}
		set
		{
			path_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Skill
	{
		get
		{
			return skill_;
		}
		set
		{
			skill_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsUnlock
	{
		get
		{
			return isUnlock_;
		}
		set
		{
			isUnlock_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TechNodeId
	{
		get
		{
			return techNodeId_;
		}
		set
		{
			techNodeId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierBossTemplate()
	{
	}

	[DebuggerNonUserCode]
	public SoldierBossTemplate(SoldierBossTemplate other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		personalityIntuition_ = other.personalityIntuition_;
		personalityAnalysis_ = other.personalityAnalysis_;
		personalityChaos_ = other.personalityChaos_;
		soldierPlayerHead_ = other.soldierPlayerHead_;
		soldierRoleSkillType_ = other.soldierRoleSkillType_;
		soldierRoleSkillIcon_ = other.soldierRoleSkillIcon_;
		title_ = other.title_;
		desc_ = other.desc_;
		path_ = other.path_;
		skill_ = other.skill_;
		isUnlock_ = other.isUnlock_;
		techNodeId_ = other.techNodeId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierBossTemplate Clone()
	{
		return new SoldierBossTemplate(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierBossTemplate);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierBossTemplate other)
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
		if (PersonalityIntuition != other.PersonalityIntuition)
		{
			return false;
		}
		if (PersonalityAnalysis != other.PersonalityAnalysis)
		{
			return false;
		}
		if (PersonalityChaos != other.PersonalityChaos)
		{
			return false;
		}
		if (SoldierPlayerHead != other.SoldierPlayerHead)
		{
			return false;
		}
		if (SoldierRoleSkillType != other.SoldierRoleSkillType)
		{
			return false;
		}
		if (SoldierRoleSkillIcon != other.SoldierRoleSkillIcon)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Path != other.Path)
		{
			return false;
		}
		if (Skill != other.Skill)
		{
			return false;
		}
		if (IsUnlock != other.IsUnlock)
		{
			return false;
		}
		if (TechNodeId != other.TechNodeId)
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
		if (PersonalityIntuition != 0)
		{
			num ^= PersonalityIntuition.GetHashCode();
		}
		if (PersonalityAnalysis != 0)
		{
			num ^= PersonalityAnalysis.GetHashCode();
		}
		if (PersonalityChaos != 0)
		{
			num ^= PersonalityChaos.GetHashCode();
		}
		if (SoldierPlayerHead.Length != 0)
		{
			num ^= SoldierPlayerHead.GetHashCode();
		}
		if (SoldierRoleSkillType != 0)
		{
			num ^= SoldierRoleSkillType.GetHashCode();
		}
		if (SoldierRoleSkillIcon.Length != 0)
		{
			num ^= SoldierRoleSkillIcon.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Path.Length != 0)
		{
			num ^= Path.GetHashCode();
		}
		if (Skill != 0)
		{
			num ^= Skill.GetHashCode();
		}
		if (IsUnlock)
		{
			num ^= IsUnlock.GetHashCode();
		}
		if (TechNodeId != 0)
		{
			num ^= TechNodeId.GetHashCode();
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
		if (PersonalityIntuition != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(PersonalityIntuition);
		}
		if (PersonalityAnalysis != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(PersonalityAnalysis);
		}
		if (PersonalityChaos != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(PersonalityChaos);
		}
		if (SoldierPlayerHead.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(SoldierPlayerHead);
		}
		if (SoldierRoleSkillType != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(SoldierRoleSkillType);
		}
		if (SoldierRoleSkillIcon.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(SoldierRoleSkillIcon);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Title);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(Desc);
		}
		if (Path.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Path);
		}
		if (Skill != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(Skill);
		}
		if (IsUnlock)
		{
			output.WriteRawTag(104);
			output.WriteBool(IsUnlock);
		}
		if (TechNodeId != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(TechNodeId);
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
		if (PersonalityIntuition != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PersonalityIntuition);
		}
		if (PersonalityAnalysis != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PersonalityAnalysis);
		}
		if (PersonalityChaos != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PersonalityChaos);
		}
		if (SoldierPlayerHead.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SoldierPlayerHead);
		}
		if (SoldierRoleSkillType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SoldierRoleSkillType);
		}
		if (SoldierRoleSkillIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SoldierRoleSkillIcon);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Path.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Path);
		}
		if (Skill != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Skill);
		}
		if (IsUnlock)
		{
			num += 2;
		}
		if (TechNodeId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TechNodeId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierBossTemplate other)
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
			if (other.PersonalityIntuition != 0)
			{
				PersonalityIntuition = other.PersonalityIntuition;
			}
			if (other.PersonalityAnalysis != 0)
			{
				PersonalityAnalysis = other.PersonalityAnalysis;
			}
			if (other.PersonalityChaos != 0)
			{
				PersonalityChaos = other.PersonalityChaos;
			}
			if (other.SoldierPlayerHead.Length != 0)
			{
				SoldierPlayerHead = other.SoldierPlayerHead;
			}
			if (other.SoldierRoleSkillType != 0)
			{
				SoldierRoleSkillType = other.SoldierRoleSkillType;
			}
			if (other.SoldierRoleSkillIcon.Length != 0)
			{
				SoldierRoleSkillIcon = other.SoldierRoleSkillIcon;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Path.Length != 0)
			{
				Path = other.Path;
			}
			if (other.Skill != 0)
			{
				Skill = other.Skill;
			}
			if (other.IsUnlock)
			{
				IsUnlock = other.IsUnlock;
			}
			if (other.TechNodeId != 0)
			{
				TechNodeId = other.TechNodeId;
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
				PersonalityIntuition = input.ReadInt32();
				break;
			case 32u:
				PersonalityAnalysis = input.ReadInt32();
				break;
			case 40u:
				PersonalityChaos = input.ReadInt32();
				break;
			case 50u:
				SoldierPlayerHead = input.ReadString();
				break;
			case 56u:
				SoldierRoleSkillType = input.ReadInt32();
				break;
			case 66u:
				SoldierRoleSkillIcon = input.ReadString();
				break;
			case 74u:
				Title = input.ReadString();
				break;
			case 82u:
				Desc = input.ReadString();
				break;
			case 90u:
				Path = input.ReadString();
				break;
			case 96u:
				Skill = input.ReadInt32();
				break;
			case 104u:
				IsUnlock = input.ReadBool();
				break;
			case 112u:
				TechNodeId = input.ReadInt32();
				break;
			}
		}
	}
}
