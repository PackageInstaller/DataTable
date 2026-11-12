using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ProduceHelper : IMessage<ProduceHelper>, IMessage, IEquatable<ProduceHelper>, IDeepCloneable<ProduceHelper>
{
	private static readonly MessageParser<ProduceHelper> _parser = new MessageParser<ProduceHelper>(() => new ProduceHelper());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ComCYOIdsFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_comCYOIds_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> comCYOIds_ = new RepeatedField<int>();

	public const int ProductionIdFieldNumber = 3;

	private int productionId_;

	[DebuggerNonUserCode]
	public static MessageParser<ProduceHelper> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(666);

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
	public RepeatedField<int> ComCYOIds => comCYOIds_;

	[DebuggerNonUserCode]
	public int ProductionId
	{
		get
		{
			return productionId_;
		}
		set
		{
			productionId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ProduceHelper()
	{
	}

	[DebuggerNonUserCode]
	public ProduceHelper(ProduceHelper other)
		: this()
	{
		id_ = other.id_;
		comCYOIds_ = other.comCYOIds_.Clone();
		productionId_ = other.productionId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ProduceHelper Clone()
	{
		return new ProduceHelper(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ProduceHelper);
	}

	[DebuggerNonUserCode]
	public bool Equals(ProduceHelper other)
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
		if (!comCYOIds_.Equals(other.comCYOIds_))
		{
			return false;
		}
		if (ProductionId != other.ProductionId)
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
		num ^= comCYOIds_.GetHashCode();
		if (ProductionId != 0)
		{
			num ^= ProductionId.GetHashCode();
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
		comCYOIds_.WriteTo(output, _repeated_comCYOIds_codec);
		if (ProductionId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ProductionId);
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
		num += comCYOIds_.CalculateSize(_repeated_comCYOIds_codec);
		if (ProductionId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ProductionId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ProduceHelper other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			comCYOIds_.Add(other.comCYOIds_);
			if (other.ProductionId != 0)
			{
				ProductionId = other.ProductionId;
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
			case 18u:
				comCYOIds_.AddEntriesFrom(input, _repeated_comCYOIds_codec);
				break;
			case 24u:
				ProductionId = input.ReadInt32();
				break;
			}
		}
	}
}
