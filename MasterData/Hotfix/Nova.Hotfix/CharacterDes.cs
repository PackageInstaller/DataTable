using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharacterDes : IMessage<CharacterDes>, IMessage, IEquatable<CharacterDes>, IDeepCloneable<CharacterDes>
{
	private static readonly MessageParser<CharacterDes> _parser = new MessageParser<CharacterDes>(() => new CharacterDes());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int AliasFieldNumber = 2;

	private string alias_ = "";

	public const int CnCvFieldNumber = 3;

	private string cnCv_ = "";

	public const int JpCvFieldNumber = 4;

	private string jpCv_ = "";

	public const int CharColorFieldNumber = 5;

	private string charColor_ = "";

	public const int CharSkillColorFieldNumber = 6;

	private string charSkillColor_ = "";

	public const int CharDesFieldNumber = 7;

	private string charDes_ = "";

	public const int TagFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_tag_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> tag_ = new RepeatedField<int>();

	public const int ForceFieldNumber = 9;

	private int force_;

	public const int PreferTagsFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_preferTags_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> preferTags_ = new RepeatedField<int>();

	public const int HateTagsFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_hateTags_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> hateTags_ = new RepeatedField<int>();

	public const int BirthdayFieldNumber = 12;

	private string birthday_ = "";

	public const int PotentialMain1FieldNumber = 13;

	private string potentialMain1_ = "";

	public const int PotentialMain2FieldNumber = 14;

	private string potentialMain2_ = "";

	public const int PotentialAssistant1FieldNumber = 15;

	private string potentialAssistant1_ = "";

	public const int PotentialAssistant2FieldNumber = 16;

	private string potentialAssistant2_ = "";

	public const int PotentialMainContent1FieldNumber = 17;

	private string potentialMainContent1_ = "";

	public const int PotentialMainContent2FieldNumber = 18;

	private string potentialMainContent2_ = "";

	public const int PotentialAssistantContent1FieldNumber = 19;

	private string potentialAssistantContent1_ = "";

	public const int PotentialAssistantContent2FieldNumber = 20;

	private string potentialAssistantContent2_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<CharacterDes> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(164);

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
	public string Alias
	{
		get
		{
			return alias_;
		}
		set
		{
			alias_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CnCv
	{
		get
		{
			return cnCv_;
		}
		set
		{
			cnCv_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string JpCv
	{
		get
		{
			return jpCv_;
		}
		set
		{
			jpCv_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CharColor
	{
		get
		{
			return charColor_;
		}
		set
		{
			charColor_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CharSkillColor
	{
		get
		{
			return charSkillColor_;
		}
		set
		{
			charSkillColor_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CharDes
	{
		get
		{
			return charDes_;
		}
		set
		{
			charDes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Tag => tag_;

	[DebuggerNonUserCode]
	public int Force
	{
		get
		{
			return force_;
		}
		set
		{
			force_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> PreferTags => preferTags_;

	[DebuggerNonUserCode]
	public RepeatedField<int> HateTags => hateTags_;

	[DebuggerNonUserCode]
	public string Birthday
	{
		get
		{
			return birthday_;
		}
		set
		{
			birthday_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string PotentialMain1
	{
		get
		{
			return potentialMain1_;
		}
		set
		{
			potentialMain1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string PotentialMain2
	{
		get
		{
			return potentialMain2_;
		}
		set
		{
			potentialMain2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string PotentialAssistant1
	{
		get
		{
			return potentialAssistant1_;
		}
		set
		{
			potentialAssistant1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string PotentialAssistant2
	{
		get
		{
			return potentialAssistant2_;
		}
		set
		{
			potentialAssistant2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string PotentialMainContent1
	{
		get
		{
			return potentialMainContent1_;
		}
		set
		{
			potentialMainContent1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string PotentialMainContent2
	{
		get
		{
			return potentialMainContent2_;
		}
		set
		{
			potentialMainContent2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string PotentialAssistantContent1
	{
		get
		{
			return potentialAssistantContent1_;
		}
		set
		{
			potentialAssistantContent1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string PotentialAssistantContent2
	{
		get
		{
			return potentialAssistantContent2_;
		}
		set
		{
			potentialAssistantContent2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public CharacterDes()
	{
	}

	[DebuggerNonUserCode]
	public CharacterDes(CharacterDes other)
		: this()
	{
		id_ = other.id_;
		alias_ = other.alias_;
		cnCv_ = other.cnCv_;
		jpCv_ = other.jpCv_;
		charColor_ = other.charColor_;
		charSkillColor_ = other.charSkillColor_;
		charDes_ = other.charDes_;
		tag_ = other.tag_.Clone();
		force_ = other.force_;
		preferTags_ = other.preferTags_.Clone();
		hateTags_ = other.hateTags_.Clone();
		birthday_ = other.birthday_;
		potentialMain1_ = other.potentialMain1_;
		potentialMain2_ = other.potentialMain2_;
		potentialAssistant1_ = other.potentialAssistant1_;
		potentialAssistant2_ = other.potentialAssistant2_;
		potentialMainContent1_ = other.potentialMainContent1_;
		potentialMainContent2_ = other.potentialMainContent2_;
		potentialAssistantContent1_ = other.potentialAssistantContent1_;
		potentialAssistantContent2_ = other.potentialAssistantContent2_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharacterDes Clone()
	{
		return new CharacterDes(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterDes);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharacterDes other)
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
		if (Alias != other.Alias)
		{
			return false;
		}
		if (CnCv != other.CnCv)
		{
			return false;
		}
		if (JpCv != other.JpCv)
		{
			return false;
		}
		if (CharColor != other.CharColor)
		{
			return false;
		}
		if (CharSkillColor != other.CharSkillColor)
		{
			return false;
		}
		if (CharDes != other.CharDes)
		{
			return false;
		}
		if (!tag_.Equals(other.tag_))
		{
			return false;
		}
		if (Force != other.Force)
		{
			return false;
		}
		if (!preferTags_.Equals(other.preferTags_))
		{
			return false;
		}
		if (!hateTags_.Equals(other.hateTags_))
		{
			return false;
		}
		if (Birthday != other.Birthday)
		{
			return false;
		}
		if (PotentialMain1 != other.PotentialMain1)
		{
			return false;
		}
		if (PotentialMain2 != other.PotentialMain2)
		{
			return false;
		}
		if (PotentialAssistant1 != other.PotentialAssistant1)
		{
			return false;
		}
		if (PotentialAssistant2 != other.PotentialAssistant2)
		{
			return false;
		}
		if (PotentialMainContent1 != other.PotentialMainContent1)
		{
			return false;
		}
		if (PotentialMainContent2 != other.PotentialMainContent2)
		{
			return false;
		}
		if (PotentialAssistantContent1 != other.PotentialAssistantContent1)
		{
			return false;
		}
		if (PotentialAssistantContent2 != other.PotentialAssistantContent2)
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
		if (Alias.Length != 0)
		{
			num ^= Alias.GetHashCode();
		}
		if (CnCv.Length != 0)
		{
			num ^= CnCv.GetHashCode();
		}
		if (JpCv.Length != 0)
		{
			num ^= JpCv.GetHashCode();
		}
		if (CharColor.Length != 0)
		{
			num ^= CharColor.GetHashCode();
		}
		if (CharSkillColor.Length != 0)
		{
			num ^= CharSkillColor.GetHashCode();
		}
		if (CharDes.Length != 0)
		{
			num ^= CharDes.GetHashCode();
		}
		num ^= tag_.GetHashCode();
		if (Force != 0)
		{
			num ^= Force.GetHashCode();
		}
		num ^= preferTags_.GetHashCode();
		num ^= hateTags_.GetHashCode();
		if (Birthday.Length != 0)
		{
			num ^= Birthday.GetHashCode();
		}
		if (PotentialMain1.Length != 0)
		{
			num ^= PotentialMain1.GetHashCode();
		}
		if (PotentialMain2.Length != 0)
		{
			num ^= PotentialMain2.GetHashCode();
		}
		if (PotentialAssistant1.Length != 0)
		{
			num ^= PotentialAssistant1.GetHashCode();
		}
		if (PotentialAssistant2.Length != 0)
		{
			num ^= PotentialAssistant2.GetHashCode();
		}
		if (PotentialMainContent1.Length != 0)
		{
			num ^= PotentialMainContent1.GetHashCode();
		}
		if (PotentialMainContent2.Length != 0)
		{
			num ^= PotentialMainContent2.GetHashCode();
		}
		if (PotentialAssistantContent1.Length != 0)
		{
			num ^= PotentialAssistantContent1.GetHashCode();
		}
		if (PotentialAssistantContent2.Length != 0)
		{
			num ^= PotentialAssistantContent2.GetHashCode();
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
		if (Alias.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Alias);
		}
		if (CnCv.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(CnCv);
		}
		if (JpCv.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(JpCv);
		}
		if (CharColor.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(CharColor);
		}
		if (CharSkillColor.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(CharSkillColor);
		}
		if (CharDes.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(CharDes);
		}
		tag_.WriteTo(output, _repeated_tag_codec);
		if (Force != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Force);
		}
		preferTags_.WriteTo(output, _repeated_preferTags_codec);
		hateTags_.WriteTo(output, _repeated_hateTags_codec);
		if (Birthday.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(Birthday);
		}
		if (PotentialMain1.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(PotentialMain1);
		}
		if (PotentialMain2.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(PotentialMain2);
		}
		if (PotentialAssistant1.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(PotentialAssistant1);
		}
		if (PotentialAssistant2.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(PotentialAssistant2);
		}
		if (PotentialMainContent1.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(PotentialMainContent1);
		}
		if (PotentialMainContent2.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(PotentialMainContent2);
		}
		if (PotentialAssistantContent1.Length != 0)
		{
			output.WriteRawTag(154, 1);
			output.WriteString(PotentialAssistantContent1);
		}
		if (PotentialAssistantContent2.Length != 0)
		{
			output.WriteRawTag(162, 1);
			output.WriteString(PotentialAssistantContent2);
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
		if (Alias.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Alias);
		}
		if (CnCv.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CnCv);
		}
		if (JpCv.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(JpCv);
		}
		if (CharColor.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CharColor);
		}
		if (CharSkillColor.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CharSkillColor);
		}
		if (CharDes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CharDes);
		}
		num += tag_.CalculateSize(_repeated_tag_codec);
		if (Force != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Force);
		}
		num += preferTags_.CalculateSize(_repeated_preferTags_codec);
		num += hateTags_.CalculateSize(_repeated_hateTags_codec);
		if (Birthday.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Birthday);
		}
		if (PotentialMain1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PotentialMain1);
		}
		if (PotentialMain2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PotentialMain2);
		}
		if (PotentialAssistant1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PotentialAssistant1);
		}
		if (PotentialAssistant2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(PotentialAssistant2);
		}
		if (PotentialMainContent1.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(PotentialMainContent1);
		}
		if (PotentialMainContent2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(PotentialMainContent2);
		}
		if (PotentialAssistantContent1.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(PotentialAssistantContent1);
		}
		if (PotentialAssistantContent2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(PotentialAssistantContent2);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharacterDes other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Alias.Length != 0)
			{
				Alias = other.Alias;
			}
			if (other.CnCv.Length != 0)
			{
				CnCv = other.CnCv;
			}
			if (other.JpCv.Length != 0)
			{
				JpCv = other.JpCv;
			}
			if (other.CharColor.Length != 0)
			{
				CharColor = other.CharColor;
			}
			if (other.CharSkillColor.Length != 0)
			{
				CharSkillColor = other.CharSkillColor;
			}
			if (other.CharDes.Length != 0)
			{
				CharDes = other.CharDes;
			}
			tag_.Add(other.tag_);
			if (other.Force != 0)
			{
				Force = other.Force;
			}
			preferTags_.Add(other.preferTags_);
			hateTags_.Add(other.hateTags_);
			if (other.Birthday.Length != 0)
			{
				Birthday = other.Birthday;
			}
			if (other.PotentialMain1.Length != 0)
			{
				PotentialMain1 = other.PotentialMain1;
			}
			if (other.PotentialMain2.Length != 0)
			{
				PotentialMain2 = other.PotentialMain2;
			}
			if (other.PotentialAssistant1.Length != 0)
			{
				PotentialAssistant1 = other.PotentialAssistant1;
			}
			if (other.PotentialAssistant2.Length != 0)
			{
				PotentialAssistant2 = other.PotentialAssistant2;
			}
			if (other.PotentialMainContent1.Length != 0)
			{
				PotentialMainContent1 = other.PotentialMainContent1;
			}
			if (other.PotentialMainContent2.Length != 0)
			{
				PotentialMainContent2 = other.PotentialMainContent2;
			}
			if (other.PotentialAssistantContent1.Length != 0)
			{
				PotentialAssistantContent1 = other.PotentialAssistantContent1;
			}
			if (other.PotentialAssistantContent2.Length != 0)
			{
				PotentialAssistantContent2 = other.PotentialAssistantContent2;
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
				Alias = input.ReadString();
				break;
			case 26u:
				CnCv = input.ReadString();
				break;
			case 34u:
				JpCv = input.ReadString();
				break;
			case 42u:
				CharColor = input.ReadString();
				break;
			case 50u:
				CharSkillColor = input.ReadString();
				break;
			case 58u:
				CharDes = input.ReadString();
				break;
			case 64u:
			case 66u:
				tag_.AddEntriesFrom(input, _repeated_tag_codec);
				break;
			case 72u:
				Force = input.ReadInt32();
				break;
			case 80u:
			case 82u:
				preferTags_.AddEntriesFrom(input, _repeated_preferTags_codec);
				break;
			case 88u:
			case 90u:
				hateTags_.AddEntriesFrom(input, _repeated_hateTags_codec);
				break;
			case 98u:
				Birthday = input.ReadString();
				break;
			case 106u:
				PotentialMain1 = input.ReadString();
				break;
			case 114u:
				PotentialMain2 = input.ReadString();
				break;
			case 122u:
				PotentialAssistant1 = input.ReadString();
				break;
			case 130u:
				PotentialAssistant2 = input.ReadString();
				break;
			case 138u:
				PotentialMainContent1 = input.ReadString();
				break;
			case 146u:
				PotentialMainContent2 = input.ReadString();
				break;
			case 154u:
				PotentialAssistantContent1 = input.ReadString();
				break;
			case 162u:
				PotentialAssistantContent2 = input.ReadString();
				break;
			}
		}
	}
}
