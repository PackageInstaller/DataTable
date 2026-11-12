using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityReturneeQuestGroup : IMessage<ActivityReturneeQuestGroup>, IMessage, IEquatable<ActivityReturneeQuestGroup>, IDeepCloneable<ActivityReturneeQuestGroup>
{
	private static readonly MessageParser<ActivityReturneeQuestGroup> _parser = new MessageParser<ActivityReturneeQuestGroup>(() => new ActivityReturneeQuestGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ReturneeIdFieldNumber = 2;

	private int returneeId_;

	public const int DayOpenFieldNumber = 3;

	private int dayOpen_;

	[DebuggerNonUserCode]
	public static MessageParser<ActivityReturneeQuestGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(44);

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
	public int ReturneeId
	{
		get
		{
			return returneeId_;
		}
		set
		{
			returneeId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DayOpen
	{
		get
		{
			return dayOpen_;
		}
		set
		{
			dayOpen_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ActivityReturneeQuestGroup()
	{
	}

	[DebuggerNonUserCode]
	public ActivityReturneeQuestGroup(ActivityReturneeQuestGroup other)
		: this()
	{
		id_ = other.id_;
		returneeId_ = other.returneeId_;
		dayOpen_ = other.dayOpen_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityReturneeQuestGroup Clone()
	{
		return new ActivityReturneeQuestGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityReturneeQuestGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityReturneeQuestGroup other)
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
		if (ReturneeId != other.ReturneeId)
		{
			return false;
		}
		if (DayOpen != other.DayOpen)
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
		if (ReturneeId != 0)
		{
			num ^= ReturneeId.GetHashCode();
		}
		if (DayOpen != 0)
		{
			num ^= DayOpen.GetHashCode();
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
		if (ReturneeId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ReturneeId);
		}
		if (DayOpen != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(DayOpen);
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
		if (ReturneeId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ReturneeId);
		}
		if (DayOpen != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DayOpen);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityReturneeQuestGroup other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ReturneeId != 0)
			{
				ReturneeId = other.ReturneeId;
			}
			if (other.DayOpen != 0)
			{
				DayOpen = other.DayOpen;
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
				ReturneeId = input.ReadInt32();
				break;
			case 24u:
				DayOpen = input.ReadInt32();
				break;
			}
		}
	}
}
