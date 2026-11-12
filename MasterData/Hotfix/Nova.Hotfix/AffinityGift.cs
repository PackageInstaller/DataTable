using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class AffinityGift : IMessage<AffinityGift>, IMessage, IEquatable<AffinityGift>, IDeepCloneable<AffinityGift>
{
	private static readonly MessageParser<AffinityGift> _parser = new MessageParser<AffinityGift>(() => new AffinityGift());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int BaseAffinityFieldNumber = 2;

	private int baseAffinity_;

	public const int TagsFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_tags_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> tags_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<AffinityGift> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(78);

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
	public int BaseAffinity
	{
		get
		{
			return baseAffinity_;
		}
		set
		{
			baseAffinity_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Tags => tags_;

	[DebuggerNonUserCode]
	public AffinityGift()
	{
	}

	[DebuggerNonUserCode]
	public AffinityGift(AffinityGift other)
		: this()
	{
		id_ = other.id_;
		baseAffinity_ = other.baseAffinity_;
		tags_ = other.tags_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public AffinityGift Clone()
	{
		return new AffinityGift(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as AffinityGift);
	}

	[DebuggerNonUserCode]
	public bool Equals(AffinityGift other)
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
		if (BaseAffinity != other.BaseAffinity)
		{
			return false;
		}
		if (!tags_.Equals(other.tags_))
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
		if (BaseAffinity != 0)
		{
			num ^= BaseAffinity.GetHashCode();
		}
		num ^= tags_.GetHashCode();
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
		if (BaseAffinity != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(BaseAffinity);
		}
		tags_.WriteTo(output, _repeated_tags_codec);
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
		if (BaseAffinity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BaseAffinity);
		}
		num += tags_.CalculateSize(_repeated_tags_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(AffinityGift other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.BaseAffinity != 0)
			{
				BaseAffinity = other.BaseAffinity;
			}
			tags_.Add(other.tags_);
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
				BaseAffinity = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				tags_.AddEntriesFrom(input, _repeated_tags_codec);
				break;
			}
		}
	}
}
