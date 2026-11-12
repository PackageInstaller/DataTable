using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class VampireSurvivorLevel : IMessage<VampireSurvivorLevel>, IMessage, IEquatable<VampireSurvivorLevel>, IDeepCloneable<VampireSurvivorLevel>
{
	private static readonly MessageParser<VampireSurvivorLevel> _parser = new MessageParser<VampireSurvivorLevel>(() => new VampireSurvivorLevel());

	private UnknownFieldSet _unknownFields;

	public const int GroupIDFieldNumber = 1;

	private int groupID_;

	public const int LevelFieldNumber = 2;

	private int level_;

	public const int ExpFieldNumber = 3;

	private int exp_;

	[DebuggerNonUserCode]
	public static MessageParser<VampireSurvivorLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1062);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int GroupID
	{
		get
		{
			return groupID_;
		}
		set
		{
			groupID_ = value;
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
	public int Exp
	{
		get
		{
			return exp_;
		}
		set
		{
			exp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public VampireSurvivorLevel()
	{
	}

	[DebuggerNonUserCode]
	public VampireSurvivorLevel(VampireSurvivorLevel other)
		: this()
	{
		groupID_ = other.groupID_;
		level_ = other.level_;
		exp_ = other.exp_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public VampireSurvivorLevel Clone()
	{
		return new VampireSurvivorLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as VampireSurvivorLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(VampireSurvivorLevel other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (GroupID != other.GroupID)
		{
			return false;
		}
		if (Level != other.Level)
		{
			return false;
		}
		if (Exp != other.Exp)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (GroupID != 0)
		{
			num ^= GroupID.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (Exp != 0)
		{
			num ^= Exp.GetHashCode();
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
		if (GroupID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(GroupID);
		}
		if (Level != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Level);
		}
		if (Exp != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Exp);
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
		if (GroupID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupID);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (Exp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Exp);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(VampireSurvivorLevel other)
	{
		if (other != null)
		{
			if (other.GroupID != 0)
			{
				GroupID = other.GroupID;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.Exp != 0)
			{
				Exp = other.Exp;
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
				GroupID = input.ReadInt32();
				break;
			case 16u:
				Level = input.ReadInt32();
				break;
			case 24u:
				Exp = input.ReadInt32();
				break;
			}
		}
	}
}
