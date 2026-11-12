using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GachaReward : IMessage<GachaReward>, IMessage, IEquatable<GachaReward>, IDeepCloneable<GachaReward>
{
	private static readonly MessageParser<GachaReward> _parser = new MessageParser<GachaReward>(() => new GachaReward());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GachaIdFieldNumber = 2;

	private int gachaId_;

	public const int IndexFieldNumber = 3;

	private int index_;

	public const int NumFieldNumber = 4;

	private int num_;

	public const int TidFieldNumber = 5;

	private int tid_;

	public const int QtyFieldNumber = 6;

	private int qty_;

	[DebuggerNonUserCode]
	public static MessageParser<GachaReward> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(370);

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
	public int GachaId
	{
		get
		{
			return gachaId_;
		}
		set
		{
			gachaId_ = value;
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
	public int Num
	{
		get
		{
			return num_;
		}
		set
		{
			num_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Tid
	{
		get
		{
			return tid_;
		}
		set
		{
			tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty
	{
		get
		{
			return qty_;
		}
		set
		{
			qty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public GachaReward()
	{
	}

	[DebuggerNonUserCode]
	public GachaReward(GachaReward other)
		: this()
	{
		id_ = other.id_;
		gachaId_ = other.gachaId_;
		index_ = other.index_;
		num_ = other.num_;
		tid_ = other.tid_;
		qty_ = other.qty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GachaReward Clone()
	{
		return new GachaReward(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GachaReward);
	}

	[DebuggerNonUserCode]
	public bool Equals(GachaReward other)
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
		if (GachaId != other.GachaId)
		{
			return false;
		}
		if (Index != other.Index)
		{
			return false;
		}
		if (Num != other.Num)
		{
			return false;
		}
		if (Tid != other.Tid)
		{
			return false;
		}
		if (Qty != other.Qty)
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
		if (GachaId != 0)
		{
			num ^= GachaId.GetHashCode();
		}
		if (Index != 0)
		{
			num ^= Index.GetHashCode();
		}
		if (Num != 0)
		{
			num ^= Num.GetHashCode();
		}
		if (Tid != 0)
		{
			num ^= Tid.GetHashCode();
		}
		if (Qty != 0)
		{
			num ^= Qty.GetHashCode();
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
		if (GachaId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GachaId);
		}
		if (Index != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Index);
		}
		if (Num != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Num);
		}
		if (Tid != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Tid);
		}
		if (Qty != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Qty);
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
		if (GachaId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GachaId);
		}
		if (Index != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Index);
		}
		if (Num != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Num);
		}
		if (Tid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tid);
		}
		if (Qty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(GachaReward other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.GachaId != 0)
			{
				GachaId = other.GachaId;
			}
			if (other.Index != 0)
			{
				Index = other.Index;
			}
			if (other.Num != 0)
			{
				Num = other.Num;
			}
			if (other.Tid != 0)
			{
				Tid = other.Tid;
			}
			if (other.Qty != 0)
			{
				Qty = other.Qty;
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
				GachaId = input.ReadInt32();
				break;
			case 24u:
				Index = input.ReadInt32();
				break;
			case 32u:
				Num = input.ReadInt32();
				break;
			case 40u:
				Tid = input.ReadInt32();
				break;
			case 48u:
				Qty = input.ReadInt32();
				break;
			}
		}
	}
}
