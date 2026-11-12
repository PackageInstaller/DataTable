using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TraceHuntSelfHuntExtraCost : IMessage<TraceHuntSelfHuntExtraCost>, IMessage, IEquatable<TraceHuntSelfHuntExtraCost>, IDeepCloneable<TraceHuntSelfHuntExtraCost>
{
	private static readonly MessageParser<TraceHuntSelfHuntExtraCost> _parser = new MessageParser<TraceHuntSelfHuntExtraCost>(() => new TraceHuntSelfHuntExtraCost());

	private UnknownFieldSet _unknownFields;

	public const int TimesFieldNumber = 1;

	private int times_;

	public const int ExtraCost1TidFieldNumber = 2;

	private int extraCost1Tid_;

	public const int ExtraCost1QtyFieldNumber = 3;

	private int extraCost1Qty_;

	[DebuggerNonUserCode]
	public static MessageParser<TraceHuntSelfHuntExtraCost> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(994);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Times
	{
		get
		{
			return times_;
		}
		set
		{
			times_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ExtraCost1Tid
	{
		get
		{
			return extraCost1Tid_;
		}
		set
		{
			extraCost1Tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ExtraCost1Qty
	{
		get
		{
			return extraCost1Qty_;
		}
		set
		{
			extraCost1Qty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TraceHuntSelfHuntExtraCost()
	{
	}

	[DebuggerNonUserCode]
	public TraceHuntSelfHuntExtraCost(TraceHuntSelfHuntExtraCost other)
		: this()
	{
		times_ = other.times_;
		extraCost1Tid_ = other.extraCost1Tid_;
		extraCost1Qty_ = other.extraCost1Qty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TraceHuntSelfHuntExtraCost Clone()
	{
		return new TraceHuntSelfHuntExtraCost(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TraceHuntSelfHuntExtraCost);
	}

	[DebuggerNonUserCode]
	public bool Equals(TraceHuntSelfHuntExtraCost other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Times != other.Times)
		{
			return false;
		}
		if (ExtraCost1Tid != other.ExtraCost1Tid)
		{
			return false;
		}
		if (ExtraCost1Qty != other.ExtraCost1Qty)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Times != 0)
		{
			num ^= Times.GetHashCode();
		}
		if (ExtraCost1Tid != 0)
		{
			num ^= ExtraCost1Tid.GetHashCode();
		}
		if (ExtraCost1Qty != 0)
		{
			num ^= ExtraCost1Qty.GetHashCode();
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
		if (Times != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Times);
		}
		if (ExtraCost1Tid != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ExtraCost1Tid);
		}
		if (ExtraCost1Qty != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ExtraCost1Qty);
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
		if (Times != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Times);
		}
		if (ExtraCost1Tid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ExtraCost1Tid);
		}
		if (ExtraCost1Qty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ExtraCost1Qty);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TraceHuntSelfHuntExtraCost other)
	{
		if (other != null)
		{
			if (other.Times != 0)
			{
				Times = other.Times;
			}
			if (other.ExtraCost1Tid != 0)
			{
				ExtraCost1Tid = other.ExtraCost1Tid;
			}
			if (other.ExtraCost1Qty != 0)
			{
				ExtraCost1Qty = other.ExtraCost1Qty;
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
				Times = input.ReadInt32();
				break;
			case 16u:
				ExtraCost1Tid = input.ReadInt32();
				break;
			case 24u:
				ExtraCost1Qty = input.ReadInt32();
				break;
			}
		}
	}
}
