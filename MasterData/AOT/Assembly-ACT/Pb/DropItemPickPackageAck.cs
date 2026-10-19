using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class DropItemPickPackageAck : IMessage<DropItemPickPackageAck>, IMessage, IEquatable<DropItemPickPackageAck>, IDeepCloneable<DropItemPickPackageAck>, IBufferMessage
{
	private static readonly MessageParser<DropItemPickPackageAck> _parser = new MessageParser<DropItemPickPackageAck>(() => new DropItemPickPackageAck());

	private UnknownFieldSet _unknownFields;

	public const int DropResFieldNumber = 1;

	private static readonly FieldCodec<DropItemPickInfo> _repeated_dropRes_codec = FieldCodec.ForMessage(10u, DropItemPickInfo.Parser);

	private readonly RepeatedField<DropItemPickInfo> dropRes_ = new RepeatedField<DropItemPickInfo>();

	public const int WidFieldNumber = 2;

	private int wid_;

	public const int GotRewardsFieldNumber = 3;

	private static readonly FieldCodec<UniversalItem> _repeated_gotRewards_codec = FieldCodec.ForMessage(26u, UniversalItem.Parser);

	private readonly RepeatedField<UniversalItem> gotRewards_ = new RepeatedField<UniversalItem>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<DropItemPickPackageAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => DropitemReflection.Descriptor.MessageTypes[1];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<DropItemPickInfo> DropRes => dropRes_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Wid
	{
		get
		{
			return wid_;
		}
		set
		{
			wid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<UniversalItem> GotRewards => gotRewards_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DropItemPickPackageAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DropItemPickPackageAck(DropItemPickPackageAck other)
		: this()
	{
		dropRes_ = other.dropRes_.Clone();
		wid_ = other.wid_;
		gotRewards_ = other.gotRewards_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DropItemPickPackageAck Clone()
	{
		return new DropItemPickPackageAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as DropItemPickPackageAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(DropItemPickPackageAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!dropRes_.Equals(other.dropRes_))
		{
			return false;
		}
		if (Wid != other.Wid)
		{
			return false;
		}
		if (!gotRewards_.Equals(other.gotRewards_))
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
		num ^= dropRes_.GetHashCode();
		if (Wid != 0)
		{
			num ^= Wid.GetHashCode();
		}
		num ^= gotRewards_.GetHashCode();
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
		dropRes_.WriteTo(ref output, _repeated_dropRes_codec);
		if (Wid != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Wid);
		}
		gotRewards_.WriteTo(ref output, _repeated_gotRewards_codec);
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
		num += dropRes_.CalculateSize(_repeated_dropRes_codec);
		if (Wid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Wid);
		}
		num += gotRewards_.CalculateSize(_repeated_gotRewards_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(DropItemPickPackageAck other)
	{
		if (other != null)
		{
			dropRes_.Add(other.dropRes_);
			if (other.Wid != 0)
			{
				Wid = other.Wid;
			}
			gotRewards_.Add(other.gotRewards_);
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
				dropRes_.AddEntriesFrom(ref input, _repeated_dropRes_codec);
				break;
			case 16u:
				Wid = input.ReadInt32();
				break;
			case 26u:
				gotRewards_.AddEntriesFrom(ref input, _repeated_gotRewards_codec);
				break;
			}
		}
	}
}
