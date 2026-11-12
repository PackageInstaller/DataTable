using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerBuild : IMessage<StarTowerBuild>, IMessage, IEquatable<StarTowerBuild>, IDeepCloneable<StarTowerBuild>
{
	private static readonly MessageParser<StarTowerBuild> _parser = new MessageParser<StarTowerBuild>(() => new StarTowerBuild());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int StarTowerIdFieldNumber = 2;

	private int starTowerId_;

	public const int CharactersFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_characters_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> characters_ = new RepeatedField<int>();

	public const int DiscsFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_discs_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> discs_ = new RepeatedField<int>();

	public const int PotantialsFieldNumber = 5;

	private string potantials_ = "";

	public const int SubNotesFieldNumber = 6;

	private string subNotes_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerBuild> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(830);

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
	public RepeatedField<int> Characters => characters_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Discs => discs_;

	[DebuggerNonUserCode]
	public string Potantials
	{
		get
		{
			return potantials_;
		}
		set
		{
			potantials_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string SubNotes
	{
		get
		{
			return subNotes_;
		}
		set
		{
			subNotes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public StarTowerBuild()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerBuild(StarTowerBuild other)
		: this()
	{
		id_ = other.id_;
		starTowerId_ = other.starTowerId_;
		characters_ = other.characters_.Clone();
		discs_ = other.discs_.Clone();
		potantials_ = other.potantials_;
		subNotes_ = other.subNotes_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerBuild Clone()
	{
		return new StarTowerBuild(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerBuild);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerBuild other)
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
		if (StarTowerId != other.StarTowerId)
		{
			return false;
		}
		if (!characters_.Equals(other.characters_))
		{
			return false;
		}
		if (!discs_.Equals(other.discs_))
		{
			return false;
		}
		if (Potantials != other.Potantials)
		{
			return false;
		}
		if (SubNotes != other.SubNotes)
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
		if (StarTowerId != 0)
		{
			num ^= StarTowerId.GetHashCode();
		}
		num ^= characters_.GetHashCode();
		num ^= discs_.GetHashCode();
		if (Potantials.Length != 0)
		{
			num ^= Potantials.GetHashCode();
		}
		if (SubNotes.Length != 0)
		{
			num ^= SubNotes.GetHashCode();
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
		if (StarTowerId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(StarTowerId);
		}
		characters_.WriteTo(output, _repeated_characters_codec);
		discs_.WriteTo(output, _repeated_discs_codec);
		if (Potantials.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Potantials);
		}
		if (SubNotes.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(SubNotes);
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
		if (StarTowerId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StarTowerId);
		}
		num += characters_.CalculateSize(_repeated_characters_codec);
		num += discs_.CalculateSize(_repeated_discs_codec);
		if (Potantials.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Potantials);
		}
		if (SubNotes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SubNotes);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerBuild other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.StarTowerId != 0)
			{
				StarTowerId = other.StarTowerId;
			}
			characters_.Add(other.characters_);
			discs_.Add(other.discs_);
			if (other.Potantials.Length != 0)
			{
				Potantials = other.Potantials;
			}
			if (other.SubNotes.Length != 0)
			{
				SubNotes = other.SubNotes;
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
				StarTowerId = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				characters_.AddEntriesFrom(input, _repeated_characters_codec);
				break;
			case 32u:
			case 34u:
				discs_.AddEntriesFrom(input, _repeated_discs_codec);
				break;
			case 42u:
				Potantials = input.ReadString();
				break;
			case 50u:
				SubNotes = input.ReadString();
				break;
			}
		}
	}
}
