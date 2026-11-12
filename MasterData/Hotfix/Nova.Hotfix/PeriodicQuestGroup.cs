using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PeriodicQuestGroup : IMessage<PeriodicQuestGroup>, IMessage, IEquatable<PeriodicQuestGroup>, IDeepCloneable<PeriodicQuestGroup>
{
	private static readonly MessageParser<PeriodicQuestGroup> _parser = new MessageParser<PeriodicQuestGroup>(() => new PeriodicQuestGroup());

	private UnknownFieldSet _unknownFields;

	public const int BelongFieldNumber = 1;

	private int belong_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int UnlockTimeFieldNumber = 3;

	private int unlockTime_;

	[DebuggerNonUserCode]
	public static MessageParser<PeriodicQuestGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(648);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Belong
	{
		get
		{
			return belong_;
		}
		set
		{
			belong_ = value;
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
	public int UnlockTime
	{
		get
		{
			return unlockTime_;
		}
		set
		{
			unlockTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public PeriodicQuestGroup()
	{
	}

	[DebuggerNonUserCode]
	public PeriodicQuestGroup(PeriodicQuestGroup other)
		: this()
	{
		belong_ = other.belong_;
		groupId_ = other.groupId_;
		unlockTime_ = other.unlockTime_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PeriodicQuestGroup Clone()
	{
		return new PeriodicQuestGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PeriodicQuestGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(PeriodicQuestGroup other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Belong != other.Belong)
		{
			return false;
		}
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (UnlockTime != other.UnlockTime)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Belong != 0)
		{
			num ^= Belong.GetHashCode();
		}
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (UnlockTime != 0)
		{
			num ^= UnlockTime.GetHashCode();
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
		if (Belong != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Belong);
		}
		if (GroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GroupId);
		}
		if (UnlockTime != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(UnlockTime);
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
		if (Belong != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Belong);
		}
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (UnlockTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockTime);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PeriodicQuestGroup other)
	{
		if (other != null)
		{
			if (other.Belong != 0)
			{
				Belong = other.Belong;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.UnlockTime != 0)
			{
				UnlockTime = other.UnlockTime;
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
				Belong = input.ReadInt32();
				break;
			case 16u:
				GroupId = input.ReadInt32();
				break;
			case 24u:
				UnlockTime = input.ReadInt32();
				break;
			}
		}
	}
}
