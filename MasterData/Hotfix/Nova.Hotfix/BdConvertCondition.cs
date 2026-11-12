using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class BdConvertCondition : IMessage<BdConvertCondition>, IMessage, IEquatable<BdConvertCondition>, IDeepCloneable<BdConvertCondition>
{
	private static readonly MessageParser<BdConvertCondition> _parser = new MessageParser<BdConvertCondition>(() => new BdConvertCondition());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CondFieldNumber = 2;

	private int cond_;

	public const int CondParamsFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_condParams_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> condParams_ = new RepeatedField<int>();

	public const int RequestDesFieldNumber = 4;

	private string requestDes_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<BdConvertCondition> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(122);

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
	public int Cond
	{
		get
		{
			return cond_;
		}
		set
		{
			cond_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> CondParams => condParams_;

	[DebuggerNonUserCode]
	public string RequestDes
	{
		get
		{
			return requestDes_;
		}
		set
		{
			requestDes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public BdConvertCondition()
	{
	}

	[DebuggerNonUserCode]
	public BdConvertCondition(BdConvertCondition other)
		: this()
	{
		id_ = other.id_;
		cond_ = other.cond_;
		condParams_ = other.condParams_.Clone();
		requestDes_ = other.requestDes_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public BdConvertCondition Clone()
	{
		return new BdConvertCondition(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as BdConvertCondition);
	}

	[DebuggerNonUserCode]
	public bool Equals(BdConvertCondition other)
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
		if (Cond != other.Cond)
		{
			return false;
		}
		if (!condParams_.Equals(other.condParams_))
		{
			return false;
		}
		if (RequestDes != other.RequestDes)
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
		if (Cond != 0)
		{
			num ^= Cond.GetHashCode();
		}
		num ^= condParams_.GetHashCode();
		if (RequestDes.Length != 0)
		{
			num ^= RequestDes.GetHashCode();
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
		if (Cond != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Cond);
		}
		condParams_.WriteTo(output, _repeated_condParams_codec);
		if (RequestDes.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(RequestDes);
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
		if (Cond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Cond);
		}
		num += condParams_.CalculateSize(_repeated_condParams_codec);
		if (RequestDes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RequestDes);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(BdConvertCondition other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Cond != 0)
			{
				Cond = other.Cond;
			}
			condParams_.Add(other.condParams_);
			if (other.RequestDes.Length != 0)
			{
				RequestDes = other.RequestDes;
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
				Cond = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				condParams_.AddEntriesFrom(input, _repeated_condParams_codec);
				break;
			case 34u:
				RequestDes = input.ReadString();
				break;
			}
		}
	}
}
