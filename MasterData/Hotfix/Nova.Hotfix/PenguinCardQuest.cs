using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PenguinCardQuest : IMessage<PenguinCardQuest>, IMessage, IEquatable<PenguinCardQuest>, IDeepCloneable<PenguinCardQuest>
{
	private static readonly MessageParser<PenguinCardQuest> _parser = new MessageParser<PenguinCardQuest>(() => new PenguinCardQuest());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int DescFieldNumber = 2;

	private string desc_ = "";

	public const int TypeFieldNumber = 3;

	private int type_;

	public const int BuffGroupFieldNumber = 4;

	private int buffGroup_;

	public const int LevelFieldNumber = 5;

	private int level_;

	public const int TurnLimitFieldNumber = 6;

	private int turnLimit_;

	public const int Param1FieldNumber = 7;

	private int param1_;

	public const int Param2FieldNumber = 8;

	private int param2_;

	public const int Param3FieldNumber = 9;

	private int param3_;

	public const int Param4FieldNumber = 10;

	private int param4_;

	[DebuggerNonUserCode]
	public static MessageParser<PenguinCardQuest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(636);

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
	public int BuffGroup
	{
		get
		{
			return buffGroup_;
		}
		set
		{
			buffGroup_ = value;
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
	public int TurnLimit
	{
		get
		{
			return turnLimit_;
		}
		set
		{
			turnLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Param1
	{
		get
		{
			return param1_;
		}
		set
		{
			param1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Param2
	{
		get
		{
			return param2_;
		}
		set
		{
			param2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Param3
	{
		get
		{
			return param3_;
		}
		set
		{
			param3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Param4
	{
		get
		{
			return param4_;
		}
		set
		{
			param4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public PenguinCardQuest()
	{
	}

	[DebuggerNonUserCode]
	public PenguinCardQuest(PenguinCardQuest other)
		: this()
	{
		id_ = other.id_;
		desc_ = other.desc_;
		type_ = other.type_;
		buffGroup_ = other.buffGroup_;
		level_ = other.level_;
		turnLimit_ = other.turnLimit_;
		param1_ = other.param1_;
		param2_ = other.param2_;
		param3_ = other.param3_;
		param4_ = other.param4_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PenguinCardQuest Clone()
	{
		return new PenguinCardQuest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PenguinCardQuest);
	}

	[DebuggerNonUserCode]
	public bool Equals(PenguinCardQuest other)
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
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (BuffGroup != other.BuffGroup)
		{
			return false;
		}
		if (Level != other.Level)
		{
			return false;
		}
		if (TurnLimit != other.TurnLimit)
		{
			return false;
		}
		if (Param1 != other.Param1)
		{
			return false;
		}
		if (Param2 != other.Param2)
		{
			return false;
		}
		if (Param3 != other.Param3)
		{
			return false;
		}
		if (Param4 != other.Param4)
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
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (BuffGroup != 0)
		{
			num ^= BuffGroup.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (TurnLimit != 0)
		{
			num ^= TurnLimit.GetHashCode();
		}
		if (Param1 != 0)
		{
			num ^= Param1.GetHashCode();
		}
		if (Param2 != 0)
		{
			num ^= Param2.GetHashCode();
		}
		if (Param3 != 0)
		{
			num ^= Param3.GetHashCode();
		}
		if (Param4 != 0)
		{
			num ^= Param4.GetHashCode();
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
		if (Desc.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Desc);
		}
		if (Type != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Type);
		}
		if (BuffGroup != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(BuffGroup);
		}
		if (Level != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Level);
		}
		if (TurnLimit != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(TurnLimit);
		}
		if (Param1 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Param1);
		}
		if (Param2 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Param2);
		}
		if (Param3 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Param3);
		}
		if (Param4 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Param4);
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
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (BuffGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuffGroup);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (TurnLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TurnLimit);
		}
		if (Param1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Param1);
		}
		if (Param2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Param2);
		}
		if (Param3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Param3);
		}
		if (Param4 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Param4);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PenguinCardQuest other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.BuffGroup != 0)
			{
				BuffGroup = other.BuffGroup;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.TurnLimit != 0)
			{
				TurnLimit = other.TurnLimit;
			}
			if (other.Param1 != 0)
			{
				Param1 = other.Param1;
			}
			if (other.Param2 != 0)
			{
				Param2 = other.Param2;
			}
			if (other.Param3 != 0)
			{
				Param3 = other.Param3;
			}
			if (other.Param4 != 0)
			{
				Param4 = other.Param4;
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
				Desc = input.ReadString();
				break;
			case 24u:
				Type = input.ReadInt32();
				break;
			case 32u:
				BuffGroup = input.ReadInt32();
				break;
			case 40u:
				Level = input.ReadInt32();
				break;
			case 48u:
				TurnLimit = input.ReadInt32();
				break;
			case 56u:
				Param1 = input.ReadInt32();
				break;
			case 64u:
				Param2 = input.ReadInt32();
				break;
			case 72u:
				Param3 = input.ReadInt32();
				break;
			case 80u:
				Param4 = input.ReadInt32();
				break;
			}
		}
	}
}
