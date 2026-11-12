using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PenguinCardEndlessLevel : IMessage<PenguinCardEndlessLevel>, IMessage, IEquatable<PenguinCardEndlessLevel>, IDeepCloneable<PenguinCardEndlessLevel>
{
	private static readonly MessageParser<PenguinCardEndlessLevel> _parser = new MessageParser<PenguinCardEndlessLevel>(() => new PenguinCardEndlessLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int LevelFieldNumber = 3;

	private int level_;

	public const int DescFieldNumber = 4;

	private string desc_ = "";

	public const int BuffIdFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_buffId_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> buffId_ = new RepeatedField<int>();

	public const int AimScoreFieldNumber = 6;

	private int aimScore_;

	public const int AidePoolFieldNumber = 7;

	private int aidePool_;

	public const int InitialCardFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_initialCard_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> initialCard_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<PenguinCardEndlessLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(628);

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
	public RepeatedField<int> BuffId => buffId_;

	[DebuggerNonUserCode]
	public int AimScore
	{
		get
		{
			return aimScore_;
		}
		set
		{
			aimScore_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AidePool
	{
		get
		{
			return aidePool_;
		}
		set
		{
			aidePool_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> InitialCard => initialCard_;

	[DebuggerNonUserCode]
	public PenguinCardEndlessLevel()
	{
	}

	[DebuggerNonUserCode]
	public PenguinCardEndlessLevel(PenguinCardEndlessLevel other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		level_ = other.level_;
		desc_ = other.desc_;
		buffId_ = other.buffId_.Clone();
		aimScore_ = other.aimScore_;
		aidePool_ = other.aidePool_;
		initialCard_ = other.initialCard_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PenguinCardEndlessLevel Clone()
	{
		return new PenguinCardEndlessLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PenguinCardEndlessLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(PenguinCardEndlessLevel other)
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
		if (Desc != other.Desc)
		{
			return false;
		}
		if (!buffId_.Equals(other.buffId_))
		{
			return false;
		}
		if (AimScore != other.AimScore)
		{
			return false;
		}
		if (AidePool != other.AidePool)
		{
			return false;
		}
		if (!initialCard_.Equals(other.initialCard_))
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
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		num ^= buffId_.GetHashCode();
		if (AimScore != 0)
		{
			num ^= AimScore.GetHashCode();
		}
		if (AidePool != 0)
		{
			num ^= AidePool.GetHashCode();
		}
		num ^= initialCard_.GetHashCode();
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
		if (Desc.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Desc);
		}
		buffId_.WriteTo(output, _repeated_buffId_codec);
		if (AimScore != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(AimScore);
		}
		if (AidePool != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(AidePool);
		}
		initialCard_.WriteTo(output, _repeated_initialCard_codec);
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
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		num += buffId_.CalculateSize(_repeated_buffId_codec);
		if (AimScore != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AimScore);
		}
		if (AidePool != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AidePool);
		}
		num += initialCard_.CalculateSize(_repeated_initialCard_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PenguinCardEndlessLevel other)
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
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			buffId_.Add(other.buffId_);
			if (other.AimScore != 0)
			{
				AimScore = other.AimScore;
			}
			if (other.AidePool != 0)
			{
				AidePool = other.AidePool;
			}
			initialCard_.Add(other.initialCard_);
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
				Desc = input.ReadString();
				break;
			case 40u:
			case 42u:
				buffId_.AddEntriesFrom(input, _repeated_buffId_codec);
				break;
			case 48u:
				AimScore = input.ReadInt32();
				break;
			case 56u:
				AidePool = input.ReadInt32();
				break;
			case 64u:
			case 66u:
				initialCard_.AddEntriesFrom(input, _repeated_initialCard_codec);
				break;
			}
		}
	}
}
