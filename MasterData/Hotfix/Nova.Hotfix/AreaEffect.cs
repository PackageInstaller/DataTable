using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class AreaEffect : IMessage<AreaEffect>, IMessage, IEquatable<AreaEffect>, IDeepCloneable<AreaEffect>
{
	private static readonly MessageParser<AreaEffect> _parser = new MessageParser<AreaEffect>(() => new AreaEffect());

	private UnknownFieldSet _unknownFields;

	public const int AreaTagFieldNumber = 1;

	private int areaTag_;

	public const int MaxCountFieldNumber = 2;

	private int maxCount_;

	public const int OverLimitTypeFieldNumber = 3;

	private int overLimitType_;

	[DebuggerNonUserCode]
	public static MessageParser<AreaEffect> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(94);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int AreaTag
	{
		get
		{
			return areaTag_;
		}
		set
		{
			areaTag_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MaxCount
	{
		get
		{
			return maxCount_;
		}
		set
		{
			maxCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int OverLimitType
	{
		get
		{
			return overLimitType_;
		}
		set
		{
			overLimitType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public AreaEffect()
	{
	}

	[DebuggerNonUserCode]
	public AreaEffect(AreaEffect other)
		: this()
	{
		areaTag_ = other.areaTag_;
		maxCount_ = other.maxCount_;
		overLimitType_ = other.overLimitType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public AreaEffect Clone()
	{
		return new AreaEffect(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as AreaEffect);
	}

	[DebuggerNonUserCode]
	public bool Equals(AreaEffect other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (AreaTag != other.AreaTag)
		{
			return false;
		}
		if (MaxCount != other.MaxCount)
		{
			return false;
		}
		if (OverLimitType != other.OverLimitType)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (AreaTag != 0)
		{
			num ^= AreaTag.GetHashCode();
		}
		if (MaxCount != 0)
		{
			num ^= MaxCount.GetHashCode();
		}
		if (OverLimitType != 0)
		{
			num ^= OverLimitType.GetHashCode();
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
		if (AreaTag != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(AreaTag);
		}
		if (MaxCount != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(MaxCount);
		}
		if (OverLimitType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(OverLimitType);
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
		if (AreaTag != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AreaTag);
		}
		if (MaxCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxCount);
		}
		if (OverLimitType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OverLimitType);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(AreaEffect other)
	{
		if (other != null)
		{
			if (other.AreaTag != 0)
			{
				AreaTag = other.AreaTag;
			}
			if (other.MaxCount != 0)
			{
				MaxCount = other.MaxCount;
			}
			if (other.OverLimitType != 0)
			{
				OverLimitType = other.OverLimitType;
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
				AreaTag = input.ReadInt32();
				break;
			case 16u:
				MaxCount = input.ReadInt32();
				break;
			case 24u:
				OverLimitType = input.ReadInt32();
				break;
			}
		}
	}
}
