using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TrialCharacter : IMessage<TrialCharacter>, IMessage, IEquatable<TrialCharacter>, IDeepCloneable<TrialCharacter>
{
	private static readonly MessageParser<TrialCharacter> _parser = new MessageParser<TrialCharacter>(() => new TrialCharacter());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int CharIdFieldNumber = 3;

	private int charId_;

	public const int CharacterSkinFieldNumber = 4;

	private int characterSkin_;

	public const int BreakFieldNumber = 5;

	private int break_;

	public const int LevelFieldNumber = 6;

	private int level_;

	public const int SkillLevelFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_skillLevel_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> skillLevel_ = new RepeatedField<int>();

	public const int TalentFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_talent_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> talent_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<TrialCharacter> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1028);

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
	public int CharId
	{
		get
		{
			return charId_;
		}
		set
		{
			charId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CharacterSkin
	{
		get
		{
			return characterSkin_;
		}
		set
		{
			characterSkin_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Break
	{
		get
		{
			return break_;
		}
		set
		{
			break_ = value;
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
	public RepeatedField<int> SkillLevel => skillLevel_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Talent => talent_;

	[DebuggerNonUserCode]
	public TrialCharacter()
	{
	}

	[DebuggerNonUserCode]
	public TrialCharacter(TrialCharacter other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		charId_ = other.charId_;
		characterSkin_ = other.characterSkin_;
		break_ = other.break_;
		level_ = other.level_;
		skillLevel_ = other.skillLevel_.Clone();
		talent_ = other.talent_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TrialCharacter Clone()
	{
		return new TrialCharacter(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TrialCharacter);
	}

	[DebuggerNonUserCode]
	public bool Equals(TrialCharacter other)
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
		if (CharId != other.CharId)
		{
			return false;
		}
		if (CharacterSkin != other.CharacterSkin)
		{
			return false;
		}
		if (Break != other.Break)
		{
			return false;
		}
		if (Level != other.Level)
		{
			return false;
		}
		if (!skillLevel_.Equals(other.skillLevel_))
		{
			return false;
		}
		if (!talent_.Equals(other.talent_))
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
		if (CharId != 0)
		{
			num ^= CharId.GetHashCode();
		}
		if (CharacterSkin != 0)
		{
			num ^= CharacterSkin.GetHashCode();
		}
		if (Break != 0)
		{
			num ^= Break.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		num ^= skillLevel_.GetHashCode();
		num ^= talent_.GetHashCode();
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
		if (CharId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CharId);
		}
		if (CharacterSkin != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CharacterSkin);
		}
		if (Break != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Break);
		}
		if (Level != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Level);
		}
		skillLevel_.WriteTo(output, _repeated_skillLevel_codec);
		talent_.WriteTo(output, _repeated_talent_codec);
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
		if (CharId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharId);
		}
		if (CharacterSkin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharacterSkin);
		}
		if (Break != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Break);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		num += skillLevel_.CalculateSize(_repeated_skillLevel_codec);
		num += talent_.CalculateSize(_repeated_talent_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TrialCharacter other)
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
			if (other.CharId != 0)
			{
				CharId = other.CharId;
			}
			if (other.CharacterSkin != 0)
			{
				CharacterSkin = other.CharacterSkin;
			}
			if (other.Break != 0)
			{
				Break = other.Break;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			skillLevel_.Add(other.skillLevel_);
			talent_.Add(other.talent_);
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
				CharId = input.ReadInt32();
				break;
			case 32u:
				CharacterSkin = input.ReadInt32();
				break;
			case 40u:
				Break = input.ReadInt32();
				break;
			case 48u:
				Level = input.ReadInt32();
				break;
			case 56u:
			case 58u:
				skillLevel_.AddEntriesFrom(input, _repeated_skillLevel_codec);
				break;
			case 64u:
			case 66u:
				talent_.AddEntriesFrom(input, _repeated_talent_codec);
				break;
			}
		}
	}
}
