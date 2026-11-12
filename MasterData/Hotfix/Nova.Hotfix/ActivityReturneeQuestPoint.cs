using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityReturneeQuestPoint : IMessage<ActivityReturneeQuestPoint>, IMessage, IEquatable<ActivityReturneeQuestPoint>, IDeepCloneable<ActivityReturneeQuestPoint>
{
	private static readonly MessageParser<ActivityReturneeQuestPoint> _parser = new MessageParser<ActivityReturneeQuestPoint>(() => new ActivityReturneeQuestPoint());

	private UnknownFieldSet _unknownFields;

	public const int PointFieldNumber = 1;

	private int point_;

	public const int ReturneeIdFieldNumber = 2;

	private int returneeId_;

	public const int IndexFieldNumber = 3;

	private int index_;

	public const int Reward1TidFieldNumber = 4;

	private int reward1Tid_;

	public const int Reward1QtyFieldNumber = 5;

	private int reward1Qty_;

	[DebuggerNonUserCode]
	public static MessageParser<ActivityReturneeQuestPoint> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(46);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Point
	{
		get
		{
			return point_;
		}
		set
		{
			point_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ReturneeId
	{
		get
		{
			return returneeId_;
		}
		set
		{
			returneeId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Index
	{
		get
		{
			return index_;
		}
		set
		{
			index_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward1Tid
	{
		get
		{
			return reward1Tid_;
		}
		set
		{
			reward1Tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward1Qty
	{
		get
		{
			return reward1Qty_;
		}
		set
		{
			reward1Qty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ActivityReturneeQuestPoint()
	{
	}

	[DebuggerNonUserCode]
	public ActivityReturneeQuestPoint(ActivityReturneeQuestPoint other)
		: this()
	{
		point_ = other.point_;
		returneeId_ = other.returneeId_;
		index_ = other.index_;
		reward1Tid_ = other.reward1Tid_;
		reward1Qty_ = other.reward1Qty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityReturneeQuestPoint Clone()
	{
		return new ActivityReturneeQuestPoint(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityReturneeQuestPoint);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityReturneeQuestPoint other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Point != other.Point)
		{
			return false;
		}
		if (ReturneeId != other.ReturneeId)
		{
			return false;
		}
		if (Index != other.Index)
		{
			return false;
		}
		if (Reward1Tid != other.Reward1Tid)
		{
			return false;
		}
		if (Reward1Qty != other.Reward1Qty)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Point != 0)
		{
			num ^= Point.GetHashCode();
		}
		if (ReturneeId != 0)
		{
			num ^= ReturneeId.GetHashCode();
		}
		if (Index != 0)
		{
			num ^= Index.GetHashCode();
		}
		if (Reward1Tid != 0)
		{
			num ^= Reward1Tid.GetHashCode();
		}
		if (Reward1Qty != 0)
		{
			num ^= Reward1Qty.GetHashCode();
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
		if (Point != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Point);
		}
		if (ReturneeId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ReturneeId);
		}
		if (Index != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Index);
		}
		if (Reward1Tid != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Reward1Tid);
		}
		if (Reward1Qty != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Reward1Qty);
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
		if (Point != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Point);
		}
		if (ReturneeId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ReturneeId);
		}
		if (Index != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Index);
		}
		if (Reward1Tid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward1Tid);
		}
		if (Reward1Qty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward1Qty);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityReturneeQuestPoint other)
	{
		if (other != null)
		{
			if (other.Point != 0)
			{
				Point = other.Point;
			}
			if (other.ReturneeId != 0)
			{
				ReturneeId = other.ReturneeId;
			}
			if (other.Index != 0)
			{
				Index = other.Index;
			}
			if (other.Reward1Tid != 0)
			{
				Reward1Tid = other.Reward1Tid;
			}
			if (other.Reward1Qty != 0)
			{
				Reward1Qty = other.Reward1Qty;
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
				Point = input.ReadInt32();
				break;
			case 16u:
				ReturneeId = input.ReadInt32();
				break;
			case 24u:
				Index = input.ReadInt32();
				break;
			case 32u:
				Reward1Tid = input.ReadInt32();
				break;
			case 40u:
				Reward1Qty = input.ReadInt32();
				break;
			}
		}
	}
}
