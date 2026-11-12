using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PenguinCardAide : IMessage<PenguinCardAide>, IMessage, IEquatable<PenguinCardAide>, IDeepCloneable<PenguinCardAide>
{
	private static readonly MessageParser<PenguinCardAide> _parser = new MessageParser<PenguinCardAide>(() => new PenguinCardAide());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TitleFieldNumber = 2;

	private string title_ = "";

	public const int MaxLevelFieldNumber = 3;

	private int maxLevel_;

	public const int ScoreFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_score_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> score_ = new RepeatedField<int>();

	public const int CardGroupFieldNumber = 5;

	private int cardGroup_;

	public const int UpgradeGroupFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_upgradeGroup_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> upgradeGroup_ = new RepeatedField<int>();

	public const int UpgradeNeedFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_upgradeNeed_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> upgradeNeed_ = new RepeatedField<int>();

	public const int CharIdFieldNumber = 8;

	private int charId_;

	public const int IconFieldNumber = 9;

	private string icon_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<PenguinCardAide> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(616);

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
	public int MaxLevel
	{
		get
		{
			return maxLevel_;
		}
		set
		{
			maxLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Score => score_;

	[DebuggerNonUserCode]
	public int CardGroup
	{
		get
		{
			return cardGroup_;
		}
		set
		{
			cardGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> UpgradeGroup => upgradeGroup_;

	[DebuggerNonUserCode]
	public RepeatedField<int> UpgradeNeed => upgradeNeed_;

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
	public PenguinCardAide()
	{
	}

	[DebuggerNonUserCode]
	public PenguinCardAide(PenguinCardAide other)
		: this()
	{
		id_ = other.id_;
		title_ = other.title_;
		maxLevel_ = other.maxLevel_;
		score_ = other.score_.Clone();
		cardGroup_ = other.cardGroup_;
		upgradeGroup_ = other.upgradeGroup_.Clone();
		upgradeNeed_ = other.upgradeNeed_.Clone();
		charId_ = other.charId_;
		icon_ = other.icon_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PenguinCardAide Clone()
	{
		return new PenguinCardAide(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PenguinCardAide);
	}

	[DebuggerNonUserCode]
	public bool Equals(PenguinCardAide other)
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
		if (Title != other.Title)
		{
			return false;
		}
		if (MaxLevel != other.MaxLevel)
		{
			return false;
		}
		if (!score_.Equals(other.score_))
		{
			return false;
		}
		if (CardGroup != other.CardGroup)
		{
			return false;
		}
		if (!upgradeGroup_.Equals(other.upgradeGroup_))
		{
			return false;
		}
		if (!upgradeNeed_.Equals(other.upgradeNeed_))
		{
			return false;
		}
		if (CharId != other.CharId)
		{
			return false;
		}
		if (Icon != other.Icon)
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
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (MaxLevel != 0)
		{
			num ^= MaxLevel.GetHashCode();
		}
		num ^= score_.GetHashCode();
		if (CardGroup != 0)
		{
			num ^= CardGroup.GetHashCode();
		}
		num ^= upgradeGroup_.GetHashCode();
		num ^= upgradeNeed_.GetHashCode();
		if (CharId != 0)
		{
			num ^= CharId.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
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
		if (Title.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Title);
		}
		if (MaxLevel != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(MaxLevel);
		}
		score_.WriteTo(output, _repeated_score_codec);
		if (CardGroup != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(CardGroup);
		}
		upgradeGroup_.WriteTo(output, _repeated_upgradeGroup_codec);
		upgradeNeed_.WriteTo(output, _repeated_upgradeNeed_codec);
		if (CharId != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(CharId);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Icon);
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
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (MaxLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxLevel);
		}
		num += score_.CalculateSize(_repeated_score_codec);
		if (CardGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CardGroup);
		}
		num += upgradeGroup_.CalculateSize(_repeated_upgradeGroup_codec);
		num += upgradeNeed_.CalculateSize(_repeated_upgradeNeed_codec);
		if (CharId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharId);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PenguinCardAide other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.MaxLevel != 0)
			{
				MaxLevel = other.MaxLevel;
			}
			score_.Add(other.score_);
			if (other.CardGroup != 0)
			{
				CardGroup = other.CardGroup;
			}
			upgradeGroup_.Add(other.upgradeGroup_);
			upgradeNeed_.Add(other.upgradeNeed_);
			if (other.CharId != 0)
			{
				CharId = other.CharId;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
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
				Title = input.ReadString();
				break;
			case 24u:
				MaxLevel = input.ReadInt32();
				break;
			case 32u:
			case 34u:
				score_.AddEntriesFrom(input, _repeated_score_codec);
				break;
			case 40u:
				CardGroup = input.ReadInt32();
				break;
			case 48u:
			case 50u:
				upgradeGroup_.AddEntriesFrom(input, _repeated_upgradeGroup_codec);
				break;
			case 56u:
			case 58u:
				upgradeNeed_.AddEntriesFrom(input, _repeated_upgradeNeed_codec);
				break;
			case 64u:
				CharId = input.ReadInt32();
				break;
			case 74u:
				Icon = input.ReadString();
				break;
			}
		}
	}
}
