using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierEventPersonalityStory : IMessage<SoldierEventPersonalityStory>, IMessage, IEquatable<SoldierEventPersonalityStory>, IDeepCloneable<SoldierEventPersonalityStory>
{
	private static readonly MessageParser<SoldierEventPersonalityStory> _parser = new MessageParser<SoldierEventPersonalityStory>(() => new SoldierEventPersonalityStory());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int WeightFieldNumber = 3;

	private string weight_ = "";

	public const int StoryTypeIdFieldNumber = 4;

	private int storyTypeId_;

	public const int OptionRuleFieldNumber = 5;

	private int optionRule_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierEventPersonalityStory> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(760);

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
	public string Weight
	{
		get
		{
			return weight_;
		}
		set
		{
			weight_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int StoryTypeId
	{
		get
		{
			return storyTypeId_;
		}
		set
		{
			storyTypeId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int OptionRule
	{
		get
		{
			return optionRule_;
		}
		set
		{
			optionRule_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierEventPersonalityStory()
	{
	}

	[DebuggerNonUserCode]
	public SoldierEventPersonalityStory(SoldierEventPersonalityStory other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		weight_ = other.weight_;
		storyTypeId_ = other.storyTypeId_;
		optionRule_ = other.optionRule_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierEventPersonalityStory Clone()
	{
		return new SoldierEventPersonalityStory(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierEventPersonalityStory);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierEventPersonalityStory other)
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
		if (Weight != other.Weight)
		{
			return false;
		}
		if (StoryTypeId != other.StoryTypeId)
		{
			return false;
		}
		if (OptionRule != other.OptionRule)
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
		if (Weight.Length != 0)
		{
			num ^= Weight.GetHashCode();
		}
		if (StoryTypeId != 0)
		{
			num ^= StoryTypeId.GetHashCode();
		}
		if (OptionRule != 0)
		{
			num ^= OptionRule.GetHashCode();
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
		if (GroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GroupId);
		}
		if (Weight.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Weight);
		}
		if (StoryTypeId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(StoryTypeId);
		}
		if (OptionRule != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(OptionRule);
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
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (Weight.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Weight);
		}
		if (StoryTypeId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StoryTypeId);
		}
		if (OptionRule != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OptionRule);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierEventPersonalityStory other)
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
			if (other.Weight.Length != 0)
			{
				Weight = other.Weight;
			}
			if (other.StoryTypeId != 0)
			{
				StoryTypeId = other.StoryTypeId;
			}
			if (other.OptionRule != 0)
			{
				OptionRule = other.OptionRule;
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
				GroupId = input.ReadInt32();
				break;
			case 26u:
				Weight = input.ReadString();
				break;
			case 32u:
				StoryTypeId = input.ReadInt32();
				break;
			case 40u:
				OptionRule = input.ReadInt32();
				break;
			}
		}
	}
}
