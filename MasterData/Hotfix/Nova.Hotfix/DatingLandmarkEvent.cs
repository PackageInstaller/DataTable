using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DatingLandmarkEvent : IMessage<DatingLandmarkEvent>, IMessage, IEquatable<DatingLandmarkEvent>, IDeepCloneable<DatingLandmarkEvent>
{
	private static readonly MessageParser<DatingLandmarkEvent> _parser = new MessageParser<DatingLandmarkEvent>(() => new DatingLandmarkEvent());

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

	public const int BranchTagFieldNumber = 5;

	private int branchTag_;

	public const int SortTagFieldNumber = 6;

	private int sortTag_;

	public const int AffinityFieldNumber = 7;

	private int affinity_;

	public const int Desc1FieldNumber = 8;

	private string desc1_ = "";

	public const int Desc2FieldNumber = 9;

	private string desc2_ = "";

	public const int Desc3FieldNumber = 10;

	private string desc3_ = "";

	public const int ResponseFieldNumber = 11;

	private string response_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<DatingLandmarkEvent> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(252);

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
	public int BranchTag
	{
		get
		{
			return branchTag_;
		}
		set
		{
			branchTag_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SortTag
	{
		get
		{
			return sortTag_;
		}
		set
		{
			sortTag_ = value;
		}
	}

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
	public DatingLandmarkEvent()
	{
	}

	[DebuggerNonUserCode]
	public DatingLandmarkEvent(DatingLandmarkEvent other)
		: this()
	{
		id_ = other.id_;
		datingEventType_ = other.datingEventType_;
		datingEventParams_ = other.datingEventParams_.Clone();
		datingEventExclude_ = other.datingEventExclude_.Clone();
		branchTag_ = other.branchTag_;
		sortTag_ = other.sortTag_;
		affinity_ = other.affinity_;
		desc1_ = other.desc1_;
		desc2_ = other.desc2_;
		desc3_ = other.desc3_;
		response_ = other.response_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DatingLandmarkEvent Clone()
	{
		return new DatingLandmarkEvent(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DatingLandmarkEvent);
	}

	[DebuggerNonUserCode]
	public bool Equals(DatingLandmarkEvent other)
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
		if (BranchTag != other.BranchTag)
		{
			return false;
		}
		if (SortTag != other.SortTag)
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
		num ^= datingEventExclude_.GetHashCode();
		if (BranchTag != 0)
		{
			num ^= BranchTag.GetHashCode();
		}
		if (SortTag != 0)
		{
			num ^= SortTag.GetHashCode();
		}
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
		datingEventExclude_.WriteTo(output, _repeated_datingEventExclude_codec);
		if (BranchTag != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(BranchTag);
		}
		if (SortTag != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(SortTag);
		}
		if (Affinity != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Affinity);
		}
		if (Desc1.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Desc1);
		}
		if (Desc2.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Desc2);
		}
		if (Desc3.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(Desc3);
		}
		if (Response.Length != 0)
		{
			output.WriteRawTag(90);
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
		num += datingEventExclude_.CalculateSize(_repeated_datingEventExclude_codec);
		if (BranchTag != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BranchTag);
		}
		if (SortTag != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SortTag);
		}
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
	public void MergeFrom(DatingLandmarkEvent other)
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
			if (other.BranchTag != 0)
			{
				BranchTag = other.BranchTag;
			}
			if (other.SortTag != 0)
			{
				SortTag = other.SortTag;
			}
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
			case 34u:
				datingEventExclude_.AddEntriesFrom(input, _repeated_datingEventExclude_codec);
				break;
			case 40u:
				BranchTag = input.ReadInt32();
				break;
			case 48u:
				SortTag = input.ReadInt32();
				break;
			case 56u:
				Affinity = input.ReadInt32();
				break;
			case 66u:
				Desc1 = input.ReadString();
				break;
			case 74u:
				Desc2 = input.ReadString();
				break;
			case 82u:
				Desc3 = input.ReadString();
				break;
			case 90u:
				Response = input.ReadString();
				break;
			}
		}
	}
}
