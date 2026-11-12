using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerEvent : IMessage<StarTowerEvent>, IMessage, IEquatable<StarTowerEvent>, IDeepCloneable<StarTowerEvent>
{
	private static readonly MessageParser<StarTowerEvent> _parser = new MessageParser<StarTowerEvent>(() => new StarTowerEvent());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int OptionsRulesIdFieldNumber = 2;

	private int optionsRulesId_;

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int EventTypeFieldNumber = 4;

	private int eventType_;

	public const int GuaranteedMapIdFieldNumber = 5;

	private int guaranteedMapId_;

	public const int RelatedNPCsFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_relatedNPCs_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> relatedNPCs_ = new RepeatedField<int>();

	public const int EventResTypeFieldNumber = 7;

	private int eventResType_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerEvent> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(842);

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
	public int OptionsRulesId
	{
		get
		{
			return optionsRulesId_;
		}
		set
		{
			optionsRulesId_ = value;
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
	public int GuaranteedMapId
	{
		get
		{
			return guaranteedMapId_;
		}
		set
		{
			guaranteedMapId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> RelatedNPCs => relatedNPCs_;

	[DebuggerNonUserCode]
	public int EventResType
	{
		get
		{
			return eventResType_;
		}
		set
		{
			eventResType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StarTowerEvent()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerEvent(StarTowerEvent other)
		: this()
	{
		id_ = other.id_;
		optionsRulesId_ = other.optionsRulesId_;
		desc_ = other.desc_;
		eventType_ = other.eventType_;
		guaranteedMapId_ = other.guaranteedMapId_;
		relatedNPCs_ = other.relatedNPCs_.Clone();
		eventResType_ = other.eventResType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerEvent Clone()
	{
		return new StarTowerEvent(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerEvent);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerEvent other)
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
		if (OptionsRulesId != other.OptionsRulesId)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (EventType != other.EventType)
		{
			return false;
		}
		if (GuaranteedMapId != other.GuaranteedMapId)
		{
			return false;
		}
		if (!relatedNPCs_.Equals(other.relatedNPCs_))
		{
			return false;
		}
		if (EventResType != other.EventResType)
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
		if (OptionsRulesId != 0)
		{
			num ^= OptionsRulesId.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (EventType != 0)
		{
			num ^= EventType.GetHashCode();
		}
		if (GuaranteedMapId != 0)
		{
			num ^= GuaranteedMapId.GetHashCode();
		}
		num ^= relatedNPCs_.GetHashCode();
		if (EventResType != 0)
		{
			num ^= EventResType.GetHashCode();
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
		if (OptionsRulesId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(OptionsRulesId);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Desc);
		}
		if (EventType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(EventType);
		}
		if (GuaranteedMapId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(GuaranteedMapId);
		}
		relatedNPCs_.WriteTo(output, _repeated_relatedNPCs_codec);
		if (EventResType != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(EventResType);
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
		if (OptionsRulesId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OptionsRulesId);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (EventType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EventType);
		}
		if (GuaranteedMapId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GuaranteedMapId);
		}
		num += relatedNPCs_.CalculateSize(_repeated_relatedNPCs_codec);
		if (EventResType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EventResType);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerEvent other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.OptionsRulesId != 0)
			{
				OptionsRulesId = other.OptionsRulesId;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.EventType != 0)
			{
				EventType = other.EventType;
			}
			if (other.GuaranteedMapId != 0)
			{
				GuaranteedMapId = other.GuaranteedMapId;
			}
			relatedNPCs_.Add(other.relatedNPCs_);
			if (other.EventResType != 0)
			{
				EventResType = other.EventResType;
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
				OptionsRulesId = input.ReadInt32();
				break;
			case 26u:
				Desc = input.ReadString();
				break;
			case 32u:
				EventType = input.ReadInt32();
				break;
			case 40u:
				GuaranteedMapId = input.ReadInt32();
				break;
			case 48u:
			case 50u:
				relatedNPCs_.AddEntriesFrom(input, _repeated_relatedNPCs_codec);
				break;
			case 56u:
				EventResType = input.ReadInt32();
				break;
			}
		}
	}
}
