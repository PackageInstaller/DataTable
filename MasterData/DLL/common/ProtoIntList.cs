using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

public sealed class ProtoIntList : IMessage<ProtoIntList>, IMessage, IEquatable<ProtoIntList>, IDeepCloneable<ProtoIntList>
{
	private static readonly MessageParser<ProtoIntList> _parser = new MessageParser<ProtoIntList>(() => new ProtoIntList());

	public const int ListFieldNumber = 1;

	private static readonly FieldCodec<int> _repeated_list_codec = FieldCodec.ForInt32(10u);

	private readonly RepeatedField<int> list_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<ProtoIntList> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => BlackboardReflection.Descriptor.MessageTypes[5];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public RepeatedField<int> List => list_;

	[DebuggerNonUserCode]
	public ProtoIntList()
	{
	}

	[DebuggerNonUserCode]
	public ProtoIntList(ProtoIntList other)
		: this()
	{
		list_ = other.list_.Clone();
	}

	[DebuggerNonUserCode]
	public ProtoIntList Clone()
	{
		return new ProtoIntList(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ProtoIntList);
	}

	[DebuggerNonUserCode]
	public bool Equals(ProtoIntList other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!list_.Equals(other.list_))
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		return num ^ list_.GetHashCode();
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		list_.WriteTo(output, _repeated_list_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		return num + list_.CalculateSize(_repeated_list_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ProtoIntList other)
	{
		if (other != null)
		{
			list_.Add(other.list_);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			if (num != 8 && num != 10)
			{
				input.SkipLastField();
			}
			else
			{
				list_.AddEntriesFrom(input, _repeated_list_codec);
			}
		}
	}
}
