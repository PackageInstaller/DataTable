using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DatingBranch : IMessage<DatingBranch>, IMessage, IEquatable<DatingBranch>, IDeepCloneable<DatingBranch>
{
	private static readonly MessageParser<DatingBranch> _parser = new MessageParser<DatingBranch>(() => new DatingBranch());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int DatingEventTypeFieldNumber = 2;

	private int datingEventType_;

	public const int DatingEventParamsFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_datingEventParams_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> datingEventParams_ = new RepeatedField<int>();

	public const int DatingEventExcludeFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_datingEventExclude_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> datingEventExclude_ = new RepeatedField<int>();

	public const int Option1FieldNumber = 5;

	private string option1_ = "";

	public const int Option2FieldNumber = 6;

	private string option2_ = "";

	public const int Option3FieldNumber = 7;

	private string option3_ = "";

	public const int Option4FieldNumber = 8;

	private string option4_ = "";

	public const int Option5FieldNumber = 9;

	private string option5_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<DatingBranch> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(242);

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
	public int DatingEventType
	{
		get
		{
			return datingEventType_;
		}
		set
		{
			datingEventType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> DatingEventParams => datingEventParams_;

	[DebuggerNonUserCode]
	public RepeatedField<int> DatingEventExclude => datingEventExclude_;

	[DebuggerNonUserCode]
	public string Option1
	{
		get
		{
			return option1_;
		}
		set
		{
			option1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Option2
	{
		get
		{
			return option2_;
		}
		set
		{
			option2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Option3
	{
		get
		{
			return option3_;
		}
		set
		{
			option3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Option4
	{
		get
		{
			return option4_;
		}
		set
		{
			option4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Option5
	{
		get
		{
			return option5_;
		}
		set
		{
			option5_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public DatingBranch()
	{
	}

	[DebuggerNonUserCode]
	public DatingBranch(DatingBranch other)
		: this()
	{
		id_ = other.id_;
		datingEventType_ = other.datingEventType_;
		datingEventParams_ = other.datingEventParams_.Clone();
		datingEventExclude_ = other.datingEventExclude_.Clone();
		option1_ = other.option1_;
		option2_ = other.option2_;
		option3_ = other.option3_;
		option4_ = other.option4_;
		option5_ = other.option5_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DatingBranch Clone()
	{
		return new DatingBranch(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DatingBranch);
	}

	[DebuggerNonUserCode]
	public bool Equals(DatingBranch other)
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
		if (DatingEventType != other.DatingEventType)
		{
			return false;
		}
		if (!datingEventParams_.Equals(other.datingEventParams_))
		{
			return false;
		}
		if (!datingEventExclude_.Equals(other.datingEventExclude_))
		{
			return false;
		}
		if (Option1 != other.Option1)
		{
			return false;
		}
		if (Option2 != other.Option2)
		{
			return false;
		}
		if (Option3 != other.Option3)
		{
			return false;
		}
		if (Option4 != other.Option4)
		{
			return false;
		}
		if (Option5 != other.Option5)
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
		if (DatingEventType != 0)
		{
			num ^= DatingEventType.GetHashCode();
		}
		num ^= datingEventParams_.GetHashCode();
		num ^= datingEventExclude_.GetHashCode();
		if (Option1.Length != 0)
		{
			num ^= Option1.GetHashCode();
		}
		if (Option2.Length != 0)
		{
			num ^= Option2.GetHashCode();
		}
		if (Option3.Length != 0)
		{
			num ^= Option3.GetHashCode();
		}
		if (Option4.Length != 0)
		{
			num ^= Option4.GetHashCode();
		}
		if (Option5.Length != 0)
		{
			num ^= Option5.GetHashCode();
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
		if (DatingEventType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(DatingEventType);
		}
		datingEventParams_.WriteTo(output, _repeated_datingEventParams_codec);
		datingEventExclude_.WriteTo(output, _repeated_datingEventExclude_codec);
		if (Option1.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Option1);
		}
		if (Option2.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Option2);
		}
		if (Option3.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Option3);
		}
		if (Option4.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Option4);
		}
		if (Option5.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Option5);
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
		if (DatingEventType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DatingEventType);
		}
		num += datingEventParams_.CalculateSize(_repeated_datingEventParams_codec);
		num += datingEventExclude_.CalculateSize(_repeated_datingEventExclude_codec);
		if (Option1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Option1);
		}
		if (Option2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Option2);
		}
		if (Option3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Option3);
		}
		if (Option4.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Option4);
		}
		if (Option5.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Option5);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DatingBranch other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.DatingEventType != 0)
			{
				DatingEventType = other.DatingEventType;
			}
			datingEventParams_.Add(other.datingEventParams_);
			datingEventExclude_.Add(other.datingEventExclude_);
			if (other.Option1.Length != 0)
			{
				Option1 = other.Option1;
			}
			if (other.Option2.Length != 0)
			{
				Option2 = other.Option2;
			}
			if (other.Option3.Length != 0)
			{
				Option3 = other.Option3;
			}
			if (other.Option4.Length != 0)
			{
				Option4 = other.Option4;
			}
			if (other.Option5.Length != 0)
			{
				Option5 = other.Option5;
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
				DatingEventType = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				datingEventParams_.AddEntriesFrom(input, _repeated_datingEventParams_codec);
				break;
			case 32u:
			case 34u:
				datingEventExclude_.AddEntriesFrom(input, _repeated_datingEventExclude_codec);
				break;
			case 42u:
				Option1 = input.ReadString();
				break;
			case 50u:
				Option2 = input.ReadString();
				break;
			case 58u:
				Option3 = input.ReadString();
				break;
			case 66u:
				Option4 = input.ReadString();
				break;
			case 74u:
				Option5 = input.ReadString();
				break;
			}
		}
	}
}
