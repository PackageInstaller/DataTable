using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PenguinBaseCardPool : IMessage<PenguinBaseCardPool>, IMessage, IEquatable<PenguinBaseCardPool>, IDeepCloneable<PenguinBaseCardPool>
{
	private static readonly MessageParser<PenguinBaseCardPool> _parser = new MessageParser<PenguinBaseCardPool>(() => new PenguinBaseCardPool());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int BaseCardIdFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_baseCardId_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> baseCardId_ = new RepeatedField<int>();

	public const int WeightFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_weight_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> weight_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<PenguinBaseCardPool> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(612);

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
	public RepeatedField<int> BaseCardId => baseCardId_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Weight => weight_;

	[DebuggerNonUserCode]
	public PenguinBaseCardPool()
	{
	}

	[DebuggerNonUserCode]
	public PenguinBaseCardPool(PenguinBaseCardPool other)
		: this()
	{
		id_ = other.id_;
		baseCardId_ = other.baseCardId_.Clone();
		weight_ = other.weight_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PenguinBaseCardPool Clone()
	{
		return new PenguinBaseCardPool(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PenguinBaseCardPool);
	}

	[DebuggerNonUserCode]
	public bool Equals(PenguinBaseCardPool other)
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
		if (!baseCardId_.Equals(other.baseCardId_))
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
		num ^= baseCardId_.GetHashCode();
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
		baseCardId_.WriteTo(output, _repeated_baseCardId_codec);
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
		num += baseCardId_.CalculateSize(_repeated_baseCardId_codec);
		num += weight_.CalculateSize(_repeated_weight_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PenguinBaseCardPool other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			baseCardId_.Add(other.baseCardId_);
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
				baseCardId_.AddEntriesFrom(input, _repeated_baseCardId_codec);
				break;
			case 24u:
			case 26u:
				weight_.AddEntriesFrom(input, _repeated_weight_codec);
				break;
			}
		}
	}
}
