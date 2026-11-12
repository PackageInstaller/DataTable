using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PenguinCardAidePool : IMessage<PenguinCardAidePool>, IMessage, IEquatable<PenguinCardAidePool>, IDeepCloneable<PenguinCardAidePool>
{
	private static readonly MessageParser<PenguinCardAidePool> _parser = new MessageParser<PenguinCardAidePool>(() => new PenguinCardAidePool());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int AideIdFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_aideId_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> aideId_ = new RepeatedField<int>();

	public const int WeightFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_weight_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> weight_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<PenguinCardAidePool> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(618);

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
	public RepeatedField<int> AideId => aideId_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Weight => weight_;

	[DebuggerNonUserCode]
	public PenguinCardAidePool()
	{
	}

	[DebuggerNonUserCode]
	public PenguinCardAidePool(PenguinCardAidePool other)
		: this()
	{
		id_ = other.id_;
		aideId_ = other.aideId_.Clone();
		weight_ = other.weight_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PenguinCardAidePool Clone()
	{
		return new PenguinCardAidePool(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PenguinCardAidePool);
	}

	[DebuggerNonUserCode]
	public bool Equals(PenguinCardAidePool other)
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
		if (!aideId_.Equals(other.aideId_))
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
		num ^= aideId_.GetHashCode();
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
		aideId_.WriteTo(output, _repeated_aideId_codec);
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
		num += aideId_.CalculateSize(_repeated_aideId_codec);
		num += weight_.CalculateSize(_repeated_weight_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PenguinCardAidePool other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			aideId_.Add(other.aideId_);
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
				aideId_.AddEntriesFrom(input, _repeated_aideId_codec);
				break;
			case 24u:
			case 26u:
				weight_.AddEntriesFrom(input, _repeated_weight_codec);
				break;
			}
		}
	}
}
