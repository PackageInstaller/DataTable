using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class table_PenguinCardBuffWeight : IMessage<table_PenguinCardBuffWeight>, IMessage, IEquatable<table_PenguinCardBuffWeight>, IDeepCloneable<table_PenguinCardBuffWeight>
{
	private static readonly MessageParser<table_PenguinCardBuffWeight> _parser = new MessageParser<table_PenguinCardBuffWeight>(() => new table_PenguinCardBuffWeight());

	private UnknownFieldSet _unknownFields;

	public const int ListFieldNumber = 1;

	private static readonly FieldCodec<PenguinCardBuffWeight> _repeated_list_codec = FieldCodec.ForMessage(10u, PenguinCardBuffWeight.Parser);

	private readonly RepeatedField<PenguinCardBuffWeight> list_ = new RepeatedField<PenguinCardBuffWeight>();

	[DebuggerNonUserCode]
	public static MessageParser<table_PenguinCardBuffWeight> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(623);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public RepeatedField<PenguinCardBuffWeight> List => list_;

	[DebuggerNonUserCode]
	public table_PenguinCardBuffWeight()
	{
	}

	[DebuggerNonUserCode]
	public table_PenguinCardBuffWeight(table_PenguinCardBuffWeight other)
		: this()
	{
		list_ = other.list_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public table_PenguinCardBuffWeight Clone()
	{
		return new table_PenguinCardBuffWeight(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as table_PenguinCardBuffWeight);
	}

	[DebuggerNonUserCode]
	public bool Equals(table_PenguinCardBuffWeight other)
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
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		num ^= list_.GetHashCode();
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
		list_.WriteTo(output, _repeated_list_codec);
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		num += list_.CalculateSize(_repeated_list_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(table_PenguinCardBuffWeight other)
	{
		if (other != null)
		{
			list_.Add(other.list_);
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
			}
			else
			{
				list_.AddEntriesFrom(input, _repeated_list_codec);
			}
		}
	}
}
