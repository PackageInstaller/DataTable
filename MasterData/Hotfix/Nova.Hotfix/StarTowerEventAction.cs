using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerEventAction : IMessage<StarTowerEventAction>, IMessage, IEquatable<StarTowerEventAction>, IDeepCloneable<StarTowerEventAction>
{
	private static readonly MessageParser<StarTowerEventAction> _parser = new MessageParser<StarTowerEventAction>(() => new StarTowerEventAction());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int EventIdFieldNumber = 2;

	private int eventId_;

	public const int TrigVoiceFieldNumber = 3;

	private string trigVoice_ = "";

	public const int DescFieldNumber = 4;

	private string desc_ = "";

	public const int GroupFieldNumber = 5;

	private int group_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerEventAction> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(844);

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
	public int EventId
	{
		get
		{
			return eventId_;
		}
		set
		{
			eventId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string TrigVoice
	{
		get
		{
			return trigVoice_;
		}
		set
		{
			trigVoice_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int Group
	{
		get
		{
			return group_;
		}
		set
		{
			group_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StarTowerEventAction()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerEventAction(StarTowerEventAction other)
		: this()
	{
		id_ = other.id_;
		eventId_ = other.eventId_;
		trigVoice_ = other.trigVoice_;
		desc_ = other.desc_;
		group_ = other.group_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerEventAction Clone()
	{
		return new StarTowerEventAction(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerEventAction);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerEventAction other)
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
		if (EventId != other.EventId)
		{
			return false;
		}
		if (TrigVoice != other.TrigVoice)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Group != other.Group)
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
		if (EventId != 0)
		{
			num ^= EventId.GetHashCode();
		}
		if (TrigVoice.Length != 0)
		{
			num ^= TrigVoice.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Group != 0)
		{
			num ^= Group.GetHashCode();
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
		if (EventId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(EventId);
		}
		if (TrigVoice.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(TrigVoice);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Desc);
		}
		if (Group != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Group);
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
		if (EventId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EventId);
		}
		if (TrigVoice.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TrigVoice);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Group != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Group);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerEventAction other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.EventId != 0)
			{
				EventId = other.EventId;
			}
			if (other.TrigVoice.Length != 0)
			{
				TrigVoice = other.TrigVoice;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Group != 0)
			{
				Group = other.Group;
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
				EventId = input.ReadInt32();
				break;
			case 26u:
				TrigVoice = input.ReadString();
				break;
			case 34u:
				Desc = input.ReadString();
				break;
			case 40u:
				Group = input.ReadInt32();
				break;
			}
		}
	}
}
