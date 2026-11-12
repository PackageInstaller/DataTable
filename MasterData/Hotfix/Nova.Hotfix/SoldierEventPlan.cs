using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierEventPlan : IMessage<SoldierEventPlan>, IMessage, IEquatable<SoldierEventPlan>, IDeepCloneable<SoldierEventPlan>
{
	private static readonly MessageParser<SoldierEventPlan> _parser = new MessageParser<SoldierEventPlan>(() => new SoldierEventPlan());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int EventGroupIdFieldNumber = 2;

	private int eventGroupId_;

	public const int EventTypeFieldNumber = 3;

	private int eventType_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierEventPlan> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(762);

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
	public int EventGroupId
	{
		get
		{
			return eventGroupId_;
		}
		set
		{
			eventGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EventType
	{
		get
		{
			return eventType_;
		}
		set
		{
			eventType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierEventPlan()
	{
	}

	[DebuggerNonUserCode]
	public SoldierEventPlan(SoldierEventPlan other)
		: this()
	{
		id_ = other.id_;
		eventGroupId_ = other.eventGroupId_;
		eventType_ = other.eventType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierEventPlan Clone()
	{
		return new SoldierEventPlan(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierEventPlan);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierEventPlan other)
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
		if (EventGroupId != other.EventGroupId)
		{
			return false;
		}
		if (EventType != other.EventType)
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
		if (EventGroupId != 0)
		{
			num ^= EventGroupId.GetHashCode();
		}
		if (EventType != 0)
		{
			num ^= EventType.GetHashCode();
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
		if (EventGroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(EventGroupId);
		}
		if (EventType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(EventType);
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
		if (EventGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EventGroupId);
		}
		if (EventType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EventType);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierEventPlan other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.EventGroupId != 0)
			{
				EventGroupId = other.EventGroupId;
			}
			if (other.EventType != 0)
			{
				EventType = other.EventType;
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
				EventGroupId = input.ReadInt32();
				break;
			case 24u:
				EventType = input.ReadInt32();
				break;
			}
		}
	}
}
