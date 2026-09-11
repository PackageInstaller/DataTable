using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

public sealed class ProtoInt3List : IMessage<ProtoInt3List>, IMessage, IEquatable<ProtoInt3List>, IDeepCloneable<ProtoInt3List>
{
	private static readonly MessageParser<ProtoInt3List> _parser = new MessageParser<ProtoInt3List>(() => new ProtoInt3List());

	public const int ListFieldNumber = 1;

	private static readonly FieldCodec<ProtoInt3> _repeated_list_codec = FieldCodec.ForMessage(10u, ProtoInt3.Parser);

	private readonly RepeatedField<ProtoInt3> list_ = new RepeatedField<ProtoInt3>();

	[DebuggerNonUserCode]
	public static MessageParser<ProtoInt3List> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => BlackboardReflection.Descriptor.MessageTypes[10];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public RepeatedField<ProtoInt3> List => list_;

	[DebuggerNonUserCode]
	public ProtoInt3List()
	{
	}

	[DebuggerNonUserCode]
	public ProtoInt3List(ProtoInt3List other)
		: this()
	{
		list_ = other.list_.Clone();
	}

	[DebuggerNonUserCode]
	public ProtoInt3List Clone()
	{
		return new ProtoInt3List(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ProtoInt3List);
	}

	[DebuggerNonUserCode]
	public bool Equals(ProtoInt3List other)
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
	public void MergeFrom(ProtoInt3List other)
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
