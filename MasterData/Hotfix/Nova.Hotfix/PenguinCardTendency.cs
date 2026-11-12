using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PenguinCardTendency : IMessage<PenguinCardTendency>, IMessage, IEquatable<PenguinCardTendency>, IDeepCloneable<PenguinCardTendency>
{
	private static readonly MessageParser<PenguinCardTendency> _parser = new MessageParser<PenguinCardTendency>(() => new PenguinCardTendency());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int LevelFieldNumber = 3;

	private int level_;

	public const int ScoreFieldNumber = 4;

	private int score_;

	public const int CardGroupFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_cardGroup_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> cardGroup_ = new RepeatedField<int>();

	public const int AddWeightFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_addWeight_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> addWeight_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<PenguinCardTendency> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(640);

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
	public RepeatedField<int> CardGroup => cardGroup_;

	[DebuggerNonUserCode]
	public RepeatedField<int> AddWeight => addWeight_;

	[DebuggerNonUserCode]
	public PenguinCardTendency()
	{
	}

	[DebuggerNonUserCode]
	public PenguinCardTendency(PenguinCardTendency other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		level_ = other.level_;
		score_ = other.score_;
		cardGroup_ = other.cardGroup_.Clone();
		addWeight_ = other.addWeight_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PenguinCardTendency Clone()
	{
		return new PenguinCardTendency(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PenguinCardTendency);
	}

	[DebuggerNonUserCode]
	public bool Equals(PenguinCardTendency other)
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
		if (Score != other.Score)
		{
			return false;
		}
		if (!cardGroup_.Equals(other.cardGroup_))
		{
			return false;
		}
		if (!addWeight_.Equals(other.addWeight_))
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
		if (Score != 0)
		{
			num ^= Score.GetHashCode();
		}
		num ^= cardGroup_.GetHashCode();
		num ^= addWeight_.GetHashCode();
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
		if (Score != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Score);
		}
		cardGroup_.WriteTo(output, _repeated_cardGroup_codec);
		addWeight_.WriteTo(output, _repeated_addWeight_codec);
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
		if (Score != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Score);
		}
		num += cardGroup_.CalculateSize(_repeated_cardGroup_codec);
		num += addWeight_.CalculateSize(_repeated_addWeight_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PenguinCardTendency other)
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
			if (other.Score != 0)
			{
				Score = other.Score;
			}
			cardGroup_.Add(other.cardGroup_);
			addWeight_.Add(other.addWeight_);
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
			case 32u:
				Score = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				cardGroup_.AddEntriesFrom(input, _repeated_cardGroup_codec);
				break;
			case 48u:
			case 50u:
				addWeight_.AddEntriesFrom(input, _repeated_addWeight_codec);
				break;
			}
		}
	}
}
