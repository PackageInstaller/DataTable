using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

public sealed class ProtoBool : IMessage<ProtoBool>, IMessage, IEquatable<ProtoBool>, IDeepCloneable<ProtoBool>
{
	private static readonly MessageParser<ProtoBool> _parser = new MessageParser<ProtoBool>(() => new ProtoBool());

	public const int ValueFieldNumber = 1;

	private bool value_;

	[DebuggerNonUserCode]
	public static MessageParser<ProtoBool> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => BlackboardReflection.Descriptor.MessageTypes[7];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public bool Value
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
	public ProtoBool()
	{
	}

	[DebuggerNonUserCode]
	public ProtoBool(ProtoBool other)
		: this()
	{
		value_ = other.value_;
	}

	[DebuggerNonUserCode]
	public ProtoBool Clone()
	{
		return new ProtoBool(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ProtoBool);
	}

	[DebuggerNonUserCode]
	public bool Equals(ProtoBool other)
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
		if (Value)
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
		if (Value)
		{
			output.WriteRawTag(8);
			output.WriteBool(Value);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Value)
		{
			num += 2;
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ProtoBool other)
	{
		if (other != null && other.Value)
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
				Value = input.ReadBool();
			}
		}
	}
}
