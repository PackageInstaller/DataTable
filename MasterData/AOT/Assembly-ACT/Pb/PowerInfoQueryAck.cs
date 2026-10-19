using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class PowerInfoQueryAck : IMessage<PowerInfoQueryAck>, IMessage, IEquatable<PowerInfoQueryAck>, IDeepCloneable<PowerInfoQueryAck>, IBufferMessage
{
	private static readonly MessageParser<PowerInfoQueryAck> _parser = new MessageParser<PowerInfoQueryAck>(() => new PowerInfoQueryAck());

	private UnknownFieldSet _unknownFields;

	public const int PowerFieldNumber = 1;

	private int power_;

	public const int PowerRecoverTsFieldNumber = 2;

	private long powerRecoverTs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<PowerInfoQueryAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[145];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Power
	{
		get
		{
			return power_;
		}
		set
		{
			power_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long PowerRecoverTs
	{
		get
		{
			return powerRecoverTs_;
		}
		set
		{
			powerRecoverTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PowerInfoQueryAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PowerInfoQueryAck(PowerInfoQueryAck other)
		: this()
	{
		power_ = other.power_;
		powerRecoverTs_ = other.powerRecoverTs_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PowerInfoQueryAck Clone()
	{
		return new PowerInfoQueryAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as PowerInfoQueryAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(PowerInfoQueryAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Power != other.Power)
		{
			return false;
		}
		if (PowerRecoverTs != other.PowerRecoverTs)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		if (Power != 0)
		{
			num ^= Power.GetHashCode();
		}
		if (PowerRecoverTs != 0L)
		{
			num ^= PowerRecoverTs.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (Power != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Power);
		}
		if (PowerRecoverTs != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(PowerRecoverTs);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		if (Power != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Power);
		}
		if (PowerRecoverTs != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(PowerRecoverTs);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(PowerInfoQueryAck other)
	{
		if (other != null)
		{
			if (other.Power != 0)
			{
				Power = other.Power;
			}
			if (other.PowerRecoverTs != 0L)
			{
				PowerRecoverTs = other.PowerRecoverTs;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				Power = input.ReadInt32();
				break;
			case 16u:
				PowerRecoverTs = input.ReadInt64();
				break;
			}
		}
	}
}
