using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class table_ActivityLevelsFloor : IMessage<table_ActivityLevelsFloor>, IMessage, IEquatable<table_ActivityLevelsFloor>, IDeepCloneable<table_ActivityLevelsFloor>
{
	private static readonly MessageParser<table_ActivityLevelsFloor> _parser = new MessageParser<table_ActivityLevelsFloor>(() => new table_ActivityLevelsFloor());

	private UnknownFieldSet _unknownFields;

	public const int ListFieldNumber = 1;

	private static readonly FieldCodec<ActivityLevelsFloor> _repeated_list_codec = FieldCodec.ForMessage(10u, ActivityLevelsFloor.Parser);

	private readonly RepeatedField<ActivityLevelsFloor> list_ = new RepeatedField<ActivityLevelsFloor>();

	[DebuggerNonUserCode]
	public static MessageParser<table_ActivityLevelsFloor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(21);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public RepeatedField<ActivityLevelsFloor> List => list_;

	[DebuggerNonUserCode]
	public table_ActivityLevelsFloor()
	{
	}

	[DebuggerNonUserCode]
	public table_ActivityLevelsFloor(table_ActivityLevelsFloor other)
		: this()
	{
		list_ = other.list_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public table_ActivityLevelsFloor Clone()
	{
		return new table_ActivityLevelsFloor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as table_ActivityLevelsFloor);
	}

	[DebuggerNonUserCode]
	public bool Equals(table_ActivityLevelsFloor other)
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
	public void MergeFrom(table_ActivityLevelsFloor other)
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
