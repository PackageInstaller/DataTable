using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class table_GoldenSpyObstacle : IMessage<table_GoldenSpyObstacle>, IMessage, IEquatable<table_GoldenSpyObstacle>, IDeepCloneable<table_GoldenSpyObstacle>
{
	private static readonly MessageParser<table_GoldenSpyObstacle> _parser = new MessageParser<table_GoldenSpyObstacle>(() => new table_GoldenSpyObstacle());

	private UnknownFieldSet _unknownFields;

	public const int ListFieldNumber = 1;

	private static readonly FieldCodec<GoldenSpyObstacle> _repeated_list_codec = FieldCodec.ForMessage(10u, GoldenSpyObstacle.Parser);

	private readonly RepeatedField<GoldenSpyObstacle> list_ = new RepeatedField<GoldenSpyObstacle>();

	[DebuggerNonUserCode]
	public static MessageParser<table_GoldenSpyObstacle> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(407);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public RepeatedField<GoldenSpyObstacle> List => list_;

	[DebuggerNonUserCode]
	public table_GoldenSpyObstacle()
	{
	}

	[DebuggerNonUserCode]
	public table_GoldenSpyObstacle(table_GoldenSpyObstacle other)
		: this()
	{
		list_ = other.list_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public table_GoldenSpyObstacle Clone()
	{
		return new table_GoldenSpyObstacle(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as table_GoldenSpyObstacle);
	}

	[DebuggerNonUserCode]
	public bool Equals(table_GoldenSpyObstacle other)
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
	public void MergeFrom(table_GoldenSpyObstacle other)
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
