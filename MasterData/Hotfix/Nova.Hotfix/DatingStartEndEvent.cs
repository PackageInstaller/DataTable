using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DatingStartEndEvent : IMessage<DatingStartEndEvent>, IMessage, IEquatable<DatingStartEndEvent>, IDeepCloneable<DatingStartEndEvent>
{
	private static readonly MessageParser<DatingStartEndEvent> _parser = new MessageParser<DatingStartEndEvent>(() => new DatingStartEndEvent());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int DatingEventTypeFieldNumber = 2;

	private int datingEventType_;

	public const int DatingEventParamsFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_datingEventParams_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> datingEventParams_ = new RepeatedField<int>();

	public const int AffinityFieldNumber = 4;

	private int affinity_;

	public const int Desc1FieldNumber = 5;

	private string desc1_ = "";

	public const int Desc2FieldNumber = 6;

	private string desc2_ = "";

	public const int Desc3FieldNumber = 7;

	private string desc3_ = "";

	public const int ResponseFieldNumber = 8;

	private string response_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<DatingStartEndEvent> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(254);

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
	public int Affinity
	{
		get
		{
			return affinity_;
		}
		set
		{
			affinity_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Desc1
	{
		get
		{
			return desc1_;
		}
		set
		{
			desc1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc2
	{
		get
		{
			return desc2_;
		}
		set
		{
			desc2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc3
	{
		get
		{
			return desc3_;
		}
		set
		{
			desc3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Response
	{
		get
		{
			return response_;
		}
		set
		{
			response_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public DatingStartEndEvent()
	{
	}

	[DebuggerNonUserCode]
	public DatingStartEndEvent(DatingStartEndEvent other)
		: this()
	{
		id_ = other.id_;
		datingEventType_ = other.datingEventType_;
		datingEventParams_ = other.datingEventParams_.Clone();
		affinity_ = other.affinity_;
		desc1_ = other.desc1_;
		desc2_ = other.desc2_;
		desc3_ = other.desc3_;
		response_ = other.response_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DatingStartEndEvent Clone()
	{
		return new DatingStartEndEvent(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DatingStartEndEvent);
	}

	[DebuggerNonUserCode]
	public bool Equals(DatingStartEndEvent other)
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
		if (Affinity != other.Affinity)
		{
			return false;
		}
		if (Desc1 != other.Desc1)
		{
			return false;
		}
		if (Desc2 != other.Desc2)
		{
			return false;
		}
		if (Desc3 != other.Desc3)
		{
			return false;
		}
		if (Response != other.Response)
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
		if (Affinity != 0)
		{
			num ^= Affinity.GetHashCode();
		}
		if (Desc1.Length != 0)
		{
			num ^= Desc1.GetHashCode();
		}
		if (Desc2.Length != 0)
		{
			num ^= Desc2.GetHashCode();
		}
		if (Desc3.Length != 0)
		{
			num ^= Desc3.GetHashCode();
		}
		if (Response.Length != 0)
		{
			num ^= Response.GetHashCode();
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
		if (Affinity != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Affinity);
		}
		if (Desc1.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Desc1);
		}
		if (Desc2.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Desc2);
		}
		if (Desc3.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Desc3);
		}
		if (Response.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Response);
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
		if (Affinity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Affinity);
		}
		if (Desc1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc1);
		}
		if (Desc2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc2);
		}
		if (Desc3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc3);
		}
		if (Response.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Response);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DatingStartEndEvent other)
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
			if (other.Affinity != 0)
			{
				Affinity = other.Affinity;
			}
			if (other.Desc1.Length != 0)
			{
				Desc1 = other.Desc1;
			}
			if (other.Desc2.Length != 0)
			{
				Desc2 = other.Desc2;
			}
			if (other.Desc3.Length != 0)
			{
				Desc3 = other.Desc3;
			}
			if (other.Response.Length != 0)
			{
				Response = other.Response;
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
				Affinity = input.ReadInt32();
				break;
			case 42u:
				Desc1 = input.ReadString();
				break;
			case 50u:
				Desc2 = input.ReadString();
				break;
			case 58u:
				Desc3 = input.ReadString();
				break;
			case 66u:
				Response = input.ReadString();
				break;
			}
		}
	}
}
