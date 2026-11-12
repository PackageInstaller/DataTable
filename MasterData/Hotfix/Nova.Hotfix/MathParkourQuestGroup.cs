using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MathParkourQuestGroup : IMessage<MathParkourQuestGroup>, IMessage, IEquatable<MathParkourQuestGroup>, IDeepCloneable<MathParkourQuestGroup>
{
	private static readonly MessageParser<MathParkourQuestGroup> _parser = new MessageParser<MathParkourQuestGroup>(() => new MathParkourQuestGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ActivityIdFieldNumber = 2;

	private int activityId_;

	public const int GroupNameFieldNumber = 3;

	private string groupName_ = "";

	public const int Reward1IdFieldNumber = 4;

	private int reward1Id_;

	public const int Reward1CountFieldNumber = 5;

	private int reward1Count_;

	public const int Reward2IdFieldNumber = 6;

	private int reward2Id_;

	public const int Reward2CountFieldNumber = 7;

	private int reward2Count_;

	[DebuggerNonUserCode]
	public static MessageParser<MathParkourQuestGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(548);

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
	public int ActivityId
	{
		get
		{
			return activityId_;
		}
		set
		{
			activityId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string GroupName
	{
		get
		{
			return groupName_;
		}
		set
		{
			groupName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Reward1Id
	{
		get
		{
			return reward1Id_;
		}
		set
		{
			reward1Id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward1Count
	{
		get
		{
			return reward1Count_;
		}
		set
		{
			reward1Count_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward2Id
	{
		get
		{
			return reward2Id_;
		}
		set
		{
			reward2Id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward2Count
	{
		get
		{
			return reward2Count_;
		}
		set
		{
			reward2Count_ = value;
		}
	}

	[DebuggerNonUserCode]
	public MathParkourQuestGroup()
	{
	}

	[DebuggerNonUserCode]
	public MathParkourQuestGroup(MathParkourQuestGroup other)
		: this()
	{
		id_ = other.id_;
		activityId_ = other.activityId_;
		groupName_ = other.groupName_;
		reward1Id_ = other.reward1Id_;
		reward1Count_ = other.reward1Count_;
		reward2Id_ = other.reward2Id_;
		reward2Count_ = other.reward2Count_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MathParkourQuestGroup Clone()
	{
		return new MathParkourQuestGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MathParkourQuestGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(MathParkourQuestGroup other)
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
		if (ActivityId != other.ActivityId)
		{
			return false;
		}
		if (GroupName != other.GroupName)
		{
			return false;
		}
		if (Reward1Id != other.Reward1Id)
		{
			return false;
		}
		if (Reward1Count != other.Reward1Count)
		{
			return false;
		}
		if (Reward2Id != other.Reward2Id)
		{
			return false;
		}
		if (Reward2Count != other.Reward2Count)
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
		if (ActivityId != 0)
		{
			num ^= ActivityId.GetHashCode();
		}
		if (GroupName.Length != 0)
		{
			num ^= GroupName.GetHashCode();
		}
		if (Reward1Id != 0)
		{
			num ^= Reward1Id.GetHashCode();
		}
		if (Reward1Count != 0)
		{
			num ^= Reward1Count.GetHashCode();
		}
		if (Reward2Id != 0)
		{
			num ^= Reward2Id.GetHashCode();
		}
		if (Reward2Count != 0)
		{
			num ^= Reward2Count.GetHashCode();
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
		if (ActivityId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ActivityId);
		}
		if (GroupName.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(GroupName);
		}
		if (Reward1Id != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Reward1Id);
		}
		if (Reward1Count != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Reward1Count);
		}
		if (Reward2Id != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Reward2Id);
		}
		if (Reward2Count != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Reward2Count);
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
		if (ActivityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityId);
		}
		if (GroupName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(GroupName);
		}
		if (Reward1Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward1Id);
		}
		if (Reward1Count != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward1Count);
		}
		if (Reward2Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward2Id);
		}
		if (Reward2Count != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward2Count);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MathParkourQuestGroup other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			if (other.GroupName.Length != 0)
			{
				GroupName = other.GroupName;
			}
			if (other.Reward1Id != 0)
			{
				Reward1Id = other.Reward1Id;
			}
			if (other.Reward1Count != 0)
			{
				Reward1Count = other.Reward1Count;
			}
			if (other.Reward2Id != 0)
			{
				Reward2Id = other.Reward2Id;
			}
			if (other.Reward2Count != 0)
			{
				Reward2Count = other.Reward2Count;
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
				ActivityId = input.ReadInt32();
				break;
			case 26u:
				GroupName = input.ReadString();
				break;
			case 32u:
				Reward1Id = input.ReadInt32();
				break;
			case 40u:
				Reward1Count = input.ReadInt32();
				break;
			case 48u:
				Reward2Id = input.ReadInt32();
				break;
			case 56u:
				Reward2Count = input.ReadInt32();
				break;
			}
		}
	}
}
