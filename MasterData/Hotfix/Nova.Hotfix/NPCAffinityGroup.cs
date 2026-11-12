using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class NPCAffinityGroup : IMessage<NPCAffinityGroup>, IMessage, IEquatable<NPCAffinityGroup>, IDeepCloneable<NPCAffinityGroup>
{
	private static readonly MessageParser<NPCAffinityGroup> _parser = new MessageParser<NPCAffinityGroup>(() => new NPCAffinityGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int LevelFieldNumber = 2;

	private int level_;

	public const int AffinityValueFieldNumber = 3;

	private int affinityValue_;

	public const int AffinityGroupIdFieldNumber = 4;

	private int affinityGroupId_;

	public const int RelationshipNameFieldNumber = 5;

	private string relationshipName_ = "";

	public const int IconFieldNumber = 6;

	private string icon_ = "";

	public const int AffinityLevelStageFieldNumber = 7;

	private int affinityLevelStage_;

	public const int RewardFieldNumber = 8;

	private string reward_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<NPCAffinityGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(596);

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
	public int AffinityValue
	{
		get
		{
			return affinityValue_;
		}
		set
		{
			affinityValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AffinityGroupId
	{
		get
		{
			return affinityGroupId_;
		}
		set
		{
			affinityGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string RelationshipName
	{
		get
		{
			return relationshipName_;
		}
		set
		{
			relationshipName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int AffinityLevelStage
	{
		get
		{
			return affinityLevelStage_;
		}
		set
		{
			affinityLevelStage_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Reward
	{
		get
		{
			return reward_;
		}
		set
		{
			reward_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public NPCAffinityGroup()
	{
	}

	[DebuggerNonUserCode]
	public NPCAffinityGroup(NPCAffinityGroup other)
		: this()
	{
		id_ = other.id_;
		level_ = other.level_;
		affinityValue_ = other.affinityValue_;
		affinityGroupId_ = other.affinityGroupId_;
		relationshipName_ = other.relationshipName_;
		icon_ = other.icon_;
		affinityLevelStage_ = other.affinityLevelStage_;
		reward_ = other.reward_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public NPCAffinityGroup Clone()
	{
		return new NPCAffinityGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as NPCAffinityGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(NPCAffinityGroup other)
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
		if (Level != other.Level)
		{
			return false;
		}
		if (AffinityValue != other.AffinityValue)
		{
			return false;
		}
		if (AffinityGroupId != other.AffinityGroupId)
		{
			return false;
		}
		if (RelationshipName != other.RelationshipName)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (AffinityLevelStage != other.AffinityLevelStage)
		{
			return false;
		}
		if (Reward != other.Reward)
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
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (AffinityValue != 0)
		{
			num ^= AffinityValue.GetHashCode();
		}
		if (AffinityGroupId != 0)
		{
			num ^= AffinityGroupId.GetHashCode();
		}
		if (RelationshipName.Length != 0)
		{
			num ^= RelationshipName.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (AffinityLevelStage != 0)
		{
			num ^= AffinityLevelStage.GetHashCode();
		}
		if (Reward.Length != 0)
		{
			num ^= Reward.GetHashCode();
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
		if (Level != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Level);
		}
		if (AffinityValue != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(AffinityValue);
		}
		if (AffinityGroupId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(AffinityGroupId);
		}
		if (RelationshipName.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(RelationshipName);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Icon);
		}
		if (AffinityLevelStage != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(AffinityLevelStage);
		}
		if (Reward.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Reward);
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
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (AffinityValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AffinityValue);
		}
		if (AffinityGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AffinityGroupId);
		}
		if (RelationshipName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RelationshipName);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (AffinityLevelStage != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AffinityLevelStage);
		}
		if (Reward.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Reward);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(NPCAffinityGroup other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.AffinityValue != 0)
			{
				AffinityValue = other.AffinityValue;
			}
			if (other.AffinityGroupId != 0)
			{
				AffinityGroupId = other.AffinityGroupId;
			}
			if (other.RelationshipName.Length != 0)
			{
				RelationshipName = other.RelationshipName;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.AffinityLevelStage != 0)
			{
				AffinityLevelStage = other.AffinityLevelStage;
			}
			if (other.Reward.Length != 0)
			{
				Reward = other.Reward;
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
				Level = input.ReadInt32();
				break;
			case 24u:
				AffinityValue = input.ReadInt32();
				break;
			case 32u:
				AffinityGroupId = input.ReadInt32();
				break;
			case 42u:
				RelationshipName = input.ReadString();
				break;
			case 50u:
				Icon = input.ReadString();
				break;
			case 56u:
				AffinityLevelStage = input.ReadInt32();
				break;
			case 66u:
				Reward = input.ReadString();
				break;
			}
		}
	}
}
