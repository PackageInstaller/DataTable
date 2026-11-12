using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SubNoteSkillPromoteGroup : IMessage<SubNoteSkillPromoteGroup>, IMessage, IEquatable<SubNoteSkillPromoteGroup>, IDeepCloneable<SubNoteSkillPromoteGroup>
{
	private static readonly MessageParser<SubNoteSkillPromoteGroup> _parser = new MessageParser<SubNoteSkillPromoteGroup>(() => new SubNoteSkillPromoteGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int PhaseFieldNumber = 3;

	private int phase_;

	public const int SubNoteSkillsFieldNumber = 4;

	private string subNoteSkills_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<SubNoteSkillPromoteGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(914);

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
	public int Phase
	{
		get
		{
			return phase_;
		}
		set
		{
			phase_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string SubNoteSkills
	{
		get
		{
			return subNoteSkills_;
		}
		set
		{
			subNoteSkills_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public SubNoteSkillPromoteGroup()
	{
	}

	[DebuggerNonUserCode]
	public SubNoteSkillPromoteGroup(SubNoteSkillPromoteGroup other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		phase_ = other.phase_;
		subNoteSkills_ = other.subNoteSkills_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SubNoteSkillPromoteGroup Clone()
	{
		return new SubNoteSkillPromoteGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SubNoteSkillPromoteGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(SubNoteSkillPromoteGroup other)
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
		if (Phase != other.Phase)
		{
			return false;
		}
		if (SubNoteSkills != other.SubNoteSkills)
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
		if (Phase != 0)
		{
			num ^= Phase.GetHashCode();
		}
		if (SubNoteSkills.Length != 0)
		{
			num ^= SubNoteSkills.GetHashCode();
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
		if (Phase != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Phase);
		}
		if (SubNoteSkills.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(SubNoteSkills);
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
		if (Phase != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Phase);
		}
		if (SubNoteSkills.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SubNoteSkills);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SubNoteSkillPromoteGroup other)
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
			if (other.Phase != 0)
			{
				Phase = other.Phase;
			}
			if (other.SubNoteSkills.Length != 0)
			{
				SubNoteSkills = other.SubNoteSkills;
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
				Phase = input.ReadInt32();
				break;
			case 34u:
				SubNoteSkills = input.ReadString();
				break;
			}
		}
	}
}
