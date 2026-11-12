using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class EventOptions : IMessage<EventOptions>, IMessage, IEquatable<EventOptions>, IDeepCloneable<EventOptions>
{
	private static readonly MessageParser<EventOptions> _parser = new MessageParser<EventOptions>(() => new EventOptions());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int DescFieldNumber = 2;

	private string desc_ = "";

	public const int IgnoreInterActiveFieldNumber = 3;

	private bool ignoreInterActive_;

	public const int EventOptionTagFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_eventOptionTag_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> eventOptionTag_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<EventOptions> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(340);

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
	public bool IgnoreInterActive
	{
		get
		{
			return ignoreInterActive_;
		}
		set
		{
			ignoreInterActive_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> EventOptionTag => eventOptionTag_;

	[DebuggerNonUserCode]
	public EventOptions()
	{
	}

	[DebuggerNonUserCode]
	public EventOptions(EventOptions other)
		: this()
	{
		id_ = other.id_;
		desc_ = other.desc_;
		ignoreInterActive_ = other.ignoreInterActive_;
		eventOptionTag_ = other.eventOptionTag_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public EventOptions Clone()
	{
		return new EventOptions(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as EventOptions);
	}

	[DebuggerNonUserCode]
	public bool Equals(EventOptions other)
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
		if (Desc != other.Desc)
		{
			return false;
		}
		if (IgnoreInterActive != other.IgnoreInterActive)
		{
			return false;
		}
		if (!eventOptionTag_.Equals(other.eventOptionTag_))
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
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (IgnoreInterActive)
		{
			num ^= IgnoreInterActive.GetHashCode();
		}
		num ^= eventOptionTag_.GetHashCode();
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
		if (Desc.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Desc);
		}
		if (IgnoreInterActive)
		{
			output.WriteRawTag(24);
			output.WriteBool(IgnoreInterActive);
		}
		eventOptionTag_.WriteTo(output, _repeated_eventOptionTag_codec);
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
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (IgnoreInterActive)
		{
			num += 2;
		}
		num += eventOptionTag_.CalculateSize(_repeated_eventOptionTag_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(EventOptions other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.IgnoreInterActive)
			{
				IgnoreInterActive = other.IgnoreInterActive;
			}
			eventOptionTag_.Add(other.eventOptionTag_);
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
			case 18u:
				Desc = input.ReadString();
				break;
			case 24u:
				IgnoreInterActive = input.ReadBool();
				break;
			case 32u:
			case 34u:
				eventOptionTag_.AddEntriesFrom(input, _repeated_eventOptionTag_codec);
				break;
			}
		}
	}
}
