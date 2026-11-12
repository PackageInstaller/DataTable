using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MonsterTeam : IMessage<MonsterTeam>, IMessage, IEquatable<MonsterTeam>, IDeepCloneable<MonsterTeam>
{
	private static readonly MessageParser<MonsterTeam> _parser = new MessageParser<MonsterTeam>(() => new MonsterTeam());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int Mate0IdFieldNumber = 2;

	private int mate0Id_;

	public const int Mate1IdFieldNumber = 3;

	private int mate1Id_;

	public const int Mate2IdFieldNumber = 4;

	private int mate2Id_;

	public const int Mate3IdFieldNumber = 5;

	private int mate3Id_;

	public const int Mate4IdFieldNumber = 6;

	private int mate4Id_;

	public const int Mate5IdFieldNumber = 7;

	private int mate5Id_;

	public const int Mate6IdFieldNumber = 8;

	private int mate6Id_;

	public const int Mate7IdFieldNumber = 9;

	private int mate7Id_;

	public const int MateMoreIdFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_mateMoreId_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> mateMoreId_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<MonsterTeam> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(584);

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
	public int Mate0Id
	{
		get
		{
			return mate0Id_;
		}
		set
		{
			mate0Id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Mate1Id
	{
		get
		{
			return mate1Id_;
		}
		set
		{
			mate1Id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Mate2Id
	{
		get
		{
			return mate2Id_;
		}
		set
		{
			mate2Id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Mate3Id
	{
		get
		{
			return mate3Id_;
		}
		set
		{
			mate3Id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Mate4Id
	{
		get
		{
			return mate4Id_;
		}
		set
		{
			mate4Id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Mate5Id
	{
		get
		{
			return mate5Id_;
		}
		set
		{
			mate5Id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Mate6Id
	{
		get
		{
			return mate6Id_;
		}
		set
		{
			mate6Id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Mate7Id
	{
		get
		{
			return mate7Id_;
		}
		set
		{
			mate7Id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> MateMoreId => mateMoreId_;

	[DebuggerNonUserCode]
	public MonsterTeam()
	{
	}

	[DebuggerNonUserCode]
	public MonsterTeam(MonsterTeam other)
		: this()
	{
		id_ = other.id_;
		mate0Id_ = other.mate0Id_;
		mate1Id_ = other.mate1Id_;
		mate2Id_ = other.mate2Id_;
		mate3Id_ = other.mate3Id_;
		mate4Id_ = other.mate4Id_;
		mate5Id_ = other.mate5Id_;
		mate6Id_ = other.mate6Id_;
		mate7Id_ = other.mate7Id_;
		mateMoreId_ = other.mateMoreId_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MonsterTeam Clone()
	{
		return new MonsterTeam(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MonsterTeam);
	}

	[DebuggerNonUserCode]
	public bool Equals(MonsterTeam other)
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
		if (Mate0Id != other.Mate0Id)
		{
			return false;
		}
		if (Mate1Id != other.Mate1Id)
		{
			return false;
		}
		if (Mate2Id != other.Mate2Id)
		{
			return false;
		}
		if (Mate3Id != other.Mate3Id)
		{
			return false;
		}
		if (Mate4Id != other.Mate4Id)
		{
			return false;
		}
		if (Mate5Id != other.Mate5Id)
		{
			return false;
		}
		if (Mate6Id != other.Mate6Id)
		{
			return false;
		}
		if (Mate7Id != other.Mate7Id)
		{
			return false;
		}
		if (!mateMoreId_.Equals(other.mateMoreId_))
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
		if (Mate0Id != 0)
		{
			num ^= Mate0Id.GetHashCode();
		}
		if (Mate1Id != 0)
		{
			num ^= Mate1Id.GetHashCode();
		}
		if (Mate2Id != 0)
		{
			num ^= Mate2Id.GetHashCode();
		}
		if (Mate3Id != 0)
		{
			num ^= Mate3Id.GetHashCode();
		}
		if (Mate4Id != 0)
		{
			num ^= Mate4Id.GetHashCode();
		}
		if (Mate5Id != 0)
		{
			num ^= Mate5Id.GetHashCode();
		}
		if (Mate6Id != 0)
		{
			num ^= Mate6Id.GetHashCode();
		}
		if (Mate7Id != 0)
		{
			num ^= Mate7Id.GetHashCode();
		}
		num ^= mateMoreId_.GetHashCode();
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
		if (Mate0Id != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Mate0Id);
		}
		if (Mate1Id != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Mate1Id);
		}
		if (Mate2Id != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Mate2Id);
		}
		if (Mate3Id != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Mate3Id);
		}
		if (Mate4Id != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Mate4Id);
		}
		if (Mate5Id != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Mate5Id);
		}
		if (Mate6Id != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Mate6Id);
		}
		if (Mate7Id != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Mate7Id);
		}
		mateMoreId_.WriteTo(output, _repeated_mateMoreId_codec);
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
		if (Mate0Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Mate0Id);
		}
		if (Mate1Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Mate1Id);
		}
		if (Mate2Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Mate2Id);
		}
		if (Mate3Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Mate3Id);
		}
		if (Mate4Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Mate4Id);
		}
		if (Mate5Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Mate5Id);
		}
		if (Mate6Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Mate6Id);
		}
		if (Mate7Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Mate7Id);
		}
		num += mateMoreId_.CalculateSize(_repeated_mateMoreId_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MonsterTeam other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Mate0Id != 0)
			{
				Mate0Id = other.Mate0Id;
			}
			if (other.Mate1Id != 0)
			{
				Mate1Id = other.Mate1Id;
			}
			if (other.Mate2Id != 0)
			{
				Mate2Id = other.Mate2Id;
			}
			if (other.Mate3Id != 0)
			{
				Mate3Id = other.Mate3Id;
			}
			if (other.Mate4Id != 0)
			{
				Mate4Id = other.Mate4Id;
			}
			if (other.Mate5Id != 0)
			{
				Mate5Id = other.Mate5Id;
			}
			if (other.Mate6Id != 0)
			{
				Mate6Id = other.Mate6Id;
			}
			if (other.Mate7Id != 0)
			{
				Mate7Id = other.Mate7Id;
			}
			mateMoreId_.Add(other.mateMoreId_);
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
				Mate0Id = input.ReadInt32();
				break;
			case 24u:
				Mate1Id = input.ReadInt32();
				break;
			case 32u:
				Mate2Id = input.ReadInt32();
				break;
			case 40u:
				Mate3Id = input.ReadInt32();
				break;
			case 48u:
				Mate4Id = input.ReadInt32();
				break;
			case 56u:
				Mate5Id = input.ReadInt32();
				break;
			case 64u:
				Mate6Id = input.ReadInt32();
				break;
			case 72u:
				Mate7Id = input.ReadInt32();
				break;
			case 80u:
			case 82u:
				mateMoreId_.AddEntriesFrom(input, _repeated_mateMoreId_codec);
				break;
			}
		}
	}
}
