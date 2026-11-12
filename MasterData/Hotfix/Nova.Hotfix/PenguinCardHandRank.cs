using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PenguinCardHandRank : IMessage<PenguinCardHandRank>, IMessage, IEquatable<PenguinCardHandRank>, IDeepCloneable<PenguinCardHandRank>
{
	private static readonly MessageParser<PenguinCardHandRank> _parser = new MessageParser<PenguinCardHandRank>(() => new PenguinCardHandRank());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TitleFieldNumber = 2;

	private string title_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int SuitCountFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_suitCount_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> suitCount_ = new RepeatedField<int>();

	public const int OrderFieldNumber = 5;

	private int order_;

	public const int ValueFieldNumber = 6;

	private int value_;

	public const int RatioFieldNumber = 7;

	private int ratio_;

	[DebuggerNonUserCode]
	public static MessageParser<PenguinCardHandRank> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(634);

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
	public string Title
	{
		get
		{
			return title_;
		}
		set
		{
			title_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public RepeatedField<int> SuitCount => suitCount_;

	[DebuggerNonUserCode]
	public int Order
	{
		get
		{
			return order_;
		}
		set
		{
			order_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Value
	{
		get
		{
			return value_;
		}
		set
		{
			value_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Ratio
	{
		get
		{
			return ratio_;
		}
		set
		{
			ratio_ = value;
		}
	}

	[DebuggerNonUserCode]
	public PenguinCardHandRank()
	{
	}

	[DebuggerNonUserCode]
	public PenguinCardHandRank(PenguinCardHandRank other)
		: this()
	{
		id_ = other.id_;
		title_ = other.title_;
		desc_ = other.desc_;
		suitCount_ = other.suitCount_.Clone();
		order_ = other.order_;
		value_ = other.value_;
		ratio_ = other.ratio_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PenguinCardHandRank Clone()
	{
		return new PenguinCardHandRank(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PenguinCardHandRank);
	}

	[DebuggerNonUserCode]
	public bool Equals(PenguinCardHandRank other)
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
		if (Title != other.Title)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (!suitCount_.Equals(other.suitCount_))
		{
			return false;
		}
		if (Order != other.Order)
		{
			return false;
		}
		if (Value != other.Value)
		{
			return false;
		}
		if (Ratio != other.Ratio)
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
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		num ^= suitCount_.GetHashCode();
		if (Order != 0)
		{
			num ^= Order.GetHashCode();
		}
		if (Value != 0)
		{
			num ^= Value.GetHashCode();
		}
		if (Ratio != 0)
		{
			num ^= Ratio.GetHashCode();
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
		if (Title.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Title);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Desc);
		}
		suitCount_.WriteTo(output, _repeated_suitCount_codec);
		if (Order != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Order);
		}
		if (Value != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Value);
		}
		if (Ratio != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Ratio);
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
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		num += suitCount_.CalculateSize(_repeated_suitCount_codec);
		if (Order != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Order);
		}
		if (Value != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Value);
		}
		if (Ratio != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Ratio);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PenguinCardHandRank other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			suitCount_.Add(other.suitCount_);
			if (other.Order != 0)
			{
				Order = other.Order;
			}
			if (other.Value != 0)
			{
				Value = other.Value;
			}
			if (other.Ratio != 0)
			{
				Ratio = other.Ratio;
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
			case 18u:
				Title = input.ReadString();
				break;
			case 26u:
				Desc = input.ReadString();
				break;
			case 32u:
			case 34u:
				suitCount_.AddEntriesFrom(input, _repeated_suitCount_codec);
				break;
			case 40u:
				Order = input.ReadInt32();
				break;
			case 48u:
				Value = input.ReadInt32();
				break;
			case 56u:
				Ratio = input.ReadInt32();
				break;
			}
		}
	}
}
