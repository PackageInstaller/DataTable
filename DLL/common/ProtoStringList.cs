using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

public sealed class ProtoStringList : IMessage<ProtoStringList>, IMessage, IEquatable<ProtoStringList>, IDeepCloneable<ProtoStringList>
{
	private static readonly MessageParser<ProtoStringList> _parser = new MessageParser<ProtoStringList>(() => new ProtoStringList());

	public const int ListFieldNumber = 1;

	private static readonly FieldCodec<string> _repeated_list_codec = FieldCodec.ForString(10u);

	private readonly RepeatedField<string> list_ = new RepeatedField<string>();

	[DebuggerNonUserCode]
	public static MessageParser<ProtoStringList> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => BlackboardReflection.Descriptor.MessageTypes[6];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public RepeatedField<string> List => list_;

	[DebuggerNonUserCode]
	public ProtoStringList()
	{
	}

	[DebuggerNonUserCode]
	public ProtoStringList(ProtoStringList other)
		: this()
	{
		list_ = other.list_.Clone();
	}

	[DebuggerNonUserCode]
	public ProtoStringList Clone()
	{
		return new ProtoStringList(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ProtoStringList);
	}

	[DebuggerNonUserCode]
	public bool Equals(ProtoStringList other)
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
	public void MergeFrom(ProtoStringList other)
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
			if (num != 10)
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
