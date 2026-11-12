using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class BreakOutCharacter : IMessage<BreakOutCharacter>, IMessage, IEquatable<BreakOutCharacter>, IDeepCloneable<BreakOutCharacter>
{
	private static readonly MessageParser<BreakOutCharacter> _parser = new MessageParser<BreakOutCharacter>(() => new BreakOutCharacter());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CharIdFieldNumber = 2;

	private int charId_;

	public const int NameFieldNumber = 3;

	private string name_ = "";

	public const int UnlockCondFieldNumber = 4;

	private int unlockCond_;

	public const int UnlockParamsFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_unlockParams_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> unlockParams_ = new RepeatedField<int>();

	public const int EETFieldNumber = 6;

	private int eET_;

	public const int ModelFieldNumber = 7;

	private string model_ = "";

	public const int ModelScaleFieldNumber = 8;

	private int modelScale_;

	public const int FactionFieldNumber = 9;

	private int faction_;

	public const int FCAIActionFieldNumber = 10;

	private string fCAIAction_ = "";

	public const int FCComboGroupFieldNumber = 11;

	private string fCComboGroup_ = "";

	public const int SkillIdFieldNumber = 12;

	private int skillId_;

	public const int MPFieldNumber = 13;

	private int mP_;

	public const int SkillCDFieldNumber = 14;

	private int skillCD_;

	public const int IconFieldNumber = 15;

	private string icon_ = "";

	public const int AttributeFieldNumber = 16;

	private int attribute_;

	public const int LevelFieldNumber = 17;

	private int level_;

	[DebuggerNonUserCode]
	public static MessageParser<BreakOutCharacter> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(132);

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
	public int UnlockCond
	{
		get
		{
			return unlockCond_;
		}
		set
		{
			unlockCond_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> UnlockParams => unlockParams_;

	[DebuggerNonUserCode]
	public int EET
	{
		get
		{
			return eET_;
		}
		set
		{
			eET_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Model
	{
		get
		{
			return model_;
		}
		set
		{
			model_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ModelScale
	{
		get
		{
			return modelScale_;
		}
		set
		{
			modelScale_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Faction
	{
		get
		{
			return faction_;
		}
		set
		{
			faction_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string FCAIAction
	{
		get
		{
			return fCAIAction_;
		}
		set
		{
			fCAIAction_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string FCComboGroup
	{
		get
		{
			return fCComboGroup_;
		}
		set
		{
			fCComboGroup_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

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
	public int MP
	{
		get
		{
			return mP_;
		}
		set
		{
			mP_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SkillCD
	{
		get
		{
			return skillCD_;
		}
		set
		{
			skillCD_ = value;
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
	public int Attribute
	{
		get
		{
			return attribute_;
		}
		set
		{
			attribute_ = value;
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
	public BreakOutCharacter()
	{
	}

	[DebuggerNonUserCode]
	public BreakOutCharacter(BreakOutCharacter other)
		: this()
	{
		id_ = other.id_;
		charId_ = other.charId_;
		name_ = other.name_;
		unlockCond_ = other.unlockCond_;
		unlockParams_ = other.unlockParams_.Clone();
		eET_ = other.eET_;
		model_ = other.model_;
		modelScale_ = other.modelScale_;
		faction_ = other.faction_;
		fCAIAction_ = other.fCAIAction_;
		fCComboGroup_ = other.fCComboGroup_;
		skillId_ = other.skillId_;
		mP_ = other.mP_;
		skillCD_ = other.skillCD_;
		icon_ = other.icon_;
		attribute_ = other.attribute_;
		level_ = other.level_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public BreakOutCharacter Clone()
	{
		return new BreakOutCharacter(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as BreakOutCharacter);
	}

	[DebuggerNonUserCode]
	public bool Equals(BreakOutCharacter other)
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
		if (CharId != other.CharId)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (UnlockCond != other.UnlockCond)
		{
			return false;
		}
		if (!unlockParams_.Equals(other.unlockParams_))
		{
			return false;
		}
		if (EET != other.EET)
		{
			return false;
		}
		if (Model != other.Model)
		{
			return false;
		}
		if (ModelScale != other.ModelScale)
		{
			return false;
		}
		if (Faction != other.Faction)
		{
			return false;
		}
		if (FCAIAction != other.FCAIAction)
		{
			return false;
		}
		if (FCComboGroup != other.FCComboGroup)
		{
			return false;
		}
		if (SkillId != other.SkillId)
		{
			return false;
		}
		if (MP != other.MP)
		{
			return false;
		}
		if (SkillCD != other.SkillCD)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Attribute != other.Attribute)
		{
			return false;
		}
		if (Level != other.Level)
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
		if (CharId != 0)
		{
			num ^= CharId.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (UnlockCond != 0)
		{
			num ^= UnlockCond.GetHashCode();
		}
		num ^= unlockParams_.GetHashCode();
		if (EET != 0)
		{
			num ^= EET.GetHashCode();
		}
		if (Model.Length != 0)
		{
			num ^= Model.GetHashCode();
		}
		if (ModelScale != 0)
		{
			num ^= ModelScale.GetHashCode();
		}
		if (Faction != 0)
		{
			num ^= Faction.GetHashCode();
		}
		if (FCAIAction.Length != 0)
		{
			num ^= FCAIAction.GetHashCode();
		}
		if (FCComboGroup.Length != 0)
		{
			num ^= FCComboGroup.GetHashCode();
		}
		if (SkillId != 0)
		{
			num ^= SkillId.GetHashCode();
		}
		if (MP != 0)
		{
			num ^= MP.GetHashCode();
		}
		if (SkillCD != 0)
		{
			num ^= SkillCD.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Attribute != 0)
		{
			num ^= Attribute.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
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
		if (CharId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CharId);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Name);
		}
		if (UnlockCond != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(UnlockCond);
		}
		unlockParams_.WriteTo(output, _repeated_unlockParams_codec);
		if (EET != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(EET);
		}
		if (Model.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Model);
		}
		if (ModelScale != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ModelScale);
		}
		if (Faction != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Faction);
		}
		if (FCAIAction.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(FCAIAction);
		}
		if (FCComboGroup.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(FCComboGroup);
		}
		if (SkillId != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(SkillId);
		}
		if (MP != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(MP);
		}
		if (SkillCD != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(SkillCD);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(Icon);
		}
		if (Attribute != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(Attribute);
		}
		if (Level != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(Level);
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
		if (CharId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharId);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (UnlockCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockCond);
		}
		num += unlockParams_.CalculateSize(_repeated_unlockParams_codec);
		if (EET != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EET);
		}
		if (Model.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Model);
		}
		if (ModelScale != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ModelScale);
		}
		if (Faction != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Faction);
		}
		if (FCAIAction.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FCAIAction);
		}
		if (FCComboGroup.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FCComboGroup);
		}
		if (SkillId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkillId);
		}
		if (MP != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MP);
		}
		if (SkillCD != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkillCD);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Attribute != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Attribute);
		}
		if (Level != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(BreakOutCharacter other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.CharId != 0)
			{
				CharId = other.CharId;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.UnlockCond != 0)
			{
				UnlockCond = other.UnlockCond;
			}
			unlockParams_.Add(other.unlockParams_);
			if (other.EET != 0)
			{
				EET = other.EET;
			}
			if (other.Model.Length != 0)
			{
				Model = other.Model;
			}
			if (other.ModelScale != 0)
			{
				ModelScale = other.ModelScale;
			}
			if (other.Faction != 0)
			{
				Faction = other.Faction;
			}
			if (other.FCAIAction.Length != 0)
			{
				FCAIAction = other.FCAIAction;
			}
			if (other.FCComboGroup.Length != 0)
			{
				FCComboGroup = other.FCComboGroup;
			}
			if (other.SkillId != 0)
			{
				SkillId = other.SkillId;
			}
			if (other.MP != 0)
			{
				MP = other.MP;
			}
			if (other.SkillCD != 0)
			{
				SkillCD = other.SkillCD;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Attribute != 0)
			{
				Attribute = other.Attribute;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
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
				CharId = input.ReadInt32();
				break;
			case 26u:
				Name = input.ReadString();
				break;
			case 32u:
				UnlockCond = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				unlockParams_.AddEntriesFrom(input, _repeated_unlockParams_codec);
				break;
			case 48u:
				EET = input.ReadInt32();
				break;
			case 58u:
				Model = input.ReadString();
				break;
			case 64u:
				ModelScale = input.ReadInt32();
				break;
			case 72u:
				Faction = input.ReadInt32();
				break;
			case 82u:
				FCAIAction = input.ReadString();
				break;
			case 90u:
				FCComboGroup = input.ReadString();
				break;
			case 96u:
				SkillId = input.ReadInt32();
				break;
			case 104u:
				MP = input.ReadInt32();
				break;
			case 112u:
				SkillCD = input.ReadInt32();
				break;
			case 122u:
				Icon = input.ReadString();
				break;
			case 128u:
				Attribute = input.ReadInt32();
				break;
			case 136u:
				Level = input.ReadInt32();
				break;
			}
		}
	}
}
