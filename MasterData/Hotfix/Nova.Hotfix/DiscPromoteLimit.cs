using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DiscPromoteLimit : IMessage<DiscPromoteLimit>, IMessage, IEquatable<DiscPromoteLimit>, IDeepCloneable<DiscPromoteLimit>
{
	private static readonly MessageParser<DiscPromoteLimit> _parser = new MessageParser<DiscPromoteLimit>(() => new DiscPromoteLimit());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int RarityFieldNumber = 2;

	private int rarity_;

	public const int PhaseFieldNumber = 3;

	private string phase_ = "";

	public const int MaxLevelFieldNumber = 4;

	private string maxLevel_ = "";

	public const int WorldClassLimitFieldNumber = 5;

	private int worldClassLimit_;

	[DebuggerNonUserCode]
	public static MessageParser<DiscPromoteLimit> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(282);

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
	public string Phase
	{
		get
		{
			return phase_;
		}
		set
		{
			phase_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string MaxLevel
	{
		get
		{
			return maxLevel_;
		}
		set
		{
			maxLevel_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public DiscPromoteLimit()
	{
	}

	[DebuggerNonUserCode]
	public DiscPromoteLimit(DiscPromoteLimit other)
		: this()
	{
		id_ = other.id_;
		rarity_ = other.rarity_;
		phase_ = other.phase_;
		maxLevel_ = other.maxLevel_;
		worldClassLimit_ = other.worldClassLimit_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DiscPromoteLimit Clone()
	{
		return new DiscPromoteLimit(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DiscPromoteLimit);
	}

	[DebuggerNonUserCode]
	public bool Equals(DiscPromoteLimit other)
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
		if (Rarity != other.Rarity)
		{
			return false;
		}
		if (Phase != other.Phase)
		{
			return false;
		}
		if (MaxLevel != other.MaxLevel)
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
		if (Rarity != 0)
		{
			num ^= Rarity.GetHashCode();
		}
		if (Phase.Length != 0)
		{
			num ^= Phase.GetHashCode();
		}
		if (MaxLevel.Length != 0)
		{
			num ^= MaxLevel.GetHashCode();
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
		if (Rarity != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Rarity);
		}
		if (Phase.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Phase);
		}
		if (MaxLevel.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(MaxLevel);
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
		if (Rarity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rarity);
		}
		if (Phase.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Phase);
		}
		if (MaxLevel.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(MaxLevel);
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
	public void MergeFrom(DiscPromoteLimit other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Rarity != 0)
			{
				Rarity = other.Rarity;
			}
			if (other.Phase.Length != 0)
			{
				Phase = other.Phase;
			}
			if (other.MaxLevel.Length != 0)
			{
				MaxLevel = other.MaxLevel;
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
				Rarity = input.ReadInt32();
				break;
			case 26u:
				Phase = input.ReadString();
				break;
			case 34u:
				MaxLevel = input.ReadString();
				break;
			case 40u:
				WorldClassLimit = input.ReadInt32();
				break;
			}
		}
	}
}
