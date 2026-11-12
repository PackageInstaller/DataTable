using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TrapAttribute : IMessage<TrapAttribute>, IMessage, IEquatable<TrapAttribute>, IDeepCloneable<TrapAttribute>
{
	private static readonly MessageParser<TrapAttribute> _parser = new MessageParser<TrapAttribute>(() => new TrapAttribute());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TriggerFieldNumber = 2;

	private bool trigger_;

	public const int TriggerIDsFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_triggerIDs_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> triggerIDs_ = new RepeatedField<int>();

	public const int FilterFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_filter_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> filter_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<TrapAttribute> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1000);

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
	public bool Trigger
	{
		get
		{
			return trigger_;
		}
		set
		{
			trigger_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> TriggerIDs => triggerIDs_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Filter => filter_;

	[DebuggerNonUserCode]
	public TrapAttribute()
	{
	}

	[DebuggerNonUserCode]
	public TrapAttribute(TrapAttribute other)
		: this()
	{
		id_ = other.id_;
		trigger_ = other.trigger_;
		triggerIDs_ = other.triggerIDs_.Clone();
		filter_ = other.filter_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TrapAttribute Clone()
	{
		return new TrapAttribute(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TrapAttribute);
	}

	[DebuggerNonUserCode]
	public bool Equals(TrapAttribute other)
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
		if (Trigger != other.Trigger)
		{
			return false;
		}
		if (!triggerIDs_.Equals(other.triggerIDs_))
		{
			return false;
		}
		if (!filter_.Equals(other.filter_))
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
		if (Trigger)
		{
			num ^= Trigger.GetHashCode();
		}
		num ^= triggerIDs_.GetHashCode();
		num ^= filter_.GetHashCode();
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
		if (Trigger)
		{
			output.WriteRawTag(16);
			output.WriteBool(Trigger);
		}
		triggerIDs_.WriteTo(output, _repeated_triggerIDs_codec);
		filter_.WriteTo(output, _repeated_filter_codec);
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
		if (Trigger)
		{
			num += 2;
		}
		num += triggerIDs_.CalculateSize(_repeated_triggerIDs_codec);
		num += filter_.CalculateSize(_repeated_filter_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TrapAttribute other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Trigger)
			{
				Trigger = other.Trigger;
			}
			triggerIDs_.Add(other.triggerIDs_);
			filter_.Add(other.filter_);
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
				Trigger = input.ReadBool();
				break;
			case 24u:
			case 26u:
				triggerIDs_.AddEntriesFrom(input, _repeated_triggerIDs_codec);
				break;
			case 32u:
			case 34u:
				filter_.AddEntriesFrom(input, _repeated_filter_codec);
				break;
			}
		}
	}
}
