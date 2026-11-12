using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MathParkourQuest : IMessage<MathParkourQuest>, IMessage, IEquatable<MathParkourQuest>, IDeepCloneable<MathParkourQuest>
{
	private static readonly MessageParser<MathParkourQuest> _parser = new MessageParser<MathParkourQuest>(() => new MathParkourQuest());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int ConditionFieldNumber = 3;

	private int condition_;

	public const int ConditionParamsFieldNumber = 4;

	private string conditionParams_ = "";

	public const int TargetFieldNumber = 5;

	private int target_;

	public const int DescFieldNumber = 6;

	private string desc_ = "";

	public const int Reward1IdFieldNumber = 7;

	private int reward1Id_;

	public const int Reward1CountFieldNumber = 8;

	private int reward1Count_;

	public const int Reward2IdFieldNumber = 9;

	private int reward2Id_;

	public const int Reward2CountFieldNumber = 10;

	private int reward2Count_;

	[DebuggerNonUserCode]
	public static MessageParser<MathParkourQuest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(546);

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
	public int Condition
	{
		get
		{
			return condition_;
		}
		set
		{
			condition_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ConditionParams
	{
		get
		{
			return conditionParams_;
		}
		set
		{
			conditionParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Target
	{
		get
		{
			return target_;
		}
		set
		{
			target_ = value;
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
	public MathParkourQuest()
	{
	}

	[DebuggerNonUserCode]
	public MathParkourQuest(MathParkourQuest other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		condition_ = other.condition_;
		conditionParams_ = other.conditionParams_;
		target_ = other.target_;
		desc_ = other.desc_;
		reward1Id_ = other.reward1Id_;
		reward1Count_ = other.reward1Count_;
		reward2Id_ = other.reward2Id_;
		reward2Count_ = other.reward2Count_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MathParkourQuest Clone()
	{
		return new MathParkourQuest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MathParkourQuest);
	}

	[DebuggerNonUserCode]
	public bool Equals(MathParkourQuest other)
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
		if (Condition != other.Condition)
		{
			return false;
		}
		if (ConditionParams != other.ConditionParams)
		{
			return false;
		}
		if (Target != other.Target)
		{
			return false;
		}
		if (Desc != other.Desc)
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
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (Condition != 0)
		{
			num ^= Condition.GetHashCode();
		}
		if (ConditionParams.Length != 0)
		{
			num ^= ConditionParams.GetHashCode();
		}
		if (Target != 0)
		{
			num ^= Target.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
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
		if (GroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GroupId);
		}
		if (Condition != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Condition);
		}
		if (ConditionParams.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(ConditionParams);
		}
		if (Target != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Target);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Desc);
		}
		if (Reward1Id != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Reward1Id);
		}
		if (Reward1Count != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Reward1Count);
		}
		if (Reward2Id != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Reward2Id);
		}
		if (Reward2Count != 0)
		{
			output.WriteRawTag(80);
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
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (Condition != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Condition);
		}
		if (ConditionParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ConditionParams);
		}
		if (Target != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Target);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
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
	public void MergeFrom(MathParkourQuest other)
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
			if (other.Condition != 0)
			{
				Condition = other.Condition;
			}
			if (other.ConditionParams.Length != 0)
			{
				ConditionParams = other.ConditionParams;
			}
			if (other.Target != 0)
			{
				Target = other.Target;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
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
				GroupId = input.ReadInt32();
				break;
			case 24u:
				Condition = input.ReadInt32();
				break;
			case 34u:
				ConditionParams = input.ReadString();
				break;
			case 40u:
				Target = input.ReadInt32();
				break;
			case 50u:
				Desc = input.ReadString();
				break;
			case 56u:
				Reward1Id = input.ReadInt32();
				break;
			case 64u:
				Reward1Count = input.ReadInt32();
				break;
			case 72u:
				Reward2Id = input.ReadInt32();
				break;
			case 80u:
				Reward2Count = input.ReadInt32();
				break;
			}
		}
	}
}
