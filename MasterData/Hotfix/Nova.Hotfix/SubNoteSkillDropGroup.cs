using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SubNoteSkillDropGroup : IMessage<SubNoteSkillDropGroup>, IMessage, IEquatable<SubNoteSkillDropGroup>, IDeepCloneable<SubNoteSkillDropGroup>
{
	private static readonly MessageParser<SubNoteSkillDropGroup> _parser = new MessageParser<SubNoteSkillDropGroup>(() => new SubNoteSkillDropGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int SubNoteSkillIdFieldNumber = 3;

	private int subNoteSkillId_;

	[DebuggerNonUserCode]
	public static MessageParser<SubNoteSkillDropGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(912);

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
	public int SubNoteSkillId
	{
		get
		{
			return subNoteSkillId_;
		}
		set
		{
			subNoteSkillId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SubNoteSkillDropGroup()
	{
	}

	[DebuggerNonUserCode]
	public SubNoteSkillDropGroup(SubNoteSkillDropGroup other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		subNoteSkillId_ = other.subNoteSkillId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SubNoteSkillDropGroup Clone()
	{
		return new SubNoteSkillDropGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SubNoteSkillDropGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(SubNoteSkillDropGroup other)
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
		if (SubNoteSkillId != other.SubNoteSkillId)
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
		if (SubNoteSkillId != 0)
		{
			num ^= SubNoteSkillId.GetHashCode();
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
		if (SubNoteSkillId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(SubNoteSkillId);
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
		if (SubNoteSkillId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SubNoteSkillId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SubNoteSkillDropGroup other)
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
			if (other.SubNoteSkillId != 0)
			{
				SubNoteSkillId = other.SubNoteSkillId;
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
				SubNoteSkillId = input.ReadInt32();
				break;
			}
		}
	}
}
