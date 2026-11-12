using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TrialBuild : IMessage<TrialBuild>, IMessage, IEquatable<TrialBuild>, IDeepCloneable<TrialBuild>
{
	private static readonly MessageParser<TrialBuild> _parser = new MessageParser<TrialBuild>(() => new TrialBuild());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int StarTowerIdFieldNumber = 3;

	private int starTowerId_;

	public const int ScoreFieldNumber = 4;

	private int score_;

	public const int CharFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_char_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> char_ = new RepeatedField<int>();

	public const int DiscFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_disc_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> disc_ = new RepeatedField<int>();

	public const int PotentialFieldNumber = 7;

	private string potential_ = "";

	public const int ActiveSecondaryIdsFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_activeSecondaryIds_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> activeSecondaryIds_ = new RepeatedField<int>();

	public const int NoteFieldNumber = 9;

	private string note_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<TrialBuild> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1026);

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
	public int StarTowerId
	{
		get
		{
			return starTowerId_;
		}
		set
		{
			starTowerId_ = value;
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
	public RepeatedField<int> Char => char_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Disc => disc_;

	[DebuggerNonUserCode]
	public string Potential
	{
		get
		{
			return potential_;
		}
		set
		{
			potential_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> ActiveSecondaryIds => activeSecondaryIds_;

	[DebuggerNonUserCode]
	public string Note
	{
		get
		{
			return note_;
		}
		set
		{
			note_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public TrialBuild()
	{
	}

	[DebuggerNonUserCode]
	public TrialBuild(TrialBuild other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		starTowerId_ = other.starTowerId_;
		score_ = other.score_;
		char_ = other.char_.Clone();
		disc_ = other.disc_.Clone();
		potential_ = other.potential_;
		activeSecondaryIds_ = other.activeSecondaryIds_.Clone();
		note_ = other.note_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TrialBuild Clone()
	{
		return new TrialBuild(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TrialBuild);
	}

	[DebuggerNonUserCode]
	public bool Equals(TrialBuild other)
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
		if (StarTowerId != other.StarTowerId)
		{
			return false;
		}
		if (Score != other.Score)
		{
			return false;
		}
		if (!char_.Equals(other.char_))
		{
			return false;
		}
		if (!disc_.Equals(other.disc_))
		{
			return false;
		}
		if (Potential != other.Potential)
		{
			return false;
		}
		if (!activeSecondaryIds_.Equals(other.activeSecondaryIds_))
		{
			return false;
		}
		if (Note != other.Note)
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
		if (StarTowerId != 0)
		{
			num ^= StarTowerId.GetHashCode();
		}
		if (Score != 0)
		{
			num ^= Score.GetHashCode();
		}
		num ^= char_.GetHashCode();
		num ^= disc_.GetHashCode();
		if (Potential.Length != 0)
		{
			num ^= Potential.GetHashCode();
		}
		num ^= activeSecondaryIds_.GetHashCode();
		if (Note.Length != 0)
		{
			num ^= Note.GetHashCode();
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
		if (StarTowerId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(StarTowerId);
		}
		if (Score != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Score);
		}
		char_.WriteTo(output, _repeated_char_codec);
		disc_.WriteTo(output, _repeated_disc_codec);
		if (Potential.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Potential);
		}
		activeSecondaryIds_.WriteTo(output, _repeated_activeSecondaryIds_codec);
		if (Note.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Note);
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
		if (StarTowerId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StarTowerId);
		}
		if (Score != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Score);
		}
		num += char_.CalculateSize(_repeated_char_codec);
		num += disc_.CalculateSize(_repeated_disc_codec);
		if (Potential.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Potential);
		}
		num += activeSecondaryIds_.CalculateSize(_repeated_activeSecondaryIds_codec);
		if (Note.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Note);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TrialBuild other)
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
			if (other.StarTowerId != 0)
			{
				StarTowerId = other.StarTowerId;
			}
			if (other.Score != 0)
			{
				Score = other.Score;
			}
			char_.Add(other.char_);
			disc_.Add(other.disc_);
			if (other.Potential.Length != 0)
			{
				Potential = other.Potential;
			}
			activeSecondaryIds_.Add(other.activeSecondaryIds_);
			if (other.Note.Length != 0)
			{
				Note = other.Note;
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
				StarTowerId = input.ReadInt32();
				break;
			case 32u:
				Score = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				char_.AddEntriesFrom(input, _repeated_char_codec);
				break;
			case 48u:
			case 50u:
				disc_.AddEntriesFrom(input, _repeated_disc_codec);
				break;
			case 58u:
				Potential = input.ReadString();
				break;
			case 64u:
			case 66u:
				activeSecondaryIds_.AddEntriesFrom(input, _repeated_activeSecondaryIds_codec);
				break;
			case 74u:
				Note = input.ReadString();
				break;
			}
		}
	}
}
