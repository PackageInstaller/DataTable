using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class EventResult : IMessage<EventResult>, IMessage, IEquatable<EventResult>, IDeepCloneable<EventResult>
{
	private static readonly MessageParser<EventResult> _parser = new MessageParser<EventResult>(() => new EventResult());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int Effect1FieldNumber = 2;

	private int effect1_;

	public const int Parameter1FieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_parameter1_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> parameter1_ = new RepeatedField<int>();

	public const int Effect2FieldNumber = 4;

	private int effect2_;

	public const int Parameter2FieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_parameter2_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> parameter2_ = new RepeatedField<int>();

	public const int Effect3FieldNumber = 6;

	private int effect3_;

	public const int Parameter3FieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_parameter3_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> parameter3_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<EventResult> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(346);

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
	public int Effect1
	{
		get
		{
			return effect1_;
		}
		set
		{
			effect1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Parameter1 => parameter1_;

	[DebuggerNonUserCode]
	public int Effect2
	{
		get
		{
			return effect2_;
		}
		set
		{
			effect2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Parameter2 => parameter2_;

	[DebuggerNonUserCode]
	public int Effect3
	{
		get
		{
			return effect3_;
		}
		set
		{
			effect3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Parameter3 => parameter3_;

	[DebuggerNonUserCode]
	public EventResult()
	{
	}

	[DebuggerNonUserCode]
	public EventResult(EventResult other)
		: this()
	{
		id_ = other.id_;
		effect1_ = other.effect1_;
		parameter1_ = other.parameter1_.Clone();
		effect2_ = other.effect2_;
		parameter2_ = other.parameter2_.Clone();
		effect3_ = other.effect3_;
		parameter3_ = other.parameter3_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public EventResult Clone()
	{
		return new EventResult(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as EventResult);
	}

	[DebuggerNonUserCode]
	public bool Equals(EventResult other)
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
		if (Effect1 != other.Effect1)
		{
			return false;
		}
		if (!parameter1_.Equals(other.parameter1_))
		{
			return false;
		}
		if (Effect2 != other.Effect2)
		{
			return false;
		}
		if (!parameter2_.Equals(other.parameter2_))
		{
			return false;
		}
		if (Effect3 != other.Effect3)
		{
			return false;
		}
		if (!parameter3_.Equals(other.parameter3_))
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
		if (Effect1 != 0)
		{
			num ^= Effect1.GetHashCode();
		}
		num ^= parameter1_.GetHashCode();
		if (Effect2 != 0)
		{
			num ^= Effect2.GetHashCode();
		}
		num ^= parameter2_.GetHashCode();
		if (Effect3 != 0)
		{
			num ^= Effect3.GetHashCode();
		}
		num ^= parameter3_.GetHashCode();
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
		if (Effect1 != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Effect1);
		}
		parameter1_.WriteTo(output, _repeated_parameter1_codec);
		if (Effect2 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Effect2);
		}
		parameter2_.WriteTo(output, _repeated_parameter2_codec);
		if (Effect3 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Effect3);
		}
		parameter3_.WriteTo(output, _repeated_parameter3_codec);
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
		if (Effect1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Effect1);
		}
		num += parameter1_.CalculateSize(_repeated_parameter1_codec);
		if (Effect2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Effect2);
		}
		num += parameter2_.CalculateSize(_repeated_parameter2_codec);
		if (Effect3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Effect3);
		}
		num += parameter3_.CalculateSize(_repeated_parameter3_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(EventResult other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Effect1 != 0)
			{
				Effect1 = other.Effect1;
			}
			parameter1_.Add(other.parameter1_);
			if (other.Effect2 != 0)
			{
				Effect2 = other.Effect2;
			}
			parameter2_.Add(other.parameter2_);
			if (other.Effect3 != 0)
			{
				Effect3 = other.Effect3;
			}
			parameter3_.Add(other.parameter3_);
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
				Effect1 = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				parameter1_.AddEntriesFrom(input, _repeated_parameter1_codec);
				break;
			case 32u:
				Effect2 = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				parameter2_.AddEntriesFrom(input, _repeated_parameter2_codec);
				break;
			case 48u:
				Effect3 = input.ReadInt32();
				break;
			case 56u:
			case 58u:
				parameter3_.AddEntriesFrom(input, _repeated_parameter3_codec);
				break;
			}
		}
	}
}
