using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierOptionType : IMessage<SoldierOptionType>, IMessage, IEquatable<SoldierOptionType>, IDeepCloneable<SoldierOptionType>
{
	private static readonly MessageParser<SoldierOptionType> _parser = new MessageParser<SoldierOptionType>(() => new SoldierOptionType());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int StoryTypeFieldNumber = 2;

	private int storyType_;

	public const int OptionDescFieldNumber = 3;

	private string optionDesc_ = "";

	public const int CostDescFieldNumber = 4;

	private string costDesc_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<SoldierOptionType> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(774);

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
	public int StoryType
	{
		get
		{
			return storyType_;
		}
		set
		{
			storyType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string OptionDesc
	{
		get
		{
			return optionDesc_;
		}
		set
		{
			optionDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CostDesc
	{
		get
		{
			return costDesc_;
		}
		set
		{
			costDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public SoldierOptionType()
	{
	}

	[DebuggerNonUserCode]
	public SoldierOptionType(SoldierOptionType other)
		: this()
	{
		id_ = other.id_;
		storyType_ = other.storyType_;
		optionDesc_ = other.optionDesc_;
		costDesc_ = other.costDesc_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierOptionType Clone()
	{
		return new SoldierOptionType(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierOptionType);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierOptionType other)
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
		if (StoryType != other.StoryType)
		{
			return false;
		}
		if (OptionDesc != other.OptionDesc)
		{
			return false;
		}
		if (CostDesc != other.CostDesc)
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
		if (StoryType != 0)
		{
			num ^= StoryType.GetHashCode();
		}
		if (OptionDesc.Length != 0)
		{
			num ^= OptionDesc.GetHashCode();
		}
		if (CostDesc.Length != 0)
		{
			num ^= CostDesc.GetHashCode();
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
		if (StoryType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(StoryType);
		}
		if (OptionDesc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(OptionDesc);
		}
		if (CostDesc.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(CostDesc);
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
		if (StoryType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StoryType);
		}
		if (OptionDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OptionDesc);
		}
		if (CostDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CostDesc);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierOptionType other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.StoryType != 0)
			{
				StoryType = other.StoryType;
			}
			if (other.OptionDesc.Length != 0)
			{
				OptionDesc = other.OptionDesc;
			}
			if (other.CostDesc.Length != 0)
			{
				CostDesc = other.CostDesc;
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
				StoryType = input.ReadInt32();
				break;
			case 26u:
				OptionDesc = input.ReadString();
				break;
			case 34u:
				CostDesc = input.ReadString();
				break;
			}
		}
	}
}
