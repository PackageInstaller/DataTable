using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TraceHuntControl : IMessage<TraceHuntControl>, IMessage, IEquatable<TraceHuntControl>, IDeepCloneable<TraceHuntControl>
{
	private static readonly MessageParser<TraceHuntControl> _parser = new MessageParser<TraceHuntControl>(() => new TraceHuntControl());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int StartTimeFieldNumber = 2;

	private string startTime_ = "";

	public const int EndTimeFieldNumber = 3;

	private string endTime_ = "";

	public const int BossListFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_bossList_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> bossList_ = new RepeatedField<int>();

	public const int SelfHuntCost1TidFieldNumber = 5;

	private int selfHuntCost1Tid_;

	public const int SelfHuntCost1QtyFieldNumber = 6;

	private int selfHuntCost1Qty_;

	public const int OtherHuntCost1TidFieldNumber = 7;

	private int otherHuntCost1Tid_;

	public const int OtherHuntCost1QtyFieldNumber = 8;

	private int otherHuntCost1Qty_;

	public const int TraceCost1TidFieldNumber = 9;

	private int traceCost1Tid_;

	public const int TraceCost1QtyFieldNumber = 10;

	private int traceCost1Qty_;

	public const int StarDropCountFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_starDropCount_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> starDropCount_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<TraceHuntControl> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(980);

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
	public string StartTime
	{
		get
		{
			return startTime_;
		}
		set
		{
			startTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string EndTime
	{
		get
		{
			return endTime_;
		}
		set
		{
			endTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> BossList => bossList_;

	[DebuggerNonUserCode]
	public int SelfHuntCost1Tid
	{
		get
		{
			return selfHuntCost1Tid_;
		}
		set
		{
			selfHuntCost1Tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SelfHuntCost1Qty
	{
		get
		{
			return selfHuntCost1Qty_;
		}
		set
		{
			selfHuntCost1Qty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int OtherHuntCost1Tid
	{
		get
		{
			return otherHuntCost1Tid_;
		}
		set
		{
			otherHuntCost1Tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int OtherHuntCost1Qty
	{
		get
		{
			return otherHuntCost1Qty_;
		}
		set
		{
			otherHuntCost1Qty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TraceCost1Tid
	{
		get
		{
			return traceCost1Tid_;
		}
		set
		{
			traceCost1Tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TraceCost1Qty
	{
		get
		{
			return traceCost1Qty_;
		}
		set
		{
			traceCost1Qty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> StarDropCount => starDropCount_;

	[DebuggerNonUserCode]
	public TraceHuntControl()
	{
	}

	[DebuggerNonUserCode]
	public TraceHuntControl(TraceHuntControl other)
		: this()
	{
		id_ = other.id_;
		startTime_ = other.startTime_;
		endTime_ = other.endTime_;
		bossList_ = other.bossList_.Clone();
		selfHuntCost1Tid_ = other.selfHuntCost1Tid_;
		selfHuntCost1Qty_ = other.selfHuntCost1Qty_;
		otherHuntCost1Tid_ = other.otherHuntCost1Tid_;
		otherHuntCost1Qty_ = other.otherHuntCost1Qty_;
		traceCost1Tid_ = other.traceCost1Tid_;
		traceCost1Qty_ = other.traceCost1Qty_;
		starDropCount_ = other.starDropCount_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TraceHuntControl Clone()
	{
		return new TraceHuntControl(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TraceHuntControl);
	}

	[DebuggerNonUserCode]
	public bool Equals(TraceHuntControl other)
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
		if (StartTime != other.StartTime)
		{
			return false;
		}
		if (EndTime != other.EndTime)
		{
			return false;
		}
		if (!bossList_.Equals(other.bossList_))
		{
			return false;
		}
		if (SelfHuntCost1Tid != other.SelfHuntCost1Tid)
		{
			return false;
		}
		if (SelfHuntCost1Qty != other.SelfHuntCost1Qty)
		{
			return false;
		}
		if (OtherHuntCost1Tid != other.OtherHuntCost1Tid)
		{
			return false;
		}
		if (OtherHuntCost1Qty != other.OtherHuntCost1Qty)
		{
			return false;
		}
		if (TraceCost1Tid != other.TraceCost1Tid)
		{
			return false;
		}
		if (TraceCost1Qty != other.TraceCost1Qty)
		{
			return false;
		}
		if (!starDropCount_.Equals(other.starDropCount_))
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
		if (StartTime.Length != 0)
		{
			num ^= StartTime.GetHashCode();
		}
		if (EndTime.Length != 0)
		{
			num ^= EndTime.GetHashCode();
		}
		num ^= bossList_.GetHashCode();
		if (SelfHuntCost1Tid != 0)
		{
			num ^= SelfHuntCost1Tid.GetHashCode();
		}
		if (SelfHuntCost1Qty != 0)
		{
			num ^= SelfHuntCost1Qty.GetHashCode();
		}
		if (OtherHuntCost1Tid != 0)
		{
			num ^= OtherHuntCost1Tid.GetHashCode();
		}
		if (OtherHuntCost1Qty != 0)
		{
			num ^= OtherHuntCost1Qty.GetHashCode();
		}
		if (TraceCost1Tid != 0)
		{
			num ^= TraceCost1Tid.GetHashCode();
		}
		if (TraceCost1Qty != 0)
		{
			num ^= TraceCost1Qty.GetHashCode();
		}
		num ^= starDropCount_.GetHashCode();
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
		if (StartTime.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(StartTime);
		}
		if (EndTime.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(EndTime);
		}
		bossList_.WriteTo(output, _repeated_bossList_codec);
		if (SelfHuntCost1Tid != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(SelfHuntCost1Tid);
		}
		if (SelfHuntCost1Qty != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(SelfHuntCost1Qty);
		}
		if (OtherHuntCost1Tid != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(OtherHuntCost1Tid);
		}
		if (OtherHuntCost1Qty != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(OtherHuntCost1Qty);
		}
		if (TraceCost1Tid != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(TraceCost1Tid);
		}
		if (TraceCost1Qty != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(TraceCost1Qty);
		}
		starDropCount_.WriteTo(output, _repeated_starDropCount_codec);
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
		if (StartTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StartTime);
		}
		if (EndTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EndTime);
		}
		num += bossList_.CalculateSize(_repeated_bossList_codec);
		if (SelfHuntCost1Tid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SelfHuntCost1Tid);
		}
		if (SelfHuntCost1Qty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SelfHuntCost1Qty);
		}
		if (OtherHuntCost1Tid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OtherHuntCost1Tid);
		}
		if (OtherHuntCost1Qty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OtherHuntCost1Qty);
		}
		if (TraceCost1Tid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TraceCost1Tid);
		}
		if (TraceCost1Qty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TraceCost1Qty);
		}
		num += starDropCount_.CalculateSize(_repeated_starDropCount_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TraceHuntControl other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.StartTime.Length != 0)
			{
				StartTime = other.StartTime;
			}
			if (other.EndTime.Length != 0)
			{
				EndTime = other.EndTime;
			}
			bossList_.Add(other.bossList_);
			if (other.SelfHuntCost1Tid != 0)
			{
				SelfHuntCost1Tid = other.SelfHuntCost1Tid;
			}
			if (other.SelfHuntCost1Qty != 0)
			{
				SelfHuntCost1Qty = other.SelfHuntCost1Qty;
			}
			if (other.OtherHuntCost1Tid != 0)
			{
				OtherHuntCost1Tid = other.OtherHuntCost1Tid;
			}
			if (other.OtherHuntCost1Qty != 0)
			{
				OtherHuntCost1Qty = other.OtherHuntCost1Qty;
			}
			if (other.TraceCost1Tid != 0)
			{
				TraceCost1Tid = other.TraceCost1Tid;
			}
			if (other.TraceCost1Qty != 0)
			{
				TraceCost1Qty = other.TraceCost1Qty;
			}
			starDropCount_.Add(other.starDropCount_);
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
				StartTime = input.ReadString();
				break;
			case 26u:
				EndTime = input.ReadString();
				break;
			case 32u:
			case 34u:
				bossList_.AddEntriesFrom(input, _repeated_bossList_codec);
				break;
			case 40u:
				SelfHuntCost1Tid = input.ReadInt32();
				break;
			case 48u:
				SelfHuntCost1Qty = input.ReadInt32();
				break;
			case 56u:
				OtherHuntCost1Tid = input.ReadInt32();
				break;
			case 64u:
				OtherHuntCost1Qty = input.ReadInt32();
				break;
			case 72u:
				TraceCost1Tid = input.ReadInt32();
				break;
			case 80u:
				TraceCost1Qty = input.ReadInt32();
				break;
			case 88u:
			case 90u:
				starDropCount_.AddEntriesFrom(input, _repeated_starDropCount_codec);
				break;
			}
		}
	}
}
