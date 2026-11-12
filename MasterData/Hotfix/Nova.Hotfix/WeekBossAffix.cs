using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class WeekBossAffix : IMessage<WeekBossAffix>, IMessage, IEquatable<WeekBossAffix>, IDeepCloneable<WeekBossAffix>
{
	private static readonly MessageParser<WeekBossAffix> _parser = new MessageParser<WeekBossAffix>(() => new WeekBossAffix());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int LevelFieldNumber = 3;

	private int level_;

	public const int NameFieldNumber = 4;

	private string name_ = "";

	public const int DescFieldNumber = 5;

	private string desc_ = "";

	public const int IconFieldNumber = 6;

	private string icon_ = "";

	public const int ElementFieldNumber = 7;

	private int element_;

	public const int AddCampFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_addCamp_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> addCamp_ = new RepeatedField<int>();

	public const int AddClassFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_addClass_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> addClass_ = new RepeatedField<int>();

	public const int SkillIdFieldNumber = 10;

	private int skillId_;

	[DebuggerNonUserCode]
	public static MessageParser<WeekBossAffix> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1074);

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
	public int Element
	{
		get
		{
			return element_;
		}
		set
		{
			element_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> AddCamp => addCamp_;

	[DebuggerNonUserCode]
	public RepeatedField<int> AddClass => addClass_;

	[DebuggerNonUserCode]
	public int SkillId
	{
		get
		{
			return skillId_;
		}
		set
		{
			skillId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public WeekBossAffix()
	{
	}

	[DebuggerNonUserCode]
	public WeekBossAffix(WeekBossAffix other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		level_ = other.level_;
		name_ = other.name_;
		desc_ = other.desc_;
		icon_ = other.icon_;
		element_ = other.element_;
		addCamp_ = other.addCamp_.Clone();
		addClass_ = other.addClass_.Clone();
		skillId_ = other.skillId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public WeekBossAffix Clone()
	{
		return new WeekBossAffix(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as WeekBossAffix);
	}

	[DebuggerNonUserCode]
	public bool Equals(WeekBossAffix other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Element != other.Element)
		{
			return false;
		}
		if (!addCamp_.Equals(other.addCamp_))
		{
			return false;
		}
		if (!addClass_.Equals(other.addClass_))
		{
			return false;
		}
		if (SkillId != other.SkillId)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Element != 0)
		{
			num ^= Element.GetHashCode();
		}
		num ^= addCamp_.GetHashCode();
		num ^= addClass_.GetHashCode();
		if (SkillId != 0)
		{
			num ^= SkillId.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Desc);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Icon);
		}
		if (Element != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Element);
		}
		addCamp_.WriteTo(output, _repeated_addCamp_codec);
		addClass_.WriteTo(output, _repeated_addClass_codec);
		if (SkillId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(SkillId);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Element != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Element);
		}
		num += addCamp_.CalculateSize(_repeated_addCamp_codec);
		num += addClass_.CalculateSize(_repeated_addClass_codec);
		if (SkillId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkillId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(WeekBossAffix other)
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
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Element != 0)
			{
				Element = other.Element;
			}
			addCamp_.Add(other.addCamp_);
			addClass_.Add(other.addClass_);
			if (other.SkillId != 0)
			{
				SkillId = other.SkillId;
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
				Name = input.ReadString();
				break;
			case 42u:
				Desc = input.ReadString();
				break;
			case 50u:
				Icon = input.ReadString();
				break;
			case 56u:
				Element = input.ReadInt32();
				break;
			case 64u:
			case 66u:
				addCamp_.AddEntriesFrom(input, _repeated_addCamp_codec);
				break;
			case 72u:
			case 74u:
				addClass_.AddEntriesFrom(input, _repeated_addClass_codec);
				break;
			case 80u:
				SkillId = input.ReadInt32();
				break;
			}
		}
	}
}
