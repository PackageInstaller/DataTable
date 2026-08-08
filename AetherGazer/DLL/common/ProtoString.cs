using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

public sealed class ProtoString : IMessage<ProtoString>, IMessage, IEquatable<ProtoString>, IDeepCloneable<ProtoString>
{
	private static readonly MessageParser<ProtoString> _parser = new MessageParser<ProtoString>(() => new ProtoString());

	public const int SFieldNumber = 1;

	private string s_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<ProtoString> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => BlackboardReflection.Descriptor.MessageTypes[4];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public string S
	{
		get
		{
			return s_;
		}
		set
		{
			s_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public ProtoString()
	{
	}

	[DebuggerNonUserCode]
	public ProtoString(ProtoString other)
		: this()
	{
		s_ = other.s_;
	}

	[DebuggerNonUserCode]
	public ProtoString Clone()
	{
		return new ProtoString(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ProtoString);
	}

	[DebuggerNonUserCode]
	public bool Equals(ProtoString other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (S != other.S)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (S.Length != 0)
		{
			num ^= S.GetHashCode();
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
		if (S.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(S);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (S.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(S);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ProtoString other)
	{
		if (other != null && other.S.Length != 0)
		{
			S = other.S;
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			if (num != 10)
			{
				input.SkipLastField();
			}
			else
			{
				S = input.ReadString();
			}
		}
	}
}
