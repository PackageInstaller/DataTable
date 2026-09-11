using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

public sealed class ProtoInt : IMessage<ProtoInt>, IMessage, IEquatable<ProtoInt>, IDeepCloneable<ProtoInt>
{
	private static readonly MessageParser<ProtoInt> _parser = new MessageParser<ProtoInt>(() => new ProtoInt());

	public const int ValueFieldNumber = 1;

	private int value_;

	[DebuggerNonUserCode]
	public static MessageParser<ProtoInt> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => BlackboardReflection.Descriptor.MessageTypes[3];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Value
	{
		get
		{
			return value_;
		}
		set
		{
			value_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ProtoInt()
	{
	}

	[DebuggerNonUserCode]
	public ProtoInt(ProtoInt other)
		: this()
	{
		value_ = other.value_;
	}

	[DebuggerNonUserCode]
	public ProtoInt Clone()
	{
		return new ProtoInt(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ProtoInt);
	}

	[DebuggerNonUserCode]
	public bool Equals(ProtoInt other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Value != other.Value)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Value != 0)
		{
			num ^= Value.GetHashCode();
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
		if (Value != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Value);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Value != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Value);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ProtoInt other)
	{
		if (other != null && other.Value != 0)
		{
			Value = other.Value;
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			if (num != 8)
			{
				input.SkipLastField();
			}
			else
			{
				Value = input.ReadInt32();
			}
		}
	}
}
