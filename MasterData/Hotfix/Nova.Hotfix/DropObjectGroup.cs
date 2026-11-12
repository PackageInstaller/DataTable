using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DropObjectGroup : IMessage<DropObjectGroup>, IMessage, IEquatable<DropObjectGroup>, IDeepCloneable<DropObjectGroup>
{
	private static readonly MessageParser<DropObjectGroup> _parser = new MessageParser<DropObjectGroup>(() => new DropObjectGroup());

	private UnknownFieldSet _unknownFields;

	public const int DropObjectGroupIdFieldNumber = 1;

	private int dropObjectGroupId_;

	public const int DropObjectIdFieldNumber = 2;

	private int dropObjectId_;

	public const int WeightFieldNumber = 3;

	private int weight_;

	[DebuggerNonUserCode]
	public static MessageParser<DropObjectGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(322);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int DropObjectGroupId
	{
		get
		{
			return dropObjectGroupId_;
		}
		set
		{
			dropObjectGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DropObjectId
	{
		get
		{
			return dropObjectId_;
		}
		set
		{
			dropObjectId_ = value;
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
	public DropObjectGroup()
	{
	}

	[DebuggerNonUserCode]
	public DropObjectGroup(DropObjectGroup other)
		: this()
	{
		dropObjectGroupId_ = other.dropObjectGroupId_;
		dropObjectId_ = other.dropObjectId_;
		weight_ = other.weight_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DropObjectGroup Clone()
	{
		return new DropObjectGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DropObjectGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(DropObjectGroup other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (DropObjectGroupId != other.DropObjectGroupId)
		{
			return false;
		}
		if (DropObjectId != other.DropObjectId)
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
		if (DropObjectGroupId != 0)
		{
			num ^= DropObjectGroupId.GetHashCode();
		}
		if (DropObjectId != 0)
		{
			num ^= DropObjectId.GetHashCode();
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
		if (DropObjectGroupId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(DropObjectGroupId);
		}
		if (DropObjectId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(DropObjectId);
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
		if (DropObjectGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DropObjectGroupId);
		}
		if (DropObjectId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DropObjectId);
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
	public void MergeFrom(DropObjectGroup other)
	{
		if (other != null)
		{
			if (other.DropObjectGroupId != 0)
			{
				DropObjectGroupId = other.DropObjectGroupId;
			}
			if (other.DropObjectId != 0)
			{
				DropObjectId = other.DropObjectId;
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
				DropObjectGroupId = input.ReadInt32();
				break;
			case 16u:
				DropObjectId = input.ReadInt32();
				break;
			case 24u:
				Weight = input.ReadInt32();
				break;
			}
		}
	}
}
