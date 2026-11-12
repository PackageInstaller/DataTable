using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierStarterCard : IMessage<SoldierStarterCard>, IMessage, IEquatable<SoldierStarterCard>, IDeepCloneable<SoldierStarterCard>
{
	private static readonly MessageParser<SoldierStarterCard> _parser = new MessageParser<SoldierStarterCard>(() => new SoldierStarterCard());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int RarityFieldNumber = 3;

	private int rarity_;

	public const int IconFieldNumber = 4;

	private string icon_ = "";

	public const int NameFieldNumber = 5;

	private string name_ = "";

	public const int CardEffectIdFieldNumber = 6;

	private int cardEffectId_;

	public const int DesFieldNumber = 7;

	private string des_ = "";

	public const int DescFieldNumber = 8;

	private string desc_ = "";

	public const int GradeLevelCondFieldNumber = 9;

	private int gradeLevelCond_;

	public const int UnlockCondFieldNumber = 10;

	private int unlockCond_;

	public const int UnlockCondParamsFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_unlockCondParams_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> unlockCondParams_ = new RepeatedField<int>();

	public const int CharacterShowFieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_characterShow_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> characterShow_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<SoldierStarterCard> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(798);

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
	public int Rarity
	{
		get
		{
			return rarity_;
		}
		set
		{
			rarity_ = value;
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
	public int CardEffectId
	{
		get
		{
			return cardEffectId_;
		}
		set
		{
			cardEffectId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Des
	{
		get
		{
			return des_;
		}
		set
		{
			des_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int GradeLevelCond
	{
		get
		{
			return gradeLevelCond_;
		}
		set
		{
			gradeLevelCond_ = value;
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
	public RepeatedField<int> UnlockCondParams => unlockCondParams_;

	[DebuggerNonUserCode]
	public RepeatedField<int> CharacterShow => characterShow_;

	[DebuggerNonUserCode]
	public SoldierStarterCard()
	{
	}

	[DebuggerNonUserCode]
	public SoldierStarterCard(SoldierStarterCard other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		rarity_ = other.rarity_;
		icon_ = other.icon_;
		name_ = other.name_;
		cardEffectId_ = other.cardEffectId_;
		des_ = other.des_;
		desc_ = other.desc_;
		gradeLevelCond_ = other.gradeLevelCond_;
		unlockCond_ = other.unlockCond_;
		unlockCondParams_ = other.unlockCondParams_.Clone();
		characterShow_ = other.characterShow_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierStarterCard Clone()
	{
		return new SoldierStarterCard(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierStarterCard);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierStarterCard other)
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
		if (Rarity != other.Rarity)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (CardEffectId != other.CardEffectId)
		{
			return false;
		}
		if (Des != other.Des)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (GradeLevelCond != other.GradeLevelCond)
		{
			return false;
		}
		if (UnlockCond != other.UnlockCond)
		{
			return false;
		}
		if (!unlockCondParams_.Equals(other.unlockCondParams_))
		{
			return false;
		}
		if (!characterShow_.Equals(other.characterShow_))
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
		if (Rarity != 0)
		{
			num ^= Rarity.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (CardEffectId != 0)
		{
			num ^= CardEffectId.GetHashCode();
		}
		if (Des.Length != 0)
		{
			num ^= Des.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (GradeLevelCond != 0)
		{
			num ^= GradeLevelCond.GetHashCode();
		}
		if (UnlockCond != 0)
		{
			num ^= UnlockCond.GetHashCode();
		}
		num ^= unlockCondParams_.GetHashCode();
		num ^= characterShow_.GetHashCode();
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
		if (Rarity != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Rarity);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Icon);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Name);
		}
		if (CardEffectId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(CardEffectId);
		}
		if (Des.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Des);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Desc);
		}
		if (GradeLevelCond != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(GradeLevelCond);
		}
		if (UnlockCond != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(UnlockCond);
		}
		unlockCondParams_.WriteTo(output, _repeated_unlockCondParams_codec);
		characterShow_.WriteTo(output, _repeated_characterShow_codec);
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
		if (Rarity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rarity);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (CardEffectId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CardEffectId);
		}
		if (Des.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Des);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (GradeLevelCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GradeLevelCond);
		}
		if (UnlockCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockCond);
		}
		num += unlockCondParams_.CalculateSize(_repeated_unlockCondParams_codec);
		num += characterShow_.CalculateSize(_repeated_characterShow_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierStarterCard other)
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
			if (other.Rarity != 0)
			{
				Rarity = other.Rarity;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.CardEffectId != 0)
			{
				CardEffectId = other.CardEffectId;
			}
			if (other.Des.Length != 0)
			{
				Des = other.Des;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.GradeLevelCond != 0)
			{
				GradeLevelCond = other.GradeLevelCond;
			}
			if (other.UnlockCond != 0)
			{
				UnlockCond = other.UnlockCond;
			}
			unlockCondParams_.Add(other.unlockCondParams_);
			characterShow_.Add(other.characterShow_);
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
				Rarity = input.ReadInt32();
				break;
			case 34u:
				Icon = input.ReadString();
				break;
			case 42u:
				Name = input.ReadString();
				break;
			case 48u:
				CardEffectId = input.ReadInt32();
				break;
			case 58u:
				Des = input.ReadString();
				break;
			case 66u:
				Desc = input.ReadString();
				break;
			case 72u:
				GradeLevelCond = input.ReadInt32();
				break;
			case 80u:
				UnlockCond = input.ReadInt32();
				break;
			case 88u:
			case 90u:
				unlockCondParams_.AddEntriesFrom(input, _repeated_unlockCondParams_codec);
				break;
			case 96u:
			case 98u:
				characterShow_.AddEntriesFrom(input, _repeated_characterShow_codec);
				break;
			}
		}
	}
}
