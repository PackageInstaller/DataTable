using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class FloorBuff : IMessage<FloorBuff>, IMessage, IEquatable<FloorBuff>, IDeepCloneable<FloorBuff>
{
	private static readonly MessageParser<FloorBuff> _parser = new MessageParser<FloorBuff>(() => new FloorBuff());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int AddCampFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_addCamp_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> addCamp_ = new RepeatedField<int>();

	public const int AddClassFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_addClass_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> addClass_ = new RepeatedField<int>();

	public const int EffectIdFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_effectId_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> effectId_ = new RepeatedField<int>();

	public const int BuffIdFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_buffId_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> buffId_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<FloorBuff> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(352);

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
	public RepeatedField<int> AddCamp => addCamp_;

	[DebuggerNonUserCode]
	public RepeatedField<int> AddClass => addClass_;

	[DebuggerNonUserCode]
	public RepeatedField<int> EffectId => effectId_;

	[DebuggerNonUserCode]
	public RepeatedField<int> BuffId => buffId_;

	[DebuggerNonUserCode]
	public FloorBuff()
	{
	}

	[DebuggerNonUserCode]
	public FloorBuff(FloorBuff other)
		: this()
	{
		id_ = other.id_;
		addCamp_ = other.addCamp_.Clone();
		addClass_ = other.addClass_.Clone();
		effectId_ = other.effectId_.Clone();
		buffId_ = other.buffId_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public FloorBuff Clone()
	{
		return new FloorBuff(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as FloorBuff);
	}

	[DebuggerNonUserCode]
	public bool Equals(FloorBuff other)
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
		if (!addCamp_.Equals(other.addCamp_))
		{
			return false;
		}
		if (!addClass_.Equals(other.addClass_))
		{
			return false;
		}
		if (!effectId_.Equals(other.effectId_))
		{
			return false;
		}
		if (!buffId_.Equals(other.buffId_))
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
		num ^= addCamp_.GetHashCode();
		num ^= addClass_.GetHashCode();
		num ^= effectId_.GetHashCode();
		num ^= buffId_.GetHashCode();
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
		addCamp_.WriteTo(output, _repeated_addCamp_codec);
		addClass_.WriteTo(output, _repeated_addClass_codec);
		effectId_.WriteTo(output, _repeated_effectId_codec);
		buffId_.WriteTo(output, _repeated_buffId_codec);
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
		num += addCamp_.CalculateSize(_repeated_addCamp_codec);
		num += addClass_.CalculateSize(_repeated_addClass_codec);
		num += effectId_.CalculateSize(_repeated_effectId_codec);
		num += buffId_.CalculateSize(_repeated_buffId_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(FloorBuff other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			addCamp_.Add(other.addCamp_);
			addClass_.Add(other.addClass_);
			effectId_.Add(other.effectId_);
			buffId_.Add(other.buffId_);
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
			case 18u:
				addCamp_.AddEntriesFrom(input, _repeated_addCamp_codec);
				break;
			case 24u:
			case 26u:
				addClass_.AddEntriesFrom(input, _repeated_addClass_codec);
				break;
			case 32u:
			case 34u:
				effectId_.AddEntriesFrom(input, _repeated_effectId_codec);
				break;
			case 40u:
			case 42u:
				buffId_.AddEntriesFrom(input, _repeated_buffId_codec);
				break;
			}
		}
	}
}
