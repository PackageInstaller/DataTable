using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierQuestGroup : IMessage<SoldierQuestGroup>, IMessage, IEquatable<SoldierQuestGroup>, IDeepCloneable<SoldierQuestGroup>
{
	private static readonly MessageParser<SoldierQuestGroup> _parser = new MessageParser<SoldierQuestGroup>(() => new SoldierQuestGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int OpenDayFieldNumber = 3;

	private int openDay_;

	public const int DesFieldNumber = 4;

	private string des_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<SoldierQuestGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(786);

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
	public int OpenDay
	{
		get
		{
			return openDay_;
		}
		set
		{
			openDay_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Des
	{
		get
		{
			return des_;
		}
		set
		{
			des_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public SoldierQuestGroup()
	{
	}

	[DebuggerNonUserCode]
	public SoldierQuestGroup(SoldierQuestGroup other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		openDay_ = other.openDay_;
		des_ = other.des_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierQuestGroup Clone()
	{
		return new SoldierQuestGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierQuestGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierQuestGroup other)
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
		if (OpenDay != other.OpenDay)
		{
			return false;
		}
		if (Des != other.Des)
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
		if (OpenDay != 0)
		{
			num ^= OpenDay.GetHashCode();
		}
		if (Des.Length != 0)
		{
			num ^= Des.GetHashCode();
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
		if (OpenDay != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(OpenDay);
		}
		if (Des.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Des);
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
		if (OpenDay != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OpenDay);
		}
		if (Des.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Des);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierQuestGroup other)
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
			if (other.OpenDay != 0)
			{
				OpenDay = other.OpenDay;
			}
			if (other.Des.Length != 0)
			{
				Des = other.Des;
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
				OpenDay = input.ReadInt32();
				break;
			case 34u:
				Des = input.ReadString();
				break;
			}
		}
	}
}
