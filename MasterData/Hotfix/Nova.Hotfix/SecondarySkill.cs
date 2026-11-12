using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SecondarySkill : IMessage<SecondarySkill>, IMessage, IEquatable<SecondarySkill>, IDeepCloneable<SecondarySkill>
{
	private static readonly MessageParser<SecondarySkill> _parser = new MessageParser<SecondarySkill>(() => new SecondarySkill());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int LevelFieldNumber = 3;

	private int level_;

	public const int NeedSubNoteSkillsFieldNumber = 4;

	private string needSubNoteSkills_ = "";

	public const int ScoreFieldNumber = 5;

	private int score_;

	public const int EffectIdFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_effectId_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> effectId_ = new RepeatedField<int>();

	public const int NameFieldNumber = 7;

	private string name_ = "";

	public const int IconFieldNumber = 8;

	private string icon_ = "";

	public const int IconBgFieldNumber = 9;

	private string iconBg_ = "";

	public const int DescFieldNumber = 10;

	private string desc_ = "";

	public const int Param1FieldNumber = 11;

	private string param1_ = "";

	public const int Param2FieldNumber = 12;

	private string param2_ = "";

	public const int Param3FieldNumber = 13;

	private string param3_ = "";

	public const int Param4FieldNumber = 14;

	private string param4_ = "";

	public const int Param5FieldNumber = 15;

	private string param5_ = "";

	public const int Param6FieldNumber = 16;

	private string param6_ = "";

	public const int Param7FieldNumber = 17;

	private string param7_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<SecondarySkill> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(712);

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
	public int GroupId
	{
		get
		{
			return groupId_;
		}
		set
		{
			groupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Level
	{
		get
		{
			return level_;
		}
		set
		{
			level_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string NeedSubNoteSkills
	{
		get
		{
			return needSubNoteSkills_;
		}
		set
		{
			needSubNoteSkills_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public RepeatedField<int> EffectId => effectId_;

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
	public string IconBg
	{
		get
		{
			return iconBg_;
		}
		set
		{
			iconBg_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string Param4
	{
		get
		{
			return param4_;
		}
		set
		{
			param4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param5
	{
		get
		{
			return param5_;
		}
		set
		{
			param5_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param6
	{
		get
		{
			return param6_;
		}
		set
		{
			param6_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param7
	{
		get
		{
			return param7_;
		}
		set
		{
			param7_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public SecondarySkill()
	{
	}

	[DebuggerNonUserCode]
	public SecondarySkill(SecondarySkill other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		level_ = other.level_;
		needSubNoteSkills_ = other.needSubNoteSkills_;
		score_ = other.score_;
		effectId_ = other.effectId_.Clone();
		name_ = other.name_;
		icon_ = other.icon_;
		iconBg_ = other.iconBg_;
		desc_ = other.desc_;
		param1_ = other.param1_;
		param2_ = other.param2_;
		param3_ = other.param3_;
		param4_ = other.param4_;
		param5_ = other.param5_;
		param6_ = other.param6_;
		param7_ = other.param7_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SecondarySkill Clone()
	{
		return new SecondarySkill(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SecondarySkill);
	}

	[DebuggerNonUserCode]
	public bool Equals(SecondarySkill other)
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
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (Level != other.Level)
		{
			return false;
		}
		if (NeedSubNoteSkills != other.NeedSubNoteSkills)
		{
			return false;
		}
		if (Score != other.Score)
		{
			return false;
		}
		if (!effectId_.Equals(other.effectId_))
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
		if (IconBg != other.IconBg)
		{
			return false;
		}
		if (Desc != other.Desc)
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
		if (Param4 != other.Param4)
		{
			return false;
		}
		if (Param5 != other.Param5)
		{
			return false;
		}
		if (Param6 != other.Param6)
		{
			return false;
		}
		if (Param7 != other.Param7)
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
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (NeedSubNoteSkills.Length != 0)
		{
			num ^= NeedSubNoteSkills.GetHashCode();
		}
		if (Score != 0)
		{
			num ^= Score.GetHashCode();
		}
		num ^= effectId_.GetHashCode();
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (IconBg.Length != 0)
		{
			num ^= IconBg.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
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
		if (Param4.Length != 0)
		{
			num ^= Param4.GetHashCode();
		}
		if (Param5.Length != 0)
		{
			num ^= Param5.GetHashCode();
		}
		if (Param6.Length != 0)
		{
			num ^= Param6.GetHashCode();
		}
		if (Param7.Length != 0)
		{
			num ^= Param7.GetHashCode();
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
		if (GroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GroupId);
		}
		if (Level != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Level);
		}
		if (NeedSubNoteSkills.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(NeedSubNoteSkills);
		}
		if (Score != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Score);
		}
		effectId_.WriteTo(output, _repeated_effectId_codec);
		if (Name.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Name);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Icon);
		}
		if (IconBg.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(IconBg);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(Desc);
		}
		if (Param1.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Param1);
		}
		if (Param2.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(Param2);
		}
		if (Param3.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(Param3);
		}
		if (Param4.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(Param4);
		}
		if (Param5.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(Param5);
		}
		if (Param6.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(Param6);
		}
		if (Param7.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(Param7);
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
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (NeedSubNoteSkills.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(NeedSubNoteSkills);
		}
		if (Score != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Score);
		}
		num += effectId_.CalculateSize(_repeated_effectId_codec);
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (IconBg.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconBg);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Param1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param1);
		}
		if (Param2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param2);
		}
		if (Param3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param3);
		}
		if (Param4.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param4);
		}
		if (Param5.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param5);
		}
		if (Param6.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param6);
		}
		if (Param7.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param7);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SecondarySkill other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.NeedSubNoteSkills.Length != 0)
			{
				NeedSubNoteSkills = other.NeedSubNoteSkills;
			}
			if (other.Score != 0)
			{
				Score = other.Score;
			}
			effectId_.Add(other.effectId_);
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.IconBg.Length != 0)
			{
				IconBg = other.IconBg;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
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
			if (other.Param4.Length != 0)
			{
				Param4 = other.Param4;
			}
			if (other.Param5.Length != 0)
			{
				Param5 = other.Param5;
			}
			if (other.Param6.Length != 0)
			{
				Param6 = other.Param6;
			}
			if (other.Param7.Length != 0)
			{
				Param7 = other.Param7;
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
				GroupId = input.ReadInt32();
				break;
			case 24u:
				Level = input.ReadInt32();
				break;
			case 34u:
				NeedSubNoteSkills = input.ReadString();
				break;
			case 40u:
				Score = input.ReadInt32();
				break;
			case 48u:
			case 50u:
				effectId_.AddEntriesFrom(input, _repeated_effectId_codec);
				break;
			case 58u:
				Name = input.ReadString();
				break;
			case 66u:
				Icon = input.ReadString();
				break;
			case 74u:
				IconBg = input.ReadString();
				break;
			case 82u:
				Desc = input.ReadString();
				break;
			case 90u:
				Param1 = input.ReadString();
				break;
			case 98u:
				Param2 = input.ReadString();
				break;
			case 106u:
				Param3 = input.ReadString();
				break;
			case 114u:
				Param4 = input.ReadString();
				break;
			case 122u:
				Param5 = input.ReadString();
				break;
			case 130u:
				Param6 = input.ReadString();
				break;
			case 138u:
				Param7 = input.ReadString();
				break;
			}
		}
	}
}
