using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class VampireEnemySpAttr : IMessage<VampireEnemySpAttr>, IMessage, IEquatable<VampireEnemySpAttr>, IDeepCloneable<VampireEnemySpAttr>
{
	private static readonly MessageParser<VampireEnemySpAttr> _parser = new MessageParser<VampireEnemySpAttr>(() => new VampireEnemySpAttr());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int RefDistanceFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_refDistance_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> refDistance_ = new RepeatedField<int>();

	public const int RefIntervalFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_refInterval_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> refInterval_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<VampireEnemySpAttr> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1052);

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
	public RepeatedField<int> RefDistance => refDistance_;

	[DebuggerNonUserCode]
	public RepeatedField<int> RefInterval => refInterval_;

	[DebuggerNonUserCode]
	public VampireEnemySpAttr()
	{
	}

	[DebuggerNonUserCode]
	public VampireEnemySpAttr(VampireEnemySpAttr other)
		: this()
	{
		id_ = other.id_;
		refDistance_ = other.refDistance_.Clone();
		refInterval_ = other.refInterval_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public VampireEnemySpAttr Clone()
	{
		return new VampireEnemySpAttr(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as VampireEnemySpAttr);
	}

	[DebuggerNonUserCode]
	public bool Equals(VampireEnemySpAttr other)
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
		if (!refDistance_.Equals(other.refDistance_))
		{
			return false;
		}
		if (!refInterval_.Equals(other.refInterval_))
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
		num ^= refDistance_.GetHashCode();
		num ^= refInterval_.GetHashCode();
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
		refDistance_.WriteTo(output, _repeated_refDistance_codec);
		refInterval_.WriteTo(output, _repeated_refInterval_codec);
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
		num += refDistance_.CalculateSize(_repeated_refDistance_codec);
		num += refInterval_.CalculateSize(_repeated_refInterval_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(VampireEnemySpAttr other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			refDistance_.Add(other.refDistance_);
			refInterval_.Add(other.refInterval_);
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
				refDistance_.AddEntriesFrom(input, _repeated_refDistance_codec);
				break;
			case 24u:
			case 26u:
				refInterval_.AddEntriesFrom(input, _repeated_refInterval_codec);
				break;
			}
		}
	}
}
