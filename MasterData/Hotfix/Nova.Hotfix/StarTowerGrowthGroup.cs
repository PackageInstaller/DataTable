using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerGrowthGroup : IMessage<StarTowerGrowthGroup>, IMessage, IEquatable<StarTowerGrowthGroup>, IDeepCloneable<StarTowerGrowthGroup>
{
	private static readonly MessageParser<StarTowerGrowthGroup> _parser = new MessageParser<StarTowerGrowthGroup>(() => new StarTowerGrowthGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int PreGroupFieldNumber = 2;

	private int preGroup_;

	public const int WorldClassFieldNumber = 3;

	private int worldClass_;

	public const int NameFieldNumber = 4;

	private string name_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerGrowthGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(856);

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
	public int PreGroup
	{
		get
		{
			return preGroup_;
		}
		set
		{
			preGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WorldClass
	{
		get
		{
			return worldClass_;
		}
		set
		{
			worldClass_ = value;
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
	public StarTowerGrowthGroup()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerGrowthGroup(StarTowerGrowthGroup other)
		: this()
	{
		id_ = other.id_;
		preGroup_ = other.preGroup_;
		worldClass_ = other.worldClass_;
		name_ = other.name_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerGrowthGroup Clone()
	{
		return new StarTowerGrowthGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerGrowthGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerGrowthGroup other)
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
		if (PreGroup != other.PreGroup)
		{
			return false;
		}
		if (WorldClass != other.WorldClass)
		{
			return false;
		}
		if (Name != other.Name)
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
		if (PreGroup != 0)
		{
			num ^= PreGroup.GetHashCode();
		}
		if (WorldClass != 0)
		{
			num ^= WorldClass.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
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
		if (PreGroup != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(PreGroup);
		}
		if (WorldClass != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(WorldClass);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name);
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
		if (PreGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreGroup);
		}
		if (WorldClass != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WorldClass);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerGrowthGroup other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.PreGroup != 0)
			{
				PreGroup = other.PreGroup;
			}
			if (other.WorldClass != 0)
			{
				WorldClass = other.WorldClass;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
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
				PreGroup = input.ReadInt32();
				break;
			case 24u:
				WorldClass = input.ReadInt32();
				break;
			case 34u:
				Name = input.ReadString();
				break;
			}
		}
	}
}
