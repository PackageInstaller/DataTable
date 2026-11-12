using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityPenguinCardLevel : IMessage<ActivityPenguinCardLevel>, IMessage, IEquatable<ActivityPenguinCardLevel>, IDeepCloneable<ActivityPenguinCardLevel>
{
	private static readonly MessageParser<ActivityPenguinCardLevel> _parser = new MessageParser<ActivityPenguinCardLevel>(() => new ActivityPenguinCardLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ActivityIdFieldNumber = 2;

	private int activityId_;

	public const int TypeFieldNumber = 3;

	private int type_;

	public const int DurationFieldNumber = 4;

	private int duration_;

	public const int NameFieldNumber = 5;

	private string name_ = "";

	public const int PrevFieldNumber = 6;

	private int prev_;

	public const int Item1FieldNumber = 7;

	private int item1_;

	public const int Qty1FieldNumber = 8;

	private int qty1_;

	public const int Item2FieldNumber = 9;

	private int item2_;

	public const int Qty2FieldNumber = 10;

	private int qty2_;

	public const int StarScoreFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_starScore_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> starScore_ = new RepeatedField<int>();

	public const int FloorIdFieldNumber = 12;

	private int floorId_;

	public const int ScoreLevelFieldNumber = 13;

	private bool scoreLevel_;

	public const int SkipFieldNumber = 14;

	private bool skip_;

	[DebuggerNonUserCode]
	public static MessageParser<ActivityPenguinCardLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(26);

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
	public int ActivityId
	{
		get
		{
			return activityId_;
		}
		set
		{
			activityId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Duration
	{
		get
		{
			return duration_;
		}
		set
		{
			duration_ = value;
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
	public int Prev
	{
		get
		{
			return prev_;
		}
		set
		{
			prev_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Item1
	{
		get
		{
			return item1_;
		}
		set
		{
			item1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty1
	{
		get
		{
			return qty1_;
		}
		set
		{
			qty1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Item2
	{
		get
		{
			return item2_;
		}
		set
		{
			item2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty2
	{
		get
		{
			return qty2_;
		}
		set
		{
			qty2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> StarScore => starScore_;

	[DebuggerNonUserCode]
	public int FloorId
	{
		get
		{
			return floorId_;
		}
		set
		{
			floorId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool ScoreLevel
	{
		get
		{
			return scoreLevel_;
		}
		set
		{
			scoreLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Skip
	{
		get
		{
			return skip_;
		}
		set
		{
			skip_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ActivityPenguinCardLevel()
	{
	}

	[DebuggerNonUserCode]
	public ActivityPenguinCardLevel(ActivityPenguinCardLevel other)
		: this()
	{
		id_ = other.id_;
		activityId_ = other.activityId_;
		type_ = other.type_;
		duration_ = other.duration_;
		name_ = other.name_;
		prev_ = other.prev_;
		item1_ = other.item1_;
		qty1_ = other.qty1_;
		item2_ = other.item2_;
		qty2_ = other.qty2_;
		starScore_ = other.starScore_.Clone();
		floorId_ = other.floorId_;
		scoreLevel_ = other.scoreLevel_;
		skip_ = other.skip_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityPenguinCardLevel Clone()
	{
		return new ActivityPenguinCardLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityPenguinCardLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityPenguinCardLevel other)
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
		if (ActivityId != other.ActivityId)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (Duration != other.Duration)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Prev != other.Prev)
		{
			return false;
		}
		if (Item1 != other.Item1)
		{
			return false;
		}
		if (Qty1 != other.Qty1)
		{
			return false;
		}
		if (Item2 != other.Item2)
		{
			return false;
		}
		if (Qty2 != other.Qty2)
		{
			return false;
		}
		if (!starScore_.Equals(other.starScore_))
		{
			return false;
		}
		if (FloorId != other.FloorId)
		{
			return false;
		}
		if (ScoreLevel != other.ScoreLevel)
		{
			return false;
		}
		if (Skip != other.Skip)
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
		if (ActivityId != 0)
		{
			num ^= ActivityId.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Duration != 0)
		{
			num ^= Duration.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Prev != 0)
		{
			num ^= Prev.GetHashCode();
		}
		if (Item1 != 0)
		{
			num ^= Item1.GetHashCode();
		}
		if (Qty1 != 0)
		{
			num ^= Qty1.GetHashCode();
		}
		if (Item2 != 0)
		{
			num ^= Item2.GetHashCode();
		}
		if (Qty2 != 0)
		{
			num ^= Qty2.GetHashCode();
		}
		num ^= starScore_.GetHashCode();
		if (FloorId != 0)
		{
			num ^= FloorId.GetHashCode();
		}
		if (ScoreLevel)
		{
			num ^= ScoreLevel.GetHashCode();
		}
		if (Skip)
		{
			num ^= Skip.GetHashCode();
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
		if (ActivityId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ActivityId);
		}
		if (Type != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Type);
		}
		if (Duration != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Duration);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Name);
		}
		if (Prev != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Prev);
		}
		if (Item1 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Item1);
		}
		if (Qty1 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Qty1);
		}
		if (Item2 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Item2);
		}
		if (Qty2 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Qty2);
		}
		starScore_.WriteTo(output, _repeated_starScore_codec);
		if (FloorId != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(FloorId);
		}
		if (ScoreLevel)
		{
			output.WriteRawTag(104);
			output.WriteBool(ScoreLevel);
		}
		if (Skip)
		{
			output.WriteRawTag(112);
			output.WriteBool(Skip);
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
		if (ActivityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityId);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Duration != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Duration);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Prev != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Prev);
		}
		if (Item1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Item1);
		}
		if (Qty1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty1);
		}
		if (Item2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Item2);
		}
		if (Qty2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty2);
		}
		num += starScore_.CalculateSize(_repeated_starScore_codec);
		if (FloorId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorId);
		}
		if (ScoreLevel)
		{
			num += 2;
		}
		if (Skip)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityPenguinCardLevel other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Duration != 0)
			{
				Duration = other.Duration;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Prev != 0)
			{
				Prev = other.Prev;
			}
			if (other.Item1 != 0)
			{
				Item1 = other.Item1;
			}
			if (other.Qty1 != 0)
			{
				Qty1 = other.Qty1;
			}
			if (other.Item2 != 0)
			{
				Item2 = other.Item2;
			}
			if (other.Qty2 != 0)
			{
				Qty2 = other.Qty2;
			}
			starScore_.Add(other.starScore_);
			if (other.FloorId != 0)
			{
				FloorId = other.FloorId;
			}
			if (other.ScoreLevel)
			{
				ScoreLevel = other.ScoreLevel;
			}
			if (other.Skip)
			{
				Skip = other.Skip;
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
				ActivityId = input.ReadInt32();
				break;
			case 24u:
				Type = input.ReadInt32();
				break;
			case 32u:
				Duration = input.ReadInt32();
				break;
			case 42u:
				Name = input.ReadString();
				break;
			case 48u:
				Prev = input.ReadInt32();
				break;
			case 56u:
				Item1 = input.ReadInt32();
				break;
			case 64u:
				Qty1 = input.ReadInt32();
				break;
			case 72u:
				Item2 = input.ReadInt32();
				break;
			case 80u:
				Qty2 = input.ReadInt32();
				break;
			case 88u:
			case 90u:
				starScore_.AddEntriesFrom(input, _repeated_starScore_codec);
				break;
			case 96u:
				FloorId = input.ReadInt32();
				break;
			case 104u:
				ScoreLevel = input.ReadBool();
				break;
			case 112u:
				Skip = input.ReadBool();
				break;
			}
		}
	}
}
