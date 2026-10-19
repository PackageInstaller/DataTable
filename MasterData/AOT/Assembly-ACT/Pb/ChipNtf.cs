using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ChipNtf : IMessage<ChipNtf>, IMessage, IEquatable<ChipNtf>, IDeepCloneable<ChipNtf>, IBufferMessage
{
	private static readonly MessageParser<ChipNtf> _parser = new MessageParser<ChipNtf>(() => new ChipNtf());

	private UnknownFieldSet _unknownFields;

	public const int ChangesFieldNumber = 1;

	private static readonly FieldCodec<Chip> _repeated_changes_codec = FieldCodec.ForMessage(10u, Chip.Parser);

	private readonly RepeatedField<Chip> changes_ = new RepeatedField<Chip>();

	public const int RemoveUidsFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_removeUids_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> removeUids_ = new RepeatedField<int>();

	public const int ChangeWayFieldNumber = 3;

	private ItemsWays changeWay_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ChipNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ChipReflection.Descriptor.MessageTypes[0];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Chip> Changes => changes_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> RemoveUids => removeUids_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ItemsWays ChangeWay
	{
		get
		{
			return changeWay_;
		}
		set
		{
			changeWay_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ChipNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ChipNtf(ChipNtf other)
		: this()
	{
		changes_ = other.changes_.Clone();
		removeUids_ = other.removeUids_.Clone();
		changeWay_ = other.changeWay_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ChipNtf Clone()
	{
		return new ChipNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ChipNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ChipNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!changes_.Equals(other.changes_))
		{
			return false;
		}
		if (!removeUids_.Equals(other.removeUids_))
		{
			return false;
		}
		if (ChangeWay != other.ChangeWay)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		num ^= changes_.GetHashCode();
		num ^= removeUids_.GetHashCode();
		if (ChangeWay != ItemsWays.ItemswayEntergame)
		{
			num ^= ChangeWay.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		changes_.WriteTo(ref output, _repeated_changes_codec);
		removeUids_.WriteTo(ref output, _repeated_removeUids_codec);
		if (ChangeWay != ItemsWays.ItemswayEntergame)
		{
			output.WriteRawTag(24);
			output.WriteEnum((int)ChangeWay);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		num += changes_.CalculateSize(_repeated_changes_codec);
		num += removeUids_.CalculateSize(_repeated_removeUids_codec);
		if (ChangeWay != ItemsWays.ItemswayEntergame)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)ChangeWay);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ChipNtf other)
	{
		if (other != null)
		{
			changes_.Add(other.changes_);
			removeUids_.Add(other.removeUids_);
			if (other.ChangeWay != ItemsWays.ItemswayEntergame)
			{
				ChangeWay = other.ChangeWay;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 10u:
				changes_.AddEntriesFrom(ref input, _repeated_changes_codec);
				break;
			case 16u:
			case 18u:
				removeUids_.AddEntriesFrom(ref input, _repeated_removeUids_codec);
				break;
			case 24u:
				ChangeWay = (ItemsWays)input.ReadEnum();
				break;
			}
		}
	}
}
