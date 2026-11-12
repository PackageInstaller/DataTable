using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GachaPkg : IMessage<GachaPkg>, IMessage, IEquatable<GachaPkg>, IDeepCloneable<GachaPkg>
{
	private static readonly MessageParser<GachaPkg> _parser = new MessageParser<GachaPkg>(() => new GachaPkg());

	private UnknownFieldSet _unknownFields;

	public const int PkgIdFieldNumber = 1;

	private int pkgId_;

	public const int GoodsIdFieldNumber = 2;

	private int goodsId_;

	public const int WeightFieldNumber = 3;

	private int weight_;

	[DebuggerNonUserCode]
	public static MessageParser<GachaPkg> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(368);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int PkgId
	{
		get
		{
			return pkgId_;
		}
		set
		{
			pkgId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GoodsId
	{
		get
		{
			return goodsId_;
		}
		set
		{
			goodsId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Weight
	{
		get
		{
			return weight_;
		}
		set
		{
			weight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public GachaPkg()
	{
	}

	[DebuggerNonUserCode]
	public GachaPkg(GachaPkg other)
		: this()
	{
		pkgId_ = other.pkgId_;
		goodsId_ = other.goodsId_;
		weight_ = other.weight_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GachaPkg Clone()
	{
		return new GachaPkg(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GachaPkg);
	}

	[DebuggerNonUserCode]
	public bool Equals(GachaPkg other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (PkgId != other.PkgId)
		{
			return false;
		}
		if (GoodsId != other.GoodsId)
		{
			return false;
		}
		if (Weight != other.Weight)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (PkgId != 0)
		{
			num ^= PkgId.GetHashCode();
		}
		if (GoodsId != 0)
		{
			num ^= GoodsId.GetHashCode();
		}
		if (Weight != 0)
		{
			num ^= Weight.GetHashCode();
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
		if (PkgId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(PkgId);
		}
		if (GoodsId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GoodsId);
		}
		if (Weight != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Weight);
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
		if (PkgId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PkgId);
		}
		if (GoodsId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GoodsId);
		}
		if (Weight != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Weight);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(GachaPkg other)
	{
		if (other != null)
		{
			if (other.PkgId != 0)
			{
				PkgId = other.PkgId;
			}
			if (other.GoodsId != 0)
			{
				GoodsId = other.GoodsId;
			}
			if (other.Weight != 0)
			{
				Weight = other.Weight;
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
				PkgId = input.ReadInt32();
				break;
			case 16u:
				GoodsId = input.ReadInt32();
				break;
			case 24u:
				Weight = input.ReadInt32();
				break;
			}
		}
	}
}
