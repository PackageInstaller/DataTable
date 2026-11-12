using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerBuildRank : IMessage<StarTowerBuildRank>, IMessage, IEquatable<StarTowerBuildRank>, IDeepCloneable<StarTowerBuildRank>
{
	private static readonly MessageParser<StarTowerBuildRank> _parser = new MessageParser<StarTowerBuildRank>(() => new StarTowerBuildRank());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int MinGradeFieldNumber = 2;

	private int minGrade_;

	public const int RarityFieldNumber = 3;

	private int rarity_;

	public const int AttrBaseGroupIdFieldNumber = 4;

	private int attrBaseGroupId_;

	public const int LevelFieldNumber = 5;

	private int level_;

	public const int DescFieldNumber = 6;

	private string desc_ = "";

	public const int Param1FieldNumber = 7;

	private int param1_;

	public const int Param2FieldNumber = 8;

	private int param2_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerBuildRank> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(832);

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
	public int MinGrade
	{
		get
		{
			return minGrade_;
		}
		set
		{
			minGrade_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Rarity
	{
		get
		{
			return rarity_;
		}
		set
		{
			rarity_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AttrBaseGroupId
	{
		get
		{
			return attrBaseGroupId_;
		}
		set
		{
			attrBaseGroupId_ = value;
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
	public StarTowerBuildRank()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerBuildRank(StarTowerBuildRank other)
		: this()
	{
		id_ = other.id_;
		minGrade_ = other.minGrade_;
		rarity_ = other.rarity_;
		attrBaseGroupId_ = other.attrBaseGroupId_;
		level_ = other.level_;
		desc_ = other.desc_;
		param1_ = other.param1_;
		param2_ = other.param2_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerBuildRank Clone()
	{
		return new StarTowerBuildRank(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerBuildRank);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerBuildRank other)
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
		if (MinGrade != other.MinGrade)
		{
			return false;
		}
		if (Rarity != other.Rarity)
		{
			return false;
		}
		if (AttrBaseGroupId != other.AttrBaseGroupId)
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
		if (Param1 != other.Param1)
		{
			return false;
		}
		if (Param2 != other.Param2)
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
		if (MinGrade != 0)
		{
			num ^= MinGrade.GetHashCode();
		}
		if (Rarity != 0)
		{
			num ^= Rarity.GetHashCode();
		}
		if (AttrBaseGroupId != 0)
		{
			num ^= AttrBaseGroupId.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Param1 != 0)
		{
			num ^= Param1.GetHashCode();
		}
		if (Param2 != 0)
		{
			num ^= Param2.GetHashCode();
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
		if (MinGrade != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(MinGrade);
		}
		if (Rarity != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Rarity);
		}
		if (AttrBaseGroupId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(AttrBaseGroupId);
		}
		if (Level != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Level);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Desc);
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
		if (MinGrade != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MinGrade);
		}
		if (Rarity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rarity);
		}
		if (AttrBaseGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AttrBaseGroupId);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Param1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Param1);
		}
		if (Param2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Param2);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerBuildRank other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.MinGrade != 0)
			{
				MinGrade = other.MinGrade;
			}
			if (other.Rarity != 0)
			{
				Rarity = other.Rarity;
			}
			if (other.AttrBaseGroupId != 0)
			{
				AttrBaseGroupId = other.AttrBaseGroupId;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Param1 != 0)
			{
				Param1 = other.Param1;
			}
			if (other.Param2 != 0)
			{
				Param2 = other.Param2;
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
				MinGrade = input.ReadInt32();
				break;
			case 24u:
				Rarity = input.ReadInt32();
				break;
			case 32u:
				AttrBaseGroupId = input.ReadInt32();
				break;
			case 40u:
				Level = input.ReadInt32();
				break;
			case 50u:
				Desc = input.ReadString();
				break;
			case 56u:
				Param1 = input.ReadInt32();
				break;
			case 64u:
				Param2 = input.ReadInt32();
				break;
			}
		}
	}
}
