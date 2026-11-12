using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class table_SoldierCharTierAttrBonus : IMessage<table_SoldierCharTierAttrBonus>, IMessage, IEquatable<table_SoldierCharTierAttrBonus>, IDeepCloneable<table_SoldierCharTierAttrBonus>
{
	private static readonly MessageParser<table_SoldierCharTierAttrBonus> _parser = new MessageParser<table_SoldierCharTierAttrBonus>(() => new table_SoldierCharTierAttrBonus());

	private UnknownFieldSet _unknownFields;

	public const int ListFieldNumber = 1;

	private static readonly FieldCodec<SoldierCharTierAttrBonus> _repeated_list_codec = FieldCodec.ForMessage(10u, SoldierCharTierAttrBonus.Parser);

	private readonly RepeatedField<SoldierCharTierAttrBonus> list_ = new RepeatedField<SoldierCharTierAttrBonus>();

	[DebuggerNonUserCode]
	public static MessageParser<table_SoldierCharTierAttrBonus> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(743);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public RepeatedField<SoldierCharTierAttrBonus> List => list_;

	[DebuggerNonUserCode]
	public table_SoldierCharTierAttrBonus()
	{
	}

	[DebuggerNonUserCode]
	public table_SoldierCharTierAttrBonus(table_SoldierCharTierAttrBonus other)
		: this()
	{
		list_ = other.list_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public table_SoldierCharTierAttrBonus Clone()
	{
		return new table_SoldierCharTierAttrBonus(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as table_SoldierCharTierAttrBonus);
	}

	[DebuggerNonUserCode]
	public bool Equals(table_SoldierCharTierAttrBonus other)
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
	public void MergeFrom(table_SoldierCharTierAttrBonus other)
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
