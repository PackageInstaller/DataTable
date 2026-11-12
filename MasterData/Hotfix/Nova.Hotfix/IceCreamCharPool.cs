using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class IceCreamCharPool : IMessage<IceCreamCharPool>, IMessage, IEquatable<IceCreamCharPool>, IDeepCloneable<IceCreamCharPool>
{
	private static readonly MessageParser<IceCreamCharPool> _parser = new MessageParser<IceCreamCharPool>(() => new IceCreamCharPool());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int PoolIdFieldNumber = 2;

	private int poolId_;

	public const int CharIdFieldNumber = 3;

	private int charId_;

	public const int WeightFieldNumber = 4;

	private int weight_;

	[DebuggerNonUserCode]
	public static MessageParser<IceCreamCharPool> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(438);

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
	public int PoolId
	{
		get
		{
			return poolId_;
		}
		set
		{
			poolId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CharId
	{
		get
		{
			return charId_;
		}
		set
		{
			charId_ = value;
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
	public IceCreamCharPool()
	{
	}

	[DebuggerNonUserCode]
	public IceCreamCharPool(IceCreamCharPool other)
		: this()
	{
		id_ = other.id_;
		poolId_ = other.poolId_;
		charId_ = other.charId_;
		weight_ = other.weight_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public IceCreamCharPool Clone()
	{
		return new IceCreamCharPool(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as IceCreamCharPool);
	}

	[DebuggerNonUserCode]
	public bool Equals(IceCreamCharPool other)
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
		if (PoolId != other.PoolId)
		{
			return false;
		}
		if (CharId != other.CharId)
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
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (PoolId != 0)
		{
			num ^= PoolId.GetHashCode();
		}
		if (CharId != 0)
		{
			num ^= CharId.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (PoolId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(PoolId);
		}
		if (CharId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CharId);
		}
		if (Weight != 0)
		{
			output.WriteRawTag(32);
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
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (PoolId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PoolId);
		}
		if (CharId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharId);
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
	public void MergeFrom(IceCreamCharPool other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.PoolId != 0)
			{
				PoolId = other.PoolId;
			}
			if (other.CharId != 0)
			{
				CharId = other.CharId;
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
				Id = input.ReadInt32();
				break;
			case 16u:
				PoolId = input.ReadInt32();
				break;
			case 24u:
				CharId = input.ReadInt32();
				break;
			case 32u:
				Weight = input.ReadInt32();
				break;
			}
		}
	}
}
