using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

public sealed class ProtoBoolList : IMessage<ProtoBoolList>, IMessage, IEquatable<ProtoBoolList>, IDeepCloneable<ProtoBoolList>
{
	private static readonly MessageParser<ProtoBoolList> _parser = new MessageParser<ProtoBoolList>(() => new ProtoBoolList());

	public const int ListFieldNumber = 1;

	private static readonly FieldCodec<bool> _repeated_list_codec = FieldCodec.ForBool(10u);

	private readonly RepeatedField<bool> list_ = new RepeatedField<bool>();

	[DebuggerNonUserCode]
	public static MessageParser<ProtoBoolList> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => BlackboardReflection.Descriptor.MessageTypes[8];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public RepeatedField<bool> List => list_;

	[DebuggerNonUserCode]
	public ProtoBoolList()
	{
	}

	[DebuggerNonUserCode]
	public ProtoBoolList(ProtoBoolList other)
		: this()
	{
		list_ = other.list_.Clone();
	}

	[DebuggerNonUserCode]
	public ProtoBoolList Clone()
	{
		return new ProtoBoolList(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ProtoBoolList);
	}

	[DebuggerNonUserCode]
	public bool Equals(ProtoBoolList other)
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
	public void MergeFrom(ProtoBoolList other)
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
