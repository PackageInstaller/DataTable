using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharRaritySequence : IMessage<CharRaritySequence>, IMessage, IEquatable<CharRaritySequence>, IDeepCloneable<CharRaritySequence>
{
	private static readonly MessageParser<CharRaritySequence> _parser = new MessageParser<CharRaritySequence>(() => new CharRaritySequence());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GradeFieldNumber = 2;

	private int grade_;

	public const int AdvanceLvlFieldNumber = 3;

	private int advanceLvl_;

	public const int LvLimitFieldNumber = 4;

	private int lvLimit_;

	public const int WorldClassLimitFieldNumber = 5;

	private int worldClassLimit_;

	[DebuggerNonUserCode]
	public static MessageParser<CharRaritySequence> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(208);

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
	public int Grade
	{
		get
		{
			return grade_;
		}
		set
		{
			grade_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AdvanceLvl
	{
		get
		{
			return advanceLvl_;
		}
		set
		{
			advanceLvl_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LvLimit
	{
		get
		{
			return lvLimit_;
		}
		set
		{
			lvLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WorldClassLimit
	{
		get
		{
			return worldClassLimit_;
		}
		set
		{
			worldClassLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public CharRaritySequence()
	{
	}

	[DebuggerNonUserCode]
	public CharRaritySequence(CharRaritySequence other)
		: this()
	{
		id_ = other.id_;
		grade_ = other.grade_;
		advanceLvl_ = other.advanceLvl_;
		lvLimit_ = other.lvLimit_;
		worldClassLimit_ = other.worldClassLimit_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharRaritySequence Clone()
	{
		return new CharRaritySequence(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharRaritySequence);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharRaritySequence other)
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
		if (Grade != other.Grade)
		{
			return false;
		}
		if (AdvanceLvl != other.AdvanceLvl)
		{
			return false;
		}
		if (LvLimit != other.LvLimit)
		{
			return false;
		}
		if (WorldClassLimit != other.WorldClassLimit)
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
		if (Grade != 0)
		{
			num ^= Grade.GetHashCode();
		}
		if (AdvanceLvl != 0)
		{
			num ^= AdvanceLvl.GetHashCode();
		}
		if (LvLimit != 0)
		{
			num ^= LvLimit.GetHashCode();
		}
		if (WorldClassLimit != 0)
		{
			num ^= WorldClassLimit.GetHashCode();
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
		if (Grade != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Grade);
		}
		if (AdvanceLvl != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(AdvanceLvl);
		}
		if (LvLimit != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(LvLimit);
		}
		if (WorldClassLimit != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(WorldClassLimit);
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
		if (Grade != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Grade);
		}
		if (AdvanceLvl != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AdvanceLvl);
		}
		if (LvLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LvLimit);
		}
		if (WorldClassLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WorldClassLimit);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharRaritySequence other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Grade != 0)
			{
				Grade = other.Grade;
			}
			if (other.AdvanceLvl != 0)
			{
				AdvanceLvl = other.AdvanceLvl;
			}
			if (other.LvLimit != 0)
			{
				LvLimit = other.LvLimit;
			}
			if (other.WorldClassLimit != 0)
			{
				WorldClassLimit = other.WorldClassLimit;
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
				Grade = input.ReadInt32();
				break;
			case 24u:
				AdvanceLvl = input.ReadInt32();
				break;
			case 32u:
				LvLimit = input.ReadInt32();
				break;
			case 40u:
				WorldClassLimit = input.ReadInt32();
				break;
			}
		}
	}
}
