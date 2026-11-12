using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MonsterAttributeContact : IMessage<MonsterAttributeContact>, IMessage, IEquatable<MonsterAttributeContact>, IDeepCloneable<MonsterAttributeContact>
{
	private static readonly MessageParser<MonsterAttributeContact> _parser = new MessageParser<MonsterAttributeContact>(() => new MonsterAttributeContact());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int MaxLevelFieldNumber = 3;

	private int maxLevel_;

	public const int AtkTemplateIdFieldNumber = 4;

	private int atkTemplateId_;

	[DebuggerNonUserCode]
	public static MessageParser<MonsterAttributeContact> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(574);

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
	public int MaxLevel
	{
		get
		{
			return maxLevel_;
		}
		set
		{
			maxLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AtkTemplateId
	{
		get
		{
			return atkTemplateId_;
		}
		set
		{
			atkTemplateId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public MonsterAttributeContact()
	{
	}

	[DebuggerNonUserCode]
	public MonsterAttributeContact(MonsterAttributeContact other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		maxLevel_ = other.maxLevel_;
		atkTemplateId_ = other.atkTemplateId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MonsterAttributeContact Clone()
	{
		return new MonsterAttributeContact(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MonsterAttributeContact);
	}

	[DebuggerNonUserCode]
	public bool Equals(MonsterAttributeContact other)
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
		if (MaxLevel != other.MaxLevel)
		{
			return false;
		}
		if (AtkTemplateId != other.AtkTemplateId)
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
		if (MaxLevel != 0)
		{
			num ^= MaxLevel.GetHashCode();
		}
		if (AtkTemplateId != 0)
		{
			num ^= AtkTemplateId.GetHashCode();
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
		if (MaxLevel != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(MaxLevel);
		}
		if (AtkTemplateId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(AtkTemplateId);
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
		if (MaxLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxLevel);
		}
		if (AtkTemplateId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AtkTemplateId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MonsterAttributeContact other)
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
			if (other.MaxLevel != 0)
			{
				MaxLevel = other.MaxLevel;
			}
			if (other.AtkTemplateId != 0)
			{
				AtkTemplateId = other.AtkTemplateId;
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
				MaxLevel = input.ReadInt32();
				break;
			case 32u:
				AtkTemplateId = input.ReadInt32();
				break;
			}
		}
	}
}
