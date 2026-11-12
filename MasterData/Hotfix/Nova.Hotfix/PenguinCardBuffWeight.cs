using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PenguinCardBuffWeight : IMessage<PenguinCardBuffWeight>, IMessage, IEquatable<PenguinCardBuffWeight>, IDeepCloneable<PenguinCardBuffWeight>
{
	private static readonly MessageParser<PenguinCardBuffWeight> _parser = new MessageParser<PenguinCardBuffWeight>(() => new PenguinCardBuffWeight());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int BuffListFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_buffList_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> buffList_ = new RepeatedField<int>();

	public const int WeightFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_weight_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> weight_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<PenguinCardBuffWeight> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(622);

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
	public RepeatedField<int> BuffList => buffList_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Weight => weight_;

	[DebuggerNonUserCode]
	public PenguinCardBuffWeight()
	{
	}

	[DebuggerNonUserCode]
	public PenguinCardBuffWeight(PenguinCardBuffWeight other)
		: this()
	{
		id_ = other.id_;
		buffList_ = other.buffList_.Clone();
		weight_ = other.weight_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PenguinCardBuffWeight Clone()
	{
		return new PenguinCardBuffWeight(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PenguinCardBuffWeight);
	}

	[DebuggerNonUserCode]
	public bool Equals(PenguinCardBuffWeight other)
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
		if (!buffList_.Equals(other.buffList_))
		{
			return false;
		}
		if (!weight_.Equals(other.weight_))
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
		num ^= buffList_.GetHashCode();
		num ^= weight_.GetHashCode();
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
		buffList_.WriteTo(output, _repeated_buffList_codec);
		weight_.WriteTo(output, _repeated_weight_codec);
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
		num += buffList_.CalculateSize(_repeated_buffList_codec);
		num += weight_.CalculateSize(_repeated_weight_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PenguinCardBuffWeight other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			buffList_.Add(other.buffList_);
			weight_.Add(other.weight_);
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
				buffList_.AddEntriesFrom(input, _repeated_buffList_codec);
				break;
			case 24u:
			case 26u:
				weight_.AddEntriesFrom(input, _repeated_weight_codec);
				break;
			}
		}
	}
}
