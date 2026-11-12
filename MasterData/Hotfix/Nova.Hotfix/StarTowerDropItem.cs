using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerDropItem : IMessage<StarTowerDropItem>, IMessage, IEquatable<StarTowerDropItem>, IDeepCloneable<StarTowerDropItem>
{
	private static readonly MessageParser<StarTowerDropItem> _parser = new MessageParser<StarTowerDropItem>(() => new StarTowerDropItem());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TypeFieldNumber = 2;

	private int type_;

	public const int DropSplitRangeFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_dropSplitRange_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> dropSplitRange_ = new RepeatedField<int>();

	public const int RateFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_rate_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> rate_ = new RepeatedField<int>();

	public const int ModelFieldNumber = 5;

	private string model_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerDropItem> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(838);

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
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> DropSplitRange => dropSplitRange_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Rate => rate_;

	[DebuggerNonUserCode]
	public string Model
	{
		get
		{
			return model_;
		}
		set
		{
			model_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public StarTowerDropItem()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerDropItem(StarTowerDropItem other)
		: this()
	{
		id_ = other.id_;
		type_ = other.type_;
		dropSplitRange_ = other.dropSplitRange_.Clone();
		rate_ = other.rate_.Clone();
		model_ = other.model_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerDropItem Clone()
	{
		return new StarTowerDropItem(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerDropItem);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerDropItem other)
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
		if (Type != other.Type)
		{
			return false;
		}
		if (!dropSplitRange_.Equals(other.dropSplitRange_))
		{
			return false;
		}
		if (!rate_.Equals(other.rate_))
		{
			return false;
		}
		if (Model != other.Model)
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
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		num ^= dropSplitRange_.GetHashCode();
		num ^= rate_.GetHashCode();
		if (Model.Length != 0)
		{
			num ^= Model.GetHashCode();
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
		if (Type != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Type);
		}
		dropSplitRange_.WriteTo(output, _repeated_dropSplitRange_codec);
		rate_.WriteTo(output, _repeated_rate_codec);
		if (Model.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Model);
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
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		num += dropSplitRange_.CalculateSize(_repeated_dropSplitRange_codec);
		num += rate_.CalculateSize(_repeated_rate_codec);
		if (Model.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Model);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerDropItem other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			dropSplitRange_.Add(other.dropSplitRange_);
			rate_.Add(other.rate_);
			if (other.Model.Length != 0)
			{
				Model = other.Model;
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
			case 16u:
				Type = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				dropSplitRange_.AddEntriesFrom(input, _repeated_dropSplitRange_codec);
				break;
			case 32u:
			case 34u:
				rate_.AddEntriesFrom(input, _repeated_rate_codec);
				break;
			case 42u:
				Model = input.ReadString();
				break;
			}
		}
	}
}
